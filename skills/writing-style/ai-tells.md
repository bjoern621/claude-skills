# AI tells

Constructions marking text as machine-drafted, in the register this skill governs: code comments, Markdown pages, commit and PR bodies.
Each row names the construction, shows an example that fails and shows the same fact stated so it passes.
Every one of them is found by reading.
The fluent ones carry the risk: a tell survives a checklist by sounding finished.

The labelling copula, paired negation, restriction, em-dashes, quotation marks, hyphenation, changelog voice, marketing adjectives, plain register, rhetorical scaffolding, second person and closing recaps live in [reference.md](reference.md).

## Lexical

| Tell | Bad | Good |
|---|---|---|
| Inflated vocabulary: `delve`, `intricate`, `pivotal`, `underscore`, `testament`, `garner`, `myriad`, `paramount`, `tapestry`, `landscape`, `realm` | `The CI runner underscores the pivotal role of job retries.` | `The CI runner caps job retries at three attempts.` |
| Copula avoidance: `serves as`, `stands as`, `functions as`, `represents`, swapping the copula for a longer one | `TokenIssuer serves as the boundary between login and session storage.` | `TokenIssuer mints a session token once login succeeds.` |
| Jargon verb for a plain one: `leverage`, `utilize`, `facilitate`, `streamline`, `harness` | `// Utilizes a mutex to leverage exclusive access.` | `// Locks indexMu before touching the manifest.` |
| Register above developer speech: business or product wording where a plain verb exists (`bills`, `provisions`, `onboards`, `consumes`, `surfaces`, `is subject to`) | `Each review is billed to a Claude subscription.` | `Each review runs on a Claude subscription.` |
| Unnamed authority | `// Best practice suggests polling under 500 ms.` | `// Poll interval 500 ms. Above it, the health check misses two heartbeats.` |
| Vague relational preposition | `// Runs in connection with the lockfile check.` | `// Runs after ResolveLockfile confirms no version conflict.` |
| Intensifier carrying no fact: `very`, `truly`, `fundamentally`, `essentially`, `literally` | `// Fundamentally just a thin wrapper.` | `// Wraps the driver's connection pool. Adds no state.` |
| Fidelity emphasis the verb already carries: `verbatim`, `word-for-word`, `character-for-character`, `exactly as written`, `as-is` | `// Forwards the Authorization header verbatim.` | `// Forwards the Authorization header. Any rewrite breaks the signature.` |
| Significance noun: `cornerstone`, `testament`, `landmark` | `This refactor is a cornerstone of the editor's undo system.` | `This refactor moves undo-stack merging into the history table.` |
| `get` in the possession sense, standing in for the verb that happened: `gets you`, `you get`, `getting you` | `Registering the plugin yourself gets you the severity.` | `Registering the plugin yourself allows you to set the severity.` |
| Cost metaphor naming no number: `costs nothing`, `at no cost`, `costs the reader`, `a small price` | `Switching the upstream rule off costs nothing.` | `A rule set to off needs no plugin behind it.` |
| Restrictive emphasis on a case the sentence already names: `only`, `just`, `merely`, `simply`, `alone`, `purely`, `all it takes` | `// Only takes effect after a restart.` | `// Takes effect after a restart.` |

## Syntactic

| Tell | Bad | Good |
|---|---|---|
| Labelling copula, `X is a Y` renaming the subject instead of saying what it does, commonest as a paragraph opener | `A version is a tag on this project.` | `Tagging this project publishes a version.` |
| Stacked hedges | `// Could potentially leave the socket open in some cases.` | `// Socket stays open when Close runs before the write completes.` |
| Participial tack-on claiming a result the clause never established | `Fix null pointer in conflict resolver, improving stability and reliability.` | `Fix null pointer in conflict resolver when the remote reports no base revision.` |
| Rhetorical question answering itself | `Why does the worker pool restart on a config change? Because nothing reconfigures it live.` | `The worker pool restarts on a config change. Nothing reconfigures it live.` |
| Whether-list claiming coverage | `Whether the destination is one webhook or a hundred, fanout is the same.` | `Fanout is the same for one webhook and for a hundred.` |
| Rule of three, a list landing on three items for rhythm | `Refactor the query builder for clarity, maintainability, and performance.` | `Split the 400-line query builder into one function per clause type.` |
| Agentless passive hiding which component acts | `The version is read by the resolver and the value is derived from the lockfile.` | `The resolver reads the version from the lockfile.` |
| Stacked range manufacturing breadth | `Supports rows from a thousand to a billion, from one column to a thousand, everything from Postgres to MySQL.` | `Supports a thousand to a billion rows, one to a thousand columns, on Postgres, MySQL or SQLite.` |
| Parenthetical smuggling a scope qualifier | `// Retries the request (and in most cases this resolves it).` | `// Retries once. Resolves the timeout in most cases.` |
| Comma before `and` closing a list | `Split the query builder into resolver, fetcher, and linker.` | `Split the query builder into resolver, fetcher and linker.` |
| Two clauses glued with `, and` | `The cache keys on the digest, and a rebuild hits it.` | `The cache keys on the digest. A rebuild hits it.` |
| Consequence welded to a fact with `so`, `thus`, `hence`, `therefore`, `as such`, `which means`, `in turn` | `// Runs on a copy of the manifest, so the original stays unchanged.` | `// Runs on a copy of the manifest.` |
| Fronted `Only` with inversion, sequence staged as suspense | `Only after the lockfile is written does the install proceed.` | `The install proceeds after the lockfile is written.` |
| `The only X is Y`, weight standing in for the mechanism | `The only thing that matters for throughput is the batch size.` | `Batch size sets throughput.` |
| `the one X`, singularity claimed where a count states the fact | `The accent carries the one filled button the design system draws.` | `One button per screen carries a fill, in the accent colour.` |
| `not only X but also Y`, two facts staged as a climb | `The cache not only survives a reload but also shares entries across tabs.` | `The cache survives a reload and shares entries across tabs.` |
| Rejected option hung off a fact's tail with `rather than`, `instead of`, `as opposed to`, `X over Y` | `Each review runs on a Claude subscription rather than per token.` | `Each review runs on a Claude subscription.` |
| Option nobody proposed, raised so the text can reject it: `A tempting approach would be`, `One might be tempted to`, `You might think X, but` | `A tempting approach would be to rotate tokens on a cron, but that drops every session.` | `Tokens rotate in place every 24 hours.` |

## Structural

| Tell | Bad | Good |
|---|---|---|
| Prompt echo: first sentence restates its heading | `## What StopSync does` over `StopSync is a function that stops syncing.` | `## StopSync` over `Closes the watch. Already closed is success.` |
| Boilerplate section skeleton | `## Challenges and future outlook` | `## Known issues`, holding `The CI runner floors every retry at 30 s. The config file exposes no key for it.` |
| Parent heading holding only more headings | `## Architecture` straight into `### Overview` | `## Architecture` over `Three components: resolver, fetcher, linker.` |
| Bolded label plus colon turning a fact into a glossary entry | `- **Fast**: schedules in under 5 ms.` | `Schedules in under 5 ms, retries three times, reads one config file.` |
| Prose split into bullets, each one short clause | `- Hardware key check runs first.` `- Software OTP fallback runs on failure.` | `Auth tries the hardware key first and falls back to software OTP on failure.` |
| Count in a heading, chosen for the format | `## Five things to know about the connection pool` | `## Connection pool` |
| Title Case heading | `## Setting Up The Development Environment` | `## Setting up the development environment` |
| Transition openers on consecutive paragraphs: `Additionally`, `Furthermore`, `Moreover` | `Additionally, the job scheduler buffers three tasks. Furthermore, it drops the oldest.` | `The job scheduler buffers three tasks and drops the oldest on overflow.` |

## Rhetorical

| Tell | Bad | Good |
|---|---|---|
| Chat preamble or sign-off pasted in | `Certainly! Here is the commit message: Add lockfile hash check.` | `Add lockfile hash check before allowing an offline install.` |
| Citation artifact from a chat surface | `Fix parser crash on empty file oaicite:3 turn0search2.` | `Fix parser crash on empty file.` |
| Model disclaiming its own reach | `Without running the suite this cannot be confirmed.` | `Verified against Postgres 16 on the staging database.` |
| Text praising its own quality | `Refactored the builder to ensure clarity and provide a more complete solution.` | `Split the resolver into one function per version constraint.` |
| Data narrating itself | `The benchmark numbers speak for themselves.` | `Benchmark: 12 ms median, 40 ms p99, at 500 requests per second.` |
| Tool given a will or acting on itself | `The reconciler fixes itself when the settings file goes stale.` | `The reconciler rereads the settings file on every pass.` |
| Fact raised to decree: a thing pointed at an abstract (`belongs to destruction`), an abstract noun standing in for the case, an exclusivity restated once it has landed | `Red belongs to destruction and never carries a fill, and no other fill exists.` | `Red marks a destructive action. That button stays unfilled.` |
| Novelty inflation | `Introduces a novel retry strategy.` | `Retries with jittered backoff. A pool-wide reconnect spreads over 30 s.` |
| Depth framing, an ordinary fact announced as a hidden truth: `The real question is`, `At its core`, `What really matters`, `The heart of the matter` | `At its core, what really matters is whether the cache survives a restart.` | `A restart drops the cache.` |
| Objection answered where nobody raised it: `To be clear`, `This is not to say`, `Some might say X, but` | `Some might say the cache is redundant, but it saves a round trip.` | `The cache saves a round trip on every repeated lookup.` |
| Templated concession naming no size | `While the fallback path is simple, it remains a limitation worth watching.` | `The fallback path adds 200 ms and skips the cache. It runs only when the primary region is unreachable.` |

## What only a reader catches

No regex reaches these.
They are asked at the second pass.

**Elegant variation.** One entity renamed across a page to avoid repeating a word.
No single grep finds every mention.
Bad: "The client opens the socket. The peer sends a handshake. The consumer reads the reply."
Good: "The client opens the socket, sends a handshake and reads the reply."

**Uniform rhythm.** Every sentence in a passage running the same length and the same subject-verb-object shape.
Human prose mixes a short assertion with a longer qualified one.

**Causal cadence.** Every fact on a page arriving with its consequence attached by `so`, `thus` or `which means`.
A derivation the reader cannot make alone earns the connective.
The rest of the sentences carry it for rhythm.
A sentence opening on `So` or `Thus` repeats the tic with the halves split across a full stop.
Bad: "The cache keys on the digest, so a rebuild hits. The digest covers the lockfile, so a dependency bump misses."
Good: "The cache keys on the digest of the lockfile. A dependency bump misses it."

**Both-sidesism.** A design page listing what each option costs while leaving the taken one unnamed.
The page names the decision it was written to record.

**Over-determination.** A sentence stating the conclusion the code above it already showed.
Bad: `// This shows the design favours composition over inheritance.`
Good: no comment, or the constraint a reader cannot see: `// Composed rather than subclassed, so a mock swaps in without a fake base class.`

**Staccato.** Three or more one-line paragraphs under eight words, cutting for punch rather than because the content breaks there.

## The cure has its own tells

Cutting slop produces a second register that scans just as machine-made: bare fragments, amputated contrasts, sentences that survived the edit while losing their content.
`A finding is a claim.` and `Windows are reconciled.` are what a paired negation leaves behind when the negated half was carrying the sentence.

The pass runs against its own output.
Every sentence this style touched is re-read and asked whether it still states a fact a reader can use.
A sentence that lost its content is rewritten rather than kept short.
A dead sentence costs the reader more than the tell it replaced.

## False positives

Rules keeping the detectors honest.

**A quoted example is masked.** Text inside a code fence, an inline code span, or a `Bad:`/`Good:` line documents a construction.
The check for that construction skips it.

**A literal sense is exempt.** `leverage` in a finance context, `robust` as a measured property of an estimator, `seamless` describing a texture.

**A fidelity word holds where something else would change the value.** `Paste the key verbatim` beside a form that trims whitespace, `as-is` naming the mode a flag selects.

**A correction of fact is exempt.** `Use pnpm, not npm` and `Latency fell 40%, not 4%` carry the correction in the negated half.

**A live choice between two options is exempt.** "Deleted rather than shortened" and "checked rather than applied" each name which of two paths the reader takes.
The sentence empties once the second path goes.

**A restriction that narrows a real set is exempt.** Deleting `only` from `// Safe only on the render thread.` drops a caller obligation and "runs only when the primary region is unreachable" widens into a claim about every request.

**Frequency gates the voice tells.** Transition openers, staccato, rule of three and causal cadence fire on a pattern across a document.
One legitimate instance passes.

## Sources

- [Wikipedia:Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
- [Why Does ChatGPT "Delve" So Much?](https://arxiv.org/abs/2412.11385), COLING 2025, measuring the lexical spike
- [GPTZero on the rule of three](https://gptzero.me/news/the-rule-of-three/)
- [Pangram: spotting AI writing patterns](https://www.pangram.com/blog/comprehensive-guide-to-spotting-ai-writing-patterns)
- [Google developer documentation style guide, headings](https://developers.google.com/style/headings): sentence case, behind the Title Case row
- The `unslop` skill's reference corpus, for the technical-register translation and the detection machinery
