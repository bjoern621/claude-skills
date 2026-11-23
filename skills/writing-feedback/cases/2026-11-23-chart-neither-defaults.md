---
date: 2026-11-23
verdict: bad
source: Helm Values Lens diagnostic for an unknown key and its README bullet, before commits 93241a7 and 0f0c488 in helm-values-lens
---

## Verdict
On the first text, with the VS Code diagnostics on screen: "what does "defaults" mean here?"
On the first rewrite: "but is "chart xyz does not read xxx.enabled" ckearer?"

## Text
The diagnostic, one per flagged key:
"web-staging: the chart web neither defaults nor reads imgae.tag"

The README bullet:
"An information marker on a key that the chart neither defaults nor reads, most likely a misspelled or outdated key."

The first rewrite of the diagnostic, in commit 93241a7:
"web-staging: the chart web has no default for imgae.tag and no template that reads it"

## Patterns
- Field shorthand used as a verb: "the chart neither defaults nor reads". "defaults" stands for "has a default value in values.yaml". Rule: SKILL.md "Plain words for a reader outside the field". Cause: Held (one reader wrote "has no imgae.tag in its values.yaml", the other "sets no default for").
- Two checks packed into one "neither ... nor" negation that the reader must unpack: "neither defaults nor reads". Rule: SKILL.md "One independent clause per sentence" (one subject with two verbs) and reference.md, the negation on the verb. Cause: Held (both readers gave the chart two verbs, each with its own negation: "has no ... and never reads").
- The conditions of a check in place of the one fact that its result tells the reader: "has no default for imgae.tag and no template that reads it". The reader needs "does not read", since such a key changes nothing in the release. The default condition only narrows the set of flagged keys. Rule: none for a message on a check. SKILL.md "A sentence agrees with the code" pulled the other way. Cause: Uncovered and Ambiguous (two readers handed the check in the code's terms listed its conditions, one adding values.schema.json as a third. Both cited "A sentence agrees with the code" and refused a claim on the key's effect).

The first two readers got the check in plain words ("no entry for that key and no template file of the chart refers to it"), which the original writer knew as well.
The last two got it in the code's terms (`chartDefault`, `readPaths`, `schemaField`).
The same phrase had passed in German in the 2026-11-22 case ("den der Chart weder als Default hat noch liest"), where no pattern named it.

## Rewrite
The user's version, as commit 0f0c488 ships it:
"web-staging: the chart web does not read imgae.tag"

The README bullet:
"An information marker on a key that the chart does not read, such as `the chart web does not read imgae.tag`.
Such a key changes nothing in the release and most likely carries a typo or an outdated name."
