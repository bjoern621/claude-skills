# Comments, tests and messages

Code and config comments, docstrings, test names, log lines, error and assertion messages, above the rules in [SKILL.md](SKILL.md).
The examples come from the author's Go code in ChatProtoGol, a chat protocol over UDP.
Capitals used for emphasis in the originals appear in plain case.

## What earns a comment

A comment states what the code cannot show: a unit, a range, an invariant, a reason for an odd choice, a caller obligation, a contract.
A paraphrase of the line, a value gloss (`# 0: no blink.`), what the tool's documentation already says and routine code stay uncommented.
The first comment in a block, method or file holding none stays out unless it carries one of these facts.

- A setting chosen for a reason outside the file earns its line: `# Worker boots at ~930 MB, so a cap near that recycles it every few minutes.` above `per_worker_max_memory_mb = 1500`.
- A workaround links what it answers: `# Workaround for dotnet/runtime#98765, drop once it ships.`
- A number chosen by taste takes no comment.
  Defending one invents a constraint that the next reader works around.
- A line that looks redundant says why it stays: `nextHop, found := router.GetNextHop(destinationIP) // Get the current next hop again (it may have changed)`.
- A line that a reader would "fix" says why the obvious form fails: `// Can't be len(r.lsdb-1) because we might not have our local LSA yet but just received a new neighbor's LSA.`

A comment describes the code as it stands, for the code's next reader.
History, the reviewer and commented-out code stay out.
An alternative implementation goes into the commit body or an issue.
A TODO names its issue: `// TODO(#12): ...`.
A touched comment gets rewritten in the same change.
Untouched ones stay.

## A doc comment states the contract

The first line follows the language's convention.
On a function that others call, the lines after it say what a caller has to know:
- concurrency, in one wording across the project: "Can be called concurrently."
- a call obligation: "Should only be called once per packet."
- a precondition that the code asserts: "Asserts that the neighbor exists before removing it."
- a precondition that the caller meets unchecked: "It should only be used on packets with a unique packet number."
- missing input: "If the packet number does not exist, it does nothing." on the exported method, "it panics." on the internal one
- side effects: "ACK observers are notified that the connection is closed (ACK not received)."
- copies: "This function creates a copy of the payload so that the original payload can be modified without affecting the packet."
- a boolean result, both cases: "Returns true if the checksums match, false otherwise."
- a value that the caller has to handle: "Returned string may be the empty string."
- errors: "Errors if the destination address is not reachable or sending fails."
- the state after the call: "The reconstructor cannot be reused after clearing the state."
- a duty left outside, with who carries it: "The caller is responsible for consuming from the returned channel."

```go
// ForwardRouted forwards a packet to the destination address defined in the packet header.
// Routed: Uses the routing table to determine the next hop.
// This function automatically decrements the TTL by one.
// Timeouts and resends are not handled (should be handled by source peer).
// Errors if the TTL is already zero or less.
```

A compound name gets its parts explained.
Every name of the family reads its parts the same way:

```go
// SendReliableRoutedPacket sends a packet.
// Reliable: Resends and timeouts are handled.
// Routed: Uses the routing table to determine the next hop.
```

A small utility API closes on one example call and its effect: "Example: myObservable.Unsubscribe(msgChannel) will remove msgChannel from the subscribers and close it."
A package comment states its scope and the neighbour that takes the rest: "It does not detect duplicates. The sequencing package handles them."

## Data and values

A data structure documents its layout.
A wire format gets an ASCII diagram with every field's width and the total size.
Each field repeats its width: `TTL byte // Time to live (8 bits)`.
A packed byte lists its bits: "Bits 0-3: Message type (4 bits)".

```go
packetNumbers map[netip.Addr]uint32         // Maps a host address to the last packet number that was used for that host.
highestPktNum map[netip.Addr]int64          // Highest contiguous seq num received per peer; int64 to allow for negative numbers
futurePktNums map[netip.Addr]map[int64]bool // Out-of-order seq nums > highest, bounded by common.RECEIVER_WINDOW
```

A map names its key and its value.
A type chosen wider than the data says why.
A collection names its bound.

A sentinel gets its meaning where it appears: `highestAcked = -1 // No packets have been acknowledged yet for this address`.
A constant carries its unit in the name (`UDP_BUFFER_SIZE_BYTES`, `ACK_TIMEOUT_DURATION`) and its derivation or its consequence in the comment:

```go
const MAX_PAYLOAD_SIZE_BYTES = 1200 // MTU in bytes after subtracting ChatProtocol header: 1484
const UDP_BUFFER_SIZE_BYTES = 1500  // ... incoming packets larger than this will be dropped
```

A setting, a resource or a token created in config carries a description of what it does and why it exists.
A disabled feature gets one line on what it does and why the project turns it off.

## Algorithms and branches

A borrowed rule links its source: `// React only if the packet hasn't been resent yet (https://datatracker.ietf.org/doc/html/rfc5681#section-3.1)`.
A known algorithm gets its phases named (`// Slow start`, `// Congestion avoidance`, `// Multiplicative decrease`).
A reader who knows the theory finds it in the code.
`// Simulate: per peer RTO` marks where the code approximates the theory.

A branch whose condition hides its domain case gets the case named:

```go
if destAddr != socket.MustGetLocalAddress().Addr() {
	// The file transfer is for another peer
	connection.ForwardRouted(packet)
	return
}

// The file transfer is for us
```

A case label stays sparse.
An `if` that reads as its case goes without one.

## Form

Clipping happens inside the language's own convention.
A Go doc comment opens on the identifier.
JSDoc tags carry the facts.
Clipped fragments: `// Resolved timeout. nil if profile sets none.`
Formats by example: `// ms, 1..60000.`
A cut keeps every fact.
Paths, line numbers and counts that shift with edits stay out.
For a tool-written annotation (gettext `#:` origins), turn the tool's option off.

A comment breaks where its layout reads best.
Short sentences and clipped fragments can share a line: `# 365 days. Google caps web sessions at 14 days by default.`
A comment too wide for the file breaks at the one `,` `:` `;` or conjunction that splits it into readable halves.
Every other punctuation mark keeps its line.
A long line that reads in one pass stays whole.
A review judges the comment block against the layout of the file around it.

## Messages

A message carries the values that it is about and a likely cause where one exists.
- A failure names the failed step and the cause: `"Failed to open UDP socket: %v"`, lowercase when Go wraps it: `"failed to rename file: %w"`.
- An event comes first.
  The action that the code takes follows after a comma: `"Received message with TTL <= 0, dropping packet"`.
- An unexpected state reads "X, but Y": `"Received FINISH packet of %v with last packet number %d, but no reconstructor found"`.
- An error names what it found, then the rule or the remedy: `"UDP socket is already initialized. Call Close() before calling Open() again."`
- A category leads where the reader filters by it: `"Malformed LSA packet: source address %v does not match sender %v"`.
- A guess at the cause goes in parentheses: `"no next hop found for the peer address (is the peer disconnected?)"`.
- A wrapped error adds the values that explain it: `fmt.Errorf("%w - PktNum: %d, [%d, %d]", CongestionWindowFullError, pktNum64, highestAcked, highestAcked+cwnd)`.
- An assertion names the rule: `"teamID must be 4 bits (0-15)"`, `"Cannot add LSA with older or equal sequence number"`.
- A log line reports the reading: `"%s declares no retry budget"`.
- An event tag in a trace log stays upper case: `"MSG RECEIVED %v %d"`.

## Tests

A test name states what the test proves: `TestSenderWindowBlocks`, `TestHighestAckedAdvancementWhenAllPacketsAcked`.
A test step names its input and the state expected after it: `// ACK packet 0: accumulator should become 1, cwnd stays 2`.
A failure states the step, the expectation and the actual value: `"After 2nd ACK, expected cwnd to be 3, got %d"`.
A comment restating an assertion goes.

## Completion criteria

- Every comment has been read against the line beneath it and cut on a second pass.
- Every function that others call states its contract.
- Every message names its values.
