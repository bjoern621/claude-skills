---
name: writing-feedback
description: Turns the user's judgement of a text into a lasting edit of writing-style. Load when the user shows a text and judges it, asks whether it reads as AI-written, shows frustration with its wording or offers it as a sample of good writing, said outright or implied. The text may come from an agent, a person or another project.
---

# Writing feedback

Each report sharpens `writing-style`, until its rules and examples converge into one style.
A report holds a text, bad or good, and the user's verdict on it.
Who wrote the text plays no role: an agent's comment, a colleague's README and a paragraph pasted from elsewhere count the same.

Skills repository: `~/git/claude-skills` (`github.com/bjoern621/claude-skills`).
Its changes land on `main`, get pushed and get released without asking.

## 1. Name the patterns

Collect the text, the user's words about it and where it lives.
Load `writing-style` and read the text sentence by sentence against it.
Name each pattern as a shape that recurs beyond this text, with the phrase that shows it.
"Hangs a rejected option off the fact: 'never a branch'" names a pattern.
"Sounds stiff" names none.
A good sample yields the patterns that it gets right, in the same form.
Where no pattern holds up, ask the user which part grates.

Done when each pattern carries a name, a quote and a one-line fix.

## 2. Fix the text where it lives

Look for the text with `rg -F` on a distinctive phrase, in the working directory's repository and in the repositories that this session edited for the same work.
The search goes no further: no search across `~` or `/`.
- Found there: rewrite the whole comment block or paragraph under `writing-style` and commit it under that repository's rules.
- Found elsewhere, or in a project unrelated to the current work: leave it.
  The rewrite goes into the reply.
- A good sample stays as it stands.

## 3. Hand the skill work to the background

Steps 4 to 8 run in a background subagent, so the conversation goes on.
Its brief: the report verbatim, the patterns from step 1, where the text lives and the path of this file, whose steps 4 to 8 it follows.
A question from step 6 comes back as the subagent's result.
The main thread asks the user, then resumes the subagent with the answer through `SendMessage`.

## 4. Record the case

One file per report in `skills/writing-feedback/cases/`, named `<YYYY-MM-DD>-<slug>.md`:

```markdown
---
date: 2026-11-07
verdict: bad
source: screen-sharing flake.nix:4
---

## Verdict
<the user's words, quoted>

## Text
<verbatim, trimmed to the sentences that carry the patterns>

## Patterns
- <name>: "<quote>". Rule: <section in writing-style, or "none">. Cause: <row from step 5>.

## Rewrite
<the text under writing-style; a good sample leaves this out>
```

No page of `writing-style` links a case, so the cases cost a writing session nothing.

## 5. Find why the rules let it through

Look up each pattern in `writing-style`: `SKILL.md`, the page for the kind of text and `reference.md`.
Then pick the cause:

| Cause | Sign | Fix |
|---|---|---|
| Uncovered | No rule names the pattern | A rule in the section where it belongs, anchored by this case |
| Narrow | A rule aims at it, but its listed forms miss this one | Widen the rule to the shape behind its forms |
| Ambiguous | The rule reads two ways or lacks a case | Reword it, with this case as Bad and Good |
| Buried | The rule sits far from where a writer of this kind of text looks | Move it up, or into the page for that kind |
| Conflict | Another rule or example pulls the other way | Step 6 |
| Hard to see | The rule reads clearly, but a long page hides the shape from a reader | A pattern in `skills/writing-style/scripts/check-style.sh`, created on first need |
| Held | A fresh reader with the skill fixes the pattern unprompted | None: the rule stays as written, and the case stays as a regression check |

A covered pattern gets tested before it counts as a miss.
A fresh subagent gets the `writing-style` files and the case text alone, and rewrites the text.
A pattern that it fixes unprompted takes the cause Held, since the skill already carries it and the writer went without.
A pattern that it leaves in place counts as a miss, whoever wrote the text, and takes a cause from the other rows.
Count the misses in `cases/` per rule.
A rule with several misses moves up in its section or gets shorter.
A long section around it gets cut.
A good sample confirms rules and gives them anchors.

## 6. Settle a contradiction

Read the whole skill around a clash before calling it one: the section, its examples, its `reference.md` entry and the cases that cite it.
- One sentence pulls against a direction that the rest holds: that sentence carries the defect.
  Rewrite it to match.
- The skill holds both directions in earnest: ask the user.
  Quote both rules and the case, and recommend one.

Once settled, rewrite every section that held the losing direction, as a whole.
A point edit beside an untouched paragraph leaves the clash for the next reader.

## 7. Edit writing-style

A report edits `writing-style` only for a pattern that missed, or for a good sample that anchors a rule lacking one.
A report whose patterns all held goes to step 8 with its case alone.

Each edit rewrites the section that it touches as a whole.
The new point merges into existing sentences before it adds a line.
One rule lives in one place: `SKILL.md` for every text, the kind's page for that kind, `reference.md` for edge cases and tells.
A good sample becomes a Good line beside a rule that lacks an anchor.
Otherwise it stays in `cases/`.
The rules that the cases show missed most often lead their section.
`SKILL.md` must stay under 220 lines.
Past that, an addition merges or replaces another line.

Then a fresh subagent checks the edit.
It gets the `writing-style` files and the case texts alone, without patterns or rewrites.
A Bad and Good pair quoting a case gives that case away, so the pair takes a sentence of its own making.
It rewrites each bad case and judges each good one.
It covers the new case and every case naming a rule that the edit touched, or all cases while `cases/` holds fewer than 20.
A bad case left unfixed or a good one flagged sends the edit back for another pass.

## 8. Commit, push, release, update

In `~/git/claude-skills`:
1. Stage by name and commit the case and the edits as one commit.
   The body names the case and the cause, the way earlier commits in `git log` do.
2. `git push origin HEAD:main`.
   A commit holding a case alone stops here: the plugin behaves the same, so no release or update follows.
3. Release with `task release PART=<part> NOTES=<file> --yes`: `minor` for a new rule, page or skill, `patch` otherwise.
   The task picks the next tag from the tags on `origin` and creates the GitHub release on `main`.
   The notes follow the previous release (`task notes`): `## Added`, `## Changed` and `## Removed`, one bullet per rule change since the previous tag.
4. Update the local install:
   ```
   claude plugin marketplace update bjoern-skills
   claude plugin update bjoern@bjoern-skills -s user
   ```
   Each project scope of `bjoern@bjoern-skills` in `~/.claude/plugins/installed_plugins.json` takes the same update with `-s project`, run from its `projectPath`.
   A running session loads the new version after a restart.

The report names the patterns and their causes, the rules changed or that every pattern held, the source fix (path and commit) or why the text stayed, the release tag and URL, and the commit that the local install now holds.
