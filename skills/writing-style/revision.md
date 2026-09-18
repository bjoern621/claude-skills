# Revision passes

How a draft reaches the state [SKILL.md](SKILL.md) describes.
A draft here means prose a human reads out of the repository; [SKILL.md](SKILL.md) states what falls outside that.

A single reading passes a rule stated in one place.
Each pass fixes which rules are in mind while it runs, and names the sections it sweeps rather than restating them.

## The passes

They run in order, each over the whole draft.
A pass that rewrites a sentence sends the draft back through every pass already run, the rewrite being new text that nothing has checked.

### 1. Content

Read for what each sentence gives a reader who does not have the code open.
A sentence stating a fact the reader can act on stays.
A sentence restating its neighbour, its heading, or the line beneath it goes.
Capability claims are checked against the code before any other rule, a false one outweighing all of them.

### 2. Rule sweep

One entry from the sweep list at a time, the whole draft read once per entry.
The entry's section is open while its read runs.
A section recalled from memory loses its quieter rules, and this pass exists to stop that.

### 3. Document sweep

The rules under "What only a reader catches" in [ai-tells.md](ai-tells.md), which fire on a pattern across the draft rather than on one sentence.
The frequency gate closing that page decides each one.

### 4. Cure pass

Every sentence the earlier passes rewrote is read again, on its own, and asked what it now states.
Cutting a tell manufactures a register of its own: bare fragments, amputated contrasts, sentences that lost their content and kept their shape.
A sentence that lost its content is rewritten rather than left short.

### 5. Cross-check

A reader who did not write the draft reads it against this skill and reports what it finds.
The author knows what each sentence was meant to say, and cannot read it for what it says.
In an agent session a subagent reads, handed the skill and the draft and nothing about the intent behind them.
Its findings are checked rather than applied, a reader without the intent taking a deliberate choice for a slip.

## Sweep list

The sections pass 2 walks, in order.
Each rule is stated once, on the page the sweep opens to reach it.

1. [reference.md](reference.md), "Punctuation".
2. [reference.md](reference.md), "Docs and prose".
3. [SKILL.md](SKILL.md), "Comment checklist", then [reference.md](reference.md), "Comments".
4. [reference.md](reference.md), "Naming the parts".
5. [SKILL.md](SKILL.md), "Labelling copula", "Paired negation" and "Restriction", then the same three sections of [reference.md](reference.md).
6. [reference.md](reference.md), "Language states the present" and "Mood".
7. [reference.md](reference.md), "Changelog", for a changelog entry or a release note.
8. [SKILL.md](SKILL.md), "Scope and addressee".
9. [ai-tells.md](ai-tells.md), one table per read: lexical, syntactic, structural, rhetorical.
10. [page-shape.md](page-shape.md) for a docs page or a README, then [readme.md](readme.md) for a README.

Entries 1 to 7 open every rule-bearing section of [reference.md](reference.md), and entries 3, 5 and 8 add the sections of [SKILL.md](SKILL.md) that state a rule of their own.
Entry 5 reads the draft once for the labelling copula alone, that shape surviving a general read by sounding like a definition.
Entry 9 opens the four tables of [ai-tells.md](ai-tells.md); that page's "What only a reader catches" belongs to pass 3 and "The cure has its own tells" to pass 4.
Entry 10 names [page-shape.md](page-shape.md) and [readme.md](readme.md) whole.
The sections of [SKILL.md](SKILL.md) left out of the list condense reference sections the list already opens, or point into entries 9 and 10.
"Scope of application", "Completion criteria" and each page's "Sources" carry no rule a draft can break.
A rule added inside a listed section joins the sweep with no edit here.
The exemptions in "False positives" of [ai-tells.md](ai-tells.md) hold over every entry.

## Completion criteria

- Every capability claim in the draft has been checked against the code.
- Every entry in the sweep list has had its own read of the whole draft.
- Every rule under "What only a reader catches" has been asked of the whole draft, against the frequency gate closing that page.
- Every comment written or touched has been read against the line beneath it, one comment at a time.
- No sentence re-labels its subject with `is a`, `is an`, `is the` or `are the`, outside a glossary row and a domain-model entry.
- Every sentence the passes rewrote has been through the cure pass.
- A cross-check has run, and each finding it returned has been accepted or refused with a reason.
