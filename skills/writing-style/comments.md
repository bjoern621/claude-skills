# Comments by example

The comments that this skill asks for, shown in the author's own Go code from ChatProtoGol, a chat protocol over UDP.
Each comment there carries a fact that a caller or the next maintainer needs and that the code leaves unsaid.
Capitals used for emphasis in the originals appear in plain case here.

## A doc comment states the contract

The first line follows the language's convention.
The lines after it say what a caller has to know before calling:
- concurrency: "Can be called concurrently."
- a call obligation: "Should only be called once per packet."
- missing input: "If the packet number does not exist, it does nothing." on the exported method, "If the packet number does not exist, it panics." on the internal one
- side effects: "ACK observers are notified that the connection is closed (ACK not received)."
- copies: "This function creates a copy of the payload so that the original payload can be modified without affecting the packet."
- errors: "Errors if the destination address is not reachable or sending fails."
- what it leaves to somebody else: "Timeouts and resends are not handled (should be handled by source peer)."
- a precondition on its input: "It should only be used on packets with a unique packet number (i.e., packets that have DestAddr == socket.GetLocalAddress() and have message types that provide packet numbers)."

```go
// ForwardRouted forwards a packet to the destination address defined in the packet header.
// Routed: Uses the routing table to determine the next hop.
// This function automatically decrements the TTL by one.
// Timeouts and resends are not handled (should be handled by source peer).
// Errors if the TTL is already zero or less.
```

## A compound name gets its parts explained

```go
// SendReliableRoutedPacket sends a packet.
// Reliable: Resends and timeouts are handled.
// Routed: Uses the routing table to determine the next hop.
```

The sibling `SendReliablePacketTo` reuses "Reliable:" and adds "To: Send the packet to a specific address and port."
The parts read the same in every name of the family.

## A data structure documents its layout

The struct carries an ASCII diagram of the header with every field's width and the total size.
Each field repeats its width in a trailing comment: `TTL byte // Time to live (8 bits)`.
A packed byte lists its bits: "Bits 0-3: Message type (4 bits)".

## A field says what it maps and where it stops

```go
packetNumbers map[netip.Addr]uint32           // Maps a host address to the last packet number that was used for that host.
highestPktNum map[netip.Addr]int64            // Highest contiguous seq num received per peer; int64 to allow for negative numbers
futurePktNums map[netip.Addr]map[int64]bool   // Out-of-order seq nums > highest, bounded by common.RECEIVER_WINDOW
```

A map names its key and its value.
A type chosen wider than the data says why.
A collection names its bound.

## A sentinel value gets its meaning where it appears

```go
highestAcked = -1 // No packets have been acknowledged yet for this address
```

`const RETRIES_PER_PACKET = 10 // ...; -1 means infinite retries`

## A constant carries its unit and its consequence

The unit sits in the name: `UDP_BUFFER_SIZE_BYTES`, `ACK_TIMEOUT_DURATION`.
The comment adds the derivation or what happens at the limit:

```go
const MAX_PAYLOAD_SIZE_BYTES = 1200 // MTU in bytes after subtracting ChatProtocol header: 1484
const UDP_BUFFER_SIZE_BYTES = 1500  // ... incoming packets larger than this will be dropped
const INITIAL_CWND = 10             // ... modified dynamically per peer based on ACKs received
```

The exact number lives beside the code that sets it and nowhere else.

## A borrowed rule links its source

```go
if openAck.retries == common.RETRIES_PER_PACKET { // React only if the packet hasn't been resent yet (https://datatracker.ietf.org/doc/html/rfc5681#section-3.1)
```

The nil-interface check links the article that explains the trap.

## A known algorithm gets its phases named

`// Slow start`, `// Congestion avoidance` and `// Multiplicative decrease` sit at the top of their branches.
A reader who knows TCP finds the theory in the code.
`// Simulate: per peer RTO` marks where the code approximates the theory.

## A branch names its case in the domain

```go
if destAddr != socket.MustGetLocalAddress().Addr() {
	// The file transfer is for another peer
	connection.ForwardRouted(packet)
	return
}

// The file transfer is for us
```

The condition compares addresses.
The comment names what the comparison means.
A case label stays sparse: it goes where the condition fails to read as its case, and an `if` that says its case itself goes without one.

## A line that looks redundant says why it stays

```go
nextHop, found := router.GetNextHop(destinationIP) // Get the current next hop again (it may have changed)
```

`// Return a copy to prevent race conditions on the original map` sits above `maps.Copy`.

## Messages carry the values and a likely cause

- error: `"no next hop found for the peer address (is the peer disconnected?)"`
- wrapped error: `fmt.Errorf("%w - PktNum: %d, [%d, %d]", CongestionWindowFullError, pktNum64, highestAcked, highestAcked+cwnd)` puts the window bounds into the message
- assertion: `"teamID must be 4 bits (0-15)"`, `"Cannot add LSA with older or equal sequence number"`
- log line: `"Ignoring (subsequent) timeout for %s; within RTO cooldown period."`

## Test names state the behaviour

`TestSenderWindowBlocks`, `TestHighestAckedAdvancementWhenAllPacketsAcked`, `TestCongestionAvoidanceAccumulatorReset`.

## What stays out

The repository also holds a commented-out second implementation and TODOs without an issue.
Both stay out under [SKILL.md](SKILL.md): the alternative goes into the commit body or an issue.
