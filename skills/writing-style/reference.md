# Writing style reference

Full ruleset for everything written into a repository.
[SKILL.md](SKILL.md) carries the working checklist; this file settles the details and edge cases.

## Punctuation

Em-dashes (`—`, U+2014) and the box-drawing `─` (U+2500) appear only inside ASCII-art diagrams drawn with `┌ ┐ └ ┘ │ ─`.
Everywhere else a hyphen, comma, parenthesis, colon, or period takes their place.
The same habit on a regular hyphen ("the handler is the bridge - it converts...") is the same fault with a different glyph: use a period or restructure.
Prefer two sentences over a semicolon gluing two clauses.
Reserve semicolons for list items containing internal commas.
One layer of parentheses maximum.

## Docs and prose

Applies to README files, architecture docs, doc comments, and the body of commit messages and PR descriptions.
Code comments take one further cut on top; see "Comments" below, which wins on any conflict about length or sentence form.

**Neutral, third-person description.**
State what the system does.
Do not address the reader.
- Bad: "You can call `OrThrow()` to extract the value."
- Good: "`OrThrow()` extracts the success value or throws the error variant."
- Words to avoid: "you", "your", "we", "we'll", "let's", "our".

**No marketing adjectives or filler.** Cut words that praise the code rather than describe it: "elegant", "clean", "robust", "powerful", "seamless", "leverage", "utilize", "essentially", "crucial", "critical", "simply", "just", "easily", "battle-tested", "production-ready".

**No rhetorical scaffolding.**
Drop "It is worth noting that", "Importantly,", "Notably,", "Note that", "In essence,", "Of course,".
State the fact directly.

**No sales-pitch framings.**
Avoid "This is more than X", "X enables Y to thrive".
"Not just X, but Y" is one shape of the pattern in "Paired negation" below.

**Written as a reference.**
Documentation describes the finished state.
Avoid "First, we...", "Now we will...", "Next, let's...".

**Code over explanation.**
If a behaviour fits in five lines, show it.

**No closing recap.**
The reader just read the body.

**Cut hedging on facts.**
Reserve hedging for genuinely conditional behaviour.
- Bad: "may throw on null input in some cases".
- Good: "Throws on null input".

**One idea per sentence; one job per paragraph.**
Comma-chained sentences with three subordinate clauses are an LLM tic.
Break them up.

**One sentence per line.**
Break the source line at every sentence end.
A sentence owns its line, however short.
Diffs then show the sentence that changed instead of a reflowed block.
- Applies to the source of Markdown, code comments, and commit bodies. Rendered Markdown joins the lines back, so readers see no difference.
- A sentence longer than the file's comfortable width wraps at a clause boundary; a continuation line never starts a new sentence.
- Line-oriented text already one item per line (bullets, tables, code) is unaffected.

**Documentation is time-agnostic.**
The test for any sentence: would it become false because of work that has nothing to do with this document?
Then it is an observation, and it rots into a confident lie.
Do not write:
- Counts and tallies: "46 dependencies across 28 files".
- Point-in-time versions of things the repo does not itself pin: "the latest release is v1.12.0".
- Status snapshots: "nine updates are pending", "this is not yet supported".
- Temporal words: "currently", "now", "recently", "as of", "at the time of writing", "new", "still", "today", "soon".
- Dates and "last updated" lines. Git records them, and accurately.

State the invariant that produces the fact:
- Bad: "The chart's ten component images resolve from `appVersion`."
- Good: "The chart's component images carry no explicit tag, so each resolves from `appVersion`."

Version facts that are contracts rather than measurements are fine: "requires Postgres 14 or newer".
A pin in a config file is that file's business; the doc explains why the pin exists.

**Point at the source of truth instead of copying it.**
State what the file is for and why it is shaped that way, then name it.
The file answers "what is set".

**Anchors must survive edits.**
Name a file, symbol, heading, or config key; a line number rots on the next edit.
Name sections instead of writing "the section above".

**Cut everything that does not pull its weight.**
Before adding a section, diagram, table, or example, ask whether the reader needs it to use or modify the system.
Remove on sight: diagrams for one-line operations, tables restating nearby prose, "Overview" sections that preview instead of state, historical archeology, "Concepts" sections that exist to look thorough, the same fact repeated in different wording.

## Comments

A comment states the constraint the code cannot show, and nothing else.
A comment that restates the code is deleted rather than shortened.
This governs `//`, `#`, `///`, `/** */`, XML doc comments and docstrings.

**Whether a comment is needed at all is decided first.**
A name that already says it takes no comment: `getPlayerGuid`, `isEmpty`, `maxRetries`.
Written down is only what the name cannot carry: a unit, a range, an invariant, a reason for an odd choice, an obligation on the caller.
- Bad: `// GetPlayerGuid returns the player GUID.`
- Good: no comment.
- Good: `// Zero until the first sync completes.`

**A comment is written clipped.**
Articles, copulas and self-reference go: "a", "an", "the", "is the", "which is", "this function".
A noun phrase is a whole comment, and a fragment needs no trailing period.
- Bad: `// This function returns the resolved timeout for the given profile, or nil if the profile does not set one.`
- Good: `// Resolved timeout. nil if profile sets none.`

**Shortest form that keeps every fact wins.**
A comment that shrinks and still answers the "why" got better; one that shrinks by dropping a constraint got worse.

**A format, a value or a range is shown by example.**
- Bad: `// The key is the region name in lowercase, a slash, then the bucket name in uppercase.`
- Good: `// Key: "eu-west/ARCHIVE".`
- Bad: `// Accepts a duration in milliseconds between one and sixty thousand.`
- Good: `// ms, 1..60000.`

**The language's own comment convention comes first.**
Clipping happens inside that shape.
Where the convention demands a word these rules would cut, the convention wins.
- Go: a doc comment starts with the identifier. `// StartWatch opens a watcher for the path. Already open is success.`
- C#: XML doc comments, one clipped line per tag.
- TypeScript/JavaScript: JSDoc, `@param` and `@returns` carry the facts.
- Python: a docstring in the style the file already uses.
- Rust: `///` on the item, `//!` on the module.

**Wrap at a sentence end.**
A source line holds one sentence, however short that leaves the line.
A sentence too long for the file's width breaks after a comma or before a conjunction ("and", "or", "but", "so"), and a continuation line never starts a new sentence.

**A touched comment is rewritten in the same change.**
Editing the code under a comment means re-reading that comment and bringing it to this style, whether or not the edit made it false.

**Only the unusual is commented.**
A comment earns its place by stating what a reader cannot get from the code or from the rest of the repository.
Routine gets none: a setting three other files already set the same way, a service enabled the way every host enables it.
The test: could this comment be pasted, unchanged, above the same construct somewhere else in the repository? Then it says nothing about here.
- Bad: `# A GitOps mirror, like the other servers: the pipeline updates every host centrally and this one converges by pulling.`
- Bad: `# As root, which is the only account here, so it needs no sudo rule.` Nothing suggested a sudo rule.
- Good: no comment.

**An absence is explained only where a reader would restore it.**
"Why this is not here" is worth a line when the missing thing looks required, was there before, or is what the neighbouring code does.
It is noise when nothing pointed that way.

**Every comment gets a second pass.**
Re-read each comment before moving on and rewrite it, every time.
Ask, in order:
- Routine anywhere else in the repository? Delete it.
- Restates the code? Delete it.
- Which words carry no fact? Cut them.
- Can it be shorter without losing a fact? Then it is not finished.

Cutting words is free.
Cutting facts is not.

## Paired negation

A statement followed by the excluded alternative for the same subject is machine cadence, and it is cut.
The shapes: "X, not Y", "X, never Y", "X and never Y", "not Y but X", "not just X but Y", "Y is not the point; X is".
The negated half is normally the assertion restated with a minus sign in front, so it carries no fact and exists to make the sentence swing.
- Bad: "A connection is checked by arithmetic and never by a round trip."
- Good: "A connection is checked by arithmetic."
- Bad: `// The table decides the retry budget, not the caller.`
- Good: `// Retry budget comes from the table.`
- Bad: "It reports a reading, not a regression."
- Good: "It reports a reading."

**The negated half earns its place only where a reader was about to assume it.**
The test is to say the alternative out loud and ask whether anything pointed that way.
"Asserted in release builds too, not only in debug" answers a real expectation.
"Checked by arithmetic, never by a round trip" answers an expectation nobody had.
One such clause on a page is already a lot.

**Cutting the negated half means rewriting the passage around it.**
Where the contrast carried the sentence's only content, striking it leaves a sentence saying nothing.
A dead sentence is a worse defect than the cadence it replaced.
Read the neighbours and move the fact: usually the opener goes entirely because the sentence after it already carries the point, or the excluded alternative comes back as a positive statement of what does happen.
- Bad cut: "A finding is a claim, not a verdict." to "A finding is a claim."
- Good cut: drop the opener, and let "Every finding is held against the product before it is believed." carry it.
- Bad cut: "Windows are reconciled, not opened by an event." to "Windows are reconciled."
- Good cut: "A render pass opens the windows the model asks for."

**An aphoristic copula is the same tell.**
"A finding is a claim.", "The binding layer is a bridge.", "Trust is a property."
A copula standing alone as a paragraph opener, re-labelling a noun the reader already holds, usually there to set up a contrast.
Say what the thing does instead.
A copula handing the reader a term they lack is a definition and stays, which is what a glossary row and a domain-model entry are built from.

**A plain negative sentence is untouched by this.**
"Restart drops no queued job" and `// nil when the profile sets no timeout` each state one fact about one subject.
Two subjects put side by side are two statements, so "Cutting words is free. Cutting facts is not." stays.
What is cut is one subject asserted and mirrored in the same breath.

## Language states the present

Every word describes the thing as it stands.
What it replaced, what is planned, and what building it was like are changelog voice, at home only in commits, PR descriptions, release notes, and migration guides.
Everywhere else it is cut: interface copy, comments, Markdown pages, log lines, error messages, test names, config comments, identifiers.

Three faces:
- Past: "used to", "as before", "this has been fixed", "new", "since the rewrite", "moved here from".
- Future: "not yet", "coming soon", "planned", "for now", "eventually".
- Workshop: "by design", "we decided", "after some experimentation", "it turned out that".

**A clause that argues with somebody is the clearest tell.**
"and never was" rebuts a complaint nobody made.
Writing reports a state and names a consequence.

**Naming an absence teaches a capability and then takes it away.**
- Bad: "There is no way to apply this without a restart."
- Good: "Applying restarts the service."

Per surface:
- Interface copy is the strictest: the reader holds no earlier version. Bad: "This field is no longer editable while syncing." Good: "Locked while syncing. Stop the sync to change it." Bad: "Dark mode is not supported yet." Good: "This theme ships light only."
- Comments are written from the file. Bad: `// Now returns nil instead of an error.` Good: `// nil when the profile sets no timeout.` Bad: `// Moved here from Session.cs.` Good: no comment.
- Docs describe the system. An upgrade guide is the page whose subject genuinely is the change.
- Identifiers name what the thing does. `newParser`, `parserV2`, `legacyPath`, `improvedRetry` are true for one release and confusing after the next.
- Logs, asserts and test failures report the reading. Bad: `t.Fatal("this broke when the retry table landed")`. Good: `t.Fatalf("%s declares no retry budget", profile)`.

**A state whose name contains a past is not history.**
"Disconnected", "Retrying in 5 s", "stale", "expired" are readings of a running system, and they stay.
The ban covers the product's history, and a run's own states stay.
A migration naming an old and a new key describes its own present job.

The test, clause by clause:
- Would a reader who met this thing a minute ago act differently because of this clause? No: cut it.
- Does the clause only parse for somebody who knows a previous version or how the work went? Cut it.
