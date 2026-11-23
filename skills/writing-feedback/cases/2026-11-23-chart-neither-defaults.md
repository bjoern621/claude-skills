---
date: 2026-11-23
verdict: bad
source: Helm Values Lens diagnostic for an unknown key and its README bullet, before commit 93241a7 in helm-values-lens
---

## Verdict
The user showed the VS Code diagnostics and asked: "what does "defaults" mean here?"

## Text
The diagnostic, one per flagged key:
"web-staging: the chart web neither defaults nor reads imgae.tag"

The README bullet:
"An information marker on a key that the chart neither defaults nor reads, most likely a misspelled or outdated key."

## Patterns
- Field shorthand used as a verb: "the chart neither defaults nor reads". "defaults" stands for "has a default value in values.yaml". Rule: SKILL.md "Plain words for a reader outside the field". Cause: Held (one reader wrote "has no imgae.tag in its values.yaml", the other "sets no default for").
- Two checks packed into one "neither ... nor" negation that the reader must unpack: "neither defaults nor reads". Rule: SKILL.md "One independent clause per sentence" (one subject with two verbs) and reference.md, the negation on the verb. Cause: Held (both readers gave the chart two verbs, each with its own negation: "has no ... and never reads").

The brief handed both readers the check in plain words ("no entry for that key and no template file of the chart refers to it"), which the original writer knew as well.
The same phrase had passed in German in the 2026-11-22 case ("den der Chart weder als Default hat noch liest"), where no pattern named it.

## Rewrite
The diagnostic as commit 93241a7 ships it:
"web-staging: the chart web has no default for imgae.tag and no template that reads it"

The README bullet:
"An information marker on a key without a default in the chart and without a template that reads it, such as `the chart web has no default for imgae.tag and no template that reads it`.
Such a key changes nothing in the release and most likely carries a typo or an outdated name."
