# AI tells

Constructions marking text as machine-drafted, in the register this repository writes: code comments, Markdown pages, commit and PR bodies.
Each row names the construction, shows an example that fails, and shows the same fact stated so it passes.
The mechanical ones are detected by `scripts/check-style.sh`; the rest need a reader.

Paired negation, em-dashes, changelog voice, marketing adjectives, rhetorical scaffolding, second person and closing recaps live in [reference.md](reference.md).

## Lexical

| Tell | Bad | Good |
|---|---|---|
| Inflated vocabulary: `delve`, `intricate`, `pivotal`, `underscore`, `testament`, `garner`, `myriad`, `paramount`, `tapestry`, `landscape`, `realm` | `The retry queue underscores the pivotal role of backpressure.` | `The retry queue caps backpressure at three retries.` |
| Copula avoidance: `serves as`, `stands as`, `functions as`, `represents` | `Publisher serves as the boundary between capture and encode.` | `Publisher is the boundary between capture and encode.` |
| Jargon verb for a plain one: `leverage`, `utilize`, `facilitate`, `streamline`, `harness` | `// Utilizes a mutex to leverage exclusive access.` | `// Locks settingsMu before touching the file.` |
| Unnamed authority | `// Best practice suggests polling under 500 ms.` | `// Poll interval 500 ms. Above it, jitter exceeds one frame.` |
| Vague relational preposition | `// Runs in connection with the cursor-mode check.` | `// Runs after PickCursorMode confirms Embedded support.` |
| Intensifier carrying no fact: `very`, `truly`, `fundamentally`, `essentially`, `literally` | `// Fundamentally just a thin wrapper.` | `// Wraps the codec table. Adds no state.` |
| Significance noun: `cornerstone`, `testament`, `landmark` | `This refactor is a cornerstone of the transport layer.` | `This refactor moves codec negotiation into the transport table.` |

## Syntactic

| Tell | Bad | Good |
|---|---|---|
| Stacked hedges | `// Could potentially leave the socket open in some cases.` | `// Socket stays open when Close runs before the write completes.` |
| Participial tack-on claiming a result the clause never established | `Fix null pointer in cursor handler, improving stability and reliability.` | `Fix null pointer in cursor handler when the portal reports no default cursor.` |
| Rhetorical question answering itself | `Why does the encoder restart on a settings change? Because nothing reconfigures it live.` | `The encoder restarts on a settings change. Nothing reconfigures it live.` |
| Whether-list claiming coverage | `Whether the destination is one viewer or a hundred, fanout is the same.` | `Fanout is the same for one viewer and for a hundred.` |
| Rule of three, a list landing on three items for rhythm | `Refactor the pipeline builder for clarity, maintainability, and performance.` | `Split the 400-line pipeline builder into one function per codec.` |
| Agentless passive hiding which component acts | `The setting is read by the render pass and the value is derived from the model.` | `The render pass reads the setting from the model.` |
| Stacked range manufacturing breadth | `Supports resolutions from 480p to 4K, from 30 to 120 fps, everything from H.264 to AV1.` | `Supports 480p to 4K at 30 to 120 fps, in H.264, HEVC or AV1.` |
| Parenthetical smuggling a scope qualifier | `// Retries the request (and in most cases this resolves it).` | `// Retries once. Resolves the timeout in most cases.` |

## Structural

| Tell | Bad | Good |
|---|---|---|
| Prompt echo: first sentence restates its heading | `## What StopReceive does` over `StopReceive is a function that stops receiving.` | `## StopReceive` over `Closes decode. Already closed is success.` |
| Boilerplate section skeleton | `## Challenges and future outlook` | `## Known issues`, holding `SRT floors every hop at 120 ms, and MediaMTX exposes no key for it.` |
| Parent heading holding only more headings | `## Architecture` straight into `### Overview` | `## Architecture` over `Three components: capture, encode, relay.` |
| Bolded label plus colon turning a fact into a glossary entry | `- **Fast**: encodes in under 5 ms.` | `Encodes in under 5 ms, retries three times, reads one config file.` |
| Prose split into bullets, each one short clause | `- Hardware init runs first.` `- Software fallback runs on failure.` | `Encoder tries hardware first and falls back to software on init failure.` |
| Count in a heading, chosen for the format | `## Five things to know about the transport table` | `## Transport table` |
| Title Case heading | `## Setting Up The Development Environment` | `## Setting up the development environment` |
| Transition openers on consecutive paragraphs: `Additionally`, `Furthermore`, `Moreover` | `Additionally, the relay buffers three segments. Furthermore, it drops the oldest.` | `The relay buffers three segments and drops the oldest on overflow.` |

## Rhetorical

| Tell | Bad | Good |
|---|---|---|
| Chat preamble or sign-off pasted in | `Certainly! Here is the commit message: Add portal capability check.` | `Add portal capability check before enabling embedded cursor mode.` |
| Citation artifact from a chat surface | `Fix decode crash on empty stream oaicite:3 turn0search2.` | `Fix decode crash on empty stream.` |
| Model disclaiming its own reach | `Without running the suite this cannot be confirmed.` | `Verified against MediaMTX 1.9 on the dev relay.` |
| Text praising its own quality | `Refactored the builder to ensure clarity and provide a more complete solution.` | `Split the builder into one function per codec.` |
| Data narrating itself | `The benchmark numbers speak for themselves.` | `Benchmark: 12 ms median, 40 ms p99, at 500 requests per second.` |
| Tool given a will or acting on itself | `The reconciler fixes itself when the settings file goes stale.` | `The reconciler rereads the settings file on every pass.` |
| Novelty inflation | `Introduces a novel retry strategy.` | `Retries with jittered backoff, so a relay reconnect avoids a thundering herd.` |
| Templated concession naming no size | `While the fallback path is simple, it remains a limitation worth watching.` | `The fallback path adds 200 ms and drops audio, so it runs only when the relay is unreachable.` |

## What only a reader catches

No regex reaches these, so they are asked at the second pass.

**Elegant variation.** One entity renamed across a page to avoid repeating a word, which costs the reader the grep that would have found every mention.
Bad: "The client opens the socket. The peer sends a handshake. The consumer reads the reply."
Good: "The client opens the socket, sends a handshake, and reads the reply."

**Uniform rhythm.** Every sentence in a passage running the same length and the same subject-verb-object shape.
Human prose mixes a short assertion with a longer qualified one.

**Both-sidesism.** A design page listing what each option costs while leaving the taken one unnamed.
The page exists to record the decision, so it names the decision.

**Over-determination.** A sentence stating the conclusion the code above it already showed.
Bad: `// This shows the design favours composition over inheritance.`
Good: no comment, or the constraint a reader cannot see: `// Composed rather than subclassed, so a mock swaps in without a fake base class.`

**Staccato.** Three or more one-line paragraphs under eight words, cutting for punch rather than because the content breaks there.

## The cure has its own tells

Cutting slop produces a second register that scans just as machine-made: bare fragments, amputated contrasts, sentences that survived the edit while losing their content.
`A finding is a claim.` and `Windows are reconciled.` are what a paired negation leaves behind when the negated half was carrying the sentence.

So the pass runs against its own output.
Every sentence this style touched is re-read and asked whether it still states a fact a reader can use, and a sentence that lost its content is rewritten rather than kept short.
A dead sentence is a worse defect than the tell it replaced.

## False positives

Four rules keep the detectors honest.

**A quoted example is masked.** Text inside a code fence, an inline code span, or a `Bad:`/`Good:` line documents a construction, so it is exempt from the check for that construction.

**A literal sense is exempt.** `leverage` in a finance context, `robust` as a measured property of an estimator, `seamless` describing a texture.

**A correction of fact is exempt.** `Use pnpm, not npm` and `Latency fell 40%, not 4%` carry the correction in the negated half.

**Frequency gates the voice tells.** Transition openers, staccato and rule-of-three fire on a pattern across a document, so one legitimate instance passes.

## Sources

- [Wikipedia:Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
- [Why Does ChatGPT "Delve" So Much?](https://arxiv.org/abs/2412.11385), COLING 2025, measuring the lexical spike
- [GPTZero on the rule of three](https://gptzero.me/news/the-rule-of-three/)
- [Pangram: spotting AI writing patterns](https://www.pangram.com/blog/comprehensive-guide-to-spotting-ai-writing-patterns)
- The `unslop` skill's reference corpus, for the technical-register translation and the detection machinery
