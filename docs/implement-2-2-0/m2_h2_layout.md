# HTTP/2 storage measurement and delivery contract

Three-target compiler measurements and independent review confirm the proposed
warm layout cost before Session delivery implementation. This checkpoint contains
declarations and measurements only; cold carving, sink delivery and native
activation are not implemented by it.

The [recovery archive](evidence/m2_h2_layout/README.md) preserves complete raw
compiler reports, source/input manifests, declaration-only patch, measurement
sources, arithmetic, reviews, source restoration and the concrete delivery handoff.
The frozen 1025-file baseline remains
`580199bc84e81779dd050943fc0b1bb7a9b8f1af113fcb28e7fab560fc105af6`.

## Measured declarations

Linux, macOS and Windows agree on these byte sizes:

| Type | Baseline | Proposed declaration |
| --- | ---: | ---: |
| Eight-stream Session | 1384 | 1392 |
| Storage descriptor | 288 | 296 |
| Capacities descriptor | 56 | 64 |
| Callbacks descriptor | 56 | 72 |

The embedded Session adds eight bytes to each actual TcpConnection. Real disabled
default planner totals grow by 8192 bytes across 1024 connections on every target.
Optional H1 cold owners add another eight bytes each when allocated; that field
belongs to later startup/native integration. Descriptors are not separately
multiplied into the slab.

Measured proxy types are receive state 144 bytes and driver owner 1288 bytes,
including eight 152-byte slots. Eight optional cancellation reasons occupy 16
bytes, rather than eight. Queue payload, blocks and head/tail pairs total 74192
bytes per enabled connection. The resulting proposed enabled growth, including
both pointers, is 605120 bytes for the private eight-connection configuration or
77455360 bytes for default capacities explicitly enabled at 1024 connections.
Both supplied configurations have zero capture overflow; two overflow matrices
are accounted for symbolically. These totals are proposed aligned-region
arithmetic over measured proxies, not a finished carving implementation.

All six ReleaseSafe compiler invocations intentionally exit one solely because
they emit compile-time logs. They are not test passes or regression reds.
Full input/override/source identities match before and after, and the independent
review re-parses the raw reports and accounting. Formatting and an independent
AST refresh pass; no executable, test, client or native probe runs.

## Root decision and corrected delivery gate

Root approves the bounded additive Session/Storage/Capacities/Callbacks fields
for the next registered-sink Session slice. Actual implementation types and
three-target layouts must be checked before updating exact expectations. Disabled
storage must allocate no upload pool or driver region. Native startup binding and
the H1 cold pointer remain a later slice.

Root also identified a missing distinction between observing DATA and delivering
it while Continue output is blocked or older queue bytes remain. The independently
checked correction adds delivery_allowed to the stack event. Fresh payload is
observed once even while held, preserving immediate limits. Held input invokes no
sink and changes no actual sink readiness; Session ignores its synthetic paused
result, retains FIFO bytes and releases no payload credit for the hold.

Complete informational HEADERS acceptance opens the Continue gate for both chunk
and end. A real resume during blocked Continue clears sink pause without opening
that gate; later output acceptance drains automatically without a second resume.
Reset/cancel discards pending Continue. The next implementation must prove these
rules with real encoded Session input, registered sinks and fixed writer capacity.

No Root source, dependency pin, capacity limit, assertion, release gate or stopped
native experiment changed in this measurement checkpoint. Full HTTP/2 delivery,
native/TLS composition, actual 100000000-byte uploads and final M2 acceptance
remain open.
