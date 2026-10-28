# HTTP/2 request streaming: live pauses and controls

On 2026-10-28, four new cases and normal idle shutdown passed against the actual
configured HTTPS App over TLS 1.3 with `h2`. Five accepted uploads retain their
counts, hashes and control diagnostics through deinit. The
[evidence package](evidence/m2_h2_pause_control_live/README.md) preserves exact
sources, commands, reviews, input identities and raw results.

This extends the [core live proof](m2_h2_core_live.md). It does not complete the
remaining H2 matrix, physical lifetime verification, production adoption or M2.
Root production source and maintained dependency pins are unchanged.

| Case | Observed behavior |
| --- | --- |
| `partial_pause` | First 8192-byte DATA payload pauses after seven accepted bytes. A further 4097 bytes and EOF leave it paused at seven. Owning-loop resume completes all 12289 bytes in FIFO order with the expected independent hash. |
| `final_pause` | All 32 bytes are accepted with paused readiness and EOF already sent; end waits for resume without further upload bytes. |
| `begin_pause_empty` | Begin is paused; empty DATA EOF produces no chunk or end until resume, then completes with zero bytes and the empty hash. |
| `control_rules` | Active-ready resume returns `BodyNotPaused`; stale resume/cancel return `BodyControlExpired` while a second binding is active and after completion, without changing either request. Both requests complete all 32 bytes. |
| `shutdown_idle` | Owned SIGTERM, successful run/deinit, exit zero, child reaped, no forced cleanup or cleanup errors. All five post-deinit records equal their pre-deinit results. |

Both partial-pause barriers use a status request on the same connection after
the preceding DATA/EOF, establishing parser ordering without timing guesses.
They require no final response headers or stream end before resume. Payload
hashing accepts only the returned prefix; status finalizes a copy of the active
hash. No TLS-read or callback-count assumption determines progress.

The partial payload SHA-256 is
`f84149bf46313d9f7da734e3d53f88b2d01a2c01c38bf422063c507b237915f4`.
The 32-byte payload, including its final marker, has SHA-256
`7f0c5881a9ae2683debba016a4786b6c08dc684c5a334fa0b9876e6e32c390b5`.
Every upload has begin/end/cancel 1/1/0; totals are 5/5/0, zero failed begins,
zero errors and zero active bindings. Forty-one responses end normally.

Actual begin/chunk callbacks check 42 public resume/cancel refusals against
`BodyCallbackActive`; terminal callbacks check ten against `BodyControlExpired`.
These are ordinary public validation calls, not native cancellation schedules.
Separate fixed records survive reuse of the two sink slots. Copied tokens may
retire bindings synchronously; subsequent accesses use stable result storage.

## Source, review and execution

The unchanged 1031-file candidate is
`fc69e66f18d404aff19a0b018b81dd35c02ec2a46ed8f38670eb926c794f72de`,
from the [native composition checkpoint](evidence/m2_h2_native_tcp/README.md).
The existing c223 override, C bindings, six libraries, pinned client and helper
remain unchanged. The profile retains eight connections, 80 headers, 24 captures,
4096-byte H2 body stride and the previously measured 4098304-byte slab.
Fixed result records and bounded client capture add no full-body accumulation.

Debug and ReleaseSafe compile-only builds pass; only ReleaseSafe binary
`f553e8000d23347195611e241529c07e0b7158768638e35f8f36d7b52be06952`
is executed. Intermediate accessor and missing-field compile failures remain
preserved. Before initial review, preparation corrects fixed case ordering and
a silent cancellation invariant. Independent process review passes; protocol
review finds that the barrier could miss final HEADERS before resume. A shared
pure guard fixes that gap, with real pinned-codec checks for unresponded,
headers-only and ended states. No original live failure or behavioral red is
claimed. Both scoped re-reviews pass without new findings.

Root checks all 48 inputs, seven inventories, actual recipes/profile/binaries
and reviews before precise execution authorization. The single run exits zero
without retry; owned PID/start, nonce, listener and certificate fingerprint are
verified before health. Continuous output retention, response/metadata/event
bounds, absolute deadlines and independent cleanup are retained. The key is
removed; Root verifies raw records, post-deinit equality and unchanged inputs
after execution. The archive contains no private key or build binary.

The runner supports unique selected subsets with exact unused-record checks;
this live run selects all five listed IDs. Subsets have source/compile evidence,
not separate native results. Reset absence covers bytes observed, not an unseen
future frame after reading stops. Fixed-capacity accounting is not an RSS/leak
or general native lifetime proof.

Remaining Task 5b requires empty/limit/Continue/quota behavior, padded trailers,
receive credit, concurrent routes, overflow metadata and helper coverage. Task 5c
still requires producer/file/pressure/reuse, active public cancellation, peer
reset, application errors, ordinary disconnect, active shutdown and the combined
matrix. H3, multipart transport, genuine early data, full quality/platform gates,
maintained adoption and the original milestones remain open. Stopped experiments
and denied socket cases were not resumed.
