# Interface text

Every string that a user reads on screen, wherever it lives in the code: labels, buttons, help text, option descriptions, tooltips, dialogs, notifications, error and refusal messages, disabled-control explanations, empty states and CLI output.
The sentence rules in [SKILL.md](SKILL.md) hold for it as well.
On conflict, this page wins for a string on screen.
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
- Result of a check (a diagnostic, a lint warning, a validation hint): the one fact that the result tells the reader.
  The conditions that the check tests stay in the code and its docs.
  "`retry_limit` appears in no handler, no default config and no schema." becomes "The app does not read `retry_limit`."
- A wait names no exact seconds: "Try again in a moment."
- Confirmation of an action that cannot come back: what goes, what stays and whether it comes back, one fact per item.
  "Removes the backups and stops the schedule." becomes "Removes the backups." beside "Stops the schedule."
- Disabled control: why and what enables it.
  "Locked while a backup runs. Stop the backup to change it."
- Option description: the observable effect and when to pick it.
  "Copies what changed since the last run. Faster, but it needs the last run to still be there."
- Tooltip: 25 words at most, adding what the label leaves out.
  Anything that the reader must act on goes in the interface proper.
- Empty state: what is so, then the next step.
  "No saved configurations. Name the configuration below to keep it."
- A screen's description names what it decides.
- A text holds for one item and for several: "two pending files" reads as well as one.

## Words

- The project's language.
  English copy takes American spelling.
- Terms come from the project's design or style document before a new one gets coined.
- Ordinary technical verbs: holds, targets, refuses, retries, serves.
- Problem words name what happened: "could not", "unable", "not supported".
  "error", "failed", "invalid", "illegal" and "fatal" stay out: they aim at the reader.
  "Invalid file name." becomes "The file name cannot contain slashes."
- "please" for a request to wait or redo work, "sorry" for serious loss.
- Identifiers ride in parentheses: "Compressed with the slower method (zstd-19)."
- What is so and what to do.

## Completion criteria

- Every string written or touched has been read against Voice, Shape, its surface and Words.
- A second pass, one string at a time, named the fact that each word carries and cut the words carrying none.
