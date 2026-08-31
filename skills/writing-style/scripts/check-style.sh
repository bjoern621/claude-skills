#!/usr/bin/env bash
# Style check for comments and docs.
# Usage: check-style.sh [file ...]; default: files changed vs HEAD.
# Exit 1 on findings. ASCII-art diagram lines can legitimately hit the em-dash check; judge those by eye.
set -uo pipefail

files=("$@")
if [ ${#files[@]} -eq 0 ]; then
    while IFS= read -r f; do files+=("$f"); done < <(git diff --name-only HEAD 2>/dev/null)
fi

fail=0

report() {
    # $1 category, $2 rg output
    [ -z "$2" ] && return
    fail=1
    printf '%s\n' "$2" | while IFS= read -r line; do
        printf '%s: %s\n' "$1" "$line"
    done
}

for f in "${files[@]}"; do
    [ -f "$f" ] || continue

    hits=$(rg -n --no-heading '—|─' "$f" | rg -v '[┌┐└┘├┤┬┴┼╔╗╚╝║═╪]' || true)
    report "EM-DASH/BOX-CHAR $f" "$hits"

    hits=$(rg -n --no-heading '^\s*(#|//|///|--)\s.*\s(the|a|an|of|to|in|on|for|with|its|is|are|was|by|from|that|which|as|at|into|over)$' "$f" || true)
    report "MID-CLAUSE-WRAP $f" "$hits"

    hits=$(rg -n --no-heading -i '\b(no longer|used to be|not yet|moved here from|coming soon|previously)\b' "$f" || true)
    report "CHANGELOG-VOICE $f" "$hits"

    case "$f" in
        *.md)
            hits=$(rg -n --no-heading '[a-z]\. [A-Z]' "$f" | rg -v 'e\.g\.|i\.e\.|etc\.|vs\.|^\s*\d+:\s*([-*+|]|\d+\.)' || true)
            report "MULTI-SENTENCE-LINE $f" "$hits"
            ;;
    esac
done

if [ "$fail" -eq 0 ]; then
    echo "check-style: clean"
fi
exit "$fail"
