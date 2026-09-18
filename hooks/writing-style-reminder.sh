#!/usr/bin/env bash
# $1: hook event name, echoed back so the host accepts the payload.
# $2: surface, selecting the line-break clause that applies there.
set -eu

event=$1
surface=${2:-source}

copula="Labelling copula 'X is a Y' is banned. Say what the thing does."

case $surface in
prompt)
    message="Load writing-style before repository prose a human reads, and interface-text before a string a user reads. However small the edit. $copula"
    ;;
rendered)
    message="writing-style governs this page. Load it unless it is already loaded. $copula A rendered editor takes no hard wrapping: a paragraph goes in as one line."
    ;;
*)
    message="writing-style governs every word written into this repository. Load it before this edit unless it is already loaded. $copula One sentence per source line. Break a sentence at punctuation or a conjunction in code comments alone."
    ;;
esac

printf '{"hookSpecificOutput":{"hookEventName":"%s","additionalContext":"%s"}}\n' "$event" "$message"
