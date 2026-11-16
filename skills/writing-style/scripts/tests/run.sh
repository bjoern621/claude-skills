#!/usr/bin/env bash
# Runs style-check.sh on the fixtures beside this file and compares its hits with expected.txt.
# Usage: run.sh
set -uo pipefail

cd "$(dirname "$0")" || exit 2
check=../style-check.sh
fail=0

# Prints "file:line:col id" per hit.
hits() { awk '/^[^ ]+:[0-9]+:[0-9]+ / { sub(/:$/, "", $2); print $1, $2 }'; }

expect() {
    if [ "$2" = "$3" ]; then
        printf 'ok    %s\n' "$1"
    else
        printf 'FAIL  %s\n' "$1"
        diff <(printf '%s\n' "$2") <(printf '%s\n' "$3") | sed 's/^/      /'
        fail=1
    fi
}

actual=$({
    for f in hits.md commit.msg comments.ts comments.py; do bash "$check" "$f"; done
    bash "$check" --as ui strings.txt
} | hits)
expect "every fixture hit matches expected.txt" "$(cat expected.txt)" "$actual"

out=$(bash "$check" clean.md)
expect "clean.md passes with no output and exit 0" "0:" "$?:$out"

bash "$check" hits.md >/dev/null
expect "a hit exits 1" "1" "$?"

expect "stdin reads as a commit message" \
    "$(rg '^commit\.msg:' expected.txt | sed 's/^commit\.msg:/stdin:/')" \
    "$(bash "$check" <commit.msg | hits)"

expect "--rule keeps the named rules alone" \
    "$(rg ' (em-dash|well)$' expected.txt)" \
    "$(bash "$check" --rule em-dash,well hits.md | hits)"

bash "$check" --rule no-such-rule hits.md >/dev/null 2>&1
expect "an unknown rule exits 2" "2" "$?"

exit "$fail"
