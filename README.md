# claude-skills

Claude Code plugin marketplace carrying personal skills.

## Plugins

`bjoern`: writing conventions.
Ships the `writing-style` skill (style for comments, docs, and commit bodies) and a per-turn reminder hook.
The skill enforces clipped comments, line breaks at punctuation, one sentence per markdown line, and time-agnostic docs.
Full rules: [skills/writing-style/reference.md](skills/writing-style/reference.md).

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
