#!/usr/bin/env bash
# Page-shape measurement for Markdown docs.
# Usage: page-shape.sh <page.md> [page.md ...]
# Locates the page worth re-reading. A signal outside the reference shape wants a reason, not an automatic edit.
# Reference shape: docs/auth-flow.md.
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
    # Implementation vocabulary: a source file, a package path, or a dotted code identifier.
    # A route, a bare directory, a config key and a config file are contract, so none of them match.
    impl=$(rg -o '`[^`]+`' "$f" 2>/dev/null \
        | rg -v '`[^`]*\.(md|ya?ml|json|toml|ini|conf|env)`' \
        | rg -c \
        '\.(go|cs|axaml|ts|tsx|jsx?|py|rs|java|rb|kt|swift|c|cc|cpp|h|hpp|php|scala|ex|dart)`|(^|/)(internal|pkg|cmd|src|lib|app)/|`[A-Za-z_][A-Za-z0-9_]*\.[A-Za-z_][A-Za-z0-9_]*`' \
        || echo 0)
    longest=$(awk '/^## /{if(c>m)m=c; c=0; next} {c++} END{if(c>m)m=c; print m+0}' "$f")

    wpl=$(awk -v w="$prose_words" -v l="$prose_lines" 'BEGIN{ if(l) printf "%.1f", w/l; else print "0" }')
    wpd=$(awk -v w="$words" -v d="$diagrams" 'BEGIN{ if(d) printf "%d", w/d; else print "-" }')

    printf '%s\n' "$f"
    printf '  words                 %s   (reference shape under 800, read the page over 1500)\n' "$words"
    printf '  prose lines           %s\n' "$prose_lines"
    printf '  words per prose line  %s   (reference shape under 15, read the page over 20)\n' "$wpl"
    printf '  words per diagram     %s   (reference shape under 400, read the page over 1500, %s diagrams)\n' "$wpd" "$diagrams"
    printf '  code spans            %s, of which implementation %s   (reference shape 0)\n' "$spans" "$impl"
    printf '  longest section       %s lines   (reference shape under 30, read the page over 40)\n' "$longest"

    over=$(awk -v wpl="$wpl" -v longest="$longest" -v d="$diagrams" -v w="$words" -v p="$impl" '
        BEGIN {
            n = 0
            if (w > 1500) n++
            if (wpl + 0 > 20) n++
            if (longest + 0 > 40) n++
            if (d == 0 && w > 800) n++
            if (d > 0 && w / d > 1500) n++
            # A page whose subject is the code names it on purpose, so this one is judged by eye.
            if (p > 0) n++
            print n
        }')
    if [ "$over" -gt 0 ]; then
        printf '  %s signal(s) outside the reference shape. Read the page.\n' "$over"
        fail=1
    fi
done

exit "$fail"
