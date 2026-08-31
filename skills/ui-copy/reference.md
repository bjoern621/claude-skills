# UI copy reference

Full ruleset for user-facing interface text.
[SKILL.md](SKILL.md) carries the working checklist; this file settles the details and edge cases.
Grounded in the shared guidance of the Microsoft Writing Style Guide, Material Design writing, GOV.UK content design, Nielsen Norman Group research, and Podmajersky's "Strategic Writing for UX".

## Register

**Copy passes unnoticed.**
Interface text helps somebody to the thing they want and is forgotten on the way.
A sentence the reader stops to admire, or to decode, is rewritten.
- Bad: "That is a trade the publisher is entitled to make: it plays everywhere, and costs them."
- Good: "It plays everywhere, at the cost of viewer CPU."

**Plain conversational, not formal and not clipped.**
Full short sentences, everyday words, the tone of a competent colleague.
Formal register reads colder without reading more trustworthy; fragments read curt in help text.
Fragments stay legitimate where the surface is a fragment: chip captions, list notes, table cells.

**No opinions, no judgment, no humor.**
The copy states facts and trades; the reader decides.
Verdicts ("settings nobody asked for"), permissions ("entitled to make"), and jokes are cut.
Humor reads once; settings text is read hundreds of times.

## Person

**Neutral by default.**
The person reading is addressed directly or not at all, never described.
"The user", "the publisher", "the reader", "somebody" as a name for the person reading are banned.

**"you/your" only where ownership is otherwise ambiguous.**
- Good: "Everyone holding the key sees your streams; nobody else does."
- Bad: "You can pick a different capture method." (imperative does it: "Pick a different capture method.")

**Actions are imperatives.**
"Set a ceiling.", "Install it, or pick a capture method that uses GStreamer."

**No self-reference.**
Never "we", never "I".
Where scope needs naming, the concrete part beats "this app": "no built-in player opens RTMP", not "this app cannot open RTMP".

## Shape

**Aim 15 words per sentence, cap 25.**
Comprehension drops hard past 25 words.
A sentence with three clauses is two or three sentences.

**Lead with the fact that carries the decision.**
Front-load; detail follows for whoever reads on.
- Good: "Constant quality, variable bandwidth. The rate rises with motion and falls to almost nothing on a still screen."

**Punctuation stays simple.**
Periods and commas.
Colon only before a list or an example.
No semicolons, no em-dashes, no exclamation marks.

**Sentence case everywhere**: labels, buttons, headings, titles.
A fragment carries no trailing period; a full sentence does.

## Patterns per surface

**Error and refusal: problem, cause, fix.**
Specific over generic: exact names, exact figures, the user's own values.
The fix is named only where one exists; a refusal with no way out ends after the cause.
- Good: "FFmpeg is not installed, so its encoders cannot run. Install it, or pick a capture method that uses GStreamer."
- Good, no fix known: "GStreamer could not run libx264 on this computer."

**Disabled control: why, and what enables it.**
A grayed control is never a communication dead end.

**Option description: what it does, when to pick it.**
The observable effect beats the definition.
- Bad: "4:2:0 chroma subsampling retains one quarter of the color samples."
- Good: "Keeps a quarter of the color. Colored text and edges smear: the washed-out video-call look."

**Tooltip: 25 words at most.**
Supplemental only; anything the user must act on lives in the interface proper.
Never a restatement of the visible label.

**Empty state: what is so, then the next step.**
- Good: "Nothing saved yet. Name the configuration below to keep it."

**Layered depth.**
The first sentence carries the decision; mechanism follows only where the decision needs it.
Help text may teach; it may not lecture.

## Words

**American English**, one variant throughout, never mixed.

**One term per concept.**
A concept renamed per surface costs the reader a lookup each time.
The user's computer is "this computer".

**Personification stays standard.**
Verbs normal in technical writing stay: an encoder targets, holds, refuses; SRT retransmits; a relay serves.
Dramatic agency goes: nothing "spends whatever the picture costs" or "asks no more of a home router".

**Blame-free problem words.**
Not aimed at the user or their input: "error", "failed", "invalid", "illegal", "bad", "abort", "fatal".
Instead: "could not", "unable", "incorrect", "not supported", "stop".
- Bad: "Invalid stream name."
- Good: "The stream name cannot contain spaces."

**Politeness words are rare.**
"please" only when asking the user to wait or to redo work.
"sorry" only for serious loss (data loss, unusable state).
Facts and fixes carry the courtesy.

**Identifiers ride in parentheses.**
Plain words carry the sentence; the identifier appears where a log or command line would show it.
- Good: "Every viewer decodes it on the CPU (avdec_h264)."
Paired forms keep the mid-dot: "yuv420p · 4:2:0".

**Positive framing.**
Say what is so and what to do, not what is absent.
An absence is named only where the reader would try to restore it.
- Bad: "Nothing carries the pointer over the relay, so viewers see no pointer."
- Good: "The pointer shows only in the preview on this computer. Viewers see the picture without it."

**No changelog voice.**
The reader holds no earlier version of the product.
"no longer", "not yet", "new" are cut; the state is named instead.
This rule is shared with [writing-style](../writing-style/reference.md), which states it in full.

## Second pass

Every string is re-read before moving on, every time.
Ask, in order:
- Does it read like a colleague talking, or like an author writing? Rewrite the author out.
- Does the first sentence carry the decision? Reorder.
- Which words carry no fact? Cut them.
- Does any sentence pass 25 words? Split it.
- Shorter without losing a fact? Not finished.
