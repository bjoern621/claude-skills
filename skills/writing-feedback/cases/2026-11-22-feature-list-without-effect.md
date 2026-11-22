---
date: 2026-11-22
verdict: bad
source: an agent's chat reply announcing Helm Values Lens v1.0.0, and the README intro of helm-values-lens before commit 237d55c
---

## Verdict
"du sagst "Was es kann: - Setups ohne Konfiguration: Argo CD Application (einzelne source und sources, $ref-Values-Dateien), ApplicationSet (Generatoren list, git, matrix, merge), App-of-Apps, Helmfile (auch .gotmpl), Flux HelmRelease (mit valuesFrom und targetPath), Kustomize helmCharts." aber wass soll das alles heißen??? setup ohne konfiguraito und dann istest du einfach irgendwelche tech stacks auf... sage mir die readme etc was ist es und welch efeatures du hs"

## Text
The chat reply, trimmed:

```
**Was es kann:**
- **Setups ohne Konfiguration:** Argo CD Application (einzelne `source` und `sources`, `$ref`-Values-Dateien), ApplicationSet (Generatoren `list`, `git`, `matrix`, `merge`), App-of-Apps, Helmfile (auch `.gotmpl`), Flux HelmRelease (mit `valuesFrom` und `targetPath`), Kustomize `helmCharts`.
- **Chart ohne Deployment-Datei:** ein Release mit den Chart-Defaults, dazu eins pro `values-<env>.yaml`.
- **Hints in Values-Dateien:** `overridden by X: <final>`, `also set by X`, `= chart default`, ein Info-Marker bei einem Key, den der Chart weder als Default hat noch liest.
```

The README intro in the same shape:

"Helm Values Lens shows in VS Code where each Helm value gets set, which layer overrides it and the value that the chart renders with.
It reads the order of the values files from the files that deploy your charts: Argo CD Applications and ApplicationSets, Helmfiles, Flux HelmReleases and Kustomize `helmCharts`.
A repository with one of those needs no setup."

## Patterns
- Feature list without a line on what the software does: "Was es kann:" followed straight by "Setups ohne Konfiguration". Rule: docs.md "A README" (name and what it does in one to three lines) covers the README alone. Cause: Uncovered for release notes (both readers opened Text 1 on "Helm Values Lens liest die Reihenfolge" or "erkennt diese Setups", with no line on what the user sees).
- Benefit label with nothing to attach it to: "Setups ohne Konfiguration:" and "needs no setup". Rule: SKILL.md "Terms and names", a term gets its meaning at first use. Cause: Narrow (both readers kept "needs no setup" and one kept "Setups ohne Konfiguration" word for word, since the rule reads as aimed at terms of the field).
- Inventory of supported inputs in place of effects, with spec fields packed into parentheses: "ApplicationSet (Generatoren `list`, `git`, `matrix`, `merge`)". Rule: docs.md "A README", what it does as one checkable fact per line. Cause: Narrow, with a Conflict settled under step 6 (both readers split the inventory into six bullets and kept every field, citing the closed-set exception of SKILL.md "Leave numbers and lists open").
- Hint strings quoted without what each tells the reader: "`overridden by X: <final>`, `also set by X`, `= chart default`". Rule: SKILL.md "Terms and names" and "Behaviour". Cause: Held (both readers gave each hint its meaning or marked the missing fact as a gap).

## Scope
The text sat in a chat reply, which follows the `caveman` plugin.
The same shape sat in the README intro.
The reply summarised the README and the release.
docs.md "A README" takes the rules on what it does, the benefit and the inventory.
docs.md "A changelog" takes the opening of notes that announce the software.
The closed-set exception pulled against the README shape in one sentence alone.
The edit placed the full set in the reference where the reader looks it up.

## Rewrite
The chat reply:

```
Helm Values Lens zeigt in VS Code neben jeder Zeile einer Values-Datei, welchen Wert der Helm-Chart am Ende bekommt und welche Datei ihn setzt.

- Die Reihenfolge der Values-Dateien liest die Extension aus der Datei, die den Chart deployt: einer Argo CD Application oder ApplicationSet, einer `helmfile.yaml`, einer Flux HelmRelease oder einer `kustomization.yaml`. Du musst nichts einstellen.
- Ein Chart ohne solche Datei bekommt ein Release mit seinen Defaults und eins pro `values-<env>.yaml`.
- `overridden by values-staging.yaml: 1.27-rc`: eine spätere Datei überschreibt den Wert, mit dem Wert, der am Ende gilt.
- `also set by helm.valuesObject`: eine spätere Datei setzt denselben Wert noch einmal.
- `= chart default`: die Zeile ändert nichts, der Chart hat den Wert schon.
- Ein Info-Marker an einem Key, den der Chart weder als Default hat noch liest, meist ein vertippter oder veralteter Key.
```

The README intro: commit 237d55c in helm-values-lens.
