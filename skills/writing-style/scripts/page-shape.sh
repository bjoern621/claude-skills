#!/usr/bin/env bash
# Page-shape measurement for Markdown docs.
# Usage: page-shape.sh <page.md> [page.md ...]
# Locates the page worth re-reading. A signal outside the reference shape wants a reason, not an automatic edit.
set -uo pipefail

fail=0

for f in "$@"; do
    if [ ! -f "$f" ]; then
        printf '%s: not a file\n' "$f"
        fail=1
        continue
    fi

    # Prose lines only: fences, fence bodies, table rows and headings excluded.
    read -r prose_lines prose_words <<<"$(awk '
        /^[[:space:]]*```/ { fence = !fence; next }
        fence { next }
        /^[[:space:]]*$/ { next }
        /^[[:space:]]*\|/ { next }
        /^[[:space:]]*#/ { next }
        { lines++; words += NF }
        END { printf "%d %d", lines, words }
    ' "$f")"

    words=$(wc -w < "$f")
    diagrams=$(rg -c '^```mermaid' "$f" 2>/dev/null || echo 0)
    spans=$(rg -o '`[^`]+`' "$f" 2>/dev/null | wc -l)
    # Implementation vocabulary: a source file, a package path or a dotted code identifier.
    # A route, a bare directory, a config key and a config file are contract, so none of them match.
    impl=$(rg -o '`[^`]+`' "$f" 2>/dev/null \
        | rg -v '`[^`]*\.(md|ya?ml|json|toml|ini|conf|env)`' \
        | rg -c \
        '\.(go|cs|axaml|ts|tsx|jsx?|py|rs|java|rb|kt|swift|c|cc|cpp|h|hpp|php|scala|ex|dart)`|(^|/)(internal|pkg|cmd|src|lib|app)/|`[A-Za-z_][A-Za-z0-9_]*\.[A-Za-z_][A-Za-z0-9_]*`' \
        || echo 0)
    longest=$(awk '/^## /{if(c>m)m=c; c=0; next} {c++} END{if(c>m)m=c; print m+0}' "$f")

    wpl=$(awk -v w="$prose_words" -v l="$prose_lines" 'BEGIN{ if(l) printf "%.1f", w/l; else print "0" }')
    wpd=$(awk -v w="$words" -v d="$diagrams" 'BEGIN{ if(d) printf "%d", w/d; else print "-" }')

    # A README gets a budget of its own, since its reader skims and its pictures carry what shows on screen.
    is_readme=0
    case "$(basename "$f")" in *README*|*readme*) is_readme=1 ;; esac
    pictures=$(rg -c '!\[[^]]*\]\(|<img ' "$f" 2>/dev/null || echo 0)
    # Prose lines above the first picture, or -1 for a page without one.
    before_picture=$(awk '
        /!\[[^]]*\]\(|<img / { found = 1; exit }
        /^[[:space:]]*```/ { fence = !fence; next }
        fence { next }
        /^[[:space:]]*$/ { next }
        /^[[:space:]]*#/ { next }
        { n++ }
        END { print (found ? n + 0 : -1) }
    ' "$f")
    wpp=$(awk -v w="$words" -v p="$pictures" 'BEGIN{ if(p) printf "%d", w/p; else print "-" }')

    printf '%s\n' "$f"
    printf '  words                 %s   (reference shape under 800, read the page over 1500)\n' "$words"
    printf '  prose lines           %s\n' "$prose_lines"
    printf '  words per prose line  %s   (reference shape under 15, read the page over 20)\n' "$wpl"
    printf '  words per diagram     %s   (reference shape under 400, read the page over 1500, %s diagrams)\n' "$wpd" "$diagrams"
    printf '  code spans            %s, of which implementation %s   (reference shape 0)\n' "$spans" "$impl"
    printf '  longest section       %s lines   (reference shape under 30, read the page over 40)\n' "$longest"
    if [ "$is_readme" -eq 1 ]; then
        printf '  README words          %s   (README shape under 800)\n' "$words"
        printf '  lines before picture  %s   (README shape 1 or 2, -1 without a picture)\n' "$before_picture"
        printf '  words per picture     %s   (README shape under 200, %s pictures)\n' "$wpp" "$pictures"
    fi

    over=$(awk -v wpl="$wpl" -v longest="$longest" -v d="$diagrams" -v w="$words" -v p="$impl" \
        -v r="$is_readme" -v bp="$before_picture" -v pics="$pictures" '
        BEGIN {
            n = 0
            if (w > 1500) n++
            if (wpl + 0 > 20) n++
            if (longest + 0 > 40) n++
            if (d == 0 && w > 800) n++
            if (d > 0 && w / d > 1500) n++
            # A page whose subject is the code names it on purpose, so this one is judged by eye.
            if (p > 0) n++
            if (r == 1 && w > 800) n++
            if (r == 1 && (bp < 0 || bp > 2)) n++
            if (r == 1 && pics > 0 && w / pics > 200) n++
            print n
        }')
    if [ "$over" -gt 0 ]; then
        printf '  %s signal(s) outside the reference shape. Read the page.\n' "$over"
        fail=1
    fi
done

exit "$fail"
