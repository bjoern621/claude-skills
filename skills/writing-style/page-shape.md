# Page shape

What a docs page is shaped like, above the sentence level.
A page has one **thesis**, it names **contract** vocabulary, and it is short.
Sentence style, wrapping, changelog voice and time-agnostic phrasing live in [reference.md](reference.md).

## Thesis

A page answers one question, and the first three lines state it.
Every section serves that question.

Name the thesis in one sentence before writing.
A section that serves a different question belongs to a different page, so a page carrying four theses is four pages sharing a filename.

- Thesis: "who may do what, and what a leak costs".
- Thesis: "how a request reaches storage".
- Two pages, even when one package implements both.

## Architecture and programming are separate subjects

Architecture is what the parts are, what crosses between them, and what decides what.
Programming is which file holds it, what the function is called, and what type it returns.
The code answers the second completely and without going stale, so a page reaching for it spends its length on the half it is worst at.

An architecture page names no source file, no function, no type and no package path.

- Bad: "`publish.SamePipeline` renders both settings objects and compares the strings."
- Good: "A relaunch is decided by rendering both configurations and comparing them."
- Bad: "`App.run` is the publish in force and carries the settings its pipeline was built from."
- Good: "The publish in force carries the settings its pipeline was built from."

A reader reaches the code through the contract vocabulary, which the code spells the same way.
"The publisher compares the rendered command" leads to the comparison by its own words, and keeps leading there after a rename.
`publish.SamePipeline` leads there once.

A page whose subject genuinely is the code, an onboarding map or a package tour, is a different page and says so in its title.

## Contract

A page names what survives a rename.

| Kind | Belongs | Example |
|---|---|---|
| Contract vocabulary | Yes, this is the architecture | `POST /tokens`, `public/`, a config key, a wire message name, a third-party tool's own element name |
| A config file the reader edits | Yes | `deploy/gateway.yml` |
| Role name, in plain words | Yes | the gateway, the relay, the decode host |
| Implementation vocabulary | No, the code answers it | `authEngine`, `internal/authsvc`, `publish/live.go`, `App.run`, a struct field, a package-responsibility table |

Protocol verbs, wire paths, config keys and a third-party tool's own element names hold across any refactor, so they carry the architecture.
An internal name holds until someone renames it.

Test by renaming a type, then by moving a file.
A page that changes either time is a page restating code.

- Good: "Filtering happens at the gateway, so a listing carries one tenant."
- Bad: the same sentence with the package name closing the section.
- Bad: a table mapping each package to what it owns.

## A page states the decision and stops

Length is the defect a reader meets first, and it is usually the argument rather than the facts.
A decision is one line.
The reasoning that reached it, the alternative that lost, and the second and third consequence are the author's working, and the reader did not come for it.

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

A rewrite landing near a tenth of the length is the ordinary result, and the facts all survive it.
What a measurement cost to obtain says nothing about how much page it deserves.

## A diagram replaces a paragraph

Mermaid carries an exchange or a path better than prose does, so it goes first and the prose states the consequence.
`sequenceDiagram` for an exchange between parts, `flowchart` for the route something takes.
Two lines after the diagram, naming what follows from it.
A flow carried by prose alone wants a diagram above it.

## One screen per section

A section runs to about one screen.
Longer than that is two sections, or a page holding what another page owns.

## The shape, measured

`scripts/page-shape.sh` reports these numbers for any page.
Calibrate them per repository: measure the page whose shape the project already likes, and read that page's numbers as the target.

| Signal | Reference shape | Read the page |
|---|---|---|
| Words on the page | Under 800 | Over 1500 |
| Words per prose line | Under 15 | Over 20 |
| Implementation spans | None | Any |
| Words per diagram | Under 400 | Over 1500 |
| Longest section | Under 30 lines | Over 40 |

The numbers locate the page worth re-reading.

A page whose job is defining terms carries almost no contract vocabulary by design, so a glossary reads correctly at zero.
Name the exception when a signal fires for a reason like that one.

## Where the numbers read differently

A rules reference measures unlike an architecture page, and some signals fire on it for a reason.
Its sections are rule clusters holding one job, so a long section stays.
Its code spans are specimens of the constructions it governs, so implementation spans are the subject rather than a defect.
It describes no flow, so it draws no diagram.

## Completion criteria

- The thesis fits one sentence, and every section serves it.
- Every code span on the page is contract vocabulary, a config file the reader edits, or a term the page defines.
- No source file, function, type or package path appears, unless the page's subject is the code and its title says so.
- Every decision is stated in a line, with the working cut.
- Every flow has its diagram, and the prose under it states the consequence.
- Every section fits one screen.
- `bash <skill-dir>/scripts/page-shape.sh <page>` reports numbers, and each one outside the reference shape has a reason.
