# Plaintext HTTP/1 request streaming checkpoint

The isolated App and transport implementation now delivers real plaintext
request bodies through the public streaming API. Both fixed-length and chunked
clients sent exactly 100000000 logical bytes; the server returned the same
incrementally computed SHA256 and count. This checkpoint preserves reviewed
code and partial live verification. M2 and production integration remain open.
The [corrected client follow-up](evidence/m2_h1_plaintext_corrected/README.md)
now passes all 21 cases against the identical source and server binary.
The [producer and lifecycle extension](evidence/m2_h1_plaintext_lifecycle/README.md)
passes all 26 cases, with independent source and live-evidence review.

The [recovery archive](evidence/m2_h1_plaintext/README.md) contains the actual
eight-file combined overlay, five existing-file preimages, component patches,
test sources, client/server fixtures, raw command results, source manifests,
integration review and the initial live failures. It applies over the
[typed retirement checkpoint](evidence/m2_h1_invariant_failure/README.md).
Root source, dependency pins and maintained dependency refs are unchanged.

## Implementation and review

App binds its head resolver after stable placement and selects an unreserved
body route. It preserves middleware, initial header views, query/capture checks,
quota ordering and buffered routing. The concrete TCP upload module owns
retained input, partial acceptance, pause/resume, framing, sink delivery,
terminal cleanup and quota release. Native TCP callbacks retain their operation
borrows through cancellation retirement and physical close. Shutdown supplies
the explicit shutdown cancellation reason.

App spec and quality review approved the component. Transport review found
premature pipeline dispatch while a file response remained active. The reviewed
v6 fix includes file ownership in the existing dispatch guard. Behavioral red
and green tests cover that predicate; the live real-file checks separately prove
the resulting ordering. Crypto source review found no TLS-specific lifetime
defect; this ingress implementation remains plaintext-only.

The combined integration review approved header handoff, stable binding,
reasoned shutdown and exactly-once centralized test registration. Its source
digest is `acff666a13770119f4dab5441a8996bbee70c18df2e96d92b1e99d07547b254b`.
All 1023 original inputs remained unchanged during the recorded live run.

## Verification and actual failures

- App head tests: 12/12 in Debug and ReleaseSafe; unchanged App and router
  suites: 31/31 and 39/39.
- Transport v6 tests: 19/19 in both modes. Combined selected central tests:
  62/62 in both modes, using the actual io_uring backend.
- Full centralized semantic compilation: native, macOS and Windows pass.
  Scoped formatting, conventions and release-version checks pass.
- Initial owned live matrix: 18/20 pass. These include both exact large
  uploads, empty and exact-limit bodies, Continue, partial/final-byte pause,
  stream pipelines, middleware/metadata, application cancellation, stale
  controls, malformed chunks and sink failures.
- A real 16777313-byte file arrives completely before the pipelined health
  response, and completely before EOF on a separate Connection:close request.
- The owned server exits with status 0, is reaped without forced termination,
  and emits its post-deinit drain marker.

The two failed client checks are retained. Failed begin produced pre-header
EOF; ADR0008 requires rollback, reservation release and no accepted binding or
cancel, but does not require a final HTTP status there. The client needs a
dedicated contract check and successful same-route retry. The chunked over-limit
case observed a connection reset while sending rejected content/trailers or
checking closure. Its existing record does not prove whether a complete 413
arrived. The corrected check must preserve the parsed response and require a
complete 413; a reset alone cannot pass. Neither failure is discarded or counted
as success in this checkpoint.

The separately reviewed corrected run resolves both checks without a production
change. The original rejected-content sequence receives a complete empty 413,
then a reset; the new size-line-only case receives a complete 413 and clean EOF
before sending any payload. Both record zero accepted bytes, exactly one cancel
and a successful same-route retry. Failed begin records clean pre-header EOF,
no Continue or accepted binding/terminal, and a successful same-route retry.
Quota and declared-limit refusals now require exact 503 and 413 statuses.
All 21 cases pass, including the unchanged exact large uploads and file checks.
The runner exits 0 with all source/build/runtime/override inputs unchanged;
the server exits 0 and drains without forced termination. Bytecode writes are
disabled. Three unchanged healthy TLS echo tests also pass; these exercise
legacy buffered behavior and do not prove TLS request streaming.

The evidence wrapper also failed its final whole-directory hash assertion:
Python's helper import generated one bytecode cache. Recovery retained that
extra file's hash, verified every original source and compiler/runtime input,
copied the actual raw results, then removed only the generated cache. The
canonical source digest is restored. The wrapper's exit status is 1; its lost
inner numeric status is not reconstructed as evidence.

## Producer and lifecycle verification

Producer metadata, cross-route admission, ordinary disconnect/shutdown and
end-error cases now pass in the 26-case extension. The producer remained
unfinished after the upload binding was reused: 2686976 bytes had been queued
at that snapshot. It subsequently reached 16777313 bytes through 11 additional
real producer calls, validating retained metadata on every call. Three routes
were admitted simultaneously. Peer disconnect and end error released quota for
real retries; active-upload shutdown delivered exactly one shutdown cancel for
the accepted seven-byte prefix, followed by normal deinit and process exit.

The extension's runner exits 0 with all recorded inputs unchanged. Independent
review found no actionable evidence gaps. Its fixture uses independent
server-lifetime producer storage; it makes no producer-abort reclamation claim.

## Remaining acceptance

TLS/H2/H3 live streaming,
multipart transport integration, native Windows, maintained dependency
publication/adoption and final project gates remain required. No native fault
or cancellation-schedule experiment was run. No allocator-instrumented,
cross-platform runtime or complete milestone result is claimed.
