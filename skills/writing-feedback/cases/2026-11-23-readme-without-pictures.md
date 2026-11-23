---
date: 2026-11-23
verdict: bad
source: README.md of helm-values-lens at commit 0f187aa, 200 lines and 2197 words with 3 screenshots
---

## Verdict
"the readme is way too long and to few images. more images more eye candy and catchy things. less (much) text"

## Text
The opening, above the first picture:

"Helm Values Lens shows in VS Code, next to each line of a values file, the value that the Helm chart ends up with.
A value often gets set in several files, such as the chart's `values.yaml`, a `values-production.yaml` and the Argo CD Application that deploys the chart.
Each of these files adds a layer of values.
The last layer wins.
The hint names that layer and its value.

The extension reads which files feed a release, and in which order, from the files of the tool that deploys the chart: Argo CD, Helmfile, Flux or Kustomize.
A repository that deploys with one of them needs no settings."

Two of the 25 bullets under "What it shows", each describing a sight on screen in words:

"- Next to a value in a values file: the layer that overrides or deletes it, with the final value (`overridden by values-staging.yaml: 1.27-rc`).
- A warning on a key that no chart reads, such as `imgae.tag: read by no chart, ignored by web.`
  Such a key changes nothing in the release and most likely carries a typo or an outdated name.
  Where a release that takes the file did not load, the warning drops to a note, since the extension cannot tell whether its chart reads the key."

From the sections "How it orders the layers" and "These stay out of the trace":

"The test suite compares the merged values with the `COMPUTED VALUES` of `helm install --dry-run=client` for each release."
"- Flux `valuesFiles` that leave out `values.yaml`: Flux then drops the chart defaults, which the trace keeps."

The page went on with a commands table, a table of seven setups, the URL resolution order, a settings table and a settings snippet.

## Patterns
- Reference manual as README: every feature carries its edge cases inline. "Where a release that takes the file did not load, the warning drops to a note". Rule: docs.md "A page" (a short page, one question per page). Cause: Held (both readers moved the edge cases to a linked features page).
- Text where a picture shows it: about 25 bullets describe what appears on screen, against 3 screenshots. "Next to a value in a values file: the layer that overrides or deletes it". Rule: docs.md "A README" lists one picture in the informing shape. Cause: Uncovered (one reader kept 3 pictures, the other dropped to 2. Neither marked a place for another, though the brief invited marking what they could not produce).
- Length past the budget, defended by the shape: 2197 words against page-shape.sh's reference of 800. Rule: docs.md "A page" (a short page) and the page-shape.sh reference. Cause: Conflict (the readers cut to 1588 and 1069 words and kept the rest, citing the README section list and the sentence "The full list, with the fields and variants of each, goes under 'where it works'". page-shape.sh let each number stand once it had a reason). Settled under step 6: that sentence pulled against "a short page" and the user's verdict.
- Internals and limits on the landing page: "How it orders the layers", "These stay out of the trace", the test suite. Rule: docs.md "A README", one line on internals, contributor material on its own page. Cause: Held for the layer order and the test suite (both readers moved them out). One reader kept the list of what stays out of the trace, citing "An unsupported case gets named where the reader would assume it works".
- Concept explained before it is shown: 7 lines of explanation above the first picture. "Each of these files adds a layer of values. The last layer wins." Rule: docs.md "A README", name and what it does in one to three lines, then the picture. Cause: Hard to see (one reader cut to 3 lines, the other kept all 7. The line budget sat inside a list of eleven sections).

## Rewrite
A sketch of the shape, with picture places marked:

```markdown
# Helm Values Lens

See the value that each line of a Helm values file ends up with, right in VS Code.

![A values file with a hint after each value: overridden by values-staging.yaml: 1.27-rc](docs/values-file.png)

Each file of a release adds a layer of values.
The hint names the layer that wins.
It reads the layers from your Argo CD, Helmfile, Flux or Kustomize files.

## What it shows

[GIF: hover over a key, listing every layer of each release]
Hover a key to see every layer that sets it, each linked to its line.

[Screenshot: the warning on imgae.tag]
A warning marks a key that no chart reads, with a quick fix that renames it.

[Screenshot: final values after each .Values read in a template]
A template shows the final value after each `.Values` read.

[GIF: F12 from a template to the values line that wins]
Go to Definition jumps from a template to the values line that wins.

[docs/features.md](docs/features.md) lists every hint, fix and command.
```
