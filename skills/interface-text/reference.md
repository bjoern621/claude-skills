# Interface text reference

Full ruleset for user-facing interface text.
[SKILL.md](SKILL.md) carries the working checklist; this file settles the details and edge cases.
Grounded in the shared guidance of the Microsoft Writing Style Guide, Material Design writing, GOV.UK content design, Nielsen Norman Group research, and Podmajersky's "Strategic Writing for UX".

Examples come from several kinds of product on purpose, so the rule shows through rather than one product's vocabulary.

## Register

**Copy passes unnoticed.**
Interface text helps somebody to the thing they want and is forgotten on the way.
A sentence the reader stops to admire, or to decode, is rewritten.
- Bad: "That is a trade you are entitled to make: it opens anywhere, and it costs you."
- Good: "It opens in any editor, at the cost of a larger file."

**Plain conversational.**
Full short sentences, everyday words, the tone of a competent colleague.
Formal register reads colder without reading more trustworthy; fragments read curt in help text.
Fragments stay legitimate where the surface is a fragment: chip captions, list notes, table cells.

**No opinions, no judgment, no humor.**
The copy states facts and trades; the reader decides.
Verdicts ("settings nobody asked for"), permissions ("entitled to make"), and jokes are cut.
Humor reads once; settings text is read hundreds of times.

## Person

**Neutral by default.**
The person reading is addressed directly or left unnamed.
"The user", "the customer", "the reader", "somebody" as a name for the person reading are banned.

**"you/your" only where ownership is otherwise ambiguous.**
- Good: "Everyone holding the link sees your files; nobody else does."
- Bad: "You can pick a different backup schedule." (imperative does it: "Pick a different backup schedule.")

**Actions are imperatives.**
"Set a ceiling.", "Install it, or pick a method that needs no plugin."

**No self-reference.**
Never "we", never "I".
Where scope needs naming, the concrete part beats "this app": "no built-in viewer opens this format", not "this app cannot open this format".

## Shape

**Aim 15 words per sentence, cap 25.**
Comprehension drops hard past 25 words.
A sentence with three clauses is two or three sentences.

**Lead with the fact that carries the decision.**
Front-load; detail follows for whoever reads on.
- Good: "Constant quality, variable file size. The rate rises with detail and falls to almost nothing on a blank page."

**Punctuation stays simple.**
Periods and commas.
Colon only before a list or an example.
No semicolons, no em-dashes, no exclamation marks.

**Sentence case everywhere**: labels, buttons, headings, titles.
A fragment carries no trailing period; a full sentence does.

## Patterns per surface

**Error and refusal: problem, cause, fix.**
Specific over generic: exact names, exact figures, the reader's own values.
The fix is named only where one exists; a refusal with no way out ends after the cause.
- Good: "The converter is not installed, so this format cannot be read. Install it, or export as CSV instead."
- Good, no fix known: "The database refused the connection on this machine."

**Disabled control: why, and what enables it.**
A grayed control is never a communication dead end.
- Good: "Locked while a backup runs. Stop the backup to change it."

**Option description: what it does, when to pick it.**
The observable effect beats the definition.
- Bad: "Incremental mode retains only blocks whose checksum has changed."
- Good: "Copies only what changed since the last run. Faster, and it needs the last run to still be there."

**Tooltip: 25 words at most.**
Supplemental only; anything the reader must act on lives in the interface proper.
Never a restatement of the visible label.

**Empty state: what is so, then the next step.**
- Good: "Nothing saved yet. Name the configuration below to keep it."

**Layered depth.**
The first sentence carries the decision; mechanism follows only where the decision needs it.
Help text may teach; it may not lecture.

## Words

**American English**, one variant throughout.

**One term per concept.**
A concept renamed per surface costs the reader a lookup each time.
The term list belongs to the product, so a project fixes its own names in one place and every surface reads them from there.
Check the project's design or style document for an existing term before coining one.

**Personification stays standard.**
Verbs normal in technical writing stay: a service holds, targets, refuses, retries, serves.
Dramatic agency goes: nothing "spends whatever the picture costs" or "asks no more of a home router".

**Blame-free problem words.**
Not aimed at the reader or their input: "error", "failed", "invalid", "illegal", "bad", "abort", "fatal".
Instead: "could not", "unable", "incorrect", "not supported", "stop".
- Bad: "Invalid file name."
- Good: "The file name cannot contain slashes."

**Politeness words are rare.**
"please" only when asking the reader to wait or to redo work.
"sorry" only for serious loss (data loss, unusable state).
Facts and fixes carry the courtesy.

**Identifiers ride in parentheses.**
Plain words carry the sentence; the identifier appears where a log or command line would show it.
- Good: "Compressed with the slower method (zstd-19)."

**Positive framing.**
Say what is so and what to do.
An absence is named only where the reader would try to restore it.
- Bad: "Nothing carries formatting through the export, so the file has no styles."
- Good: "The export carries text alone. Open the original to keep the styling."

**No changelog voice.**
The reader holds no earlier version of the product.
"no longer", "not yet", "new" are cut; the state is named instead.
This rule is shared with [writing-style](../writing-style/reference.md), which states it in full.

## Second pass

Every string is re-read before moving on, every time.
Ask, in order:
- Does it read like a colleague talking, or like an author writing? Rewrite the author out.
- Does the first sentence carry the decision? Reorder.
- Which words carry no fact? Cut them.
- Does any sentence pass 25 words? Split it.
- Shorter without losing a fact? Not finished.
