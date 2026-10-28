# HTTP/2 request streaming: live admission, limits and Continue

On 2026-10-28, all 13 admission cases and idle shutdown passed against the actual
configured HTTPS App over TLS 1.3 with `h2`. The run verifies zero/exact/over-limit
bodies, Continue ordering, retained middleware headers, route quota and failed
begin recovery. The [evidence package](evidence/m2_h2_admission_live/README.md)
contains exact sources, commands, reviews, identities and raw results.

This extends the [core upload](m2_h2_core_live.md) and
[pause/control](m2_h2_pause_control_live.md) proofs. Remaining H2 work, production
adoption and complete M2 acceptance stay open. Root production source and
maintained dependency pins are unchanged.

| Cases | Observed result |
| --- | --- |
| `empty_headers`, `empty_data`, `empty_declared` | Zero-limit route accepts each empty EOF form; `200`, zero accepted bytes, empty hash and no chunk callback. |
| `limit_declared`, `limit_undeclared` | Exactly 32 bytes accepted and hashed correctly with either framing. |
| `limit_declared_reject` | Declared 33 plus Expect receives `413`, no informational response or begin attempt; same-route 32-byte recovery succeeds. |
| `limit_observed_reject` | After 32 accepted bytes, the next byte causes `413` and one `body_too_large` cancel. The offending byte is excluded from count/hash; same-route recovery succeeds. |
| `zero_declared_reject` | Declared one byte refuses before begin/Continue; same-route empty recovery succeeds. |
| `zero_observed_reject` | First observed byte causes one `body_too_large` cancel with zero accepted bytes; empty recovery succeeds. |
| `continue_ready`, `continue_paused` | Each receives exactly one `100` before positive DATA. Paused acceptance stays zero until public resume, with no repeated Continue. Final `200` retains the middleware header. |
| `quota_refuse` | Two held bindings cause a third head to receive `503` without begin/Continue. After completion, two recovery bindings are simultaneously active and both complete. |
| `begin_failure_rollback` | Application begin failure on quota-one route gives `503`, one attempt/failure, no binding/end/cancel; subsequent same-route admission completes. |

All six refused primaries have empty final bodies followed by exactly one
observed raw `RST_STREAM(NO_ERROR)` after their complete final END_STREAM frame.
Healthy streams reject resets. Refusal exceptions remain bounded through the
recovery/health barrier, then retire; reset observations do not rely on the client
library emitting an event for an already-closed stream.

All 22 body-route heads run middleware once, including refusals. Every final
`200`, `413` and `503` retains exactly one `x-middleware: retained`. Both
informational responses are `100` and leave final-header metadata intact.
The 32-byte payload SHA-256 is
`7f0c5881a9ae2683debba016a4786b6c08dc684c5a334fa0b9876e6e32c390b5`.

Actual aggregate counts are middleware 22, begin attempts 19, successful bindings
18, ends 16, cancels 2 and failed begins 1, with 384 accepted bytes. Both cancel
reasons are `body_too_large`; no binding remains active and no fixture error is
recorded. All 32 persistent records, including ten untouched spares, and the
final metrics match after deinit. Seventy-six final responses end normally.
The owned child exits zero and is reaped without forced cleanup; its key is removed.

## Provenance and verification limits

Candidate source remains 1031 files, digest
`fc69e66f18d404aff19a0b018b81dd35c02ec2a46ed8f38670eb926c794f72de`,
with the same c223 override, bindings, six libraries and pinned client/helper.
The [native checkpoint](evidence/m2_h2_native_tcp/README.md) supplies its source
patch and complete reconstruction. The production profile remains eight
connections, 80 headers, 24 captures and a 4098304-byte slab. The caller-owned
32-result table is separate from two reusable sink slots; bodies are hashed
incrementally and no complete upload is accumulated.

Preparation preserves the partial observer work, fixture builds and combined
package separately. Independent protocol review passes; quality review identifies
two four-level branches. Guarded helpers flatten both, and both scoped re-reviews
pass. The changed fixture is freshly compiled in Debug and ReleaseSafe; only
ReleaseSafe binary
`6e172b88be7eeed1a6269d1d866d6fde8e561042fa9f6b9daded5df08eeb0059`
is run. Pure pinned-codec, ledger and binding checks remain distinct from live
results. No behavioral red is fabricated for this control-flow refactor.

Root verifies 122 inputs, nine inventories and actual build receipts, then records
precise authorization before one run. Owned PID/start, nonce, listener and
certificate identity precede health. Bounds include eight response records,
8192-byte reads/spans, explicit metadata/body/event limits and continuous
65536-byte output retention. Absolute deadlines are 15 seconds readiness,
30 per complete case, 900 overall and 15 graceful shutdown. Final metrics are
captured after all status reads so buffered-middleware accounting remains stable
through deinit. Postrun input identity is unchanged and no retry occurs.

The supported subsets have pure/source evidence; this one Linux ReleaseSafe run
selects all 13 cases. Raw reset assertions cover bytes read through the stated
barriers, not arbitrary future unread frames. Fixed-capacity accounting is not
an RSS/leak, exceptional-cleanup or general physical lifetime proof.

The [credit successor](m2_h2_credit_live.md) now passes padded trailers, credit
exhaustion and concurrent routes. Overflow metadata/helper checks remain
required. Producer/file/pressure/reuse, active cancellation, peer
reset, application errors, disconnect, active shutdown and the combined matrix
remain Task 5c work. H3, multipart transport, genuine early data, full native/
sanitizer/platform/compliance gates, maintained adoption and the original
milestones stay open. Stopped experiments and denied socket cases remain stopped.
