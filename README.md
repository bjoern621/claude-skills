# claude-skills

Serves personal Claude Code skills as a plugin marketplace.

## Plugins

`bjoern`: writing conventions and their upkeep from feedback, pull request shape, merge request review rounds, follow-up work and autonomous runs.
Ships the skills below and a reminder hook that runs on each prompt and each file edit.
A second hook holds each distinct `git commit` once per session, until the message has been checked against its sources.

`writing-style`: style for comments, docs, commit bodies and text on screen.
Rules: [skills/writing-style/SKILL.md](skills/writing-style/SKILL.md).
Docs pages, READMEs, ADRs, reports and changelogs: [skills/writing-style/docs.md](skills/writing-style/docs.md).
Comments, tests and messages: [skills/writing-style/comments.md](skills/writing-style/comments.md).
Text on screen: [skills/writing-style/interface.md](skills/writing-style/interface.md).

`writing-feedback`: turns the user's judgement of a text, bad or good, into an edit of `writing-style`.
Fixes the text where it lives in the current work, records the case and releases the plugin.
Steps: [skills/writing-feedback/SKILL.md](skills/writing-feedback/SKILL.md).
Cases: [skills/writing-feedback/cases/](skills/writing-feedback/cases/).

`pull-request`: shape of a pull request, merge request or issue.
One change per title, the issue link first, the shortest description that carries the change and a picture for every visible change.
Steps: [skills/pull-request/SKILL.md](skills/pull-request/SKILL.md).

`address-mr`: one review round on a GitLab merge request, invoked as `/address-mr <merge request>`.
Triages every open thread, note and suggestion, pushes the fixes that hold up and replies on each thread.
Declined threads stay open for the author.
Needs `glab` logged in to the merge request's host.
Steps: [skills/address-mr/SKILL.md](skills/address-mr/SKILL.md).

`follow-up`: works the items that a finished task left open, once the user picks some or all of them.
Keeps the items that need the task's context in the main thread.
Hands each other item to a background subagent with a short brief and relays its questions to the user.
Steps: [skills/follow-up/SKILL.md](skills/follow-up/SKILL.md).

`fullauto`: a long autonomous run over a backlog, started by saying "fullauto".
The main thread coordinates, stays reachable and reports, while background subagents fix blockers and work tickets to merged merge requests inside the user's grant.
Steps: [skills/fullauto/SKILL.md](skills/fullauto/SKILL.md).

## Use in a repository

`.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "bjoern-skills": {
      "source": {
        "source": "github",
        "repo": "bjoern621/claude-skills"
      }
    }
  },
  "enabledPlugins": {
    "bjoern@bjoern-skills": true
  }
}
```
