# M2: HTTP/2 header refusal preparation

Status: isolated implementation verified, 2026-10-27; independent review and
production integration remain open. This implements temporary header-time
refusal for selected BodyRoutes, not an HTTP/2 upload driver.

The optional named header selector uses canonical router matching before
middleware, admission counters, sink callbacks or body accumulation. Valid
selected requests receive one empty 503 from headers alone, including declared
lengths above the buffered ceiling or machine width. HEAD fallback, ANY routes,
explicit buffered-route precedence and long incoming capture paths retain
canonical matching. Default buffered callbacks remain optional and unchanged.

The session preserves malformed framing independently of the buffered size
ceiling. Selected malformed Content-Length and known END_STREAM length
mismatches produce PROTOCOL_ERROR. Buffered requests retain their original
first-error precedence. This follows the malformed-message requirements in
[RFC 9113 section 8.1.1](https://www.rfc-editor.org/rfc/rfc9113.html#section-8.1.1).

Final HEADERS with END_STREAM must enter ordered output before NO_ERROR reset,
as required for early request abortion by
[RFC 9113 section 8.1](https://www.rfc-editor.org/rfc/rfc9113.html#section-8.1).
While headers are blocked, DATA is discarded without materialization and its
flow credit is restored. Pending reset intent survives slot release and stays
ahead of sibling response output. Response-generation capacity failure resets
only that stream; hard writer errors still propagate after generation starts.

## Findings and corrections

Failing-first cases exposed selected malformed lengths losing precedence to a
buffered cap error, and an unrepresentable 503 escaping the stream-local path.
The provisional copy now retains framing validity, and bounded generation
failures recover before output begins.

A Linux32 compile also exposed two baseline send-credit guards converting
maxInt(i64) into usize. Comparing the usize amount after widening to u64 fixes
both reserve and refund guards without changing errors or layouts. Actual
native and Linux32 pure-session executables verify seven wire cases each.
This does not establish complete Linux32 App support.

One output-pressure failure belonged to the fixture: application responses
obtain fresh production TCP callbacks, bypassing the fixture's flag. The
corrected test fills the actual write ring. Existing production reset ordering
was already correct. Historical failures remain in the evidence.

## Verification and remaining work

The [checkpoint](evidence/m2_h2_refusal/README.md) preserves exact source deltas,
reconstruction instructions, immutable source bindings and raw results:

- 14 focused cases pass in Debug and ReleaseSafe.
- 69 unchanged HTTP/2 cases pass in both modes with normal local socket access.
- Native and actual Linux32 pure-session tests pass, with seven cases each.
- Six target layout compiles, formatting, conventions and version checks pass.

The initial sandbox run denied socket creation in two unchanged cases; those
failures are retained. No tests were skipped or weakened. Layout extraction
resolves LLVM aliases and requires all six exported measurements; earlier empty
dictionaries establish no measurements. Relative to the prepared App/R2 tree,
Session and TcpConnection each grow eight bytes on all measured targets;
Callbacks grows one pointer. These are isolated, cumulative-baseline-dependent
measurements, not final production capacity guarantees.

The subsequent [live TLS evidence](evidence/m2_h2_refusal_live/README.md) exercises
the unchanged isolated source with curl 8.5.0/nghttp2. A valid 100,000,000-byte
upload source with Expect: 100-continue receives an empty HTTP/2 503 with zero
bytes uploaded and no 100 Continue. A healthy 200 request reuses the same TLS
connection. The io_uring server drains with zero sink calls or retained quota;
only the healthy request invokes middleware. Both processes exit zero and the
owned server is reaped. This is refusal evidence, not a completed 100 MB upload.

No final independent review or combined transport gate has run for this
checkpoint. Account usage limits still prevent the required
independent agent review. The prepared public registry/App/R2 surface must land
with a working HTTP/1 consumer and corresponding H2/H3 refusal. Reconcile later
root changes before integration. Actual H2 streaming, bounded shared body
blocks, live 100 MB uploads and full M2 acceptance remain required.
