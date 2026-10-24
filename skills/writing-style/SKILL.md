---
name: writing-style
description: Style for repository prose and on-screen text that a human reads. Covers code and config comments, docstrings, identifiers, test names, log lines, Markdown docs, wiki pages, READMEs, changelogs, commit and PR bodies, and every string on screen (labels, buttons, tooltips, dialogs, errors, empty states, CLI output). Load before writing, editing or reviewing any of them, however small the edit. Also load it when the user asks to make text read less like AI or says "UI copy".
---

# Writing style

A chat reply follows the `caveman` plugin.
A string on screen also takes [interface.md](interface.md).
A document that an agent executes (a skill, `AGENTS.md`, `CLAUDE.md`, a prompt) follows `writing-for-agents` from `mattpocock-skills`.
A generated file takes its fixes in its generator or the generator's input.
On conflict with project style rules or a `CLAUDE.md`, this skill wins.

Every text also follows [voice.md](voice.md), the author's own way of writing.
A docs or wiki page and a README also take [docs.md](docs.md).

English and German text follow their own grammar.
The rules that rest on English grammar hold for English alone: `that` in a relative clause, the comma before `and`, "would", "well" and American spelling.
German text sets a comma before every subordinate clause, takes the quotation marks that the project uses and keeps the English terms of its field (Branch, Merge Request, Deployment).
Every other rule holds in both languages.
Open [reference.md](reference.md) for a changelog entry, a docs page, a README, a commit body over five lines or a case that a rule below leaves open.

## Sentences

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

**No comma before `and`.**
The last item follows `and` or `or` with no comma: "resolver, fetcher and linker".

**State the fact and stop.**
"X, not Y", "X, never Y", "not Y but X", "rather than", "instead of" and "X over Y" mirror the fact or hang a rejected option off it.
Cut the mirror: "Runs on a subscription rather than per token." becomes "Runs on a subscription."
An alternative that the reader arrives holding goes into a parenthesis.
A correction of fact ("Use pnpm, not npm") and a choice between two live options ("deleted rather than shortened") stay inline.

**Keep `that` in a relative clause.**
"the files the build reads" becomes "the files that the build reads", whatever the subject: "everything that you need".

**Cut a restriction that narrows nothing.**
Delete `only`, `just`, `simply` or `merely` and reread.
Same meaning: the word goes.
Wider meaning: it stays, as in `// Safe only on the render thread.`

**Let a fact stand alone.**
Cut `so`, `thus` and `which means` where the reader derives the consequence.
Cut a tacked-on participle (`, improving stability`): it claims a result that the clause never showed.

**Plain words.**
"The runner leverages the cache." becomes "The runner reads the cache."
"Each review is billed to a subscription." becomes "Each review runs on a subscription."
Cut inflated words, hedges on facts, scaffolding ("Note that", "At its core"), ALL CAPS, bold terms and emoji.
"well" appears as "as well", a water well or good health.
Every other sense takes another word: "valid" for "well-formed".

**Describe what stands.**
"now", "new", "no longer", "not yet", "currently", "recently", "soon", dates and counts that other work changes belong in commits and changelogs.
State the invariant that produces the fact.

**"would" for the path argued against.**
"Leaving the rule on would report each dependency twice."
A path that the page offers keeps the indicative.

**Leave numbers and lists open.**
A number or a list that the code sets goes stale with the next edit to the code.
"Retries three times" becomes "retries a few times".
A list names a few members and says that more exist: "providers such as Gmail and Outlook".
A closed set that the reader has to hit stays complete: the values that a field accepts.

**Punctuation.**
A period, comma, colon or parenthesis takes the place of an em-dash, a `─` or a spaced hyphen standing in for one.
ASCII diagrams keep their box-drawing lines.
Straight quotes, one layer of parentheses, a hyphenated pair in front of its noun alone ("a high-quality report").

**Third person** in docs.
A README, a setup page and a contributing page address the reader as "you".
A design doc says "we" for the team's choice.

## Facts

A sentence agrees with the code or the page that it describes.
Every path, name, namespace and version that it names exists as named.
Two places stating one fact agree.
Where they differ, the source that owns the subject settles it.

## Line breaks

Markdown and commit bodies take one sentence per source line.
Prose runs a sentence to its end on one line, whatever the width.
A code comment breaks where its layout reads best.
Short sentences and clipped fragments can share a line: `# 365 days. Google caps web sessions at 14 days by default.`
A comment too wide for the file breaks at the one `,` `:` `;` or conjunction that splits it into readable halves.
Every other punctuation mark keeps its line.
A long line that reads in one pass stays whole.
A review judges the comment block against the layout of the file around it.
A wiki page, an issue, a PR or MR description and a review note show every line break: a paragraph goes in as one line.

## Comments

1. A comment states what the code cannot show: unit, range, invariant, reason for an odd choice, caller obligation.
   A doc comment on a function that others call carries its contract after the first line: concurrency, call obligations, behaviour on missing input, side effects, copies, errors and what it leaves to the caller.
   A data structure documents its layout: field widths and meanings, a diagram for a wire format.
   A branch whose condition hides its domain case gets the case named, sparingly.
   A paraphrase of the line, a value gloss (`# 0: no blink.`), what the tool's documentation already says and routine code stay uncommented.
2. The first comment in a block, method or file holding none stays out unless it carries a fact from item 1.
3. It describes the code as it stands, for the code's next reader.
   History, the reviewer and commented-out code stay out.
   A TODO names its issue: `// TODO(#12): ...`.
4. Paths, line numbers and counts stay out.
   For a tool-written annotation (gettext `#:` origins), turn the tool's option off.
5. Clipped fragments: `// Resolved timeout. nil if profile sets none.`
   Formats by example: `// ms, 1..60000.`
   A cut keeps every fact.
6. Clipping happens inside the language's own convention.
   A Go doc comment opens on the identifier.
   JSDoc tags carry the facts.
7. A touched comment gets rewritten in the same change.
   Untouched ones stay.
8. A test name states what the test proves.
   A log line reports the reading: `"%s declares no retry budget"`.

[comments.md](comments.md) shows each kind in the author's own code.

## Reviewing

A finding names the rule in this skill that the text breaks.
Text breaking no rule here stays as written.
A tell from [reference.md](reference.md) counts once it forms a pattern across the page.
A fix follows these rules itself.

## Completion criteria

- Every sentence written or touched has been read against each rule under "Sentences", one rule at a time.
- Every `, and` and `;` has been read against what follows.
  None leads into a second subject.
- Every comment has been read against the line beneath it and cut on a second pass.
- Every fact, name and path has been checked against its source.
- A docs page, a README and a commit body over five lines have been read once more by a subagent handed this skill and the draft alone.
  Each finding got accepted or refused with a reason.

Reading settles each of these.
A pattern match passes every fluent, empty sentence.
