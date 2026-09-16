---
name: writing-style
description: Style for repository prose a human reads, agent-executed documents aside. Covers code comments, config and manifest comments, docstrings, identifiers, test names, log lines, markdown docs, READMEs, changelogs, commit and PR bodies. Load before writing, editing or reviewing one, however small the edit, when any wording question comes up, and when the user says "fix comments", "clean up docs" or "reads like AI".
---

# Writing style

Governs what a human reads out of a repository: code comments, config-file comments, docstrings, identifiers, test names, log lines, markdown docs, READMEs, changelogs, commit and PR bodies.
Chat replies are out of scope (caveman rules govern those).
So is a document an agent executes: a skill, `AGENTS.md`, `CLAUDE.md`, a prompt file.
That document is written to make an agent's behaviour repeatable, and these rules are written to make a human's reading fast.
Full ruleset with examples: [reference.md](reference.md).
Read it before the first comment or doc edit of a session.
[revision.md](revision.md) revises a draft in five passes, and runs on a docs page, a README or a commit body rather than on a comment touched in passing.

## Comment checklist

Apply to every comment written or touched:

1. Keep only comments stating a constraint the code cannot show: unit, range, invariant, reason for an odd choice, caller obligation.
   Delete a comment that restates the code or repeats what is routine elsewhere in the repository.
2. Name the reason before adding a comment to a line that carried none: the constraint a reader cannot get from the code.
   An answer that paraphrases the line means the line stays bare.
3. Delete a value gloss on sight.
   `# 0: no blink.` over `cursor_blink_interval = 0` and `# 0: no inertial glide after the fingers lift.` over `momentum_scroll = 0.0` say what the name and the value already say.
4. Delete what the tool's own documentation carries.
   A setting reachable by searching its name is already written down, somewhere that stays current: `// Merge requests opened per project per hour.` over `prHourlyLimit: 3`.
   What earns a line is why this project chose this value, and only where that reason sits outside the file.
5. Write clipped fragments: noun phrases, articles and copulas dropped.
   `// Resolved timeout. nil if profile sets none.`
6. Show formats and ranges by example: `// Key: "eu-west/ARCHIVE".`, `// ms, 1..60000.`
7. Keep the language's own convention (Go doc comments start with the identifier, JSDoc tags carry the facts) and clip inside it.
8. Second pass: re-read each comment and cut again.
   Shortest form that keeps every fact wins; cutting words is free, cutting facts is not.

## Line wrapping

Break lines at sentence ends, after `,` `:` `;`, or at a conjunction ("and", "or", "but", "so").
One sentence per markdown source line.
A continuation line continues its sentence.
The rule binds the source; rendered Markdown joins the lines back.
Text already one item per line, bullets, tables and code, is unaffected.

## Paired negation

State the assertion and stop, leaving the excluded alternative unsaid: "X, not Y", "X, never Y", "X and never Y", "not Y but X".
- Good: `// Retry budget comes from the table.`
- Bad: `// The table decides the retry budget, not the caller.`

Keep the negated half only where a reader was about to assume it, which is rare.
Cutting it means rewriting the passage: where the contrast carried the only content, the opener goes entirely and the next sentence carries the fact.
A residue like "A finding is a claim." or "Windows are reconciled." states nothing.
A dead sentence is a worse defect than the cadence it replaced.
A plain negative statement about one subject is unaffected: `// nil when the profile sets no timeout.`

An aphoristic copula is the same tell with the negated half already gone.
"A finding is a claim.", "The binding layer is a bridge.", "A version is a tag on this project." each open a paragraph by re-labelling a noun the reader already holds.
Say what the thing does: "Tagging this project publishes a version."
A copula handing the reader a term they lack is a definition and stays.

## Restriction

`only` and its family (`just`, `merely`, `simply`, `alone`, `nothing but`, `all it takes`) narrow a set.
Where the sentence already names the narrow case, the word is emphasis and it is cut.
Delete it and read again: a sentence that now covers a case the code rules out keeps the word.
- Good: `// Takes effect after a restart.`
- Bad: `// Only takes effect after a restart.`
- Good: `// Safe only on the render thread.`, where deletion drops a caller obligation.

Fronted "Only after X does Y" stages a sequence as suspense.
The clause goes back to its plain order.
"The only X is Y" reaches for weight, and the mechanism takes its place.
An exclusivity a reader has to honour is written as an invariant.
Rewrites: [reference.md](reference.md).

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
Behaviour belonging to one of those tools is that tool's documentation.
The page names the tool and stops.
Explaining the addressee's own tools back to them is the first thing to cut from a page that runs long.
Worked examples: [page-shape.md](page-shape.md).

## Page shape

[page-shape.md](page-shape.md): what a page answers, which names it may carry, why architecture and programming are separate subjects, and how much of a draft is the author's working.
Read it when starting a docs page, restructuring one, splitting one, or reviewing one that reads long.
`bash <skill-dir>/scripts/page-shape.sh <page>` reports the measurements.

## README

[readme.md](readme.md): who a README is read by, the two shapes it comes in, and which one a project's reader picks.
A reader who already grants the value takes the informing shape, and a reader arriving with a default this software contradicts takes the arguing shape.
Read it when writing, restructuring or reviewing a README.

## AI tells

Catalogue with a bad and a good example each: [ai-tells.md](ai-tells.md).
Read it when drafting a doc page or a commit body, and when a passage reads fluent while saying little.

The ones worth holding without opening the file, under the names that page gives them:
- Inflated vocabulary, where a plain word carries the fact: `delve`, `pivotal`, `underscore`, `leverage`, `utilize`, `serves as`.
- Participial tack-on, claiming a result the clause never established: "Fix the null pointer, improving stability."
- Stacked hedges on a fact that can be asserted: "could potentially leave the socket open."
- Rule of three, a list landing on three items for rhythm.
- Chat preamble in a commit body: "Certainly! Here is", `oaicite`, "I hope this helps".
- Prompt echo, a heading whose first sentence restates it.
- Causal cadence, a consequence welded on with `so`, `thus` or `which means` where the fact stands alone.
- Restrictive emphasis on a case the sentence already names: "Only takes effect after a restart."
  `// Safe only on the render thread.` keeps the word, deletion dropping a caller obligation.

## Docs

State the invariant, in present tense, third person.
Time-agnostic: a sentence that work elsewhere would falsify (counts, unpinned versions, status snapshots, "currently"/"soon") is an observation that rots.
Changelog voice ("used to", "not yet", "moved here") lives in commits and PRs alone.
Architecture and programming are separate subjects.
A page describing the system names contract vocabulary: routes, config keys, wire message names, and the parts in plain words.
No source file, function, type or package path appears.
A decision is one line, and the reasoning that reached it is the author's working.
A snippet opens with its destination, as a comment in the snippet's own language.
A changelog entry names what somebody taking the release notices.
Work leaving the published artifact as it was stays out.
Cut every section, table, and diagram the reader can do without.

## Scope of application

A touched comment is rewritten to this style in the same change.
Untouched comments stay as they are; whole-file sweeps happen only on request.
Project style rules add to these; on conflict this skill wins.

## Completion criteria

A touched comment is finished once the checklist has run over it, it has been read against the line beneath it, and a second pass has cut it again.
A draft is finished once the five passes in [revision.md](revision.md) have run and that page's criteria are met.

Nothing here is settled by a tool.
A pattern match catches a handful of shapes and passes every comment that is fluent and empty.
A report saying "clean" stops the reading that would have caught the rest.
Every pass is done by reading.
