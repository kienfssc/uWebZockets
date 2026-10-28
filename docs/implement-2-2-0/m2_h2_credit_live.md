# M2: owned HTTP/2 credit, trailers and concurrent routes

Status: three new cases and idle shutdown pass in one completed Linux
ReleaseSafe TLS1.3/h2 run. One earlier restricted-executor attempt exited before
readiness; both attempts are preserved in the [evidence](evidence/m2_h2_credit_live/README.md).
The [native TCP candidate](m2_h2_native_tcp.md), production capacities and
dependency inputs are unchanged. M2 and production adoption remain open.

| Case | Verified result |
| --- | --- |
| `queued_trailers_padding` | Pause after seven accepted bytes; queue padded DATA and trailer EOF; resume to 12289 payload bytes/hash, accounting for 12297 flow bytes. Initial metadata survives conflicting discarded trailers. |
| `receive_credit` | Send exactly 65535 legal bytes into a paused body; HEADERS/control work with both DATA credits at zero. Resume, receive genuine refunds in both scopes, then send final byte/EOF; exact 65536 bytes/hash. |
| `concurrent_routes` | Hold a paused quota-one route, refuse a sibling with empty503/no100 and ordered NO_ERROR reset; a different route completes while the holder stays paused. Resume the holder and verify same-route recovery. |
| `shutdown_idle` | Fresh connection, no active binding, owned SIGTERM, successful run/deinit, normal exit0 and reaping. |

Totals are six body heads/middleware calls, five begin attempts/bindings/ends,
zero cancellations or failed begins, **77,921 payload bytes** and **77,929 flow
bytes**. All 32 persistent records, including 26 untouched spares, and final
metrics match after deinit. Each successful request passes independent begin/end
metadata checks. Every body response retains one middleware header. There are
zero active bindings or fixture errors at completion.

The padding case hashes
`f84149bf46313d9f7da734e3d53f88b2d01a2c01c38bf422063c507b237915f4`.
The credit case hashes
`f1666d44e02004f92bd350d6c56825b1b9f882e5edcd9f25ed8d2dfe1e414bab`.
Each 32-byte concurrent upload hashes
`7f0c5881a9ae2683debba016a4786b6c08dc684c5a334fa0b9876e6e32c390b5`.
Only the expected 503 refusal permits a reset; healthy requests forbid resets,
informational responses, GOAWAY, response trailers and premature EOF.

The independent client uses public window counters and peer WINDOW_UPDATE
events. It checks the final state after each complete receive batch, separates
padding from payload, and sends only within both real credit scopes. Root's
separate result audit replays the recorded ledger arithmetic and confirms the
zero-credit state and final byte after refunds. No packet, callback or update-
frame count is an oracle; final closed-stream refunds are not required.

The fixture keeps the reviewed eight-connection profile, eight native H2 streams,
73728-byte receive pool and two reusable sink slots. Stable result records and
owned expected metadata remain separate from recyclable bindings. Each case,
including idle, uses a fresh connection within the same owned child; barriers
and controls stay on the case connection. Controls are copied before resume.
Final 32 status reads precede metrics, with no later requests before shutdown.

Source review found two verification defects: missing static-library identities
in the manifest and a Python locale guard that rejected its documented launch.
The correction binds both actual compile receipts and all six archives, and
pins `LC_ALL=C.UTF-8` with the fixed Python path. Both scoped reviews pass.
Debug and ReleaseSafe builds pass; six pure checks validate the harness. The
synthetic sequence check covers totals and recorded operations, not complete
ordering or native behavior. Its limits and original failure are retained.

The first native startup printed capacity then `Unexpected`, exited 1 and
completed no case. The exact failing syscall is unproved. A separately
authorized host-executor run used identical source, configuration and assertions
and passed. This is two startup attempts and one completed protocol run; the
failed attempt is included. Both children were reaped and both private keys
removed. The successful log is 12,346 bytes, below the 65,536-byte cap; Root verifies
the owned host PID is absent. Input hashes match before and after execution.

The [core upload](m2_h2_core_live.md), [pause/control](m2_h2_pause_control_live.md)
and [admission](m2_h2_admission_live.md) proofs remain separate. Overflow metadata
and helper checks, producer/file/output pressure, active cancellation/reset,
application errors, disconnect, reuse, active shutdown and the combined matrix
remain required. H3, multipart transport, genuine early data, full quality,
physical lifetime, compliance/platform gates, maintained publication and
production adoption remain open. These are functional observations, with no
performance, RSS, leak or general native-safety claim. Stopped experiments and
historical denied socket cases were not resumed.
