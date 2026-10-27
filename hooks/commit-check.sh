#!/usr/bin/env bash
# Holds each distinct git commit command once per session for a fact check.
# Running the same command again lets it through; a changed message gets held again.
# Reads the PreToolUse payload of a Bash call on stdin.
# The reason holds no " or \: printf writes it into the JSON unescaped.
set -eu

payload=$(cat)

command_re='"command":"(([^"\\]|\\.)*)"'
[[ $payload =~ $command_re ]] || exit 0
command=${BASH_REMATCH[1]}

commit_re='(^|[^[:alnum:]_.-])git([[:space:]]+[^;&|[:space:]]+)*[[:space:]]+commit([[:space:]]|\\n|$)'
[[ $command =~ $commit_re ]] || exit 0

session_re='"session_id":"([[:alnum:]_-]+)"'
session=unknown
[[ $payload =~ $session_re ]] && session=${BASH_REMATCH[1]}

state_dir=${XDG_RUNTIME_DIR:-/tmp}/bjoern-commit-check
mkdir -p "$state_dir"
seen=$state_dir/$session
hash=$(printf '%s' "$command" | sha256sum | cut -d' ' -f1)

grep -qxF "$hash" "$seen" 2>/dev/null && exit 0
printf '%s\n' "$hash" >>"$seen"

reason="Commit held once for a check, since a pushed message stays as written. Reread the subject and body against the staged diff. Check every claim about a tool, a state, an error or a term against its source: the tool's output, its docs or the code. Write a tool's state in the tool's own words. Fix the message where a claim fails, then run the commit again."

printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$reason"
