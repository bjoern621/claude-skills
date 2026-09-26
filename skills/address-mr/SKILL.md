---
name: address-mr
description: One review round on a GitLab merge request. Reads every open thread, note and suggestion, triages each, fixes what holds up, commits, pushes to the source branch and replies on each thread.
argument-hint: <merge request URL | group/project!iid | iid>
disable-model-invocation: true
---

# Address merge request feedback

One round: the feedback present at the **snapshot** in step 2 gets handled, and the run ends at the report.
Feedback arriving later, the review the push triggers included, belongs to the next run.

Every call to the forge goes through `glab api --hostname <host>`, with `<project>` URL-encoded (`pidgemail%2Fci`).
List endpoints take `--paginate`.

## 1. Resolve the merge request

Parse `$ARGUMENTS`:
- URL `https://<host>/<group>/<project>/-/merge_requests/<iid>`: host, project and iid from the path.
- `<group>/<project>!<iid>` or a bare `<iid>`: host and project from the `origin` remote of the repository in the working directory.

Fetch `projects/<project>/merge_requests/<iid>`.
Stop and say why when its `state` differs from `opened`, or when `source_project_id` differs from `target_project_id` (a fork branch takes a push this skill cannot make).
Keep `source_branch`, `target_branch`, `diff_refs.head_sha` and `web_url`.
Fetch `user` and keep its `username`: replies go out under that account.

## 2. Snapshot the feedback

Fetch `projects/<project>/merge_requests/<iid>/discussions` once.
That response forms the snapshot; the run never fetches discussions again to find work.

Turn the snapshot into **items**:
- Each unresolved thread yields one item: its first note carries `resolvable: true` and `resolved: false`.
  Diff threads carry `position` on the note (`new_path`, `new_line`, `old_line`), general threads carry none.
- Each individual note (`individual_note: true`) asking for something yields one item.
- A review note listing several findings (the `claude-review` job posts one) yields one item per finding.
- A ```` ```suggestion ```` block inside a thread belongs to that thread's item.

Leave out system notes (`system: true`), resolved threads, notes that ask for nothing (approvals, thanks, status), and threads already answered: the last note is by `username` and follows a note by someone else.
Notes the user wrote count as feedback like any other.

Done when every discussion in the snapshot either maps to items or has a reason it stays out.

## 3. Check out the source branch

Find the local clone whose `origin` points at the project: the working directory first, then the repositories under `~/git`, nested ones included.
With none found, clone it to `~/git/<project>` and name that in the report.

Work in a worktree holding the source branch:
- A worktree already on `source_branch` (`git worktree list`): use it after `git pull --ff-only`.
- Otherwise `git fetch origin <source_branch>` and `git worktree add .claude/worktrees/<source_branch> <source_branch>`, the branch tracking `origin/<source_branch>`.

Local `HEAD` matching `diff_refs.head_sha` confirms the checkout.
A mismatch means commits reached the branch after the snapshot: continue on the newer head and mention it.

## 4. Triage each item

Triage takes a quick look, sized to the item: open the file at the lines it names on the current head (a diff position can be outdated), check the claim against the code, and decide.
Weigh every item on its merit, whoever wrote it; a bot finding and a maintainer's remark get the same check.

Each item gets one verdict and a one-line reason:
- **fix**: the claim holds on the current code and the change belongs in this merge request.
- **answer**: the item asks a question; the reply answers it from the code.
- **stale**: the current head already addresses it, or the code it names is gone.
- **decline**: the claim does not hold, the change contradicts the merge request's purpose or the repository's conventions, it asks for work outside this merge request, or two items ask for opposite changes.
  A declined item leaves the decision to the author, so its thread stays open.

A suggestion block gets the same check: applied verbatim where it holds, adapted where the idea holds and the text needs adjusting.

Done when every item carries a verdict and a reason tied to a line of code or to the merge request's scope.

## 5. Fix, check, commit, push

Apply every **fix** item.
Run the checks the repository defines for the touched code (Taskfile, `package.json` scripts, `flake.nix` checks, the jobs in `.gitlab-ci.yml`) and repair what the fixes broke.
A fix that cannot pass its checks turns into a **decline** carrying the failure as its reason, with its edits reverted.

Commit in coherent commits, one per self-contained change, each item's fix in exactly one commit.
Stage files by name; commit messages follow the `writing-style` skill.
Push with `git push origin <source_branch>`.
A rejected push means the remote moved: `git pull --rebase`, rerun the checks, push again.
The branch history stays as it is on the remote: no force-push, no amending pushed commits.

Done when the pushed head contains every **fix** item and `git status --porcelain` in the worktree reports nothing.

## 6. Reply on the threads

Reply to each item in its own discussion: `POST projects/<project>/merge_requests/<iid>/discussions/<discussion_id>/notes` with `body`.
An individual note item gets its reply the same way, under the discussion id carrying it.
A review note with several findings gets one reply listing each finding with its verdict.

Replies follow the `writing-style` skill, one paragraph per line (the forge renders every source line break):
- **fix**: what changed and the commit's short SHA.
- **answer**: the answer, pointing at file and line.
- **stale**: the commit or line that already covers it.
- **decline**: the reason, stated plainly.

Resolve the discussions of **fix**, **answer** and **stale** items: `PUT .../discussions/<discussion_id>` with `resolved=true`, for resolvable ones.
**decline** threads stay unresolved.

Done when every discussion holding an item carries exactly one reply from this run, and every **fix**, **answer** and **stale** discussion reads resolved.

## 7. Report

End with a list: each item's author, location, verdict and reason, the commits pushed with their SHAs, the worktree path, and the threads left open for the author.
