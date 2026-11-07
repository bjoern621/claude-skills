---
name: follow-up
description: Works the open items that a finished task left behind, handing each one unrelated to that task to a background subagent with a short brief. Load when the user asks for one or more things that an earlier reply in this session left open ("fix the red test", "do 2 and 3", "do all of them").
---

# Follow-up

An open item can be anything: a red check, an untested path, a draft waiting for review, a cleanup, a question.
It sits anywhere in an earlier reply: under a heading such as "Open" or "Next steps", in a bullet or in a sentence of the report.
The main thread keeps the context of the finished task.
Each item that context does not help with runs in a subagent that starts cold, from a brief alone.
The subagent gets a short, sharp goal.
Its file reads and test runs stay out of the main thread.

## 1. Take the picked items

The user's message names the items: one, several or all.
Only those get worked.
The rest stay open, untouched.
Where the message fits two readings ("fix the test" with two red tests open), ask which before anything starts.

Done when every picked item maps to one passage of the earlier reply.

## 2. Sort related from unrelated

An item counts as related when working it needs what this conversation alone holds:
- a decision taken in it that no file records
- a hunk still uncommitted
- a file the main thread is still editing
- a result the main thread produced and has to check, such as a CI step it wrote that has not run yet

Every other item counts as unrelated.
A failure that predates the task and a gap the task only noticed both count as unrelated.
An item with a part of each splits into two: "check is red" can hold an unrelated flaky test and the related first CI run of a step the task wrote.

Done when every picked item, or each part of a split one, carries one label.

## 3. Write one brief per unrelated item

The subagent reads the brief cold.
It owns finding the cause or the approach.
The brief hands it the main thread's picture and stops there.

The brief holds:
1. Goal: the item in one sentence, as an outcome ("TestEveryFormatCrossesThePreviewLeg passes on CI").
2. Done when: a condition the subagent can check, such as a test going green, a command printing an expected line or a file holding a section.
3. Picture: what the main thread saw, quoted exactly.
   Paths, commit hashes, test names, commands, URLs and the decisive error line.
   A guess goes in as a question marked as a guess ("Flaky? The run on 115f4ed6 failed the same way.").
4. Ruled out: what the main thread already checked, with the result.
5. Keep off: the files that the main thread or another subagent owns right now.
6. Ask back: when the work needs the user (a decision, access, hardware, a judgement on taste), the subagent ends its turn on a line starting `needs input:` with one question.
   Its work so far stays in place.
7. Report: the subagent ends on what changed, the commit hashes, what stays open and a closing `result:` line.

The repository's `CLAUDE.md` and memory reach the subagent on their own.
The brief carries only facts that neither of them holds.

Done when a stranger can start from each brief with no question about the task behind it.

## 4. Start the subagents

Send every `Agent` call in one message, each with `run_in_background: true`, so the items run in parallel.
Two items that point at one likely cause, such as two tests failing on the same CI runner, go into one brief.
Pick a `subagent_type` that fits the item where the session offers one, and `general-purpose` otherwise.
Worktree isolation follows the repository's rules.

The main thread then works the related items inline, staying out of the subagents' files.

## 5. Relay questions

A subagent ending on `needs input:` hands its question to the main thread.
Put the question to the user in full sentences, naming the item it belongs to.
Resume that same subagent with the user's answer through `SendMessage`, keeping its context.
A question goes to the user every time, even where the main thread holds a likely answer.

## 6. Report

Once every subagent has finished, relay each result in the main thread's own words: the item, what changed, the commit and what stays open.
A subagent's result stands as reported.
The main thread acts on it and leaves the subagent's work as delivered.
Items the user did not pick stay listed as open.
