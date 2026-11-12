---
name: fullauto
description: Long autonomous run over a backlog. The main thread coordinates and stays reachable, background subagents do the work, and merge requests get opened and merged without asking inside the user's grant. Load when the user says "fullauto", "full auto", "full-auto", "autonomous mode", "work autonomously", "token maxing", "tokenmax", "go wild", "keep going without me" or "until MR <n>", or hands over tickets, a broken app or red pipelines to work through alone, even mid-session.
---

# Fullauto

The user hands over a backlog and steps away.
The main thread turns coordinator: it triages, hands each stream of work to a background subagent, relays questions and reports.
Every subagent works to merged, verified results.
Tokens buy certainty: the run reproduces, tests and reviews wherever a check exists.

Repository rules (`CLAUDE.md`, memory, the `writing-style` and `pull-request` skills) bind every agent of the run.
The grant widens what happens without asking.
It never lifts a repository rule.

## 1. Read the grant

Take from the user's message:
- scope: repositories, tickets, apps, devices
- what may happen without asking, such as "create and merge every MR"
- a ceiling, such as "up until MR 1000": no merge request opens once the project's next iid would pass it
- what stays a question, such as "ask me for prioritization"

Restate the grant in one line of the first reply.
An action that the grant does not name waits for a question: a force push, a production release, a deletion, a secret, money, a message to another person.
A grant holds for this session alone.

Done when the first reply names scope, the merge permission and the ceiling.

## 2. Triage the whole state

Before any feature work:
1. Fetch every checkout in scope.
2. List open issues and open merge requests with their pipeline and merge state.
3. List red pipelines on the default branch and on merge requests.
   Group the failed jobs by their decisive log line: ten red Renovate MRs often share one cause.
4. Check every device and service that the work needs, such as `adb devices` or a dev backend.

A device or account waiting on the user (USB debugging unauthorized, a sign-in, a token) goes to the user in the first reply, while the rest starts.

Done when a list holds the blockers, the faults and the tickets, each with its link.

## 3. Order the work

1. Blockers: a red default branch, a red shared job that stops every merge, a broken build.
2. Faults that the user named in the message.
3. Tickets, in the user's priority.

Without a priority from the user, propose an order in one message, with a reason per item.
Blockers start meanwhile.
A ticket waiting on something outside the run (an account, a signing key, a third party's permission) stays out of the order and gets listed as waiting.

Done when every item has a place or a stated reason for staying out.

## 4. Fan out

Each independent stream goes to one background subagent: `Agent` with `run_in_background: true`.
Independent streams start in one message.
The brief follows step 3 of the `follow-up` skill (goal, done when, picture, ruled out, keep off, ask back, report) and adds:
- the grant from step 1, word for word, with the ceiling
- the shared resources that this agent owns
- the merge request process of the repository, pointed at in `CLAUDE.md`
- the `writing-style` skill, loaded before the agent writes any text: commits, comments, merge request and issue bodies, changelog fragments, strings on screen
- the project docs that set its design goals, by path: guidelines, review rules, issue templates, the README and the docs and ADRs of the area that it touches

Before merging, the agent checks its diff and its texts against those docs and names them in its report.
A rule arriving mid-run goes to every running agent through `SendMessage`.
Each agent re-checks its unmerged work against it.

A shared resource takes one owner at a time.
A phone or emulator over ADB, a dev server port, a worktree, a branch, a component release and a migration number each count as one.
A second stream needing the same resource waits, or joins the owner's brief through `SendMessage`.
Two agents never edit the same files.
Each agent editing a repository works in a worktree of its own.

Keep a ledger in the scratchpad: agent name, stream, owned resources, state, merge request links.
Update it on every launch, notification and relay.

Done when every running stream has one agent, one owner per resource and a ledger line.

## 5. Stay reachable

The main thread answers the user within one turn, whatever runs.
- A command expected to run longer than a minute or two goes to the background.
  A build, a dependency fetch and a test suite count as long.
- A message from the user mid-turn gets answered first, then the turn continues.
- Never sleep or poll for an agent: its notification re-invokes the main thread.
- The main thread does no stream work of its own beyond a few lookups.
  Work of more than a handful of tool calls goes to an agent.

## 6. Drive each merge request to merged

Each coherent change gets a small merge request of its own.
A merge follows a green pipeline and every review thread resolved, by fix or by a reply naming the reason.
Bot review rounds repeat until the review reports no findings.

A pipeline gets one waiter: the agent that owns its merge request.
The waiter polls the pipeline status at most once a minute, one request per round.
It reads the jobs and review threads once, after the pipeline ends, and stops with its stream.
The forge serves the user and every CI job as well.
For example, seventeen loops polling merge requests every 20 seconds slowed a small GitLab's pages from milliseconds to seconds.

Never:
- merge a red pipeline
- skip a hook or a required job
- disable, skip or loosen a test to turn a pipeline green
- force-push without the grant naming it

A red job that the change did not cause goes to the blocker stream.
A flaky job gets one retry.
The same job failing twice gets investigated as a fault.
After a merge moves the default branch, the open merge requests rebase.
Before opening a merge request, check the ceiling.

## 7. Spend for certainty

The run trades tokens for verified results:
- reproduce a fault before fixing it, and again after
- run the real app on the real target, such as the phone, the browser or the desktop build
- read the full diff before every merge
- hand a non-trivial diff to a review subagent that gets the code and no conclusion
- check a subagent's claim against the forge or the code before reporting it as done

Spend on verification.
A second agent repeating a finished check buys nothing.

## 8. Ask for real decisions

A question goes to the user for:
- the priority between streams
- product behaviour that no ticket, doc or existing code settles
- credentials, accounts, keys and payments
- a physical action, such as a tap on the phone
- an action outside the grant
- a trade-off with a lasting cost, such as pinning versus tracking an upstream

Every other choice gets decided, with the reason written in the merge request.
Questions go out together, numbered, each readable on its own, the recommended answer first.
Work on the other streams continues while a question waits.
A subagent ending on `needs input:` gets its question relayed in full and its answer passed back through `SendMessage`, so it keeps its context.

## 9. Report

Report at each milestone: a blocker fixed, a merge request merged, an agent finished, a question pending.
One line per stream: state and link.
A failure gets stated with its decisive log line.

An agent's result enters a report only after its notification arrived.
Before that, the stream reads "running".

The run stops when the backlog is done, the ceiling is reached, the user says stop, or every remaining item waits on the user.
The closing report lists merged merge requests, issues filed and closed, open questions, remaining items and worktrees left on disk.

## Failure modes

| Failure                            | Counter                                                     |
| ---------------------------------- | ----------------------------------------------------------- |
| The main thread goes silent        | Long commands in the background, mid-turn messages first    |
| Two agents fight over one device   | One owner per resource, recorded in the ledger              |
| A red pipeline gets merged         | Merge on green alone. Red jobs go to the blocker stream     |
| A retry loop on a flaky job        | One retry, then an investigation                            |
| Scope creep                        | Each brief names one stream and its "done when"             |
| Too many questions                 | Decide what no rule leaves to the user, write the reason    |
| Too few questions                  | The list in step 8, asked together and early                |
| A spawned agent gets forgotten     | Ledger line per agent, updated on every notification        |
| A guessed result gets reported     | Results enter a report after the notification alone         |
| Text or design drifts from project | Briefs name `writing-style` and the design docs by path     |
