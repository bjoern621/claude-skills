---
name: writing-style
description: Writing style for every word committed to a repository - code comments, YAML/TOML/config comments, docstrings, markdown docs, READMEs, changelogs, commit and PR bodies. Load at the start of any task that writes or edits a file in a repository, in any language, however small the edit, and whenever any wording question comes up. Use when writing or editing code that carries comments, documenting, editing manifests or configs, writing or restructuring a README or docs page, drafting a commit message or PR body, reviewing wording, or the user says "fix comments", "rewrite comments", "too verbose", "clean up docs". Enforces clipped comments, wrapping at punctuation, one sentence per markdown line, time-agnostic docs, no paired negation ("X, not Y"), mood matching what happens, scope and addressee, snippets naming where they go, page shape, and a catalogue of AI writing tells.
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
2. Name the reason before adding a comment to a line that carried none: the constraint a reader cannot get from the code.
   An answer that paraphrases the line means the line stays bare.
3. Delete a value gloss on sight.
   `# 0: no blink.` over `cursor_blink_interval = 0` and `# 0: no inertial glide after the fingers lift.` over `momentum_scroll = 0.0` say what the name and the value already say.
4. Write clipped fragments: noun phrases, articles and copulas dropped.
   `// Resolved timeout. nil if profile sets none.`
5. Show formats and ranges by example: `// Key: "eu-west/ARCHIVE".`, `// ms, 1..60000.`
6. Keep the language's own convention (Go doc comments start with the identifier, JSDoc tags carry the facts) and clip inside it.
7. Second pass: re-read each comment and cut again.
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

## Mood

A consequence of a path the page argues against takes "would", because the indicative asserts that it happens.
- Bad, under a snippet switching the other rule off: "Leaving React's rule on reports each dependency twice."
- Good: "Leaving React's rule on would report each dependency twice."

A path the page genuinely offers keeps the indicative, because somebody takes it.
Clauses opening with "if", "leaving", "without", "unless" or "instead of" are where this goes wrong.

## Naming the parts

A list of members is a contract or it is cut.
The set that stays is closed and binding: the values a field accepts, the parts a key is built from.
A sample of what something holds decides nothing, and it goes false the first time a member is added.
Test by adding one, then describe the container by what it decides.
- Bad: "Settings for the app: reports, updates, logs and the linked account."
- Good: "Settings for the app itself. They hold for every project."

## Scope and addressee

A page carries what the project owns, and it addresses a reader who already runs the tools the project plugs into.
Behaviour belonging to one of those tools is that tool's documentation, so the page names the tool and stops.
Explaining the addressee's own tools back to them is the first thing to cut from a page that runs long.
Worked examples: [page-shape.md](page-shape.md).

## Page shape

[page-shape.md](page-shape.md): what a page answers, which names it may carry, why architecture and programming are separate subjects, and how much of a draft is the author's working.
Read it when starting a docs page, restructuring one, splitting one, or reviewing one that reads long.
`scripts/page-shape.sh <page>` reports the measurements.

## README

[readme.md](readme.md): who a README is read by, the two shapes it comes in, and which one a project's reader picks.
A reader who already grants the value takes the informing shape, and a reader arriving with a default this software contradicts takes the arguing shape.
Read it when writing, restructuring or reviewing a README.

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
Architecture and programming are separate subjects, so a page describing the system names no source file, function, type or package path.
A decision is one line, and the reasoning that reached it is the author's working.
A snippet opens with its destination, as a comment in the snippet's own language.
A changelog entry names what somebody taking the release notices, so work leaving the published artifact as it was stays out.
Cut every section, table, and diagram the reader can do without.

## Scope of application

A touched comment is rewritten to this style in the same change.
Untouched comments stay as they are; whole-file sweeps happen only on request.
Project style rules add to these; on conflict this skill wins.

## Completion criteria

- Every written or touched comment passes the checklist.
- Every heading names its rule at the level the rule applies, with the case it came from left to the example.
- `bash <skill-dir>/scripts/check-style.sh <touched files>` reports clean.
  Some checks report candidates rather than verdicts and are judged by eye: em-dash hits inside ASCII art, PAIRED-NEGATION whose negated half answers an assumption the reader held, VALUE-GLOSS, WHETHER-LIST, INTENSIFIER, and FIDELITY-EMPHASIS.
- A README follows [readme.md](readme.md): written for the reader deciding whether to use it, in whichever of the two shapes that reader needs, with every capability line checked against the code.
- Nothing on the page documents a tool the project only plugs into, and every snippet names where it goes.
- Every sentence this pass rewrote is re-read once more, and one that lost its content is rewritten rather than left short.
  Cutting a tell manufactures its own register, so the output takes the same scan as the input.
