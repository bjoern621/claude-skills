---
name: writing-style
description: Writing style for everything committed to a repository - code comments, YAML/TOML/config comments, docstrings, markdown docs, commit and PR bodies. Load before writing or editing any of these, however small the edit, in any repository. Use when writing or editing comments, documenting, editing manifests or configs that carry comments, writing a README or docs page, drafting a commit message, or the user says "fix comments", "rewrite comments", "too verbose", "clean up docs". Enforces clipped comments, wrapping at punctuation, one sentence per markdown line, time-agnostic docs.
---

# Writing style

Governs everything written into a repository: comments (`#`, `//`, `///`, docstrings), markdown docs, commit and PR bodies.
Chat replies are out of scope (caveman rules govern those).
Full ruleset with examples: [reference.md](reference.md).
Read it before the first comment or doc edit of a session.

## Comment checklist

Apply to every comment written or touched:

1. Keep only comments stating a constraint the code cannot show: unit, range, invariant, reason for an odd choice, caller obligation.
   Delete a comment that restates the code or repeats what is routine elsewhere in the repository.
2. Write clipped fragments: noun phrases, articles and copulas dropped.
   `// Negotiated codec. nil if transport carries no video.`
3. Show formats and ranges by example: `// Key: "rtsp/H264".`, `// ms, 1..60000.`
4. Keep the language's own convention (Go doc comments start with the identifier, JSDoc tags carry the facts) and clip inside it.
5. Second pass: re-read each comment and cut again.
   Shortest form that keeps every fact wins; cutting words is free, cutting facts is not.

## Line wrapping

Break lines at sentence ends, after `,` `:` `;`, or at a conjunction ("and", "or", "but", "so").
One sentence per markdown source line.
A continuation line continues its sentence.

## Docs

State the invariant, in present tense, third person.
Time-agnostic: a sentence that work elsewhere would falsify (counts, unpinned versions, status snapshots, "currently"/"soon") is an observation, not documentation.
Changelog voice ("used to", "not yet", "moved here") lives in commits and PRs alone.
Point at the source-of-truth file instead of copying its contents.
Cut every section, table, and diagram the reader can do without.

## Scope of application

A touched comment is rewritten to this style in the same change.
Untouched comments stay as they are; whole-file sweeps happen only on request.
Project style rules add to these; on conflict this skill wins.

## Completion criteria

- Every written or touched comment passes the checklist.
- `bash <skill-dir>/scripts/check-style.sh <touched files>` reports clean.
  ASCII-art hits on the em-dash check are the one accepted exception; judge those by eye.
