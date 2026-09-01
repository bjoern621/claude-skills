# Page shape

What a docs page is shaped like, above the sentence level: what it answers, which names it may use, and what a diagram carries.
Sentence style, wrapping, changelog voice and time-agnostic phrasing live in [reference.md](reference.md).

Three words do the work here.
A page has one **thesis**, it names **contract** vocabulary, and it ends a section on a **pointer**.

## Thesis

A page answers one question, and the first three lines state it.
Every section serves that question.

Name the thesis in one sentence before writing.
A section that serves a different question belongs to a different page, so a page carrying four theses is four pages sharing a filename.

- Thesis: "who may do what, and what a leak costs".
- Thesis: "how a frame reaches the relay".
- Two pages, even when one package implements both.

## Contract

A page names what survives a rename.

| Kind | Belongs | Example |
|---|---|---|
| Contract vocabulary | Yes, this is the architecture | `POST /tokens`, `public/`, `~^prefix`, `authJWTExclude`, `srtsink` |
| Pointer | Yes, once, at the end of a section | `backend/internal/groupsvc`, `deploy/mediamtx-groups.yml` |
| Implementation vocabulary | The code answers it | `ffmpegEngine`, `gstCapture`, a struct field, a package-responsibility table |

Protocol verbs, wire paths, config keys and a third-party tool's own element names hold across any refactor, so they carry the architecture.
An internal type name holds until someone renames it.

Test by renaming a type.
A page that changes is a page restating code, and the fix is a pointer at the package that owns the fact.

- Good: "Filtering happens at groupd, so a listing carries one group." with `backend/internal/groupsvc` closing the section.
- Bad: a table mapping each package to what it owns.

## A diagram replaces a paragraph

Mermaid carries an exchange or a path better than prose does, so it goes first and the prose states the consequence.
`sequenceDiagram` for an exchange between parts, `flowchart` for the route something takes.
Two lines after the diagram, naming what follows from it.

A page explaining a flow in prose alone is a page whose diagram was never drawn.

## One screen per section

A section runs to about one screen.
Longer than that is two sections, or a page holding what another page owns.

## The shape, measured

`docs/auth-flow.md` in this repository is the reference shape, and `scripts/page-shape.sh` reports these numbers for any page.

| Signal | Reference shape | Read the page |
|---|---|---|
| Words per prose line | Under 15 | Over 20 |
| Code spans that are pointers | Over half | Under a quarter |
| Words per diagram | Under 400 | Over 1500 |
| Longest section | Under 30 lines | Over 40 |

The numbers locate the page worth re-reading.
A long page holding one thesis and pointing at its code stays long.

A page whose job is defining terms carries few pointers by design, so `docs/glossary.md` sits at 6% and is right to.
Name the exception when a signal fires for a reason like that one.

## Completion criteria

- The thesis fits one sentence, and every section serves it.
- Every code span on the page is contract vocabulary or a terminal pointer.
- Every flow has its diagram, and the prose under it states the consequence.
- Every section fits one screen.
- `bash <skill-dir>/scripts/page-shape.sh <page>` reports numbers, and each one outside the reference shape has a reason.
