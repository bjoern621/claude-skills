# Page shape

What a docs page is shaped like, above the sentence level.
A page has one **thesis**, it names **contract** vocabulary and it is short.
Sentence style, wrapping, changelog voice and time-agnostic phrasing live in [reference.md](reference.md).

## Thesis

A page answers one question.
The first three lines state it.
Every section serves that question.
[Diátaxis](https://diataxis.fr/) names four needs a page can serve: learning, doing a task, looking a fact up, understanding.
A page serves one of them.

Name the thesis in one sentence before writing.
A section that serves a different question belongs to a different page.
A page carrying four theses is four pages sharing a filename.

- Thesis: "who may do what and what a leak costs".
- Thesis: "how a request reaches storage".
- Two pages, even when one package implements both.

## Architecture and programming are separate subjects

Architecture is what the parts are, what crosses between them and what decides what.
Programming is which file holds it, what the function is called and what type it returns.
The code answers the second completely and without going stale.
A page reaching for it spends its length on the half it is worst at.

An architecture page names no source file, no function, no type and no package path.

- Bad: "`publish.SamePipeline` renders both settings objects and compares the strings."
- Good: "A relaunch is decided by rendering both configurations and comparing them."
- Bad: "`App.run` is the publish in force and carries the settings its pipeline was built from."
- Good: "The publish in force carries the settings its pipeline was built from."

A reader reaches the code through the contract vocabulary, which the code spells the same way.
"The publisher compares the rendered command" leads to the comparison by its own words and keeps leading there after a rename.
`publish.SamePipeline` leads there once.

A page whose subject genuinely is the code, an onboarding map or a package tour, says so in its title.

## Contract

A page names what survives a rename.

| Kind | Belongs | Example |
|---|---|---|
| Contract vocabulary | Yes, it carries the architecture | `POST /tokens`, `public/`, a config key, a wire message name, a third-party tool's own element name |
| A config file the reader edits | Yes | `deploy/gateway.yml` |
| Role name, in plain words | Yes | the gateway, the relay, the decode host |
| Implementation vocabulary | No, the code answers it | `authEngine`, `internal/authsvc`, `publish/live.go`, `App.run`, a struct field, a package-responsibility table |

Protocol verbs, wire paths, config keys and a third-party tool's own element names hold across any refactor.
They carry the architecture.
An internal name holds until someone renames it.

Test by renaming a type, then by moving a file.
A page that changes either time restates code.

- Good: "Filtering happens at the gateway, so a listing carries one tenant."
- Bad: the same sentence with the package name closing the section.
- Bad: a table mapping each package to what it owns.

## A heading names the rule at the level it applies

The case that prompted the rule belongs to the example under it.
A heading naming that case sends a reader carrying a different one straight past the rule that covers them.

- Bad: "A path not taken takes the conditional", over a rule about grammatical mood.
- Good: "Mood", over the same rule, with the rejected-path example under it.

The test: somebody meeting the rule in another project reads the heading and recognizes it.
The example stays as concrete as it was.

## Scope and addressee

A page carries what the project owns.
Behaviour belonging to a tool the project plugs into is that tool's documentation.
Restating it here goes stale the first time that tool changes.
Name the tool and let its own docs answer for it.

- Bad, in a lint plugin's README: "ESLint reads `.js`, `.mjs` and `.cjs` on its own, so the `files` entry is what brings `.jsx` and TypeScript in."
- Good: the configuration example carries a `files` entry. The page explains ESLint nowhere.

The addressee sets how much is said.
Somebody configuring a plugin already runs the tool it plugs into.
The page addresses a reader who knows that tool and came for this one.
Explaining the addressee's own tools back to them reads as padding.
A page that runs long cuts it first.

Name the addressee in one line before writing, beside the thesis.
The two together decide what a section is allowed to hold.

## A snippet names where it goes

A snippet opens with its destination, written as a comment in the snippet's own language: `// eslint.config.js`, `# .github/workflows/ci.yml`, `# run from the repository root`.
A reader pasting a snippet that names no destination guesses it.

## A page states the decision and stops

A reader meets length before any other defect.
The argument rather than the facts usually causes it.
A decision takes one line.
The reasoning that reached it, the alternative that lost and the second and third consequence stay with the author.
The reader did not come for them.

Cut, in the order these usually appear:

- The mechanism behind the decision, when the decision is what the reader acts on.
- The rejected alternative and why it lost.
- Every consequence after the first.
- The aside opening "It is also what", "This is what lets", "which is the reason".

Bad, five lines:

> **The rendered command decides whether a relaunch is needed.**
> `publish.SamePipeline` renders both settings objects and compares the strings.
> The command is the whole of what an engine hands its child, so a field no builder reads cannot change it and a field a builder reads always does.
> A table of which fields matter would be a second statement of one fact, falling behind the builders the first time one read a field the table did not name.
> It is also what leaves the watch leg, the uplink figure and the relay's API port free to move under a running stream: no pipeline is built from them.

Good, one:

> A relaunch is decided by rendering both configurations and comparing them, so a setting no pipeline is built from moves under a running stream.

A rewrite lands near a tenth of the length.
The facts all survive it.
What a measurement cost to obtain says nothing about how much page it deserves.

## A diagram replaces a paragraph

Mermaid carries an exchange or a path better than prose does.
It goes first and the prose states the consequence.
`sequenceDiagram` for an exchange between parts, `flowchart` for the route something takes.
Two lines after the diagram, naming what follows from it.
A flow carried by prose alone wants a diagram above it.

## A table holds comparable data

A table earns its place with three or more related data points per row and a header naming what the column holds.
A row holding a clause belongs in prose.
A table of situations and results states a machine, which belongs in reference material.
[readme.md](readme.md) states what a README does with one.

## One screen per section

A section runs to about one screen.
Longer than that is two sections, or a page holding what another page owns.

## The shape, measured

`scripts/page-shape.sh` reports these numbers for any page.
Calibrate them per repository: measure the page whose shape the project already likes and read that page's numbers as the target.

| Signal | Reference shape | Read the page |
|---|---|---|
| Words on the page | Under 800 | Over 1500 |
| Words per prose line | Under 15 | Over 20 |
| Implementation spans | None | Any |
| Words per diagram | Under 400 | Over 1500 |
| Longest section | Under 30 lines | Over 40 |

The numbers locate the page worth re-reading.

A page whose job is defining terms carries almost no contract vocabulary by design.
A glossary reads correctly at zero.
Name the exception when a signal fires for a reason like that one.

## Where the numbers read differently

A rules reference measures unlike an architecture page.
Some signals fire on it for a reason.
Its prose takes the labelling-copula ban like any other page.
Its sections are rule clusters holding one job.
A long section stays.
Its code spans are specimens of the constructions it governs.
Implementation spans carry its subject rather than marking a defect.
It describes no flow and draws no diagram.

## Completion criteria

- The thesis fits one sentence. Every section serves it.
- Every code span on the page is contract vocabulary, a config file the reader edits, or a term the page defines.
- No source file, function, type or package path appears, unless the page's subject is the code and its title says so.
- Every decision is stated in a line, with the working cut.
- Every flow has its diagram. The prose under it states the consequence.
- Every section fits one screen.
- `bash <skill-dir>/scripts/page-shape.sh <page>` reports numbers. Each one outside the reference shape has a reason.

## Sources

- [Diátaxis](https://diataxis.fr/): the four needs a page serves, behind one thesis per page.
- [Google developer documentation style guide, tables](https://developers.google.com/style/tables): when a table beats a list.
