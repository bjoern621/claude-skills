---
date: 2026-11-17
verdict: bad
source: search-plus-plus src/webview/menu.ts, context menu item
---

## Verdict
"as written is bad. maybe exact match or so? make sure to overhault all the ui text to make good ui text"

## Text
Context menu item: `Find "rpc" as written`
Reason lines in the same menu: `socket: close spelling of secret, 2 edits away.` and `Groesse: spelled-out umlaut of Größe.`
Hint: `The key path skips this query because it ends with a dot. Remove the dot.`

## Patterns
- Label names the effect in the writer's idiom, where the reader expects the term of the field: "as written" for what search tools call an exact match. Rule: SKILL.md "Plain words for a reader outside the field", interface.md "Terms come from the project's design or style document". Cause: untested (the session ran without subagents), likely Narrow, since the rule lists inflated words and tool internals and misses an everyday phrase standing in for the field's term.
- Algorithm term on screen: "2 edits away" for an edit distance. Rule: SKILL.md "A term from a tool's internals gets the plain word". Cause: untested, likely Held.
- A component as the subject of a refusal, with "it" left to mean the query: "The key path skips this query because it ends with a dot." Rule: interface.md "The part that acts gets named". Cause: untested.

## Rewrite
Context menu item: `Match "rpc" exactly`
Reason lines: `socket: 2 letters off from secret.` and `Groesse: Größe written without umlauts.`
Hint: `Key path search is off because the query ends with a dot. Remove the dot.`
