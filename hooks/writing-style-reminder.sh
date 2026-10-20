#!/usr/bin/env bash
# $1: hook event name, echoed back so the host accepts the payload.
# $2: surface, "prompt" or "source".
# Messages hold no " or \: printf writes them into the JSON unescaped.
set -eu

event=$1
surface=${2:-source}

core="Say what a thing does, with no 'X is a Y'. One independent clause per sentence."

case $surface in
prompt)
    message="Load writing-style before repository prose that a human reads and interface-text before a string on screen, however small the edit. $core"
    ;;
*)
    message="writing-style governs repository prose that a human reads. Load it before this edit unless it is already loaded. $core One sentence per source line, a paragraph per line in a PR, issue or wiki body. interface-text governs a string on screen."
    ;;
esac

printf '{"hookSpecificOutput":{"hookEventName":"%s","additionalContext":"%s"}}\n' "$event" "$message"
