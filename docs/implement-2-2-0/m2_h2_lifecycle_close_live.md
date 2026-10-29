# HTTP/2 request streaming: disconnect, reuse and active shutdown

Status: the reviewed lifecycle fixture passes one owned Linux ReleaseSafe
TLS 1.3/h2 run. This adds three H2 case IDs to the
[application-error checkpoint](m2_h2_application_error_live.md), bringing the
inventory to 35 proved IDs and five remaining. The full combined matrix,
production adoption and original M2 acceptance remain open.

The [evidence package](evidence/m2_h2_lifecycle_close_live/README.md) retains
source, build receipts, input inventories, offline regressions, source reviews,
the exact released command, actual result/log/public certificate and independent
host audit. No private key or compiled executable is included.

## Observed behavior

| Case | Actual result |
| --- | --- |
| `disconnect` | Original connection pauses at seven accepted bytes without EOF. Public TLS unwrap succeeds, the returned socket reaches ordinary EOF, and the replacement connection observes one `peer_closed` cancellation. Old controls expire before and during independent 32-byte recovery, which completes successfully. |
| `reuse` | Nine sequential 32-byte requests complete on one connection. Each later request stays active after seven bytes while both controls for every earlier request return `BodyControlExpired` without changing the old or active record. All 72 operations pass; each old record has the independently expected `8-j` counts. |
| `shutdown_active` | The paused client stays open through owned SIGTERM. All 32 status rows and metrics are collected before the signal. The target changes from active/paused with no terminal callback to one `shutdown` cancellation, with seven bytes retained and no end. |

The two interrupted bodies retain SHA-256
`32bbe378a25091502b2baf9f7258c19444e7a43ee4593b08030acd790bd66e6a`.
Every completed body retains 32 bytes and SHA-256
`7f0c5881a9ae2683debba016a4786b6c08dc684c5a334fa0b9876e6e32c390b5`.
Metadata checks pass at middleware, begin and successful end. The fixture
retains copied public controls and stable records through slot reuse.

Actual totals are 12 admissions/begins, ten ends, two cancellations, 334 accepted
bytes, zero failed begins, zero callback/progress/end errors and zero active
bindings after deinit. The 20 spare records remain untouched. Before SIGTERM
there is one active binding and one prior cancellation; afterward there are
zero active bindings and two cancellations. Only the shutdown target's cancel,
active, paused and reason fields change. All actual post-deinit log records
and metrics match the recorded final snapshot.

Four fresh connections verify TLS 1.3, h2, the owned listener and certificate
before health requests. Client DATA totals 384 bytes. Observed connection-credit
refund is 334 bytes; departed connections have no exact-refund success oracle.
The shutdown client observes TLS EOF after the owned signal, with zero closing
H2 frames. This path does not promise a TLS close alert. The separate disconnect
case requires successful unwrap and ordinary EOF.

The server log contains 15,918 bytes under the 65,536-byte cap. SIGTERM produces
successful run/deinit records and exit zero, with normal reaping, no forced
cleanup, no cleanup errors and removal of the private key. Root independently
confirms the exact child PID/start is absent in the host namespace.

## Source and verification

The configured App keeps eight connections/native H2 slots, the 73,728-byte
receive pool, two caller sink slots and 32 fixed records. Nine body requests
exercise reuse beyond the eight native slots; no allocation index is claimed.
Response records remain bounded at eight and reads/sends at 8,192 bytes.

The unchanged 1,031-file candidate and reviewed C223 libxev override remain
isolated. Native fixture v1 compiled in Debug and ReleaseSafe against actual
13-input receipts and unchanged source/override/fixture inventories. Runtime v2
is separately frozen. Current manifest
`fc64a55cb7de3f1473a1883d12911366fe26aea745ec424cba4f0ff863258da9`
binds 2,452 inputs and seven trees. Independent pre/post identity audits match.

Preparation retains 53 ordinary checks and eight optimized adapter checks.
Review found that active shutdown could extend beyond its case deadline. The
fix clips the shared shutdown deadline to the case, whole-run and 15-second
graceful limits while preserving the separate idle allowance. Its clock
regression fails before the fix; 14 covering checks and three optimized checks
pass afterward. Current closure validation accepts, rejects an actual bound
source mutation and accepts exact restoration normally and under optimization.
Initial and scoped source reviews pass after that correction.

Remaining IDs are `producer_reuse`, `output_pressure_window`,
`output_pressure_ready`, `stream_file` and `early_final_order`. Combined H2,
HTTP/3 uploads, multipart transport composition, genuine early data, maintained
dependency publication, physical lifetime, full quality/platform/compliance and
release gates remain open. This checkpoint makes no performance, RSS, leak or
general native-safety claim. The original stopped experiments remain stopped.
