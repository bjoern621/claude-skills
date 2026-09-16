---
name: interface-text
description: Style for any string a user reads. Covers labels, help text, option descriptions, tooltips, dialog and notification text, error and refusal messages, disabled-control explanations, empty states, CLI output. Load before writing or editing one, however small the edit, and when the user says "reword this", "user-facing text", "UI copy" or "microcopy".
---

# Interface text

Governs every string a user reads on screen, whichever surface renders it.
A user-facing string takes this skill even though it lives in code; comments, docs and commits take [writing-style](../writing-style/SKILL.md) instead.
A string an agent reads, a tool description or a prompt file, takes neither skill.
Full ruleset with examples: [reference.md](reference.md).
Open its section for the surface being written, before the first copy edit of a session.

## Voice checklist

Apply to every string written or touched:

1. Plain conversational register: full short sentences, everyday words, no narrator.
   Copy passes unnoticed; a sentence with an author's voice in it is rewritten.
2. Neutral by default; "you/your" only where ownership is otherwise ambiguous.
   Never "the user", "the customer" or any third-person name for the person reading.
3. State the trade and let the reader decide.
   Opinions, judgments of a choice, asides and humor stay out.
4. Positive contractions allowed ("it's"); negatives spelled out ("cannot", "does not").
5. Name the part that acts: "the sync service", "the installer".
   "We", "I" and "this app" stay out.

## Shape

- Aim 15 words per sentence, cap 25. One idea per sentence.
- Lead with the fact that carries the decision; detail after.
- Periods, commas, and a colon before a list or an example. Nothing else.
- Sentence case everywhere. A fragment carries no period; a full sentence does.

## Pattern per surface

- Error or refusal: problem, cause, fix. Fix named only where one exists.
- Disabled control: why it is unavailable, and what enables it. Never a dead end.
- Option description: what it does, when to pick it.
- Tooltip: 25 words at most, adding what the label leaves out.
- Empty state: what is so, then the next step.

## Words

- American English, one variant throughout.
- One term per concept, fixed in one place the project owns. Read the project's design or style document before coining a name.
- Verbs normal in technical writing, such as holds, targets, refuses, retries, serves. No dramatic agency.
- Name what happened: "could not", "unable", "incorrect", "not supported", "stop".
  "error", "failed", "invalid", "illegal", "bad", "abort" and "fatal" aim at the user or their input.
- "please" only when asking the user to wait or redo work; "sorry" only for serious loss.
- Identifiers ride in parentheses: "Compressed with the slower method (zstd-19)."
- Positive framing: what is so and what to do.

## Completion criteria

- Every written or touched string passes the checklist, its surface pattern, and the Shape and Words rules.
- Second pass, one string at a time: name the fact each word carries, and cut the words that carry none.
