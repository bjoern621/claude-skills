---
name: interface-text
description: Style for any string that a user reads on screen. Covers labels, buttons, help text, option descriptions, tooltips, dialogs, notifications, error and refusal messages, disabled-control explanations, empty states and CLI output. Load before writing or editing one, however small the edit. Also load it when the user says "UI copy".
---

# Interface text

Governs every string that a user reads on screen, wherever it lives in the code.
Comments, docs and commits follow `writing-style`.
A string that an agent reads (a tool description, a prompt) follows `writing-for-agents`.

## Voice

Copy reads like a competent colleague talking and passes unnoticed.
A sentence that the reader stops to admire or decode gets rewritten.
- Full short sentences in everyday words.
  A fragment fits where the surface holds one: a chip, a table cell, a list note.
- The person reading goes unnamed or gets "you", the latter where ownership would blur otherwise.
  "the user", "the customer", "we", "I" and "this app" stay out.
- The part that acts gets named: "the sync service", "the installer".
- Actions take the imperative: "Pick a different backup schedule."
- Facts and trades, with the decision left to the reader.
  Opinions, verdicts on a choice, jokes and asides stay out.
- Positive contractions ("it's"), negatives spelled out ("cannot").

## Shape

- About 15 words per sentence, 25 at most, one idea each.
- The fact that carries the decision comes first.
- Periods, commas, parentheses around an identifier and a colon before a list or an example.
  No `;`, `!` or dashes.
- Sentence case everywhere.
  A fragment standing alone (a label, a chip, a cell) ends without a period.
  A sentence or a fragment in running text ends with one.

## Per surface

- Error or refusal: problem, cause, fix, with exact names and the reader's own values.
  The fix appears where one exists.
  "The converter is not installed, so the importer cannot read this format. Install it or export as CSV."
- Disabled control: why and what enables it.
  "Locked while a backup runs. Stop the backup to change it."
- Option description: the observable effect and when to pick it.
  "Copies what changed since the last run. Faster, but it needs the last run to still be there."
- Tooltip: 25 words at most, adding what the label leaves out.
  Anything that the reader must act on goes in the interface proper.
- Empty state: what is so, then the next step.
  "No saved configurations. Name the configuration below to keep it."
- A screen's description names what it decides.
  A list of what it holds goes false with the next addition.

## Words

- American English.
- One term per concept, taken from the project's design or style document before coining a new one.
- Ordinary technical verbs: holds, targets, refuses, retries, serves.
- Problem words name what happened: "could not", "unable", "not supported".
  "error", "failed", "invalid", "illegal" and "fatal" stay out: they aim at the reader.
  "Invalid file name." becomes "The file name cannot contain slashes."
- "please" for a request to wait or redo work, "sorry" for serious loss.
- Identifiers ride in parentheses: "Compressed with the slower method (zstd-19)."
- What is so and what to do.
  An absence gets named only where the reader would try to restore it.
- The current state, with "no longer", "not yet" and "new" left out: the reader holds no earlier version.
- "well" appears as "as well", a water well or good health.
  Every other sense takes another word.

## Completion criteria

- Every string written or touched has been read against Voice, Shape, its surface and Words.
- A second pass, one string at a time, named the fact that each word carries and cut the words carrying none.
