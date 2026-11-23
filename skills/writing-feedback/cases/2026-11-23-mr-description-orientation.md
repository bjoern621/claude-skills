---
date: 2026-11-23
verdict: bad
source: description of pidgemail/client !913, before and after the rewrite that the user asked for
---

## Verdict
On the first text: "idont understand what does this MR do? rewrite the dersciption??"
On the rewrite: "this text after i told you to change it IS WAAAAAAAAAY BETTER!! [...] make sure that all (open and future) MRs are the same quality. (note i dont mean the structure but the clearness in reading"

## Text
Title: "Sweep the cases that !889 to !892 held back"

- The count of people and messages under a thread's subject selects with a triple click, as do the merchant and the order number at the top of an order.
- Screen reader names built from catalog parts (a message, an attachment, the file stack, the drawer's Open and Fold, `Button` with `appliesTo`) each come from one entry with ICU arguments. English reads the same: a Playwright run printed identical labels before and after.
- `thread.attachment.place` gives way to a plural inside `thread.attachment.item`.

The selectable Text sits inside `TagNote`, since `ThreadTags.tsx` changes in !905. Once !905 lands, `TagNote` can take a `selectable` prop of its own.

(!889 to !892 had merged. !905 had closed without merging.)

## Patterns
- No orientation line: the body opens straight on a detail ("The count of people and messages ..."), with nothing on what the MR does as a whole. Rule: pull-request SKILL.md §3 names the rungs and leaves the opening open. Cause: Uncovered (one reader opened on the sweep's history, the other on the first bullet).
- Title names the work that produced the change: "Sweep the cases that !889 to !892 held back". Rule: pull-request SKILL.md §2, "name the goal that both serve". Cause: Ambiguous (both readers cited that sentence and named the origin: "Fix bug sweep cases freed by !889 to !892", "Bug-sweep fixes that waited for !889 to !892").
- Effect, places and trigger packed into one sentence, with the gesture as its subject: "The count ... selects with a triple click, as do the merchant ...". Rule: SKILL.md "Behaviour", trigger, state, result. Cause: Narrow (both readers opened on "A triple click selects", as the sequence rule pushes them to. Neither said what the person gains: select and copy).
- Mechanism without the problem that it ends: "each come from one entry with ICU arguments". Rule: SKILL.md "Behaviour", a fix names the behaviour that it ends. Cause: Narrow (the rule's form fits a one-line fix. One reader gave the fix before the problem, the other the fix before the gain).
- Abstract noun phrase for a line on screen: "The count of people and messages". Rule: SKILL.md "A real case anchors a rule". Cause: Held (both readers quoted "3 people, 5 messages").
- Internal terms unglossed: "ICU arguments", "catalog parts", "gives way to a plural inside". Rule: SKILL.md "Plain words for a reader outside the field". Cause: Held (both wrote "placeholders" with an example entry).
- A referenced MR left in a stale state: "Once !905 lands" after !905 closed. Rule: SKILL.md "Facts and scope". Cause: Held (both stated that !905 closed without merging).
- No anchor in behaviour the reader knows. The rewrite has "as it does in a mail". Rule: SKILL.md "A real case anchors a rule", a product that the reader knows. Cause: untested (the facts handed to the readers lacked the comparison).

## Conflict
A fresh checker flagged the approved text under pull-request §3: paragraphs of 4 and 7 sentences, the mechanism and the places that the change reaches.
The user settled it on 2026-11-23 with "Paragraph when needed".
A change that reads in one line keeps rung 2 or 3.
A change that a reader cannot follow in one line takes a short paragraph: what the person gains, the problem, the fix and one example.

## Rewrite
The user-approved description on !913, title included:

Title: "Let thread and order headers be copied, and translate screen reader labels whole"

This MR fixes two bugs that the sweep after !889 to !892 found. The fixes waited until those MRs merged.

You can select and copy more of a thread's and an order's header. Under a thread's subject, the line such as "3 people, 5 messages" selects. At the top of an order, the merchant and the order number select. A triple click selects the whole line, as it does in a mail.

Screen reader labels can now be translated as whole sentences. The code used to glue some labels together from catalog parts, such as "Open" + ", " + "agenda.pdf, Jonas, 5 Oct 2026". A translation could not reorder those parts. Each label now comes from one catalog entry with placeholders, such as `thread.attachment.openItem` ("Open, {item}"). That covers a `Button` with `appliesTo` and the labels of a message, an attachment, the file stack and the drawer's Open and Fold. A Playwright run printed the same English labels before and after. `thread.attachment.item` takes over `thread.attachment.place` as a plural.
