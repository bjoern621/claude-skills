# claude-skills

Claude Code plugin marketplace carrying personal skills.

## Plugins

`bjoern`: writing conventions.
Ships two skills and a per-turn reminder hook.

`writing-style`: style for comments, docs, and commit bodies.
Clipped comments, line breaks at punctuation, one sentence per markdown line, time-agnostic docs.
Full rules: [skills/writing-style/reference.md](skills/writing-style/reference.md).

`ui-copy`: style for user-facing interface text.
Plain conversational register, problem-cause-fix errors, positive framing, no opinions or humor.
Full rules: [skills/ui-copy/reference.md](skills/ui-copy/reference.md).

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
