---
date: 2026-11-07
verdict: bad
source: screen-sharing flake.nix:4
---

## Verdict
"is this written by ai or not? what would writing skill do?"

## Text
```nix
# A revision on both inputs and never a branch,
# so which package set a checkout builds against is this file's property
# rather than the day someone last ran `nix flake update`.
# A branch ref moves ffmpeg and GStreamer under the tree with no commit saying so,
# and those two are what every codec verdict in backend/internal/capabilities is measured against.
#
# The revision tracks nixos-unstable:
# a release channel trails GStreamer by a minor series, and the plugin set is the thing under test.
#
# Updating is an edit, not a command.
```

## Patterns
- Fragment running on into a clause, holding the claim back: "A revision on both inputs and never a branch, so". Rule: comments.md "Form", clipped fragments. Cause: Ambiguous (fragments allowed, their end unstated).
- Rejected option hung off the fact: "never a branch", "rather than the day someone last ran". Rule: "State the fact and stop". Cause: Hard to see.
- Possessive copula: "is this file's property". Rule: "Say what the thing does". Cause: Narrow (listed forms stop at `is a`, `is the`).
- Cleft copula: "those two are what every codec verdict is measured against". Rule: "Say what the thing does". Cause: Narrow.
- Second subject after `, and`: "with no commit saying so, and those two are". Rule: "One independent clause per sentence". Cause: Hard to see.
- Relabel: "the plugin set is the thing under test". Rule: "Say what the thing does". Cause: Hard to see.
- Paired negation: "an edit, not a command". Rule: "State the fact and stop". Cause: Ambiguous (the reader arrives holding `nix flake update`, and the rule left open whether that alternative stays inline or goes in a parenthesis).
- False claim: "with no commit saying so". `flake.lock` sits in the repository, so a lock bump records the move. Rule: "Facts and scope". Cause: Hard to see.
- Two-way verb: "The revision tracks nixos-unstable", while a pinned revision tracks nothing. Rule: "Terms and names". Cause: Hard to see.

## Open
docs/packaging.md ("Version pinning") states most of these facts too.
No rule says whether a comment at the pin repeats them or points at the page alone.

## Rewrite
```nix
# Both inputs pin a revision.
# A checkout then builds against the package set that this file names.
# A branch ref would let `nix flake update` move ffmpeg and GStreamer in a lock bump naming neither.
# Every codec verdict in backend/internal/capabilities gets measured against those two.
#
# The revision comes from nixos-unstable, since a release channel trails GStreamer by a minor series.
#
# An update edits the revision here (`nix flake update` leaves it unchanged).
# docs/packaging.md ("Version pinning") states the procedure and what to re-measure.
```
