---
name: writing-style
description: Style for repository prose and on-screen text that a human reads. Covers code and config comments, docstrings, identifiers, test names, log lines, Markdown docs, wiki pages, READMEs, changelogs, commit and PR bodies. Also covers every string on screen (labels, buttons, tooltips, dialogs, errors, empty states, CLI output). Load before writing, editing or reviewing any of them, however small the edit. Also load it when the user asks to make text read less like AI or says "UI copy".
---

# Writing style

Every text that a person reads follows this page, in the author's voice.
Each kind of text adds its own page on top:
- a code or config comment, a docstring, a test name, a log line or an error that a developer reads: [comments.md](comments.md)
- a docs or wiki page, a README, an ADR, a report, a setup or contributing page, a changelog: [docs.md](docs.md)
- a string on screen, errors that a user reads included: [interface.md](interface.md)
- a PR, MR or issue description: the `pull-request` skill for its shape
- a case that a rule here leaves open and the tells that no rule names: [reference.md](reference.md)

A chat reply follows the `caveman` plugin.
A document that an agent executes (a skill, `AGENTS.md`, `CLAUDE.md`, a prompt) follows `writing-for-agents` from `mattpocock-skills`.
A generated file takes its fixes in its generator or the generator's input.
On conflict with project style rules or a `CLAUDE.md`, this skill wins.

## Language

English and German text follow their own grammar.
The rules that rest on English grammar hold for English alone: `that` in a relative clause, the comma before `and`, "would", "well" and American spelling.
German text sets a comma before every subordinate clause, takes the quotation marks that the project uses and keeps the English terms of its field (Branch, Merge Request, Deployment).
Every other rule holds in both languages.

## Sentences

**Claim first, reason after.**
The claim opens the sentence.
The reason follows, after "because" or "since" where the reader cannot derive it.
It names a fact about the system or its reader: a constraint, a consequence, a cost.
"The `#` source references stay out of the catalog, since they change with every edit."
A choice names its purpose after "to avoid" or "to prevent".
The cost that it accepts follows as its own sentence: "Sending skips the ACK wait to avoid blocking. The receiver might get a faulty message."

**Say what the thing does.**
`is a`, `is an`, `is the`, `are the` and `serves as` re-label the subject.
Give it a verb.
"The binding layer is a bridge." becomes "The binding layer redraws the view when the model changes."
A predicate naming a state stays: "The buffer is full".
A glossary row keeps the copula.

**One independent clause per sentence.**
`, and` or `;` leading into a second subject with its own verb becomes a period.
"A tag sits on a message, and a thread carries its tags." becomes "A tag sits on a message. A thread carries its tags."
One subject with two verbs stays one sentence: "The job scans the window and retries once."

**State the fact and stop.**
"X, not Y", "X, never Y", "not Y but X", "rather than", "instead of" and "X over Y" mirror the fact or hang a rejected option off it.
Cut the mirror: "Runs on a subscription rather than per token." becomes "Runs on a subscription."
An alternative that the reader arrives holding goes into a parenthesis.
A correction of fact ("Use pnpm, not npm") and a choice between two live options ("deleted rather than shortened") stay inline.

**Short.**
A description fits one line.
A bullet carries one point, as a short noun phrase where it can.
The longer wording stays when the shorter one would drop a fact.
Each line earns its place by a fact that the human reader needs.

**Plain words for a reader outside the field.**
"The runner leverages the cache." becomes "The runner reads the cache."
A term from a tool's internals ("hunks", "connmark") gets the plain word for what it means.
Cut inflated words, scaffolding ("Note that", "At its core"), ALL CAPS, bold terms and emoji.
"well" appears as "as well", a water well or good health.
Every other sense takes another word: "valid" for "well-formed".

**Flat facts.**
A rule that the system holds reads flat, with "never" or "always": "One mail belongs to one linked mailbox."
A fact carries no "probably", "presumably" or "(not checked)".
A guess stays apart from the facts, marked as a guess: "(is the peer disconnected?)".
An open problem gets named as open, with its workaround and the issue that tracks it: "An own domain avoids this problem (tracked in Task-91)."

**Cut a restriction that narrows nothing.**
Delete `only`, `just`, `simply` or `merely` and reread.
Same meaning: the word goes.
Wider meaning: it stays, as in `// Safe only on the render thread.`

**Let a fact stand alone.**
Cut `so`, `thus` and `which means` where the reader derives the consequence.
Cut a tacked-on participle (`, improving stability`): it claims a result that the clause never showed.
A participle naming the action that the code takes stays: `Unknown log level, defaulting to INFO`.

**Describe what stands.**
"now", "new", "no longer", "not yet", "currently", "recently", "soon", dates and counts that other work changes belong in commits and changelogs.
State the invariant that produces the fact.

**Leave numbers and lists open.**
A number or a list that the code sets goes stale with the next edit to the code.
"Retries three times" becomes "retries a few times".
A list names a few members and says that more exist: "providers such as Gmail and Outlook".
A closed set that the reader has to hit stays complete: the values that a field accepts.
The exact number lives beside the code that sets it.

**A real case anchors a rule.**
An abstract rule gets one concrete case after "for example", or a restatement after "meaning".
The case comes from reality, with named actors and the sizes that the format fixes: "Chunk 1 can end on the first two bytes of a four-byte code point. Chunk 2 starts with the other two."
A design gets tested against the case that breaks it, such as a text written for one pending file meeting two.
A reason can point at a product that the reader knows: "A Discord chat never gets summarised either."

**"would" for the path argued against.**
"Leaving the rule on would report each dependency twice."
A path that the page offers keeps the indicative.

**Keep `that` in a relative clause.**
"the files the build reads" becomes "the files that the build reads", whatever the subject: "everything that you need".

**Punctuation.**
A period, comma, colon or parenthesis takes the place of an em-dash, a `─` or a spaced hyphen standing in for one.
ASCII diagrams keep their box-drawing lines.
Straight quotes, one layer of parentheses, a hyphenated pair in front of its noun alone ("a high-quality report").
No comma before `and` or `or` closing a list: "resolver, fetcher and linker".
A slash for "or" stays: "testing / reviewing".

## Terms and names

A term gets its meaning at first use, after "means that": "Blocking means that one block of a message or file goes out until the receiver confirms it."
An acronym gets spelled out once.
A short gloss sits in quotes and parentheses behind the term: `the sequence number ("version") of the LSA`.
A synonym follows "also" in parentheses: "all peers (also nodes)".
"more precisely" narrows a broad term to the one meant: "distribution transparency (more precisely access transparency)".
A term that reads several ways gets pinned down: "per instance" names an environment, a server or a chart version.

One concept keeps one name in every file, page and interface.
Two concepts that a reader could merge stay apart in every sentence: "Signing in to Pidgemail and linking a mail account stay independent."
Two close terms get their relation stated: "Unreachable hosts form a subset of the hosts without a route."
An existing text that fits gets reused before a new one gets written.

A name states the role in the project's own words.
It runs longer where that makes it clearer: `worker` becomes `background mail sync worker`.
A provider's term stays out of a project name: Gmail's "archive" means nothing in Outlook.
A name matches its siblings: a new bot takes the naming pattern of the other bots.
A name that marks a moment (`parserV2`, `legacyPath`, `newParser`) goes false after the next release.

## Facts and scope

A sentence agrees with the code or the page that it describes.
Every path, name, namespace and version that it names exists as named.
A state, an error or a term from an outside tool takes the tool's own words, read in its output or its docs.
For example, Argo CD marks a tracked resource gone from Git as "requires pruning".
Its "orphaned" names a resource that no application tracks.
Two places stating one fact agree.
Where they differ, the source that owns the subject settles it.

A thing gets described by what it serves and where it stops: "The WireGuard VPN gives internet and LAN access from a region with restricted internet. It reaches none of the services."
A guarantee names what it covers, then what it leaves untouched: "Blocking keeps the current block apart from other blocks of the same message type. Messages of another type stay unaffected."
A condition gets both branches: "With the blockchain subsystem, the node serves these functions as well. Without it, the node ignores the requests."
A weakness names the failure, the quality that it costs and who stays unaffected.
A process names its start state, the step that it repeats and when it stops.
A value taken from an outside source links that source beside the value.
An operation or a component gets described from its verb, after the identifier where the doc convention leads with one.
The description ends on what happens with missing or duplicate input: "Adds a vertex to the graph. Nothing happens if the vertex exists."
A sibling gets described by how it differs: "Like getEdges(). In place of a list, it concatenates a formatted string."

## Behaviour

Interface behaviour reads as the sequence that a user sees: trigger, state, result.
"The first file needs accepting. Every file after it arrives without a prompt."
An issue reports what works, what fails and what should happen.
A fix names the behaviour that it ends and, in parentheses, what that behaviour broke: "Fix payload being modified (broke file transfer)".
A status names its cause.
"Degraded" alone tells the reader nothing.
A likely cause may appear, marked as likely.

## Line breaks

Markdown and commit bodies take one sentence per source line.
Prose runs a sentence to its end on one line, whatever the width.
A wiki page, an issue, a PR or MR description and a review note show every line break: a paragraph goes in as one line.
A code comment breaks by its layout, as [comments.md](comments.md) sets out.

## Reviewing

A finding names the rule in this skill that the text breaks.
Text breaking no rule here stays as written.
A tell from [reference.md](reference.md) counts once it forms a pattern across the page.
A fix follows these rules itself.

## Completion criteria

- The page for the kind of text has been read where one exists.
  Its own criteria hold.
- Every sentence written or touched has been read against each rule under "Sentences", one rule at a time.
- Every `, and` and `;` has been read against what follows.
  None leads into a second subject.
- Every fact, name, path and term has been checked against its source before the text leaves the editor.
  A pushed commit or a posted comment stays as written.
- A commit body over five lines has been read once more by a subagent handed this skill and the draft alone.
  Each finding got accepted or refused with a reason.

Reading settles each of these.
A pattern match passes every fluent, empty sentence.
