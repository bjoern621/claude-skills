# Docs pages and READMEs

Shape of a docs page, a wiki page and a README, above the sentence rules in [SKILL.md](SKILL.md).

## A page

- One question per page.
  The first three lines answer it.
  Every section serves it.
  A section answering another question moves to another page.
- One addressee, named in a line before writing.
  The page explains what the project owns.
  A tool that the project plugs into gets named and left to its own docs.
- Contract vocabulary.
  Routes, config keys, wire message names, config files that the reader edits and the parts named in plain words.
  Source files, functions, types and package paths stay out: the code answers those.
  A page about the code itself (an onboarding map, a package tour) says so in its title.
- A decision takes one line.
  The reasoning behind it, the alternative that lost and every consequence after the first go to the ADR or the commit body.
- A snippet opens with its destination as a comment in its own language: `// eslint.config.js`.
- A diagram for a flow.
  Mermaid `sequenceDiagram` or `flowchart` comes first, two lines of consequence after it.
- A table for comparable data, three or more data points per row.
  A table of situations and results belongs on a reference page.
- One screen per section.
- A heading names the rule at the level where it applies.
  The case that prompted it goes into the example.
- An anchor names a heading or a config key, which survive edits.

`bash <skill-dir>/scripts/page-shape.sh <page>` measures length, line density and implementation spans.
Each number outside the reference shape needs a reason.

## A README

Its reader decides whether to use the software and has never seen it.
A README addresses its reader as "you".
Contributor material goes on its own page, linked at the bottom.

Informing shape, for software whose value the reader already grants: name and what it does in one to three lines, picture, what it does as one checkable fact per line, install, use, configuration, where it works, one line on internals, license.

Arguing shape, for software contradicting a default that the reader holds: name and what it does, the problem in the reader's own code, the incumbent's answer at its real cost in code, this answer to the same task in code, the cases that it fits, install and use, the next objection answered in code, license.
The two snippets hold everything identical but the answer.
Without a real default to argue against, the page takes the informing shape.
[eslint-plugin-exhaustive-deps-exclude](https://github.com/bjoern621/eslint-plugin-exhaustive-deps-exclude) runs the arguing shape end to end.
Its section order sets the model.
Its wording breaks these rules in places.

Every capability line gets checked against the code before it ships.
Limits get stated as what works.
An unsupported case gets named where the reader would assume it works.
A section that the project has nothing for stays out.

## Completion criteria

- The page's question fits one sentence.
- Every code span on the page holds contract vocabulary, a config file that the reader edits, a term that the page defines or a command that the reader runs.
  A page whose title names the code is exempt.
- Every decision takes one line.
- Every capability claim has been checked against the code.
- `page-shape.sh` has run.
  Each number outside the reference shape has a reason.
