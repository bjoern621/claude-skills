---
name: writing-style
description: Writing style for everything committed to a repository - code comments, YAML/TOML/config comments, docstrings, markdown docs, commit and PR bodies. Load before writing or editing any of these, however small the edit, in any repository. Use when writing or editing comments, documenting, editing manifests or configs that carry comments, writing a README or docs page, restructuring or splitting a docs page, drafting a commit message, or the user says "fix comments", "rewrite comments", "too verbose", "clean up docs". Enforces clipped comments, wrapping at punctuation, one sentence per markdown line, time-agnostic docs, no paired negation ("X, not Y"), page shape (one thesis per page, contract names over internal ones), and a catalogue of AI writing tells with a bad and a good example each.
---

# Writing style

Governs everything written into a repository: comments (`#`, `//`, `///`, docstrings), markdown docs, commit and PR bodies.
Chat replies are out of scope (caveman rules govern those).
Full ruleset with examples: [reference.md](reference.md).
Read it before the first comment or doc edit of a session.

## Comment checklist

Apply to every comment written or touched:

1. Keep only comments stating a constraint the code cannot show: unit, range, invariant, reason for an odd choice, caller obligation.
   Delete a comment that restates the code or repeats what is routine elsewhere in the repository.
2. Write clipped fragments: noun phrases, articles and copulas dropped.
   `// Resolved timeout. nil if profile sets none.`
3. Show formats and ranges by example: `// Key: "eu-west/ARCHIVE".`, `// ms, 1..60000.`
4. Keep the language's own convention (Go doc comments start with the identifier, JSDoc tags carry the facts) and clip inside it.
5. Second pass: re-read each comment and cut again.
   Shortest form that keeps every fact wins; cutting words is free, cutting facts is not.

## Line wrapping

Break lines at sentence ends, after `,` `:` `;`, or at a conjunction ("and", "or", "but", "so").
One sentence per markdown source line.
A continuation line continues its sentence.

## Paired negation

State the assertion and stop, leaving the excluded alternative unsaid: "X, not Y", "X, never Y", "X and never Y", "not Y but X".
- Good: `// Retry budget comes from the table.`
- Bad: `// The table decides the retry budget, not the caller.`

Keep the negated half only where a reader was about to assume it, which is rare.
Cutting it means rewriting the passage: where the contrast carried the only content, the opener goes entirely and the next sentence carries the fact.
A residue like "A finding is a claim." or "Windows are reconciled." states nothing, which is a worse defect than the cadence it replaced.
A plain negative statement about one subject is unaffected: `// nil when the profile sets no timeout.`

## Page shape

[page-shape.md](page-shape.md): what a page answers, which names it may carry, what a diagram replaces.
Read it when starting a docs page, restructuring one, splitting one, or reviewing one that reads long.
`scripts/page-shape.sh <page>` reports the measurements.

## AI tells

Catalogue with a bad and a good example each: [ai-tells.md](ai-tells.md).
Read it when drafting a doc page or a commit body, and when a passage reads fluent while saying little.

The ones worth holding without opening the file:
- Inflated word where a plain one carries the fact: `delve`, `pivotal`, `underscore`, `leverage`, `utilize`, `serves as`.
- A participle claiming a result the clause never established: "Fix the null pointer, improving stability."
- Stacked hedges on a fact that can be asserted: "could potentially leave the socket open."
- A list landing on three items for rhythm.
- Chat residue in a commit body: "Certainly! Here is", `oaicite`, "I hope this helps".
- A heading whose first sentence restates the heading.

## Docs

State the invariant, in present tense, third person.
Time-agnostic: a sentence that work elsewhere would falsify (counts, unpinned versions, status snapshots, "currently"/"soon") is an observation that rots.
Changelog voice ("used to", "not yet", "moved here") lives in commits and PRs alone.
Point at the source-of-truth file instead of copying its contents.
Cut every section, table, and diagram the reader can do without.

## Scope of application

A touched comment is rewritten to this style in the same change.
Untouched comments stay as they are; whole-file sweeps happen only on request.
Project style rules add to these; on conflict this skill wins.

## Completion criteria

- Every written or touched comment passes the checklist.
- `bash <skill-dir>/scripts/check-style.sh <touched files>` reports clean.
  Some checks report candidates rather than verdicts and are judged by eye: em-dash hits inside ASCII art, PAIRED-NEGATION whose negated half answers an assumption the reader held, WHETHER-LIST, and INTENSIFIER.
- Every sentence this pass rewrote is re-read once more, and one that lost its content is rewritten rather than left short.
  Cutting a tell manufactures its own register, so the output gets the same scan as the input.
