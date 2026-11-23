---
date: 2026-11-23
verdict: bad
source: README.md of search-plus-plus at commit 1d44645, 988 words without a picture
---

## Verdict
"the readme is way too long and to few images. more images more eye candy and catchy things. less (much) text"

## Text
The opening:

"Search++ searches the files of a VS Code workspace from its own view in the activity bar.
Typos and umlaut spellings match by default.
A dotted query also finds keys in YAML, JSON and TOML files and member chains in TypeScript and JavaScript."

Two of the nine bullets under "What it does", each describing a sight on screen in words:

"- Shows the results as a list of files or as a folder tree, with dimmed context lines around each match.
- Says in the context menu of a match why it matched, such as `Gröse: 1 letter off from Größe.`"

From the section "Query language", which held 11 bullets and 7 more lines of edge cases:

"- `apps/web` finds the folder `deploy-apps/web-dev`, since a query with a slash matches across the folders of a path.
  A match must end inside the last name of the path, which leaves out the files below `web-dev`.
  A matched name shows highlighted in its row.
  In the list, a folder with results below it takes no row of its own: the rows below it highlight its name."

The page went on with a table of nine settings, the files that every search includes and leaves out, six lines on Ctrl+Shift+F and a `keybindings.json` snippet.

## Patterns
- Text where a picture shows it: a VS Code extension with its own view and no picture. "Shows the results as a list of files or as a folder tree". Rule: docs.md "A README", each capability that shows on screen in a picture or a marked place for one. Cause: Held (both readers marked a hero shot under the opening and 7 or 11 more shots, one per capability).
- Length past the budget: 988 words against 800. Rule: docs.md "A README", under 800 words. Cause: Held (the readers cut to 736 and 617 words).
- Reference manual on the landing page: the query edge cases, the settings table and the Ctrl+Shift+F details. "A match must end inside the last name of the path". Rule: docs.md "A README", edge cases and full tables to reference pages. Cause: Held (both readers moved them to a query page and a settings page and kept three or four query examples).
- Opening on the place in place of the gain: "Search++ searches the files of a VS Code workspace from its own view in the activity bar." Rule: docs.md "A README", one line on what the reader sees or gets. Cause: Held (both readers pulled the typo and umlaut matching into the first line, ahead of the hero shot).

## Writer's version
Five commits wrote the page between 2026-11-20 and 2026-11-23 18:20.
They grew it from 744 to 988 words.
The session behind the last commit ran the plugin at 7e32e0b, whose README section listed a single picture in the shape.
Its length check let a page past 800 words stand once the page had a reason.
The rule on pictures, the budget and the reference pages arrived after the last commit, from the helm-values-lens case of the same day.
The repeat came from a session older than the rule.

## Rewrite
A sketch of the opening, with picture places marked:

```markdown
# Search++

Search your VS Code workspace and find what you meant, typos and umlaut spellings included.

![Screenshot needed: the Search++ view with a query, the line under the input and results grouped by file with dimmed context lines](docs/view.png)

## What it finds

![Screenshot needed: the query secret with a result on socket](docs/typos.png)
Words a letter or two off: `secret` finds `socket`.

![Screenshot needed: the query gateway.image.tag with its key path at the right edge of a YAML row](docs/key-path.png)
Keys by their path in YAML, JSON and TOML files: `gateway.image.tag` finds `tag` under `image` under `gateway`.

[QUERIES.md](QUERIES.md) lists every form of query.
```
