# Voice

The author's own way of writing, drawn from the author's messages and the docs and specs that the author wrote.
Every text under this skill follows it next to [SKILL.md](SKILL.md).
On conflict, SKILL.md wins.

The examples restate the author's text with the spelling fixed, German originals translated.
Chat habits stay out of repository prose: lower case, typos, dropped apostrophes, caps and "!!!" for emphasis, "or so" and "etc." as tails, tag questions ("right?") and sentences switching between German and English.
A slash for "or" stays: "testing / reviewing".

## Claim first, reason after

The claim opens the sentence.
The reason follows it, after "because" where the reader cannot derive it.
The reason names a fact about the system or its reader: a constraint, a consequence, a cost.
- "Pidgemail and PeerDrop move to the VPS because they run in production and need more stability than the home server."
- "The `#` source references stay out of the catalog, since they change with every edit."
- "The old register page stays, because it follows what a user expects it to look like."

## Short

A description fits one line.
A doc stays short enough that people read it in their daily work.
A bullet carries one point, as a short noun phrase where it can.
The longer wording stays when the shorter one would drop a fact.

## Plain words for a reader outside the field

The reader may know nothing of the area.
A term from a tool's internals ("hunks", "connmark", "well") gets the plain word for what it means.
Each line answers one question: does the human reader need it?

## Names say what the thing does

A name states the role in the project's own words.
It runs longer where that makes it clearer: `worker` becomes `background mail sync worker`.
A provider's term stays out of a project name: Gmail's "archive" means nothing in Outlook.
A name matches its siblings: a new bot takes the naming pattern of the other bots.
A term that reads several ways gets pinned down: "per instance" names an environment, a server or a chart version.
The text says which.

## Concepts stay apart

Two concepts that a reader could merge get kept apart in every sentence.
- "Signing in to Pidgemail and linking a mail account stay independent."
- "Inbox works as a view like any other."
- "Sending files and sending text take two different interfaces."

## Invariants read flat

A rule that the system holds reads as a flat statement with "never", "always" or "only".
- "One mail belongs to one linked mailbox."
- "The committed hardware-configuration.nix holds the placeholder. A host never commits over it."
- "Argo CD stays on vmk3s, the master node."

A fact carries no "probably", "presumably" or "(not checked)".
An open problem gets named as open, in one plain sentence.

## Purpose and limit

A thing gets described by what it serves and where it stops.
- "The WireGuard VPN gives internet and LAN access from a region with restricted internet. It reaches none of the services."
- "An offline-access token lets a background app sign in while the user sits away from the PC."

## A page opens on its job

The first line names what the page does.
The content starts on the next line.
- "This document describes how to set up a local development environment."
- "This guide describes how you contribute."

## Terms get defined where they first appear

A term gets its meaning after "means that" at first use.
- "Blocking means that one block of a message or file goes out until the receiver confirms it."

An acronym gets spelled out once.
A synonym follows "also" in parentheses: "all peers (also nodes)".
"more precisely" narrows a broad term to the one meant: "distribution transparency (more precisely access transparency)".

## Operations read verb first

An operation or a component gets described from its verb, with no subject.
The description ends on what happens with missing or duplicate input.
- "Adds a vertex to the graph. Nothing happens if the vertex exists."
- "Returns the incident edges of a vertex. Nil if the vertex is not part of the graph."

A sibling gets described by how it differs: "Like getEdges(). In place of a list, it concatenates a formatted string."

## Guarantees name their scope

A guarantee names what it covers, then what it leaves untouched.
- "Blocking guarantees that the receiver keeps the current block apart from other blocks of the same message type. Messages of another type stay unaffected."

A condition gets both branches: "With the blockchain subsystem, the node serves these functions as well. Without it, the node ignores the requests."
A weakness names the failure, the quality that it costs and who stays unaffected: "Without the registry, new peers cannot join. Peers already connected stay unaffected."
A process names its start state, the step that it repeats and when it stops: "This repeats until every vertex is part of the edge sequence."

## A real case anchors a rule

An abstract rule gets one concrete case after "for example", or a restatement after "meaning".
- "This view works like any other. Meaning the server does little. Most logic sits in the client apps."

The case comes from reality: real providers, real mails, real edge cases.
A design gets tested against the case that breaks it, such as a text written for one pending file meeting two.
A reason can point at a product that the reader knows: "A Discord chat never gets summarised either."
An example uses named actors and the sizes that the format fixes: "Chunk 1 can end on the first two bytes of a four-byte code point. Chunk 2 starts with the other two."

## Behaviour from the user's side

Interface behaviour reads as the sequence that a user sees: trigger, state, result.
- "The first file needs accepting. Every file after it arrives without a prompt."
- "On hover the circle grows a little. On click it expands, then drags its end behind it."

An issue reports what works, what fails and what should happen.
- "The profile menu plays its show and hide animations. The add-mailbox dialog vanishes without its hide animation."

A status names its cause.
"Degraded" alone tells the reader nothing.
A likely cause may appear, marked as likely.

## Steps and figures

A setup step opens with the condition that calls for it, then the command, then the result that the reader sees.
- "Clone the repository, if not done yet:"

A default names where to change it.
An alternative names what it costs: "Services started without the debugger skip every breakpoint."
A figure gets one line on what it shows and one on how to read its notation: "'For all …' in the diagram stands for a loop."

## Register follows the page

A setup page and a contributing page address the reader as "you", in the imperative.
A design doc says "we" for a choice that the team made.
Every other page stays in the third person.

## Open problems and assumptions

An open problem names its workaround and the issue that tracks it: "An own domain avoids this problem (tracked in Task-91)."
Assumed values get declared once for the whole section: "Values are educated guesses unless stated otherwise."
A cited bound sits next to the place where the implementation misses it, with the reason and a pointer to a better one.

## What it does and why

A setting, a resource or a token created in config carries a description of what it does and why it exists.
A value taken from an outside source links that source next to the value.
A disabled feature gets one line on what it does and why the project turns it off.

## One wording across the project

An existing text that fits gets reused before a new one gets written.
One concept keeps one name in every file, page and interface.
