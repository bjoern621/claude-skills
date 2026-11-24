---
date: 2026-11-24
verdict: bad
source: pidgemail/client packages/app/src/locales/en/messages.po, settings.account.deleteDialog, at commit df5140bf
---

## Verdict
On a screenshot of the dialog: "these dialogs look weird? is the text correct and are symbols / icons missing?"
The missing bullets came from a CSS fault.
The facts in the text held.

## Text
The title, which truncates in a narrow dialog:
"Delete the account {address}?"

Three list items, each a translation message of its own:
- "Its mailboxes, tags, views, rules and settings leave Pidgemail on every device."
- "The mail stays with each provider, untouched. Pidgemail gives up its access to every mailbox."
- "The sign-in page opens next. Confirm there to delete the sign-in as well."

Below them:
"A deleted account cannot be recovered."

## Patterns
- A pronoun whose referent sits outside its own string: "Its mailboxes" points at the account in the title. Rule: interface.md "Voice", the part that acts gets named. Cause: Held (both clean readers made Pidgemail the subject: "Pidgemail deletes everything that the account holds", "the account's tags").
- Two facts in one list item: "The mail stays with each provider, untouched. Pidgemail gives up its access to every mailbox." Rule: SKILL.md "Short", a bullet carries one point. Cause: Ambiguous, with a Conflict settled under step 6 (both clean readers kept two results in one item under one subject, "Pidgemail unlinks every mailbox and leaves its mail untouched", citing "One subject with two verbs stays one sentence". Both had the project's own "one fact per line" in the brief. After a first edit of "Short" alone, a reader still kept two sentences in one item, so interface.md took a line for the confirmation as well).
- One word in two senses within one sentence: "The sign-in page opens next. Confirm there to delete the sign-in as well." The page belongs to Keycloak, the second "sign-in" names the identity that it deletes. Rule: SKILL.md "Terms and names", a term that reads several ways gets pinned down and two concepts stay apart. Cause: Narrow (two of three readers kept both senses, one citing "One concept keeps one name" for the code's term "the sign-in". The rule's example names a term that reads several ways alone and no compound). "Terms and names" carries earlier misses in the flake-pin and feature-list cases, so its one-name rules moved to the head of the section.

Three readers ran.
The first read the worktree of the source fix and saw its split of the second item, so it counts for the third pattern alone (it wrote "To delete your sign-in as well, confirm on the page that opens next.").

## Rewrite
The source fix in pidgemail/client!995 (commit dc159d67) splits the second item and addresses the reader in the first:
- "Your mailboxes, tags, views, rules and settings leave Pidgemail on every device."
- "Your mail stays with each provider, untouched."
- "Pidgemail gives up its access to every mailbox."

The third item under the rule:
- "To delete your sign-in as well, confirm on the page that opens next."
