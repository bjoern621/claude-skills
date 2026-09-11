# README shape

What a README carries, for whom, and in which order.
The sentence rules in [reference.md](reference.md) and the page rules in [page-shape.md](page-shape.md) hold here as well.

## Reader

A README is read by somebody deciding whether to use the software, who has never seen it.
Every line is written for that reader.
What a contributor needs lives on its own page, linked from the bottom.

## Order

The broadest fact comes first and the page narrows as it goes, so a reader who stops at any point knows what the thing is.

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

## Capabilities

A section named "Limits", "Caveats" or "Known issues" fronts what fails.
The same facts state what works: the hosts that receive, the size a transfer handles in seconds, the setting that keeps typed lines out of history.
An unsupported case is named only where the reader was about to assume it works.

## Mechanism stays on its own page

How it works is an explanation, and the deciding reader needs one sentence of it plus a link.
A section walking through a protocol, a round trip or the phases of a transfer belongs on a page whose subject that is.

## Prose over a table of cases

A table of situations and results is a state machine, and a state machine is reference material.
The main path gets a paragraph in the order the task happens, and each edge case gets a sentence after it.
When a table does earn its place is stated in [page-shape.md](page-shape.md).

## Measured

`scripts/page-shape.sh` reports the numbers.
Install and configuration snippets push a README's word count over the reference shape, and that is the reason to name.

## Sources

- [Make a README](https://www.makeareadme.com/): the sections a README carries and their order, with a template.
- [Awesome README](https://github.com/matiassingers/awesome-readme): READMEs to measure a draft against, plus articles and tools.
- [GitHub, about READMEs](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes): what GitHub renders where, and how relative links resolve.
- [Diátaxis](https://diataxis.fr/): the four needs a page serves, which puts mechanism on an explanation page.
