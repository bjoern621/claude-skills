---
date: 2026-11-23
verdict: bad
source: a Helm Values Lens diagnostic proposed in a chat reply, for a key in a values file that several releases share
---

## Verdict
"but remove this "defaults it" thats weird??? isnt it? when sth isnt read then its not read!"

## Text
The release, chart, file and key names stand in for the user's own.

"No release that reads globals.yaml reads global.storage.secretPath: neither platform nor web defaults it or reads it in a template."

## Patterns
- The conditions of a check in place of the one fact that its result tells the reader: "defaults it or reads it in a template". The user thinks in the effect: the chart ignores the key. Rule: interface.md "Result of a check", added in v2.9.0 after the chart-neither-defaults case. Cause: Held (both readers wrote "The charts platform and web do not read global.storage.secretPath." and cited that rule).
- One verb in two senses in one sentence: "No release that reads globals.yaml reads global.storage.secretPath". A release reads a file, a chart reads a key. Rule: SKILL.md "Terms and names", two concepts that a reader could merge stay apart. Cause: Held (both readers made the chart the subject and named the two senses of "reads").
- A negated actor: "No release ... reads". Rule: reference.md, the negation on the verb. Cause: Held (both readers put "do not read" on the chart).

The writer ran the plugin at f415f5b, which predates v2.9.0.
That install lacked the rule on the result of a check.
The repeat came from a session that had loaded the skill before the release.
Both readers got the check in the code's terms (`isUnknownKey`, `chartDefault`, `readPaths`, `schemaField`) and the current `writing-style`.

## Rewrite
"platform and web read globals.yaml. Neither chart reads global.storage.secretPath."
