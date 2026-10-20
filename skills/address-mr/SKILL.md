---
name: address-mr
description: One review round on a GitLab merge request. Reads every open thread, note and suggestion, triages each, fixes what holds up, commits, pushes to the source branch and replies on each thread.
argument-hint: <merge request URL | group/project!iid | iid>
disable-model-invocation: true
---

# Address merge request feedback

One round handles the feedback present at the snapshot in step 2 and ends at the report.
Feedback arriving later, the review that the push triggers included, waits for the next run.

Every forge call goes through `glab api --hostname <host>`, with `<project>` URL-encoded (`pidgemail%2Fci`).
List endpoints take `--paginate`.

## 1. Resolve the merge request

Parse `$ARGUMENTS`:
- URL `https://<host>/<group>/<project>/-/merge_requests/<iid>`: host, project and iid from the path.
- `<group>/<project>!<iid>`: project and iid from the argument, host from the `origin` remote of the working directory.
- A bare `<iid>`: host and project from that `origin` remote.

Without an `origin` remote, stop and ask for the merge request URL.

Fetch `projects/<project>/merge_requests/<iid>`.
Stop and say why when `state` differs from `opened` or `source_project_id` differs from `target_project_id` (a fork branch takes a push that this skill cannot make).
Keep `source_branch` and `diff_refs.head_sha`.
Fetch `user` and keep its `username`: replies go out under that account.

## 2. Snapshot the feedback

Fetch `projects/<project>/merge_requests/<iid>/discussions` once.
That response holds all the work for this run.

Turn it into items:
- Each unresolved thread yields one item per request in it: its first note carries `resolvable: true` and `resolved: false`.
  A diff thread carries `position` on the note (`new_path`, `new_line`, `old_line`).
- Each individual note (`individual_note: true`) asking for something yields one.
- A review note listing several findings (the `claude-review` job posts one) yields one per finding.
- A ```` ```suggestion ```` block belongs to its thread's item.

System notes (`system: true`), resolved threads, notes asking for nothing (approvals, thanks, status) and answered threads stay out.
A thread counts as answered when its last note comes from an earlier run: written by `username`, opening with a verdict as a code span (`` `fix` ``).
The user's own notes count as feedback.

Done when every discussion in the snapshot maps to items or has a reason to stay out.

## 3. Open a worktree on the source branch

Find the local clone whose `origin` points at the project: the working directory first, then the repositories under `~/git`, nested ones included.
With none found, clone `ssh_url_to_repo` from `projects/<project>` to `~/git/<path_with_namespace>` and name that in the report.

From that clone, `git fetch origin <source_branch>`, then work in `.claude/worktrees/<source_branch>` on a detached HEAD:
- `git worktree list --porcelain` lists the path: `git -C <path> status --porcelain` prints nothing and `git -C <path> cherry origin/<source_branch> HEAD` prints no `+` line, then `git -C <path> switch --detach origin/<source_branch>`.
  Anything printed stops the run with a report.
- A directory at the path that git does not list stops the run with a report.
- No directory: `git worktree prune`, then `git worktree add --detach .claude/worktrees/<source_branch> origin/<source_branch>`.

`HEAD` matching `diff_refs.head_sha` confirms the checkout.
A different head means the branch moved after the snapshot: continue on it and mention it.

## 4. Triage each item

Open the file at the lines that the item names on the current head (a diff position can be outdated), check the claim against the code and decide.
A bot finding and a maintainer's remark get the same check.

Each item gets one verdict and a one-line reason:
- `fix`: the claim holds on the current code and within this merge request's scope.
- `answer`: the item asks a question, answered from the code.
  Its thread stays open for the asker.
- `stale`: the current head already addresses it or removed the code that it names.
- `decline`: the claim does not hold, contradicts the merge request's purpose or the repository's conventions, asks for work outside this merge request or conflicts with another item.
  Its thread stays open for the author to decide.

A suggestion block gets applied verbatim where it holds and adapted where the idea holds.

Done when every item carries a verdict and a reason tied to a line of code or to the merge request's scope.

## 5. Fix, check, commit, push

Apply every `fix` item.
Run the checks that the repository defines for the touched code (Taskfile, `package.json` scripts, `flake.nix` checks, `.gitlab-ci.yml` jobs) and repair what the fixes broke.
A fix that cannot pass its checks becomes a `decline` carrying the failure, with its edits reverted.

Commit one self-contained change at a time, each item's fix in exactly one commit.
Stage files by name.
Commit messages follow `writing-style`.
Push with `git push origin HEAD:refs/heads/<source_branch>`.
A push rejected as non-fast-forward means the remote moved: `git fetch origin <source_branch>`, `git rebase origin/<source_branch>`, rerun the checks and push again.
A conflicting rebase gets aborted (`git rebase --abort`).
The round then stops before step 6 and reports.
Pushed history stays as it is: no force-push, no amending a pushed commit.

Done when the pushed head contains every `fix` item and `git status --porcelain` in the worktree prints nothing.

## 6. Reply on the threads

Reply in each item's discussion: `POST projects/<project>/merge_requests/<iid>/discussions/<discussion_id>/notes` with `body`.
A review note with several findings gets one reply: a first line counting verdicts (`` `fix` 2, `decline` 1 ``), then each finding with its verdict.

Each reply opens with its verdict as a code span and follows `writing-style`, one paragraph per line (the forge renders every line break):
- `fix`: what changed and the commit's short SHA.
- `answer`: the answer, pointing at file and line.
- `stale`: the commit or line that covers it.
- `decline`: the reason.

Resolve each discussion that is resolvable after the reply and whose items all carry `fix` or `stale`: `PUT .../discussions/<discussion_id>` with `resolved=true`.

Done when all three hold:
- every discussion holding an item carries exactly one reply from this run
- every discussion resolvable after the reply whose items all carry `fix` or `stale` reads resolved
- every discussion holding an `answer` or a `decline` stays open

## 7. Report

End with a list holding:
- each item's author, location, verdict and reason
- the commits pushed, with their SHAs
- the worktree path, which stays until the merge request merges
- the threads left open for the author
