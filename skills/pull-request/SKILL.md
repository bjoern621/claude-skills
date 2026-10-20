---
name: pull-request
description: Shape of a pull request, merge request or issue: title, description, issue link, picture. Load before opening or filing one or editing its title or description. Also load it when the user says "write the issue".
---

# Pull request

Decides what the title names, how long the description runs and which picture goes in.
Wording follows `writing-style`.
An issue follows [issues.md](issues.md).

The rules follow PRs that a student team wrote by hand for PeerDrop (github.com/bjoern621/PeerDrop, numbers below 250).
They read like a teammate's note to a reviewer who has the diff open beside it.
The description carries what the diff cannot show.

## 1. Language

Write in the language of the project's recent issue titles, PR titles and commit subjects.
Identifiers, commands and quoted UI strings keep their spelling.
PeerDrop writes German around English names: "Copy Button für eigenes Token hinzugefügt".

## 2. Title

One change in 3 to 8 words, shaped like the project's own titles:
- `wss:// in Production statt ws://`
- `Fix für vertauschte Delete-Icon-Farben`
- `Add /address-mr for merge request review rounds`

A title that needs "and" or a comma names two changes.
Split the branch or name the goal that both serve.

## 3. Description

The first line links the issue: `Closes #21` for one that the PR finishes, `Part of #262` for one that it touches.
An issue in another project takes its full reference: `Closes group/project#21`.
Then the smallest rung that carries the change:
1. The link alone, where title and issue say everything.
2. One to three sentences on what changes, as the user or the reviewer meets it.
3. One bullet per change, one line each, eight at most, where the change lands in several places.

Each of these follows where it applies, in one or two sentences:
- the reason for a choice that looks wrong, with a link when one explains it
- an open point and what unblocks it
- a teammate action, addressed to the teammate: "@HomeMichi Du kannst jetzt die Docker Compose ausführen."
- numbered manual-check steps, where the reviewer has to see the change run
- the Figma frame, mockup or issue comment that the change implements

File lists, the mechanism, build results and acceptance criteria stay in the diff, CI and the issue.
A description that fits one screen takes no headings.

## 4. Picture

The picture goes right under the sentence that it shows:

| Change | Picture |
|---|---|
| Visible UI result | Screenshot of the changed area |
| Visual fix or restyle | Before and after in a two-column table |
| Hover, animation, drag, a flow across screens | GIF |
| Flow, protocol or state change without UI | Mermaid `sequenceDiagram` or `stateDiagram-v2` |
| Console error or CLI output | Fenced code block |

Renames, CI, dependency and refactor work take no picture.
Capture and upload: [pictures.md](pictures.md).

## 5. Finished

- The title names one change in the project's language.
- The first body line links the issue where one exists.
- Every sentence answers something that the diff, CI and issue leave open.
- Every change matching a table row carries its picture.
  The report to the user names any missing one.
- `writing-style` has run over title and body.

## Example

```markdown
Closes #6

- Geräte senden regelmäßig Heartbeats an den Server
- Server leitet Heartbeats an aktive Clients weiter
- WebSocket wird nach dem Login neu aufgebaut

![Geräteliste mit Statuspunkten](https://github.com/user-attachments/assets/…)

@NovaCaller `NpgsqlDataSource` läuft jetzt als Singleton, neue Repositories bekommen sie per Konstruktor.
```
