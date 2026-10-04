# claude-skills

Claude Code plugin marketplace carrying personal skills.

## Plugins

`bjoern`: writing conventions and merge request review rounds.
Ships four skills and a per-turn reminder hook.

`writing-style`: style for comments, docs and commit bodies.
Clipped comments, line breaks at punctuation, one sentence per markdown line, time-agnostic docs.
Full rules: [skills/writing-style/reference.md](skills/writing-style/reference.md).
Revision passes and the sweep list: [skills/writing-style/revision.md](skills/writing-style/revision.md).
Page shape and README shape: [skills/writing-style/page-shape.md](skills/writing-style/page-shape.md), [skills/writing-style/readme.md](skills/writing-style/readme.md).

`interface-text`: style for user-facing interface text.
Plain conversational register, problem-cause-fix errors, positive framing, no opinions or humor.
Full rules: [skills/interface-text/reference.md](skills/interface-text/reference.md).

`pull-request`: shape of a pull request, merge request or issue.
One change per title, the issue link first, the shortest description that carries the change and a picture for every visible change.
Steps: [skills/pull-request/SKILL.md](skills/pull-request/SKILL.md).
Issues: [skills/pull-request/issues.md](skills/pull-request/issues.md).

`address-mr`: one review round on a GitLab merge request, invoked as `/address-mr <merge request>`.
Triages every open thread, note and suggestion, pushes the fixes that hold up to the source branch and replies on each thread.
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
