# claude-skills

Serves personal Claude Code skills as a plugin marketplace.

## Plugins

`bjoern`: writing conventions, pull request shape and merge request review rounds.
Ships the skills below and a reminder hook that runs on each prompt and each file edit.

`writing-style`: style for comments, docs and commit bodies.
Rules: [skills/writing-style/SKILL.md](skills/writing-style/SKILL.md).
Docs pages and READMEs: [skills/writing-style/docs.md](skills/writing-style/docs.md).

`interface-text`: style for text on screen, with error, tooltip and empty-state patterns.
Rules: [skills/interface-text/SKILL.md](skills/interface-text/SKILL.md).

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
