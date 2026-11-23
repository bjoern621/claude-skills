# Docs pages

Shape of a docs page, a wiki page, a README, an ADR, a report and a setup or contributing page, above the rules in [SKILL.md](SKILL.md).

## A page

- One question per page.
  The first line names what the page does: "This document describes how to set up a local development environment."
  The content starts on the next line.
  The first three lines answer the question.
  Every section serves it.
  A section answering another question moves to another page.
- One addressee, named in a line before writing.
  The page explains what the project owns.
  A tool that the project plugs into gets named and left to its own docs.
- A person reads the page.
  An instruction to an agent and a split of work between agents and people go to the files that an agent executes.
  A sentence on what a tool does stays.
- Register follows the page.
  A README, a setup page and a contributing page address the reader as "you", in the imperative.
  A design doc says "we" for a choice that the team made.
  Every other page stays in the third person.
  A step that the reader takes stands in the imperative on every page.
- Contract vocabulary.
  Routes, config keys, wire message names, config files that the reader edits and the parts named in plain words.
  Source files, functions, types and package paths stay out: the code answers those.
  A page about the code itself (an onboarding map, a package tour) says so in its title.
- A short page.
  People read it in their daily work.
  One screen per section.
- A heading names the rule at the level where it applies.
  The case that prompted it goes into the example.
- An anchor names a heading or a config key, which survive edits.

## Steps, snippets and figures

- A setup step opens with the condition that calls for it, then the command, then the result that the reader sees: "Clone the repository, if not done yet:"
- A default names where to change it.
  An alternative names what it costs: "Services started without the debugger skip every breakpoint."
- A snippet opens with its destination as a comment in its own language: `// eslint.config.js`.
- A diagram for a flow.
  Mermaid `sequenceDiagram` or `flowchart` comes first, two lines of consequence after it.
- A figure gets one line on what it shows and one on how to read its notation: "'For all …' in the diagram stands for a loop."
- A table for comparable data: three or more data points per row, or two variants of one thing with one row per property.
  A table of situations and results belongs on a reference page.

## Decisions, reports and requirements

- On a docs page, a decision takes one line.
  The reasoning behind it, the options that lost and every consequence after the first go to the ADR or the commit body.
- An ADR or a report names the options weighed, the one picked and the consequence that it brings: "Several approaches came up, among them an external DNS provider, IPv6 multicast and a local DNS server inside the ICC. The choice fell on the last. As a consequence, the network answers only inside the ICC."
- A report opens on its focus and closes with the next goals.
  It names where the work left the plan and why: "Unlike planned, implementation has not started, since another interim presentation took place."
- A quality goal pairs a stimulus with a measurable response: "An SPV node sends 100 requests to the network. No single full node handles more than 50% of them."
- Assumed values get declared once for the whole section: "Values are educated guesses unless stated otherwise."
- A cited bound sits next to the place where the implementation misses it, with the reason and a pointer to a better one.

## A README

Its reader decides whether to use the software and has never seen it.
A README stays under 800 words, since its reader skims.
Its pictures carry what shows on screen.
A product with a screen shows each capability in a screenshot, or a GIF for a hover, a jump or a fix being applied, with a one-line caption below each.
A writer without the running product marks each picture's place as an image link to the file that it needs, the shot described in its alt text: `![GIF needed: hover over a key, listing its layers](docs/hover.gif)`.
A capability with nothing to show on screen takes one line of text.
Edge cases, the full input list, the full tables of commands and settings and the algorithm go to reference pages, linked from the section that they deepen.
Contributor material goes on its own page, linked at the bottom.

Informing shape, for software whose value the reader already grants: name, one line on what it does, the hero picture, each capability as one checkable fact beside its picture, install, use, configuration, where it works, one line on internals, license.

Arguing shape, for software contradicting a default that the reader holds: name and what it does, the problem in the reader's own code, the incumbent's answer at its real cost in code, this answer to the same task in code, the cases that it fits, install and use, the next objection answered in code, license.
The two snippets hold everything identical but the answer.
Without a real default to argue against, the page takes the informing shape.
[eslint-plugin-exhaustive-deps-exclude](https://github.com/bjoern621/eslint-plugin-exhaustive-deps-exclude) runs the arguing shape end to end.
Its section order sets the model.
Its wording breaks these rules in places.

"What it does" names what the reader sees or gets, ahead of any input that the software reads.
The concept behind it waits until after the hero picture: "Later profiles override earlier ones." goes under the picture that shows the profiles.
A benefit reads as what happens: "zero-config" becomes "finds the bucket in the credentials that the cloud CLI already holds".
A check reads as the fact that its result tells the reader, in the words of its message on screen.
The intro names the kinds of input in one line, such as the tools whose files it reads.
"Where it works" names each of them in one line and links the reference page that lists their fields and variants.

Every capability line gets checked against the code before it ships.
Limits get stated as what works.
An unsupported case that the reader would assume works gets one line under "where it works".
The rest of the limits go to the reference page.
A section that the project has nothing for stays out.

## A changelog

An entry names what somebody taking the release notices: behaviour, a message, a supported version, a shipped file.
A test script, a CI step and a refactor leave the published artifact as it was and get no entry.
Notes that announce the software to readers who never saw it, such as those of a 1.0 release, open with the README's lines on what it does.

## Completion criteria

- The page's question fits one sentence.
- Every code span on the page holds contract vocabulary, a config file that the reader edits, a term that the page defines or a command that the reader runs.
  A page whose title names the code is exempt.
- Every decision on a docs page takes one line.
- Every capability claim has been checked against the code.
- A README names what the reader sees in one line, before the hero picture and before any input that the software reads.
- Each capability of a README that shows on screen carries a picture or a marked place for one.
- The page has been read once more by a subagent handed the skill and the draft alone.
  Each finding got accepted or refused with a reason.
- `bash <skill-dir>/scripts/page-shape.sh <page>` has run.
  It measures length, line density, implementation spans and, on a README, the lines before the first picture and the words per picture.
  A README number outside the reference shape moves text to a reference page.
  On another page, each such number has a reason.
