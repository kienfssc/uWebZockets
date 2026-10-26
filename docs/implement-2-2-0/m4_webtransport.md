# M4: WebTransport activation boundary

Delivery re-declared on 2026-10-26 under the plan's explicit M4-3 alternative.
Reassess on 2026-11-02, or the first authorized maintained-fork review earlier.
[ADR 0001](../adr/0001-http3-datagram-and-webtransport.md) retains its accepted
wire design. No live WebTransport or application-datagram capability is enabled.

## Evidence and blocking chain

The [reviewed readiness evidence](evidence/m4_readiness/README.md) binds source
and published backend facts. M3 remains open: the maintained mirror differs
from upstream, HPACK parent/child alignment is unpublished, required protection
acceptance is missing, and the Codespace account has no fork push/admin access.
An unpublished integration commit cannot become a root pin. No new GitHub fork,
local overlay, fetched-source rewrite, or private dependency is a fallback.

The published server lacks the complete draft-16 server primitives. Its gated
legacy settings differ from the selected draft, application-controlled outgoing
uni streams and reset-at are absent, and enabling a macro alone is insufficient.
Engine callbacks have no generation-checked connection/session binding or live
datagram ingress/egress path. Header attachment enters ordinary body collection;
completed CONNECT dispatch returns 501. A long-lived CONNECT is not admitted
at headers and can await ordinary request completion/bounds. No new live
CONNECT-501 or negative-SETTINGS probe is claimed.

Pinned aioquic 1.3.0's stock WebTransport option also uses legacy settings and
lacks reset-at support. The successful ordinary HTTP/3 gate remains a regression
control; it is not the required compatible WebTransport gate. Source hashes and
fixed [draft-16 requirements](https://www.ietf.org/archive/id/draft-ietf-webtrans-http3-16.html#section-3.1)
are retained. The future adapter must distinguish application/policy drops
from [RFC 9297 datagram-framing errors](https://www.rfc-editor.org/rfc/rfc9297.html#section-2.1).

BackendCapabilities intentionally retains the primitive `quic_datagrams=true`.
The required extended-CONNECT, outgoing-uni, reset-at, and draft-16 bits remain
false, so require_backend refuses activation. That raw primitive is not live
listener advertisement. Existing helper APIs remain available with the same
public surface. Independent review confirms the source/permission/client/
protocol evidence and finds no actionable readiness-record issue.

## Restoration owners and acceptance

1. Build/vendor maintainer: establish reviewed exact mirrors and protections,
   publish HPACK alignment, synchronize all child pins/ledger entries, and
   complete M3's baseline. Resolve the separate h1spec attribution issue before
   release; it is not a missing WebTransport primitive.
2. Build/vendor and QUIC owners: implement and test ledgered server APIs,
   current settings and reset-at semantics in the maintained integration
   branch; publish a reviewed immutable commit and update all four root views.
3. QUIC, transport, and router owners: bind fixed connection/session slots,
   header-time long-lived CONNECT admission, capsule/stream/datagram ownership,
   limits, reset/close/flow-control cleanup, and bidirectional egress without
   hot allocation. Coordinate header-time ingress with M2.
4. Verification: separately review and pin a compatible client; prove settings,
   transport parameters, sessions, streams/datagrams, origin refusal, malformed
   cases, healthy siblings, teardown, and qlogs. Repeat required sanitizer,
   cold dependency, package, and ordinary protocol gates on the final pin.
5. Integrator: flip capabilities only with that successful gate and update
   SECURITY, QUIC/protocol/roadmap documentation in the same feature change.

Local source/test preparation can continue before publication; these barriers
do not make research impossible. This dated declaration resolves the permitted
delivery decision while preserving every implementation and restoration item.
It does not claim live activation, whole-release readiness, or M3 completion.
