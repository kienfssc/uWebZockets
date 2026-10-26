# M2: request streaming and incremental multipart

Status: core architecture accepted; request-surface compatibility revision
in progress, 2026-10-26. Transport implementation awaits M1 completion.
No request-streaming capability
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
including concrete control errors, callback-only Request pointers, synchronous
terminal callbacks, streaming-only framing limits, and exact transport storage
requirements. Bounded re-review found no remaining actionable design findings;
root accepted the contract. External CLI review was skipped during autonomous
implementation; later maintainer review remains separate.

Implementation then proceeds through common contract/router,
HTTP/1/TLS, HTTP/2, HTTP/3, a 100 MB transport matrix, and incremental multipart.
Every behavioral slice requires failing-first regression evidence and the
original milestone gates. No checks or runtime behavior are claimed from this
architecture-only work.


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
errors do not solve the compatibility/refusal requirements. Core inline-control,
terminal, progress, and capacity design remains useful; the revised API and
middleware/body-helper semantics need fresh architecture review and compiler
proof. No live streaming capability is advertised.
