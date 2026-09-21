# Writing style reference

Full ruleset for the prose this skill governs.
[SKILL.md](SKILL.md) states that scope and carries the working checklist; this file settles the details and edge cases.

## Punctuation

Em-dashes (`—`, U+2014) and the box-drawing `─` (U+2500) appear only inside ASCII-art diagrams drawn with `┌ ┐ └ ┘ │ ─`.
Everywhere else a hyphen, comma, parenthesis, colon, or period takes their place.
The same habit on a regular hyphen ("the handler is the bridge - it converts...") fails the same way with a different glyph: use a period or restructure.
A comma never stands before "and".
The last two items of a list join on the word alone: "a hyphen, a parenthesis and a colon".
Two clauses wide enough to want a comma between them become two sentences.
German writes its lists the same way.
Prefer two sentences over a semicolon gluing two clauses.
Reserve semicolons for list items containing internal commas.
One layer of parentheses maximum.
Straight quotation marks throughout, `"` and `'`.
The curly forms come from an editor that substitutes them on the way in and they break a command copied out of the page.
A hyphenated pair keeps its hyphen in front of the noun and drops it behind: "a high-quality report", "the report is high quality".
The pair carrying its hyphen in every position marks machine drafting: `third-party`, `cross-functional`, `data-driven`, `real-time`, `end-to-end`.

## Docs and prose

Applies to architecture docs, doc comments and the body of commit messages and PR descriptions.
A README takes these rules with one exception, stated under "Register" in [readme.md](readme.md).
Code comments take one further cut on top; see "Comments", which wins on any conflict about length or sentence form.

**Neutral, third-person description.**
State what the system does.
Do not address the reader.
- Bad: "You can call `OrThrow()` to extract the value."
- Good: "`OrThrow()` extracts the success value or throws the error variant."
- Words to avoid: "you", "your", "we", "we'll", "let's", "our".
- A README addresses somebody deciding whether to use the software. [readme.md](readme.md) states that scope.

**No marketing adjectives or filler.** Cut words that praise the code rather than describe it: "elegant", "clean", "robust", "powerful", "seamless", "leverage", "utilize", "essentially", "crucial", "critical", "simply", "just", "easily", "battle-tested", "production-ready".

**Plain register.**
Write the word a developer says at the desk.
Business and product vocabulary sits a level above that.
It reads as a press release: "bills", "provisions", "onboards", "consumes", "surfaces", "enables", "is subject to".
- Bad: "Each review is billed to a Claude subscription."
- Good: "Each review runs on a Claude subscription."
- Bad: "The runner consumes the artifact endpoint."
- Good: "The runner downloads the artifact."
The plain verb names the same event.
The reader stops on nothing.

**No rhetorical scaffolding.**
Drop "It is worth noting that", "Importantly,", "Notably,", "Note that", "In essence,", "Of course,".
State the fact directly.
Depth framing announces a hidden truth and hands over no detail: "The real question is", "At its core", "What really matters", "The heart of the matter", "Here's the thing".
- Bad: "At its core, what really matters is whether the cache survives a restart."
- Good: "A restart drops the cache."

**No sales-pitch framings.**
Avoid "This is more than X", "X enables Y to thrive".
"Not just X, but Y" is one shape of the pattern in "Paired negation".

**No dramatization.**
A rule written as decree sits a register above the fact and carries less of it.
The shapes: an allegiance verb pointing a thing at an abstract ("belongs to destruction", "is reserved for danger"), an abstract noun standing in for the case ("destruction" for a destructive action) and an exclusivity restated once it has landed.
"Plain register" above names the business wording that sits over the fact.
A decree sits over it from the other side.
Plain ownership keeps the verb: "A setting belongs to the tool that defines it" names who documents it.
- Bad: "The accent carries the one filled button the design system draws. Red belongs to destruction and never carries a fill, and no other fill exists."
- Good: "One button per screen carries a fill, in the accent colour. Red marks a destructive action and its button stays unfilled."

**Written as a reference.**
Documentation describes the finished state.
Avoid "First, we...", "Now we will...", "Next, let's...".

**Code over explanation.**
If a behaviour fits in five lines, show it.

**No closing recap.**
The page ends on its last fact.
The reader just read the body.
A closer repeated under each section runs the same move at the scale of the page: "That is the real win." under one heading after another.

**No decoration.**
An emoji, an arrow ("->"), a check mark or a cross in a heading, a bullet or a table cell dresses the item and states nothing about it.
A horizontal rule between sections repeats the break the heading already makes.

**Emphasis stays in the words.**
ALL CAPS on a word, a period between each word ("every. single. day.") and bold on a term ask the reader to lean on a claim the sentence never made.
A claim that needs weight takes the number behind it.
- Bad: "The lock is released on EVERY path out of the function."
- Good: "All four return paths release the lock."

**Cut hedging on facts.**
Reserve hedging for genuinely conditional behaviour.
- Bad: "may throw on null input in some cases".
- Good: "Throws on null input".

**One idea per sentence; one job per paragraph.**
Comma-chained sentences with three subordinate clauses read as machine cadence.
Break them up.

**One sentence per line.**
Break the source line at every sentence end.
A sentence owns its line, however short.
Diffs then show the sentence that changed instead of a reflowed block.
- Applies to the source of Markdown files, code comments and commit bodies. Rendered Markdown joins the lines back. Readers see no difference.
- Line-oriented text already one item per line (bullets, tables, code) is unaffected.

**A sentence breaks at punctuation in a code comment alone.**
A comment too long for the file's width breaks after `,` `:` `;` or before a conjunction ("and", "or", "but", "so").
The continuation line never starts a new sentence.
Prose runs a sentence to its end on one source line, whatever the width, the wrapping belonging to the reader's editor.
- Bad, in a Markdown file: a sentence split after its first comma, so the diff shows two lines for one edit.
- Good: the whole sentence on its line, however far past the column guide it runs.

**A rendered editor takes neither rule.**
Docmost, every other wiki and a forge's issue, review and description boxes turn a source line break into a break on the page.
A paragraph goes in as one line and the editor wraps it.
Every other rule on this page holds there unchanged.

**Documentation is time-agnostic.**
The test for any sentence: would it become false because of work that has nothing to do with this document?
Then it rots into a confident lie.
Do not write:
- Counts and tallies: "46 dependencies across 28 files".
- Point-in-time versions of things the repo does not itself pin: "the latest release is v1.12.0".
- Status snapshots: "nine updates are pending", "this is not yet supported".
- Temporal words: "currently", "now", "recently", "as of", "at the time of writing", "new", "still", "today", "soon".
- Dates and "last updated" lines. Git records them accurately.

State the invariant that produces the fact:
- Bad: "The chart's ten component images resolve from `appVersion`."
- Good: "The chart's component images carry no explicit tag, so each resolves from `appVersion`."

Version facts that are contracts rather than measurements are fine: "requires Postgres 14 or newer".
A pin in a config file is that file's business; the doc explains why the pin exists.

**Architecture and programming are separate subjects.**
Architecture is what the parts are and what crosses between them; programming is which file holds it and what the function is called.
A page describing the system names no source file, no function, no type and no package path.
The code answers those completely and without going stale.
A reader reaches the code through the contract vocabulary, which the code spells the same way.
[page-shape.md](page-shape.md) states the split in full, with the config keys and wire paths that do belong.
- Bad: "`publish.SamePipeline` renders both settings objects and compares the strings."
- Good: "A relaunch is decided by rendering both configurations and comparing them."

**Anchors must survive edits.**
Name a contract term, a config key, a route or a heading; a line number rots on the next edit and a symbol name rots on the next rename.
Name sections instead of writing "the section above".

**A decision is one line.**
The mechanism behind it, the alternative that lost and every consequence after the first stay with the author.
The page carries none of them.
A rewrite lands near a tenth of the length.
The facts all survive it.

**Cut everything that does not pull its weight.**
Before adding a section, diagram, table, or example, ask whether the reader needs it to use or modify the system.
Remove on sight: diagrams for one-line operations, tables restating nearby prose, "Overview" sections that preview instead of state, historical archeology, "Concepts" sections that exist to look thorough, the same fact repeated in different wording.

## Comments

A comment states the constraint the code cannot show and nothing else.
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
A noun phrase makes a whole comment and a fragment needs no trailing period.
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
A sentence too long for the file's width breaks after a comma or before a conjunction ("and", "or", "but", "so").
A continuation line never starts a new sentence.

**A touched comment is rewritten in the same change.**
Editing the code under a comment means re-reading that comment and bringing it to this style, whether or not the edit made it false.

**Only the unusual is commented.**
A comment earns its place by stating what a reader cannot get from the code or from the rest of the repository.
Routine gets none: a setting three other files already set the same way, a service enabled the way every host enables it.
The test: could this comment be pasted, unchanged, above the same construct somewhere else in the repository? Then it says nothing about here.
- Bad: `# A GitOps mirror, like the other servers: the pipeline updates every host centrally and this one converges by pulling.`
- Bad: `# As root, which is the only account here, so it needs no sudo rule.` Nothing suggested a sudo rule.
- Good: no comment.

**A value gloss repeats the line under it.**
Translating a setting's value into words says what the name and the value already say.
- Bad: `# 0: no blink.` over `cursor_blink_interval = 0`.
- Bad: `# 0: no inertial glide after the fingers lift. Takes effect on kitty restart.` over `momentum_scroll = 0.0`.
- Good: no comment.
A disabling value earns a line where the reason for disabling sits outside the file: which hardware misbehaves, which other setting it compensates for.
Every setting in that kitty config needs the same restart, so the restart clause in the second example is routine and goes with the rest.

**Upstream documentation is not copied into the repository.**
A setting belongs to the tool that defines it and that tool documents what it does.
Saying it again pins a stale copy of someone else's reference page inside this repository, where nobody updates it when the tool changes.
The test: could a reader reach this sentence by searching the setting's name? Then it is already written, somewhere that stays current.
- Bad: `// Merge requests opened per project per hour.` over `prHourlyLimit: 3`.
- Bad: `# Seconds before the probe gives up.` over `timeoutSeconds: 5`.
- Bad: `# Whether to follow redirects.` over `follow_redirects = true`.
- Good: no comment.

The name and the value carry the meaning between them.
A reader who does not recognise the name looks it up once rather than reading a paraphrase every time.

What the upstream page cannot hold is why this project chose this value.
That earns a line only where the reason sits outside the file.
- Good: `# Worker boots at ~930 MB, so a cap near that recycles it every few minutes.` over `per_worker_max_memory_mb = 1500`.
- Good: `# vmk3s reserves nearly all its CPU, so a larger request never schedules.` over `cpu_request = "50m"`.

A number chosen by taste needs no defence.
Writing one invents a constraint the next reader then works around.

**A comment on a line that carried none is justified before it is written.**
Adding one counts as its own change.
Its reason names the constraint a reader cannot get from the code.
The question is asked before typing: what does this tell a reader that the name, the value and the rest of the repository do not?
An answer that paraphrases the line means the line stays bare.

**An absence is explained only where a reader would restore it.**
"Why this is not here" is worth a line when the missing thing looks required, was there before, or is what the neighbouring code does.
It is noise when nothing pointed that way.

**Every comment gets a second pass.**
Re-read each comment before moving on and rewrite it, every time.
Ask, in order:
- Routine anywhere else in the repository? Delete it.
- Restates the code? Delete it.
- Glosses the value on the line below? Delete it.
- Answered by the documentation of the tool that owns the setting? Delete it.
- Which words carry no fact? Cut them.
- Can it be shorter without losing a fact? Then it is not finished.

Cutting words is free.
Cutting facts is not.

## Naming the parts

**A list of members states a contract or it is cut.**
Naming what something holds earns its place where the set is closed and the reader has to hit it: the values a field accepts, the flags a caller may combine, the parts a key is built from.
A sample of the contents decides nothing.
It goes false the first time a member is added.
The test is to add one: where the sentence stops being true it was a sample.
What the container decides is written in its place.
- Bad: "The scheduler package holds the queue, the retry table, the worker pool and the metrics hook."
- Good: "The scheduler decides when a job runs and how often it retries."

**A closed set the code already shows restates it.**
Written down is the set the code cannot carry: text parsed into a value, the three spellings a string field accepts, a range narrower than the type's.
- Bad: `// Fields: name, region, bucket, created.` over the struct declaring them.
- Good: `// Region: "eu-west", "us-east", "ap-south". Anything else is refused.`

## Labelling copula

`X is a Y` hands the reader a second name for something they already hold.
It is banned.
The complement re-labels the subject instead of saying what it does, so the sentence closes without giving the reader anything to act on.
The shapes: `is a`, `is an`, `is the`, `are the`, `was a`, `were the`.
Say what the thing does and the fact comes back.
- Bad: "A finding is a claim." Good: "Every finding is held against the product before it is believed."
- Bad: "The binding layer is a bridge." Good: "The binding layer redraws the view when the model changes."
- Bad: "Trust is a property of the channel." Good: "The channel carries trust from the handshake forward."
- Bad: "A version is a tag on this project." Good: "Tagging this project publishes a version."
- Bad: `// A retry budget is a per-profile cap.` Good: `// Retry budget comes from the table.`
- Bad: "`StopSync` is a function that stops syncing." Good: "`StopSync` closes the watch. Already closed is success."

**The ban reaches every position.**
A paragraph opener, a heading's first sentence, a bullet, a table cell, a commit body and a comment take it alike.
A copula opens a paragraph more often than it appears anywhere else, usually to set up a contrast the next clause then draws.
Cutting the contrast without cutting the copula leaves the residue "Paired negation" warns about.

**A predicate that measures stays.**
"The file is empty", "The timeout is 30 s", "The socket is open" each report a reading of one subject.
The ban covers the noun standing in for the verb the sentence owed the reader.

**A definition stays.**
A glossary row and a domain-model entry exist to hand the reader a term they do not hold.
The copula does that job there.
Two surfaces keep it.
A page reaching for the shape outside them rewrites instead.

**The rewrite reaches for a verb.**
`serves as`, `stands as`, `functions as` and `represents` swap the copula for a longer one and change nothing.
- Bad: "TokenIssuer serves as the boundary between login and session storage."
- Bad: "TokenIssuer is the boundary between login and session storage."
- Good: "TokenIssuer mints a session token once login succeeds."

## Paired negation

A statement followed by the excluded alternative for the same subject is machine cadence and it is cut.
The shapes: "X, not Y", "X, never Y", "X and never Y", "not Y but X", "not just X but Y", "Y is not the point; X is".
The negated half is normally the assertion restated with a minus sign in front.
It carries no fact and exists to make the sentence swing.
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
A dead sentence costs the reader more than the cadence it replaced.
Read the neighbours and move the fact: usually the opener goes entirely because the sentence after it already carries the point, or the excluded alternative comes back as a positive statement of what does happen.
- Bad cut: "A finding is a claim, not a verdict." to "A finding is a claim."
- Good cut: drop the opener and let "Every finding is held against the product before it is believed." carry it.
- Bad cut: "Windows are reconciled, not opened by an event." to "Windows are reconciled."
- Good cut: "A render pass opens the windows the model asks for."

**A plain negative sentence is untouched by this.**
"Restart drops no queued job" and `// nil when the profile sets no timeout` each state one fact about one subject.
Two subjects put side by side are two statements and "Cutting words is free. Cutting facts is not." stays.
What is cut is one subject asserted and mirrored in the same breath.

**The substitution shapes belong here.**
"rather than", "instead of", "in place of", "as opposed to" and "X over Y" hang the rejected option off the tail of a fact.
The fact stands without it.
- Bad: "Each review runs on a Claude subscription rather than per token."
- Good: "Each review runs on a Claude subscription."
- Bad: "The resolver reads the lockfile instead of the manifest."
- Good: "The resolver reads the lockfile."

They take the test above: say the rejected option out loud and ask what pointed the reader at it.
A default the tool ships with, a habit the predecessor taught, the option the sentence before recommended: naming one of those saves a wrong assumption.

**An option nobody proposed is raised so the text can reject it.**
"A tempting approach would be", "One might be tempted to", "An obvious approach would be" and "You might think X, but" put a plan on the page for the knocking down.
The plan got there from the author's own thinking and the reader arrives without it.
The defensive openers do the same with an objection: "To be clear", "This is not to say", "Some might say X, but".
- Bad: "Session tokens rotate every 24 hours. A tempting approach would be to restart the auth service on a cron, but that drops every active session."
- Good: "Session tokens rotate in place every 24 hours. Clients refresh without a new login."

Both take the test above.
An option a reader arrives holding stays, with the reason it lost.

**A contrast that survives the test moves into a parenthesis, in a shape that changes each time.**
The main clause carries the fact.
The aside behind it carries the rejected option.
A counterfactual aside takes "would", under "Mood".
Two asides cut to the same pattern on one page turn the parenthesis into the tell the tail was, so length, verb and punctuation vary between them.
- "Each review runs on a Claude subscription. (Per-token billing needs an API key in the environment.)"
- "The resolver reads the lockfile (the manifest, up to 3.2)."
- "Set `pool = shared` before the first query (otherwise every request would open its own connection)."

**A contrast carrying the sentence's own content stays inline.**
"A comment that restates the code is deleted rather than shortened." records which of two live options a reader takes.
Nothing is left once one of them goes.
What moves into an aside is a contrast hung on a fact that already stands without it.

## Restriction

`only` narrows a set.
The family around it does the same work: `just`, `merely`, `simply`, `alone`, `purely`, `solely`, `nothing but`, `all it takes`.
Where the sentence already names the narrow case, the word carries emphasis and it is cut.
The test is deletion: read the sentence without the word and ask whether it now covers a case the code rules out.
- Bad: `// Only takes effect after a restart.`
- Good: `// Takes effect after a restart.`
- Bad: "Wiring the hook up only takes one key in the settings file."
- Good: "Wiring the hook up takes one key in the settings file."
- Bad: "The migration is merely a rename of the column."
- Good: "The migration renames the column."

**A restriction that narrows a real set stays.**
`// Safe only on the render thread.` loses a caller obligation the moment the word goes and "runs only when the primary region is unreachable" widens into a claim about every request.
That reads the deletion test the other way round: what the sentence permits changes and the word carries a fact.

**Fronted `Only` with inversion stages a sequence as suspense.**
The clause goes back to its plain order and the inversion goes with it.
- Bad: "Only after the lockfile is written does the install proceed."
- Good: "The install proceeds after the lockfile is written."
- Bad: "Three attempts run, and only then does the job fail."
- Good: "The job fails after three attempts."

**`The only X is Y` reaches for weight.**
It is checked against the code or replaced by the mechanism.
As a claim about importance it states nothing a reader can use.
As a claim about the code it goes false the first time a second path appears.
- Bad: "The only thing that matters for throughput is the batch size."
- Good: "Batch size sets throughput."
- Bad: "All you need is a token in the header."
- Good: "The request carries a token in the header."

An exclusivity a reader has to honour is written as an invariant: "WriteManifest holds the only write path to manifest.json."

**`the one X` claims singularity for weight.**
The determiner tells the reader how rare the thing is where a count tells them how many there are.
A count survives the second one appearing.
- Bad: "The accent carries the one filled button the design system draws."
- Good: "One button per screen carries a fill, in the accent colour."
- Bad: "That leaves the one place the token is read."
- Good: "The session endpoint reads the token."

**`not only X but also Y` stages two facts as a climb**.
"Paired negation" carries the rest of that family.
- Bad: "The cache not only survives a reload but also shares entries across tabs."
- Good: "The cache survives a reload and shares entries across tabs."

**Repetition across a page is its own signal.**
Several defensible instances in one passage read as cadence.
Each takes the deletion test rather than passing on the strength of the first.

## Language states the present

Every word describes the thing as it stands.
What it replaced, what is planned and what building it was like are changelog voice, at home only in commits, PR descriptions, release notes and migration guides.
Everywhere else it is cut: interface copy, comments, Markdown pages, log lines, error messages, test names, config comments, identifiers.

Three faces:
- Past: "used to", "as before", "this has been fixed", "new", "since the rewrite", "moved here from".
- Future: "not yet", "coming soon", "planned", "for now", "eventually".
- Workshop: "by design", "we decided", "after some experimentation", "it turned out that".

**A clause that argues with somebody shows this most plainly.**
"and never was" rebuts a complaint nobody made.
Writing reports a state and names a consequence.

**Naming an absence teaches a capability and then takes it away.**
- Bad: "There is no way to apply this without a restart."
- Good: "Applying restarts the service."

Per surface:
- Interface copy is the strictest: the reader holds no earlier version. Bad: "This field is no longer editable while syncing." Good: "Locked while syncing. Stop the sync to change it." Bad: "Dark mode is not supported yet." Good: "This theme ships light only."
- Comments are written from the file. Bad: `// Now returns nil instead of an error.` Good: `// nil when the profile sets no timeout.` Bad: `// Moved here from Session.cs.` Good: no comment.
- Docs describe the system. An upgrade guide takes the change as its subject and says so in its title.
- Identifiers name what the thing does. `newParser`, `parserV2`, `legacyPath`, `improvedRetry` are true for one release and confusing after the next.
- Logs, asserts and test failures report the reading. Bad: `t.Fatal("this broke when the retry table landed")`. Good: `t.Fatalf("%s declares no retry budget", profile)`.

**A state whose name contains a past is not history.**
"Disconnected", "Retrying in 5 s", "stale", "expired" are readings of a running system and they stay.
The ban covers the product's history.
A run's own states stay.
A migration naming an old and a new key describes its own present job.

The test, clause by clause:
- Would a reader who met this thing a minute ago act differently because of this clause? No: cut it.
- Does the clause only parse for somebody who knows a previous version or how the work went? Cut it.

## Mood

The indicative asserts that something happens.
A clause carries it only where it does.
A consequence belonging to a path the page argues against takes "would".

- Bad, under a snippet that switches the other rule off: "Both rules report the same missing dependencies, so leaving React's on reports each one twice."
- Good: "Both rules report the same missing dependencies, so leaving React's on would report each one twice."

Run the check on any clause opening with "if", "leaving", "without", "unless" or "instead of".
Read the clause on its own: a reader taking it as written believes the project does the thing the page argues against.

A path the page genuinely offers keeps the indicative, because somebody takes it.
"Registering the plugin yourself sets the severity" describes one of two supported paths and needs no "would".

## Changelog

An entry names what somebody taking the release notices: behaviour, a message, a supported version, a file the package ships.
Work that leaves the published artifact as it was stays out, whatever share of the diff it was.
A test script, a CI step, a refactor and a page the package does not ship are all invisible to the reader deciding whether to upgrade.

- Bad: "`npm test` compiles the sources and runs the case suite."
- Good: no entry. The published package behaves as it did.

The published artifact draws the line, rather than the size of the change.
A one-word fix to a shipped README earns an entry.
A rewritten build pipeline earns none.

## Sources

- [Keep a Changelog](https://keepachangelog.com/en/1.1.0/): the entry types and the rule that a changelog is written for humans.
- [Google developer documentation style guide, timeless documentation](https://developers.google.com/style/timeless-documentation): the rule behind "Documentation is time-agnostic".
- [Grafana Writers' Toolkit, style conventions](https://grafana.com/docs/writers-toolkit/write/style-guide/style-conventions/): positive sentences, behind "Naming an absence teaches a capability and then takes it away".
