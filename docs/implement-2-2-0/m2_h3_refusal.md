# M2: HTTP/3 header refusal preparation

Status: isolated implementation verified and independently reviewed, 2026-10-27;
production integration remains open. This prepares temporary empty 503 responses
for selected BodyRoutes before an actual HTTP/3 upload driver exists.

The engine lends its immutable router to initial header sets. Selection follows
complete structural validation and canonical method/path matching, including
query splitting, HEAD fallback, ANY, method errors and explicit buffered-route
precedence. Valid selected requests queue a final empty 503 without reads,
middleware, admission changes, sink callbacks, 100 Continue or body storage.
CONNECT and invalid QUERY retain their existing rejection paths.

Read shutdown leaves the sending side available to drain the response. This
matches the early-response allowance in
[RFC 9114 section 4.1](https://www.rfc-editor.org/rfc/rfc9114.html#section-4.1)
and the public shutdown directions documented by
[lsquic](https://lsquic.readthedocs.io/en/latest/apiref.html#c.lsquic_stream_shutdown).
Late read callbacks do not read or abort a pending refusal. A valid trailer
already decoded before shutdown is claimed and released without replacing the
initial metadata or cancelling the response. Malformed decoded fields still
fail validation before attachment. Output failure closes only that stream.

## Compatibility corrections

A Linux32 consumer exposed the initial draft changing public
HeaderSet.content_length from ?usize to ?u64. The existing field retains ?usize;
a separate checked u64 declaration supports wide-length selection before
narrowing. The old consumer compiles against the prepared baseline, fails
against the widened draft, and compiles after correction. Pure native and
Linux32 executables also exercise that exact typed assignment.

Default-off and standalone decoders preserve immediate buffered-cap rejection
at the Content-Length field. Enabled classification can defer the cap until
the completed header section identifies the selected route. Invalid lengths,
duplicates, forbidden fields, missing pseudo-fields and invalid ordering remain
errors. A failing trailer case also demonstrated the pending-response abort;
the corrected attachment releases the queued valid trailer instead.

## Verification and remaining work

The [checkpoint](evidence/m2_h3_refusal/README.md) preserves reconstructible
source deltas, raw failures, command arguments and source bindings:

- 12 focused cases pass in Debug and ReleaseSafe, covering routing, framing,
  quota preservation, unread input, long captures, output failure and trailers.
- 35 unchanged QUIC cases pass in both modes.
- Native and actual Linux32 pure tests pass eight wire cases per target.
- Six target layout compiles, formatting, conventions and version checks pass.

The initial expanded test referenced a nonexistent capture-count field; the
test now uses Request.route_param_count. A later fixture incorrectly expected
empty raw response headers to consume header storage; the corrected fixture
reports a real header-write failure. An initial regression-runner labeling
error executed the focused root; only the corrected explicit quic_tests.zig
commands establish the 35-test results. No production fixes follow from those
fixture or runner mistakes.

Alias-aware extraction requires nine layout values per target. HeaderSet grows
24 bytes on the measured 64-bit targets and 16 bytes on Linux32; QuicStream and
Engine remain unchanged relative to the prepared App/R2 baseline. Header-pool
allocation must account for that growth during final combined capacity review.

The subsequent [live HTTP/3 evidence](evidence/m2_h3_refusal_live/README.md) runs
the unchanged source with aioquic 1.3.0 and the reviewed local libxev candidate
as a test-only override. Valid headers declaring a 100,000,000-byte body, with
no DATA or sending-side FIN, receive STOP_SENDING(H3_NO_ERROR) and a complete
empty 503. A concurrent healthy sibling and a later request both return 200
on that QUIC connection. The io_uring server drains with zero sink effects or
retained quota. Both processes exit zero and the owned server is reaped. Root
dependency pins stay unchanged; this is not a completed 100 MB upload.

The [fresh independent review](evidence/m2_h3_refusal/independent-review.json)
finds no actionable issues within this frozen component. It checks canonical
selection, framing precedence, source compatibility, read shutdown, pending
response/trailer ownership, sibling isolation and untouched admission counters.
Recorded results match the source hashes and documented HeaderSet growth.
The reviewer ran no builds, tests or probes. Root accepts this bounded component;
the combined transport and full protocol gates remain open.
No dependency pin changes, FIN peeks or private lsquic-field access are included.
An unread end-of-body length mismatch is not diagnosed by header-only refusal.
Reconcile later root changes and complete the HTTP/1 consumer and H2/H3 refusal
integration before exposing the prepared public registry/App surface. Actual
HTTP/3 uploads, incremental multipart transport integration, the live 100 MB
matrix and full M2 acceptance remain open.
