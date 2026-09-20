---
name: writing-style
description: Style for repository prose a human reads, agent-executed documents aside. Covers code comments, config and manifest comments, docstrings, identifiers, test names, log lines, markdown docs, wiki and Docmost pages, READMEs, changelogs, commit and PR bodies. Load before writing, editing or reviewing one, however small the edit, when any wording question comes up and when the user says "fix comments", "clean up docs" or "reads like AI". The labelling copula "X is a Y" is banned outright and a sentence breaks at punctuation in code comments alone.
---

# Writing style

Governs what a human reads out of a repository: code comments, config-file comments, docstrings, identifiers, test names, log lines, markdown docs, READMEs, changelogs, commit and PR bodies.
Chat replies are out of scope (caveman rules govern those).
So is a document an agent executes: a skill, `AGENTS.md`, `CLAUDE.md`, a prompt file.
That document is written to make an agent's behaviour repeatable.
These rules are written to make a human's reading fast.
Full ruleset with examples: [reference.md](reference.md).
Read it before the first comment or doc edit of a session.
[revision.md](revision.md) revises a draft in five passes and runs on a docs page, a README or a commit body rather than on a comment touched in passing.

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
   What earns a line is why this project chose this value and only where that reason sits outside the file.
5. Write clipped fragments: noun phrases, articles and copulas dropped.
   `// Resolved timeout. nil if profile sets none.`
6. Show formats and ranges by example: `// Key: "eu-west/ARCHIVE".`, `// ms, 1..60000.`
7. Keep the language's own convention (Go doc comments start with the identifier, JSDoc tags carry the facts) and clip inside it.
8. Second pass: re-read each comment and cut again.
   Shortest form that keeps every fact wins; cutting words is free, cutting facts is not.

## Labelling copula

`X is a Y` hands the reader a second name for something they already hold.
It is banned.
Say what the thing does and the sentence carries a fact the reader can act on.
- Bad: "A finding is a claim." Good: "Every finding is held against the product before it is believed."
- Bad: "The binding layer is a bridge." Good: "The binding layer redraws the view when the model changes."
- Bad: "A version is a tag on this project." Good: "Tagging this project publishes a version."
- Bad: `// A retry budget is a per-profile cap.` Good: `// Retry budget comes from the table.`

The ban holds wherever the complement re-labels the subject: `is a`, `is an`, `is the`, `are the` and the past forms.
It reaches a paragraph opener, a heading's first sentence, a bullet, a commit body and a comment alike.
A predicate that measures rather than re-labels stays: "The file is empty", "The timeout is 30 s".
A glossary row and a domain-model entry hand the reader a term they do not hold.
Those two keep the copula.
Rewrites and the surrounding cases: [reference.md](reference.md), "Labelling copula".

## Line breaks

One sentence per source line, in Markdown files, code comments and commit bodies.
A sentence owns its line, however short.
The diff then shows the sentence that changed.
Rendered Markdown joins the lines back.
Text already one item per line, bullets, tables and code, is unaffected.

A code comment breaks a sentence too long for the file's width after `,` `:` `;` or before a conjunction ("and", "or", "but", "so").
Prose runs a sentence to its end on one source line, whatever the width.
A continuation line continues its sentence.

A rendered editor takes neither rule.
Docmost, every other wiki and a forge's issue, review and description boxes show a source line break on the page, so a paragraph goes in as one line and the editor wraps it.

## Paired negation

State the assertion and stop, leaving the excluded alternative unsaid: "X, not Y", "X, never Y", "X and never Y", "not Y but X".
- Good: `// Retry budget comes from the table.`
- Bad: `// The table decides the retry budget, not the caller.`

"rather than", "instead of", "as opposed to" and "X over Y" carry the same move with no negative in them.
- Good: "Each review runs on a Claude subscription."
- Bad: "Each review runs on a Claude subscription rather than per token."

Keep the negated half only where a reader was about to assume it, which is rare.
Cutting it means rewriting the passage: where the contrast carried the only content, the opener goes entirely and the next sentence carries the fact.
A residue like "A finding is a claim." or "Windows are reconciled." states nothing.
The first of them trips the copula ban as well.
A dead sentence costs the reader more than the cadence it replaced.
A contrast surviving that test goes into a parenthesis, in a shape that changes each time: "Each review runs on a Claude subscription. (Per-token billing needs an API key in the environment.)"
A plain negative statement about one subject is unaffected: `// nil when the profile sets no timeout.`

## Restriction

`only` and its family (`just`, `merely`, `simply`, `alone`, `nothing but`, `all it takes`) narrow a set.
Where the sentence already names the narrow case, the word carries emphasis and it is cut.
Delete it and read again: a sentence that now covers a case the code rules out keeps the word.
- Good: `// Takes effect after a restart.`
- Bad: `// Only takes effect after a restart.`
- Good: `// Safe only on the render thread.`, where deletion drops a caller obligation.

Fronted "Only after X does Y" stages a sequence as suspense.
The clause goes back to its plain order.
"The only X is Y" reaches for weight.
The mechanism takes its place.
An exclusivity a reader has to honour is written as an invariant.
Rewrites: [reference.md](reference.md).

## Mood

A consequence of a path the page argues against takes "would", because the indicative asserts that it happens.
- Bad, under a snippet switching the other rule off: "Leaving React's rule on reports each dependency twice."
- Good: "Leaving React's rule on would report each dependency twice."

A path the page genuinely offers keeps the indicative, because somebody takes it.
Clauses opening with "if", "leaving", "without", "unless" or "instead of" are where this goes wrong.

## Naming the parts

A list of members states a contract or it is cut.
The set that stays is closed and binding: the values a field accepts, the parts a key is built from.
A sample of what something holds decides nothing.
It goes false the first time a member is added.
Test by adding one, then describe the container by what it decides.
- Bad: "Settings for the app: reports, updates, logs and the linked account."
- Good: "Settings for the app itself. They hold for every project."

## Scope and addressee

A page carries what the project owns.
It addresses a reader who already runs the tools the project plugs into.
Behaviour belonging to one of those tools is that tool's documentation.
The page names the tool and stops.
A page that runs long cuts the addressee's own tools first.
Worked examples: [page-shape.md](page-shape.md).

## Page shape

[page-shape.md](page-shape.md): what a page answers, which names it may carry, why architecture and programming are separate subjects and how much of a draft stays with the author.
Read it when starting a docs page, restructuring one, splitting one, or reviewing one that reads long.
`bash <skill-dir>/scripts/page-shape.sh <page>` reports the measurements.

## README

[readme.md](readme.md): who a README is read by, the two shapes it comes in and which one a project's reader picks.
A reader who already grants the value takes the informing shape.
A reader arriving with a default this software contradicts takes the arguing shape.
Read it when writing, restructuring or reviewing a README.

## AI tells

Catalogue with a bad and a good example each: [ai-tells.md](ai-tells.md).
Read it when drafting a doc page or a commit body and when a passage reads fluent while saying little.

The ones worth holding without opening the file, under the names that page gives them:
- Inflated vocabulary, where a plain word carries the fact: `delve`, `pivotal`, `underscore`, `leverage`, `utilize`, `serves as`.
- Register above developer speech, business wording standing in for the plain verb: "Each review is billed to a Claude subscription."
- Participial tack-on, claiming a result the clause never established: "Fix the null pointer, improving stability."
- Stacked hedges on a fact that can be asserted: "could potentially leave the socket open."
- Rule of three, a list landing on three items for rhythm.
- Chat preamble in a commit body: "Certainly! Here is", `oaicite`, "I hope this helps".
- Prompt echo, a heading whose first sentence restates it.
- Comma before "and", closing a list or gluing two clauses: "resolver, fetcher, and linker".
- Causal cadence, a consequence welded on with `so`, `thus` or `which means` where the fact stands alone.
- Labelling copula, `X is a Y` renaming something instead of saying what it does: "The reconciler is a state machine."
- Restrictive emphasis on a case the sentence already names: "Only takes effect after a restart."
  `// Safe only on the render thread.` keeps the word, deletion dropping a caller obligation.

## Docs

State the invariant, in present tense, third person.
Time-agnostic: a sentence that work elsewhere would falsify (counts, unpinned versions, status snapshots, "currently"/"soon") rots into a confident lie.
Changelog voice ("used to", "not yet", "moved here") lives in commits and PRs alone.
Architecture and programming are separate subjects.
A page describing the system names contract vocabulary: routes, config keys, wire message names and the parts in plain words.
No source file, function, type or package path appears.
A decision takes one line.
The reasoning that reached it stays with the author.
A snippet opens with its destination, as a comment in the snippet's own language.
A changelog entry names what somebody taking the release notices.
Work leaving the published artifact as it was stays out.
Cut every section, table and diagram the reader can do without.

## Scope of application

A touched comment is rewritten to this style in the same change.
Untouched comments stay as they are; whole-file sweeps happen only on request.
Project style rules add to these; on conflict this skill wins.

## Completion criteria

A touched comment is finished once the checklist has run over it, it has been read against the line beneath it and a second pass has cut it again.
No sentence of the draft re-labels its subject with `is a`, `is an`, `is the` or `are the`, outside a glossary row and a domain-model entry.
A draft is finished once the five passes in [revision.md](revision.md) have run and that page's criteria are met.

Nothing here is settled by a tool.
A pattern match catches a handful of shapes and passes every comment that is fluent and empty.
A report saying "clean" stops the reading that would have caught the rest.
Every pass is done by reading.
