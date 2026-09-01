---
name: interface-text
description: Style for user-facing interface text - control labels, help paragraphs, option descriptions, tooltips, error and refusal messages, empty states, any string literal a user reads in an app. Load before writing or editing any user-facing string, however small the edit, in any repository. Use when writing interface text, error messages, tooltips, settings help, refusal or disabled-control explanations, or the user says "reword this text", "user-facing text", "UI copy", "microcopy". Plain conversational register, problem-cause-fix errors, positive framing, no opinions or humor.
---

# Interface text

Governs every string a user reads on screen: labels, help text, option descriptions, tooltips, errors, refusals, empty states.
A user-facing string takes this skill even though it lives in code; comments, docs and commits take [writing-style](../writing-style/SKILL.md) instead.
Full ruleset with examples: [reference.md](reference.md).
Read it before the first copy edit of a session.

## Voice checklist

Apply to every string written or touched:

1. Plain conversational register: full short sentences, everyday words, no narrator.
   Copy passes unnoticed; a sentence with an author's voice in it is rewritten.
2. Neutral by default; "you/your" only where ownership is otherwise ambiguous.
   Never "the user", "the customer" or any third-person name for the person reading.
3. No opinions, no judgment of a choice, no asides, no humor.
   State the trade; the reader decides.
4. Positive contractions allowed ("it's"); negatives spelled out ("cannot", "does not").
5. No self-reference: no "we", no "I", and the concrete part named instead of "this app".

## Shape

- Aim 15 words per sentence, cap 25. One idea per sentence.
- Lead with the fact that carries the decision; detail after.
- Periods and commas only. Colon only before a list or an example. No semicolons.
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
- Standard technical verbs only (holds, targets, refuses, retries, serves); no dramatic agency.
- Not aimed at the user or their input: "error", "failed", "invalid", "illegal", "bad", "abort".
  Instead: "could not", "unable", "incorrect", "not supported", "stop".
- "please" only when asking the user to wait or redo work; "sorry" only for serious loss.
- Identifiers ride in parentheses: "Compressed with the slower method (zstd-19)."
- Positive framing: what is so and what to do.

## Completion criteria

- Every written or touched string passes the checklist and its surface pattern.
- Second pass on every string: read it aloud, cut what carries no fact, keep every fact.
