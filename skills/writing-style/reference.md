# Writing style reference

Edge cases for the rules in [SKILL.md](SKILL.md), under each rule's name, plus the tells that no rule there names.

## Say what the thing does

The copula opens a paragraph more often than anywhere else, setting up a contrast.
Cutting the contrast and keeping the copula leaves "A finding is a claim.", which states nothing.
- Bad: "`StopSync` is a function that stops syncing." Good: "`StopSync` closes the watch. Closing a closed watch succeeds."
- Bad: "TokenIssuer serves as the boundary between login and session storage." Good: "TokenIssuer mints a session token once login succeeds."

## State the fact and stop

The alternative stays where something pointed the reader at it: a default that the tool ships with, a habit taught by the predecessor or the option recommended a sentence earlier.
It goes in a parenthesis, worded differently at each use on a page: "The resolver reads the lockfile (the manifest, up to 3.2)."
A plain negative about one subject stays: `// nil when the profile sets no timeout.`
An option that nobody proposed gets cut, rebuttal included: "A tempting approach would be", "You might think X, but", "To be clear".

## Cut a restriction that narrows nothing

- Bad: "Only after the lockfile is written does the install proceed." Good: "The install proceeds after the lockfile is written."
- Bad: "The only thing that matters for throughput is the batch size." Good: "Batch size sets throughput."
- Bad: "The accent carries the one filled button." Good: "One button per screen carries a fill."

An exclusivity that a reader has to honour becomes an invariant: "WriteManifest holds the sole write path to manifest.json."

## Keep `that` in a relative clause

To find the shape, read each noun followed directly by a determiner, a pronoun or a name.
Where the verb after the noun takes it as its object, `that` goes between them.
A clause ending on a preposition takes the same repair: "the address that the user consented to".
A verb with its object ("returns the matching messages") and a participle after its noun ("the events published on the bus") hold no clause.

## Describe what stands

A state that the running system passes through stays, in the past tense or with "no longer" and "not yet": "Disconnected", "expired", "hosts that are no longer reachable".
A version that a contract fixes stays: "requires Postgres 14 or newer".
An absence gets named where a reader would restore it: the missing thing looks required, was there before or matches its neighbours.
Elsewhere, naming an absence teaches a capability and then takes it away.
"There is no way to apply this without a restart." becomes "Applying restarts the service."

## Tells that no rule names

A voice tell (rule of three, transition openers, uniform rhythm) fires on a pattern across the page.
One instance of it passes.
- Rule of three: a list landing on three items for rhythm.
- Prompt echo: a heading whose first sentence restates it.
- A question answering itself: "Why does it restart? Because nothing reconfigures it."
- Elegant variation: one entity renamed across a page to avoid repeating a word.
- Bold label plus colon on each bullet.
- Title Case headings.
- Transition openers on consecutive paragraphs: "Additionally", "Furthermore", "Moreover".
- A closing recap or the same closer under each section.
- Chat leftovers: "Certainly! Here is", "I hope this helps", `oaicite`.
- A rule written as decree: "Red belongs to destruction and no other fill exists." becomes "Red marks a destructive action."
- A tool given a will: "The reconciler fixes itself" becomes "The reconciler rereads the settings on every pass."
- Uniform rhythm: every sentence in a passage the same length and shape.

A sentence that a cut left empty gets rewritten around a fact.
A dead sentence costs the reader more than the tell that it replaced.
