# claude-skills

Serves personal Claude Code skills as a plugin marketplace.

## Plugins

`bjoern`: writing conventions, pull request shape and merge request review rounds.
Ships the skills below and a reminder hook that runs on each prompt and each file edit.

`writing-style`: style for comments, docs, commit bodies and text on screen.
Rules: [skills/writing-style/SKILL.md](skills/writing-style/SKILL.md).
Docs pages, READMEs, ADRs, reports and changelogs: [skills/writing-style/docs.md](skills/writing-style/docs.md).
Comments, tests and messages: [skills/writing-style/comments.md](skills/writing-style/comments.md).
Text on screen: [skills/writing-style/interface.md](skills/writing-style/interface.md).

`pull-request`: shape of a pull request, merge request or issue.
One change per title, the issue link first, the shortest description that carries the change and a picture for every visible change.
Steps: [skills/pull-request/SKILL.md](skills/pull-request/SKILL.md).

`address-mr`: one review round on a GitLab merge request, invoked as `/address-mr <merge request>`.
Triages every open thread, note and suggestion, pushes the fixes that hold up and replies on each thread.
Declined threads stay open for the author.
Needs `glab` logged in to the merge request's host.
Steps: [skills/address-mr/SKILL.md](skills/address-mr/SKILL.md).

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
