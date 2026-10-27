# M2: request streaming and incremental multipart

Status: compatibility-preserving architecture accepted, 2026-10-26.
M1 is complete locally; the [common contract](m2_common_contract.md) is
implemented and verified. [Response guards](m2_response_guards.md) also pass
the combined gates. The standalone [incremental multipart utility](m2_incremental_multipart.md),
[part-sink adapter](m2_multipart_sink.md), and [head/body decoder](m2_body_decoder.md)
are integrated separately. Admission and transport implementation remain open.
No transport-driven request-streaming capability
is implemented or advertised by this report.

The architect mapped body-cap admission, borrowed headers/captures, middleware
metadata, callback ownership, informational responses, and flow control across
the existing transports. Root chose the recommended route-level sink, explicit
startup opt-in, validated/discarded trailers, and a shared bounded HTTP/2 block
pool. The [accepted ADR](../adr/0008-request-body-streaming.md) records named
types, exact terminal ownership, backpressure, helper compatibility, admission
limits, capacity arithmetic, and ordered implementation acceptance.

The selected design leaves default buffering enabled and avoids an unconditional
72 KiB receive-pool addition per connection. Streaming allocations occur only
at startup. Its body decoder emits pure events; transport drivers own sink calls
and I/O. Pauses cannot stop HTTP/2 connection control processing, and the report
does not promise inbound sibling progress after connection-window exhaustion.

Fresh-context adversarial review found two actionable omissions: control-call
cleanup timing and exact ingress/refusal bounds. The revised ADR fixes both,
including concrete control errors, callback-only metadata views, synchronous
terminal callbacks, streaming-only framing limits, and exact transport storage
requirements. Bounded re-review found no remaining actionable design findings;
root accepted the contract. External CLI review was skipped during autonomous
implementation; later maintainer review remains separate.

The common contract is verified. Implementation continues through router
admission, HTTP/1/TLS, HTTP/2, HTTP/3, a 100 MB transport matrix, and incremental
multipart.
Every behavioral slice requires failing-first regression evidence and the
original milestone gates. Architecture review alone establishes no runtime
result; the common checkpoint records its separate executed checks.


## Compatibility gate before integration

The isolated common-contract prototype passes 24 focused cases, an existing
clone case, and a public-consumer compile, but a subsequent
[compiler audit](evidence/m2_compatibility/README.md) finds a material source
break: adding BodyNotBuffered to Request.form widens its inferred closed error
set even for default buffered callers. Both an explicit narrow-return wrapper
and an exhaustive catch compile against baseline and fail against the draft.
Earlier behavioral/source review did not expose that compiler-level contract.

The draft remains isolated and unintegrated. Preserve the original plan's
buffered source-compatibility requirement; revise the new streaming-aware
request surface before landing it. Aliases, anyerror, or unrelated old parse
errors do not solve the compatibility/refusal requirements. This finding
required a fresh architecture review, completed by the accepted revision below.
Core inline-control, terminal, progress and capacity design remains useful.
The common checkpoint now supplies actual revised-source compiler proof;
no live streaming capability is advertised.

## Accepted compatibility revision

The [revised ADR](../adr/0008-request-body-streaming.md) keeps Request and
OwnedRequest unchanged. New begin/end callbacks receive a distinct const
StreamingRequest containing metadata views and no raw body. Its fallible body
helpers have the dedicated BodyNotBuffered error; explicit metadata clones
own flat storage and derive views after construction. This avoids widening
legacy inferred error sets or pointing into a moved inline request.

New BodyRoute configuration defaults to rejecting legacy global middleware.
An explicit headers_only policy runs the complete existing chain once on a
header-only legacy Request with its baseline helper semantics. Admission also
checks late middleware registration before callbacks, quota or 100 Continue.
Existing registration and event-loop APIs retain their error surfaces.

Open response starts use BodyNotComplete before mutation. Legacy send_file
retains its closed error set and uses the existing BodyNotAllowed refusal.
No fallback or descriptor ownership is accepted by that refusal.

Independent review required one lifetime clarification: a pending outgoing
producer needs independently valid context, scratch and retained metadata after
upload cleanup. Synchronous response end/reset must also leave callback source
arrays and slots pinned until that callback returns. The ADR and later adapter
acceptance now require both. Bounded re-review found no remaining findings;
root accepts the revision.

[Declaration evidence](evidence/m2_typed_design/README.md) preserves the original
proposal, corrected derivative, five source bindings and 30 checked probe
artifacts. These prove type-level feasibility only. The original runtime-mode
draft remains frozen and unintegrated; its Request/default-slab growth must
not be applied to production assertions. The [common checkpoint](m2_common_contract.md) now proves the actual new types,
unchanged buffered compiler consumers, clone failure/lifetime behavior and
measured production layouts. Transport integration remains separate.


## Incremental multipart contract

[ADR0011](../adr/0011-incremental-multipart.md) accepts a pure event parser and
a separate concrete part-sink adapter. Input data is accepted only after sink
acknowledgement; carry is bounded by boundary.len + 4, with false-prefix replay
leaving real input available for resume. EOF validates without flushing deferred
application payload. Part cleanup is once-only, including paused terminal events.

[Review evidence](evidence/m2_multipart_design/README.md) records preserved legacy
helper error sets, distinct new typed refusals and the explicit init carry
minimum. MP-L1 re-declares ordinary delimiter padding as unsupported with a
reviewed restoration criterion. No general RFC conformance or implementation
result follows from this design. The standalone parser checkpoint records its
own implementation and verification; its part-sink adapter and request transport
integration remain separate gates.

## Confirmed platform activation scope

The user confirmed setup refusal for request streaming on community BSD until
worker wakeups and native validation are available. The
[isolated platform guard](m2_upload_platform.md) is implemented and independently
reviewed. Linux, macOS and Windows are eligible; native Windows release evidence
remains mandatory. Disabled and generic pure contracts remain available.

This bounds the subsequent H1 retirement implementation plan. Its historical
unrestricted V6 liveness claim remains rejected; no physical-close algorithm
or live upload follows from a setup-policy proof. The combined baseline must
retain current Root multipart, timer, fuzz and consumer changes before actual
H1 delivery and TLS integration proceed.
