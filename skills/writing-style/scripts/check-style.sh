#!/usr/bin/env bash
# Style check for comments and docs.
# Usage: check-style.sh [file ...]; default: files changed vs HEAD.
# Exit 1 on findings.
# Prose checks read a masked copy: code fences, inline code spans, table rows and Bad:/Good: example lines are blanked, line numbers kept.
# Candidates rather than verdicts, judged by eye: PAIRED-NEGATION, VALUE-GLOSS, WHETHER-LIST, INTENSIFIER, and em-dash hits inside ASCII art.
set -uo pipefail

files=("$@")
if [ ${#files[@]} -eq 0 ]; then
    while IFS= read -r f; do files+=("$f"); done < <(git diff --name-only HEAD 2>/dev/null)
fi

fail=0
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

report() {
    # $1 category, $2 rg output
    [ -z "$2" ] && return
    fail=1
    printf '%s\n' "$2" | while IFS= read -r line; do
        printf '%s: %s\n' "$1" "$line"
    done
}

# Blanks quoted material. One output line per input line, so numbers still point at the source.
mask() {
    awk '
        NR == 1 && /^---[[:space:]]*$/ { front = 1; print ""; next }
        front && /^---[[:space:]]*$/ { front = 0; print ""; next }
        front { print ""; next }
        /^[[:space:]]*```/ { fence = !fence; print ""; next }
        fence { print ""; next }
        /^[[:space:]]*\|/ { print ""; next }
        /^[[:space:]]*[-*]?[[:space:]]*\**(Bad|Good)[^:]{0,20}:/ { print ""; next }
        { gsub(/`[^`]*`/, " "); gsub(/"[^"]*"/, " "); print }
    ' "$1"
}

for f in "${files[@]}"; do
    [ -f "$f" ] || continue
    mask "$f" > "$tmp"

    hits=$(rg -n --no-heading '—|─' "$f" | rg -v '[┌┐└┘├┤┬┴┼╔╗╚╝║═╪]' || true)
    report "EM-DASH/BOX-CHAR $f" "$hits"

    hits=$(rg -n --no-heading '^\s*(#|//|///|--)\s.*\s(the|a|an|of|to|in|on|for|with|its|is|are|was|by|from|that|which|as|at|into|over)$' "$f" || true)
    report "MID-CLAUSE-WRAP $f" "$hits"

    # Comment opening on a literal value, so the prose after it restates the line below.
    hits=$(rg -n --no-heading -i '^\s*(#|//|///|--|;)\s*"?(-?[0-9]+(\.[0-9]+)?|true|false|on|off|yes|no|none|null|nil|empty)"?\s*[:=]\s*\S' "$tmp" || true)
    report "VALUE-GLOSS $f" "$hits"

    hits=$(rg -n --no-heading -i '\b(no longer|used to be|not yet|moved here from|coming soon|previously)\b' "$tmp" || true)
    report "CHANGELOG-VOICE $f" "$hits"

    hits=$(rg -n --no-heading -i ',\s+(not|never)\s+[a-z]|\band never\b|\bnot\s+\w+\s+but\b|\bnot (just|only|merely)\b.*\bbut\b' "$tmp" || true)
    report "PAIRED-NEGATION $f" "$hits"

    hits=$(rg -n --no-heading -i '\b(delve[sd]?|intricate|pivotal|underscore[sd]?|testament|meticulous|garner\w*|myriad|plethora|paramount|tapestry|multifaceted|burgeoning|cornerstone)\b' "$tmp" || true)
    report "INFLATED-WORD $f" "$hits"

    hits=$(rg -n --no-heading -i '\b(serves?|stands?|functions?|operates?) as\b|\b(leverag|utiliz|facilitat|streamlin|harness)\w*\b' "$tmp" || true)
    report "INFLATED-VERB $f" "$hits"

    hits=$(rg -n --no-heading -i '\b(could potentially|may possibly|might potentially|probably|perhaps)\b|\bin some cases,? (may|might|could)\b' "$tmp" || true)
    report "HEDGE $f" "$hits"

    hits=$(rg -n --no-heading -i ',\s+(improving|enhancing|ensuring|reflecting|underscoring|highlighting|showcasing|demonstrating|signaling)\b' "$tmp" || true)
    report "PARTICIPIAL-TACK-ON $f" "$hits"

    hits=$(rg -n --no-heading -i '\b(studies (show|suggest)|research (suggests|indicates)|experts (agree|argue)|best practice suggests)\b|\bin (connection|association) with\b' "$tmp" || true)
    report "VAGUE-ATTRIBUTION $f" "$hits"

    hits=$(rg -n --no-heading -i '\b(oaicite|turn[0-9]+search[0-9]+|contentReference|attributableIndex)\b|^(certainly|sure|of course|great question)[!,]|\b(i hope this helps|let me know if you need|as an ai|as a language model)\b' "$tmp" || true)
    report "CHAT-LEAKAGE $f" "$hits"

    hits=$(rg -n --no-heading -i '\b(speaks? for (itself|themselves)|tells? a story|paints? a picture)\b|\bto ensure (clarity|correctness|completeness)\b|\ba more (complete|thorough) solution\b' "$tmp" || true)
    report "SELF-NARRATION $f" "$hits"

    # Fronted concessive only, so a subordinate "ask whether ..." passes.
    hits=$(rg -n --no-heading '(^|\. )[Ww]hether (it.s|the|a|an|this)\b[^.]{0,60}\bor\b' "$tmp" || true)
    report "WHETHER-LIST $f" "$hits"

    hits=$(rg -n --no-heading -i '\b(very|truly|fundamentally|essentially|absolutely|literally)\b' "$tmp" || true)
    report "INTENSIFIER $f" "$hits"

    case "$f" in
        *.md)
            # Bullets are line-oriented, so several short sentences on one are the intended shape.
            hits=$(rg -n --no-heading '[a-z]\. [A-Z]' "$tmp" | rg -v 'e\.g\.|i\.e\.|etc\.|vs\.|^\d+:\s*[-*]\s' || true)
            report "MULTI-SENTENCE-LINE $f" "$hits"

            hits=$(rg -n --no-heading -i '^#+\s+(challenges and|future (outlook|prospects)|overview\s*$)|^#+\s+\w+ (things|reasons|ways|takeaways)\b' "$tmp" || true)
            report "BOILERPLATE-HEADING $f" "$hits"

            hits=$(rg -n --no-heading '^\s*[-*]\s+\*\*[^*]+\*\*:' "$tmp" || true)
            report "BOLD-LABEL-BULLET $f" "$hits"

            hits=$(rg -n --no-heading -i '^\s*(additionally|furthermore|moreover|in addition|overall|nevertheless),' "$tmp" || true)
            report "TRANSITION-OPENER $f" "$hits"
            ;;
    esac
done

if [ "$fail" -eq 0 ]; then
    echo "check-style: clean"
fi
exit "$fail"
