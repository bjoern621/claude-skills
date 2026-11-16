#!/usr/bin/env bash
# Pattern check for the writing-style rules that a match can find.
# Usage: style-check.sh [--as doc|commit|pr|code|ui] [--rule <id>[,<id> ...]] [--list] [file ...]
# No file or "-" reads stdin, as a commit message unless --as names another kind.
# A hit marks a sentence to read against its rule. Reading settles it with a fix or the case that the rule allows.
set -uo pipefail

# One row per check: id | class | kinds of text | rule in the skill | pattern.
# fix: the match breaks the rule wherever it stands. read: the match marks a candidate that reading settles.
# re: a gawk regex on the lowercased prose. case: the same on the prose as written.
# words: whole words and phrases, split by ", ". special: the awk program below holds the check.
# Kinds: doc (Markdown, plain text), commit, pr (PR, MR, issue or wiki body), code (comments alone), ui (one string per line).
rules=$(cat <<'EOF'
em-dash         | fix  | *                  | Punctuation                                | re:—
en-dash         | fix  | *                  | Punctuation                                | re:–
spaced-hyphen   | fix  | *                  | Punctuation                                | re:[ ]--?[ ]
box-drawing     | fix  | doc,commit,pr,ui   | Punctuation                                | re:[─-╿]
curly-quote     | fix  | *                  | Punctuation                                | re:[‘’“”]
nested-parens   | read | *                  | Punctuation                                | re:\([^()]*\(
comma-and       | read | *                  | One independent clause per sentence        | re:, (and|or|but)\>
semicolon       | read | doc,commit,pr,code | One independent clause per sentence        | re:;
copula          | read | *                  | Say what the thing does                    | words:is a, is an, is the, are the, are a, serves as, act as, acts as, is what, are what, ist ein, ist eine, ist der, ist die, ist das, sind die, dient als, fungiert als
paired-negation | read | *                  | State the fact and stop                    | re:, (not|never|nicht|nie)\>|\<(rather than|instead of|sondern|anstatt|statt)\>|\<not [^.;:!?]+\<but\>
long-sentence   | read | doc,commit,pr,ui   | Short                                      | special
inflated        | fix  | *                  | Plain words for a reader outside the field | words:leverage, leverages, leveraged, leveraging, utilize, utilizes, utilized, utilizing, utilization, robust, robustly, seamless, seamlessly, streamline, streamlines, streamlined, facilitate, facilitates, empower, empowers, enhance, enhances, enhanced, comprehensive, cutting-edge, state-of-the-art, best-in-class, world-class, powerful, elegant, elegantly, delve, delves, crucial, pivotal, paramount, holistic, synergy, paradigm, myriad, plethora, tapestry, testament, unlock, unlocks, unleash, foster, fosters, bolster, bolsters, elevate, elevates, showcase, showcases, embark, endeavor, meticulous, meticulously, intricate, nuanced, vibrant, game-changer, game-changing, supercharge, effortless, effortlessly, easily, straightforward, blazing, blazingly, revolutionize, transformative, actionable, in order to, a wide range of, a variety of, numerous, plays a key role, plays a crucial role, ever-evolving, nahtlos, umfassend, leistungsstark, zahlreiche, vielfältig
scaffolding     | fix  | *                  | Plain words for a reader outside the field | words:note that, please note, it's worth noting, it is worth noting, worth mentioning, it's important to, it is important to, it should be noted, keep in mind, bear in mind, at its core, in essence, in summary, to summarize, in conclusion, simply put, in other words, as mentioned, as noted above, as described above, needless to say, when it comes to, at the end of the day, first and foremost, a tempting approach would be, you might think, to be clear, let's, here's how, here's why, here's what, the key takeaway, the bottom line, beachte, beachten sie, hinweis:, es ist wichtig, im wesentlichen, letztendlich
filler          | fix  | *                  | Plain words for a reader outside the field | words:basically, really, actually, essentially, literally, eigentlich
all-caps        | read | *                  | Plain words for a reader outside the field | case:\<(NOT|NO|NEVER|ALWAYS|MUST|SHOULD|ONLY|ALL|EVERY|ANY|DO|DON'T|IMPORTANT|CRITICAL|WARNING|NOTE|REQUIRED|NICHT|NIE|IMMER|KEIN|KEINE|NUR)\>
bold            | fix  | doc,commit,pr      | Plain words for a reader outside the field | special
emoji           | fix  | *                  | Plain words for a reader outside the field | re:[🀀-🯿]|[☀-➿]|[⬀-⯿]
well            | fix  | *                  | Plain words for a reader outside the field | re:\<well\>
hedge           | read | *                  | Flat facts                                 | words:probably, presumably, perhaps, maybe, might, possibly, likely, seems, seem to, appears to, i think, i believe, (not checked), (unverified), wahrscheinlich, vermutlich, vielleicht, eventuell, möglicherweise
restriction     | read | *                  | Cut a restriction that narrows nothing     | words:only, just, simply, merely, nur, lediglich, bloß
so-connective   | read | *                  | Let a fact stand alone                     | re:, so\>|(^[ \t]*|[.!?] )so\>|\<(thus|hence|therefore|which means|this means|that means|daher|deshalb|somit|folglich)\>
participle      | read | *                  | Let a fact stand alone                     | re:, (improving|ensuring|making|allowing|enabling|providing|reducing|increasing|keeping|leading to|resulting in|giving|helping|preventing|avoiding|highlighting|reflecting|underscoring|contributing|fostering|creating)\>
time-word       | read | doc,code,ui        | Describe what stands                       | words:now, newly, currently, recently, soon, previously, formerly, used to, for now, at the moment, going forward, jetzt, aktuell, derzeit, momentan, kürzlich, bald, inzwischen, mittlerweile, bisher
there-is-no     | read | *                  | Describe what stands                       | re:\<there (is|are|was|were) no\>|\<es gibt kein
location        | read | *                  | Form (comments.md)                         | re:\<lines? [0-9]+\>|\.(go|ts|tsx|js|jsx|py|rs|cs|java|kt|swift|c|h|cpp|rb|sh|nix|md|ya?ml|json|toml|axaml):[0-9]+\>|#l[0-9]+\>
todo            | fix  | code               | What earns a comment (comments.md)         | case:\<(TODO|FIXME|XXX|HACK)\>
two-sentences   | fix  | doc,commit         | Line breaks                                | special
title-case      | read | doc                | Tells that no rule names (reference.md)    | special
transition      | read | doc,commit,pr      | Tells that no rule names (reference.md)    | re:(^[ \t]*|[.!?] )(additionally|furthermore|moreover|in addition|importantly|interestingly|notably|ultimately|overall|that said|außerdem|darüber hinaus|zudem)\>
self-answer     | read | *                  | Tells that no rule names (reference.md)    | re:\? (because|since|weil)\>
chat-leftover   | fix  | *                  | Tells that no rule names (reference.md)    | words:certainly, here is the, here is a, here is your, here's the, here's a, here's your, i hope this helps, hope this helps, let me know, feel free to, happy to help, great question, oaicite, as an ai, i'd be happy, absolutely, of course
exclaim         | read | doc,commit,pr,code | Tells that no rule names (reference.md)    | re:[[:alnum:])]!( |$)
ui-punctuation  | fix  | ui                 | Shape (interface.md)                       | re:[;!]
problem-word    | read | ui                 | Words (interface.md)                       | words:error, failed, invalid, illegal, fatal
reader-name     | read | ui                 | Voice (interface.md)                       | words:the user, the customer, we, our, us, i, this app
EOF
)

usage() {
    printf 'Usage: style-check.sh [--as doc|commit|pr|code|ui] [--rule <id>[,<id> ...]] [--list] [file ...]\n' >&2
    exit 2
}

as=""
only=""
list=0
files=()
while [ $# -gt 0 ]; do
    case $1 in
    --as) [ $# -ge 2 ] || usage; as=$2; shift 2 ;;
    --rule) [ $# -ge 2 ] || usage; only=$2; shift 2 ;;
    --list) list=1; shift ;;
    -h | --help) usage ;;
    -) files+=("-"); shift ;;
    -*) usage ;;
    *) files+=("$1"); shift ;;
    esac
done
[ ${#files[@]} -gt 0 ] || files=("-")

case $as in
"" | doc | commit | pr | code | ui) ;;
*) printf 'style-check: --as takes doc, commit, pr, code or ui, not %s\n' "$as" >&2; exit 2 ;;
esac

if ! command -v gawk >/dev/null; then
    printf 'style-check: needs gawk\n' >&2
    exit 2
fi

if [ "$list" = 1 ]; then
    printf '%s\n' "$rules" | awk -F' *[|] *' '{ printf "%-16s %-5s %-19s %s\n", $1, $2, $3, $4 }'
    exit 0
fi

# Prints the comment markers of a source file and nothing for prose.
comment_style() {
    local base=${1##*/}
    case $base in
    Dockerfile* | Makefile | GNUmakefile | Taskfile | .gitignore | .env*) echo hash; return ;;
    esac
    case ${base##*.} in
    c | h | cc | cpp | hpp | cs | java | js | jsx | ts | tsx | mjs | cjs | go | rs | swift | kt | kts | scala | dart | php | groovy | gradle | proto | zig | jsonc | json5 | scss | less) echo slash ;;
    css) echo block ;;
    sh | bash | zsh | fish | rb | pl | yaml | yml | toml | conf | cfg | ini | tf | r | ps1 | mk | cmake | nu) echo hash ;;
    nix) echo hash,block ;;
    py) echo hash,docstring ;;
    html | htm | xml | axaml | xaml | svg | plist) echo html ;;
    vue | svelte) echo html,slash ;;
    lua | sql | hs | elm) echo dash ;;
    esac
}

kind_of() {
    if [ -n "$as" ]; then echo "$as"; return; fi
    case $1 in
    - | *COMMIT_EDITMSG | *MERGE_MSG | *TAG_EDITMSG | *SQUASH_MSG | *.msg) echo commit ;;
    *.md | *.markdown | *.mdx | *.txt | *.rst) echo doc ;;
    *) if [ -n "$(comment_style "$1")" ]; then echo code; else echo doc; fi ;;
    esac
}

export STYLE_CHECK_RULES=$rules

# Reads one text and prints a line per hit: file:line:col id: excerpt [class: rule].
check() {
    LC_ALL=C.UTF-8 gawk -v kind="$1" -v style="$2" -v name="$3" -v only="$only" -v changelog="$5" '
    function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
    function blank(n) { return sprintf("%" n "s", "") }
    function xs(n,   s) { s = sprintf("%" n "s", ""); gsub(/ /, "x", s); return s }

    # Replaces every match of re in s by x or by spaces, keeping each column in place.
    function mask(s, re, fill,   out, len) {
        out = ""
        while (match(s, re)) {
            len = RLENGTH
            out = out substr(s, 1, RSTART - 1) (fill == "x" ? xs(len) : blank(len))
            s = substr(s, RSTART + len)
        }
        return out s
    }

    function escape(w) { gsub(/[][\\.^$*+?(){}|\/]/, "\\\\&", w); return w }

    function load(   row, n, i, f, fields, pattern, words, w, k, wanted) {
        n = split(ENVIRON["STYLE_CHECK_RULES"], rows, "\n")
        if (only != "") {
            k = split(only, wanted, ",")
            for (i = 1; i <= k; i++) want[trim(wanted[i])] = 1
        }
        count = 0
        for (i = 1; i <= n; i++) {
            row = rows[i]
            if (row ~ /^[ \t]*$/) continue
            for (f = 1; f <= 4; f++) {
                match(row, /[ \t]*[|][ \t]*/)
                fields[f] = substr(row, 1, RSTART - 1)
                row = substr(row, RSTART + RLENGTH)
            }
            known[fields[1]] = 1
            if (only != "" && !(fields[1] in want)) continue
            if (fields[3] != "*" && ("," fields[3] ",") !~ ("," kind ",")) continue
            count++
            id[count] = fields[1]; class[count] = fields[2]; rule[count] = fields[4]
            pattern = row
            if (pattern ~ /^words:/) {
                k = split(substr(pattern, 7), words, ", ")
                w = ""
                for (f = 1; f <= k; f++) w = w (f > 1 ? "|" : "") escape(words[f])
                type[count] = "words"
                regex[count] = "(^|[^[:alnum:]_])(" w ")([^[:alnum:]_]|$)"
            } else if (pattern ~ /^(re|case):/) {
                type[count] = substr(pattern, 1, index(pattern, ":") - 1)
                regex[count] = substr(pattern, index(pattern, ":") + 1)
            } else {
                type[count] = pattern
            }
        }
        for (w in want) if (!(w in known)) { printf "style-check: no rule %s\n", w > "/dev/stderr"; exit 2 }
    }

    BEGIN {
        load()
        abbrev = "^(e\\.g|i\\.e|etc|vs|cf|approx|z\\.b|d\\.h|bzw|ca|usw|ggf|u\\.a|dr|mr|mrs|nr|no|fig|inc|st)$"
        limit = kind == "ui" ? 25 : 30
        fence = 0; front = 0; html = 0; block = ""; text = ""; sample = 0; stop = 0
    }

    # Returns the comment text of a code line, every other column turned to a space.
    # A block comment and a string over several lines carry on into the next line.
    function comments(line,   out, i, n, c, q, e, rest) {
        out = ""; i = 1; n = length(line); q = ""
        while (i <= n) {
            if (block != "" || text != "") {
                rest = substr(line, i)
                e = index(rest, block != "" ? block : text)
                if (e == 0) { out = out (block != "" ? rest : blank(length(rest))); break }
                out = out (block != "" ? substr(rest, 1, e - 1) : blank(e - 1)) blank(length(block text))
                i += e - 1 + length(block text)
                block = ""; text = ""
                continue
            }
            c = substr(line, i, 1)
            if (q != "") {
                out = out " "
                if (c == "\\") { out = out " "; i += 2; continue }
                if (c == q) q = ""
                i++
                continue
            }
            if (substr(line, i, 3) == "\"\"\"" || (style ~ /docstring/ && substr(line, i, 3) == "'\'''\'''\''")) {
                if (style ~ /docstring/) block = substr(line, i, 3)
                else text = "\"\"\""
                out = out blank(3); i += 3; continue
            }
            if (style ~ /slash/ && substr(line, i, 2) == "//" && substr(line, i - 1, 1) != ":") {
                rest = substr(line, i + 2); match(rest, /^[\/!]*/)
                return directive(out blank(2 + RLENGTH), substr(rest, RLENGTH + 1))
            }
            if (style ~ /slash|block/ && substr(line, i, 2) == "/*") {
                block = "*/"; out = out blank(2); i += 2; continue
            }
            if (style ~ /hash/ && c == "#" && (i == 1 || substr(line, i - 1, 1) ~ /[ \t]/) && !(FNR == 1 && substr(line, i, 2) == "#!")) {
                rest = substr(line, i); match(rest, /^#+/)
                return directive(out blank(RLENGTH), substr(rest, RLENGTH + 1))
            }
            if (style ~ /html/ && substr(line, i, 4) == "<!--") {
                block = "-->"; out = out blank(4); i += 4; continue
            }
            if (style ~ /dash/ && substr(line, i, 2) == "--") {
                return directive(out blank(2), substr(line, i + 2))
            }
            if (c == "\"" || (c == "'\''" && style !~ /hash/) || c == "`") q = c
            out = out " "
            i++
        }
        if (q == "`") text = "`"
        # A block comment line keeps its text, the leading star of its gutter dropped.
        if (match(out, /^[ \t]*\*+/)) out = blank(RLENGTH) substr(out, RLENGTH + 1)
        return directive("", out)
    }

    # Blanks a linter or compiler directive, keeping the reason that follows its " -- ".
    function directive(lead, body,   e) {
        if (body !~ /^[ \t*]*(eslint|@ts-|prettier-ignore|biome-ignore|stylelint-|noqa|nolint|shellcheck|istanbul|c8 |#?(end)?region|pragma|type: *ignore|@vite-|<reference|ReSharper|NOSONAR)/) return lead body
        e = index(body, " -- ")
        if (e == 0) return lead blank(length(body))
        return lead blank(e + 3) substr(body, e + 4)
    }

    # Returns the words around a hit: three before it, the hit and six after it.
    function excerpt(s, start, len,   left, right, out) {
        left = substr(s, 1, start - 1)
        match(left, /([^ \t]+[ \t]+){0,3}[^ \t]*$/)
        left = substr(left, RSTART)
        right = substr(s, start + len)
        match(right, /^[^ \t]*([ \t]+[^ \t]+){0,6}/)
        right = substr(right, 1, RLENGTH)
        out = left substr(s, start, len) right
        gsub(/[ \t]+/, " ", out)
        out = trim(out)
        if (length(out) > 100) out = substr(out, 1, 97) "..."
        return out
    }

    function hit(r, start, len) {
        found[++nfound] = sprintf("%06d %s:%d:%d %s: %s [%s: %s]", start, name, FNR, start, id[r], excerpt(view, start, len), class[r], rule[r])
    }

    function flush(   i) {
        asort(found)
        for (i = 1; i <= nfound; i++) print substr(found[i], 8)
        delete found
        nfound = 0
    }

    # Answers whether a match stands outside the case that its rule allows.
    function counts(r, start, len,   before, after, word) {
        before = substr(lc, 1, start - 1)
        after = substr(lc, start + len)
        if (id[r] == "well") return before !~ /(^|[^[:alnum:]])as $/
        if (id[r] == "so-connective") return after !~ /^ that\>/
        if (id[r] == "en-dash") return !(before ~ /[0-9]$/ && after ~ /^[0-9]/)
        if (id[r] == "curly-quote") return line !~ /[„‚]/
        if (id[r] == "todo") return after !~ /^\(/
        if (id[r] == "spaced-hyphen") return before ~ /[^ \t]$/ && after ~ /^[^ \t]/
        if (id[r] == "copula") return !table
        if (id[r] == "scaffolding" && substr(lc, start, len) == "note that") return before ~ /(^|[.!?:])[ \t]*$/
        if (id[r] == "time-word") return !changelog && !(substr(lc, start, len) == "soon" && before ~ /(^|[^[:alnum:]])as $/)
        return 1
    }

    function scan(r, s,   pos, cur, start, len, m) {
        pos = 1
        while (pos <= length(s)) {
            cur = blank(pos - 1) substr(s, pos)
            if (type[r] == "words") {
                if (!match(cur, regex[r], m)) break
                start = m[2, "start"]; len = m[2, "length"]
            } else {
                if (!match(cur, regex[r])) break
                start = RSTART; len = RLENGTH
                if (regex[r] ~ /^\(\^/)
                    while (len > 1 && substr(cur, start, 1) ~ /[ \t.!?]/) { start++; len-- }
            }
            if (len < 1) len = 1
            if (counts(r, start, len)) hit(r, start, len)
            pos = start + len
        }
    }

    function special(r,   s, start, word, parts, n, i, upper, lower, w) {
        if (id[r] == "bold") {
            if (prose ~ /^[ \t]*\*\*[^*]+\*\*[ \t]*$/) return
            if (match(prose, /\*\*[^*]+\*\*/)) hit(r, RSTART, RLENGTH)
            return
        }
        if (id[r] == "two-sentences") {
            if (heading || table) return
            start = 1
            while (start <= length(prose)) {
                s = blank(start - 1) substr(prose, start)
                if (!match(s, /[[:alnum:])"'\''\]][.?!]["'\'')]? +[[:upper:]]/)) return
                start = RSTART + 1
                word = substr(prose, 1, RSTART)
                match(word, /[^ \t(]+$/)
                word = tolower(substr(word, RSTART))
                if (word !~ abbrev && word !~ /\./ && length(word) > 1) { hit(r, start, 1); return }
            }
            return
        }
        if (id[r] == "long-sentence") {
            if (heading || table) return
            s = prose
            start = 0
            while (s != "") {
                if (match(s, /[.?!]+([ \t]|$)/)) { word = substr(s, 1, RSTART); i = RSTART + RLENGTH - 1 }
                else { word = s; i = length(s) }
                n = split(word, parts, /[ \t]+/)
                w = 0
                for (upper = 1; upper <= n; upper++) if (parts[upper] ~ /[[:alnum:]]/) w++
                if (w > limit) { hit(r, start + match(word, /[^ \t]/), 1); return }
                start += i
                s = substr(s, i + 1)
            }
            return
        }
        if (id[r] == "title-case") {
            if (!heading) return
            n = split(trim(prose), parts, /[ \t]+/)
            upper = 0; lower = 0
            for (i = 2; i <= n; i++) {
                w = parts[i]
                gsub(/[^[:alpha:]]/, "", w)
                if (w ~ /^[[:upper:]][[:lower:]]+$/) upper++
                else if (w ~ /^[[:lower:]]+$/) lower++
            }
            if (upper >= 1 && lower == 0) hit(r, match(prose, /[^ \t]/), 1)
        }
    }

    {
        line = $0
        sub(/\r$/, "", line)
        heading = 0; table = 0
        if (stop) next

        if (kind == "code") {
            view = comments(line)
            if (view ~ /^[ \t]*(```|~~~)/) { fence = !fence; next }
            if (fence) next
            if (sample) { if (view ~ /<\/code>/) sample = 0; next }
            if (view ~ /<code>/ && view !~ /<\/code>/) { sample = 1; next }
        } else {
            if (kind == "commit") {
                if (line ~ /^# -+ >8 -+$/) { stop = 1; next }
                if (line ~ /^#/) next
                if (line ~ /^[[:alpha:]]+(-[[:alpha:]]+)+: /) next
            }
            if (kind == "doc" && FNR == 1 && line == "---") { front = 1; next }
            if (front) { if (line == "---") front = 0; next }
            if (line ~ /^[ \t]*(```|~~~)/) { fence = !fence; next }
            if (fence) next
            if (html) { if (line ~ /-->/) html = 0; next }
            if (line ~ /<!--/ && line !~ /-->/) { html = 1; next }
            if (line ~ /^(    |\t)/ && line !~ /^[ \t]*([-*+]|[0-9]+[.)])[ \t]/) next
            if (kind == "ui" && line ~ /^[ \t]*$/) next
            view = mask(line, "<!--.*-->", " ")
            heading = kind == "doc" && view ~ /^#{1,6} /
            table = view ~ /^[ \t]*\|/
            if (table && view ~ /^[ \t|:-]+$/) next
        }

        prose = view
        prose = mask(prose, "``[^`]+``|`[^`]+`", "x")
        prose = mask(prose, "\"[^\"]*\"", "x")
        prose = mask(prose, "https?://[^ \t)>\\]]+", "x")
        prose = mask(prose, "\\]\\([^)]*\\)", " ")
        prose = mask(prose, "</?[[:alpha:]!][^>]*>", " ")
        prose = mask(prose, "&#?[[:alnum:]]+;", "x")
        if (match(prose, /^[ \t]*(>[ \t]*)*([-*+]|[0-9]+[.)])?[ \t]+/))
            prose = blank(RLENGTH) substr(prose, RLENGTH + 1)
        if (heading && match(prose, /^#+/)) prose = blank(RLENGTH) substr(prose, RLENGTH + 1)
        if (table) gsub(/[|]/, " ", prose)
        if (prose ~ /^[ \t]*$/) next
        lc = tolower(prose)

        for (r = 1; r <= count; r++) {
            if (type[r] == "special") special(r)
            else scan(r, type[r] == "case" ? prose : lc)
        }
        flush()
    }
    ' "$4"
}

out=""
for f in "${files[@]}"; do
    if [ "$f" != "-" ] && [ ! -f "$f" ]; then
        printf '%s: not a file\n' "$f" >&2
        exit 2
    fi
    name=$f
    [ "$f" = "-" ] && name=stdin
    kind=$(kind_of "$f")
    style=""
    [ "$kind" = code ] && style=$(comment_style "$f")
    changelog=0
    case $f in *[Cc][Hh][Aa][Nn][Gg][Ee]*) changelog=1 ;; esac
    result=$(check "$kind" "$style" "$name" "$f" "$changelog") || exit 2
    [ -n "$result" ] && out+="$result"$'\n'
done

[ -n "$out" ] || exit 0
printf '%s' "$out"
printf '%s' "$out" | awk '
    / \[fix: / { fix++ }
    / \[read: / { read++ }
    END { printf "%d to fix, %d to read. Fix each hit or keep it where its rule allows the case.\n", fix, read }'
exit 1
