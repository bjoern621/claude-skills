# README shape

What a README carries, for whom, and in which order.
The sentence rules in [reference.md](reference.md) hold here, with the one exception named under "Register".
The page rules in [page-shape.md](page-shape.md) hold as well.

## Reader

A README is read by somebody deciding whether to use the software, who has never seen it.
Every line is written for that reader.
What a contributor needs lives on its own page, linked from the bottom.

Two different things stand between that reader and the decision.
Either the value is already granted and only the facts are missing, or the reader arrives holding a default that this software contradicts.
The second reader has to be argued with before install means anything, and that difference picks one of the two shapes.

## The informing shape

For software whose value the reader already grants.
The broadest fact comes first and the page narrows as it goes.
A reader who stops at any point knows what the thing is.

1. Name, and one to three lines stating what it does and where it runs.
2. Badges, and a picture or recording of it in use.
3. What it does: one checkable fact per line.
4. Install.
5. Use, in the order a task happens.
6. Configuration.
7. Where it works: platforms, versions, hosts.
8. One line on the internals, linking the pages that hold them.
9. License.

A section the project has nothing for is left out.
The numbering is a default reading order rather than a schema.
A project with a stated reason to move one section moves it, and the page still works.

## The arguing shape

For software that contradicts a default the reader arrives with.
A competitor to the standard library, a lint rule that disagrees with the framework's own, a workflow replacing the documented one.
Install and configuration answer a question this reader has not asked yet.
The argument comes first and it runs on code.

1. Name, and one to three lines stating what it does.
2. The problem, in the reader's own terms, with the code that produces it.
3. The incumbent's answer to that same problem, at its real cost, in code.
4. This software's answer to the same problem, at the same task, in code.
5. The cases where its answer is the right one, each with the reason it is right there.
6. Install, use, configuration, where it works.
7. The objection the reader raises next, answered in code.
8. License.

The comparison is the argument.
Steps 3 and 4 perform one task twice and hold everything else identical between them.
Annotating the incumbent's snippet keeps its cost where the reader is already looking.
[examples/exhaustive-deps-exclude-readme.md](examples/exhaustive-deps-exclude-readme.md) runs this shape end to end.

A default has to exist for this shape to be honest.
Arguing against nothing is a sales pitch, and that project wanted the informing shape.

## Register

A README addresses somebody deciding.
"you" and "your" are correct on this page, and the second-person ban in [reference.md](reference.md) does not reach it.
A reference page describes a system to somebody already committed to it, which is why that ban holds everywhere else.
The rest of the sentence rules apply unchanged, one sentence per source line included.

The arguing shape suspends no other rule.
An argument made of code and named costs has no use for "powerful" or "seamless", and reaching for either is the sign that the comparison is missing.

## Capabilities

A capability list is a contract.
Every line on it is checked against the code before it ships.
A claim the software does not honour is the one defect a reader cannot recover from, and it outweighs every style rule on this page.

A section named "Limits", "Caveats" or "Known issues" fronts what fails.
The same facts state what works: the hosts that receive, the size a transfer handles in seconds, the setting that keeps typed lines out of history.
An unsupported case is named only where the reader was about to assume it works.

## Mechanism

How it works is an explanation, and the deciding reader needs one sentence of it plus a link to the page holding the rest.
A project with no such page lets the examples its shape already calls for carry the mechanism, and adds no section walking through it.

## Prose over a table of cases

A table of situations and results is a state machine, and a state machine is reference material.
The main path gets a paragraph in the order the task happens, and each edge case gets a sentence after it.
When a table does earn its place is stated in [page-shape.md](page-shape.md).

## Measured

`scripts/page-shape.sh` reports the numbers.
Install and configuration snippets carry a README's word count past the reference shape, and the arguing shape's paired snippets carry it further.
Both overshoots are expected, and neither is answered by cutting the snippets.

## Sources

- [Make a README](https://www.makeareadme.com/): the sections a README carries and their order, with a template.
- [Awesome README](https://github.com/matiassingers/awesome-readme): READMEs to measure a draft against, plus articles and tools.
- [GitHub, about READMEs](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes): what GitHub renders where, and how relative links resolve.
- [Diátaxis](https://diataxis.fr/): the four needs a page serves, which puts mechanism on an explanation page.
