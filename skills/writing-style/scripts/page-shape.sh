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
    pointers=$(rg -o '`[^`]+`' "$f" 2>/dev/null | rg -c '/|\.(go|cs|md|ya?ml|axaml|json|sh)' || echo 0)
    longest=$(awk '/^## /{if(c>m)m=c; c=0; next} {c++} END{if(c>m)m=c; print m+0}' "$f")

    wpl=$(awk -v w="$prose_words" -v l="$prose_lines" 'BEGIN{ if(l) printf "%.1f", w/l; else print "0" }')
    wpd=$(awk -v w="$words" -v d="$diagrams" 'BEGIN{ if(d) printf "%d", w/d; else print "-" }')
    ptr_share=$(awk -v p="$pointers" -v s="$spans" 'BEGIN{ if(s) printf "%d%%", 100*p/s; else print "-" }')

    printf '%s\n' "$f"
    printf '  words %s, prose lines %s\n' "$words" "$prose_lines"
    printf '  words per prose line  %s   (reference shape under 15, read the page over 20)\n' "$wpl"
    printf '  words per diagram     %s   (reference shape under 400, read the page over 1500, %s diagrams)\n' "$wpd" "$diagrams"
    printf '  code spans            %s, of which pointers %s (%s)   (reference shape over 50%%)\n' "$spans" "$pointers" "$ptr_share"
    printf '  longest section       %s lines   (reference shape under 30, read the page over 40)\n' "$longest"

    over=$(awk -v wpl="$wpl" -v longest="$longest" -v d="$diagrams" -v w="$words" -v p="$pointers" -v s="$spans" '
        BEGIN {
            n = 0
            if (wpl + 0 > 20) n++
            if (longest + 0 > 40) n++
            if (d == 0 && w > 800) n++
            if (d > 0 && w / d > 1500) n++
            # A page defining terms carries few pointers by design, so this one is judged by eye.
            if (s >= 20 && 100 * p / s < 25) n++
            print n
        }')
    if [ "$over" -gt 0 ]; then
        printf '  %s signal(s) outside the reference shape. Read the page.\n' "$over"
        fail=1
    fi
done

exit "$fail"
