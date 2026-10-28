# HTTP/2 request streaming: core live acceptance

On 2026-10-28, five core cases passed against the reviewed candidate's actual
configured HTTPS App and registered body sink over TLS 1.3 with `h2` ALPN.
Both declared and undeclared uploads sent and accepted exactly 100000000 bytes.
Client and server computed matching incremental SHA-256 hashes independently.
The [evidence package](evidence/m2_h2_core_live/README.md) preserves the fixture,
client wrapper, input identities, reviews, commands and raw observations.

This verifies the core subset of the [native composition](m2_h2_native_tcp.md).
The broader H2 matrix, production adoption and complete M2 acceptance remain
open. Root production source and maintained dependency pins are unchanged.

## Observed cases

| Case | Observed result |
| --- | --- |
| `ready_buffered` | Health returns `200/ok`; buffered POST echoes all 257 bytes with the independent expected hash. Sink counters remain zero. |
| `async_delayed` | Public `get_async` and `AsyncResponse.sleep_complete` return `200`, `text/plain`, exactly ten `delayed-ok` bytes and normal stream end. |
| `large_declared` | Content-Length 100000000; client sends and sink accepts exactly that count, matching SHA, begin/end/cancel 1/1/0, maximum offered span 8192. |
| `large_undeclared` | No Content-Length; the same exact count, matching SHA, callback counts and span bound. |
| `shutdown_idle` | After completed responses and no active binding, owned SIGTERM produces a post-deinit inactive marker, exit zero and successful child reaping without forced cleanup. |

The upload SHA-256, including the final 22-byte marker, is
`190f6457d88258809df90a042b0226dab5537a1984f708cfd5bb90005835cea2`.
The two sink bindings return to inactive state; final aggregate begin/end/cancel
counts are 2/2/0. Thirteen responses end normally. The recorded input also
contains 48832 WINDOW_UPDATE events; this is an observation, not the later
exhaustion, pause or sibling-isolation proof.

## Bounds and provenance

The candidate has 1031 files, digest
`fc69e66f18d404aff19a0b018b81dd35c02ec2a46ed8f38670eb926c794f72de`.
The [prior checkpoint](evidence/m2_h2_native_tcp/README.md) supplies its cumulative
patch and complete reconstruction evidence. The core harness uses the same
reviewed 93-file libxev override and unchanged C bindings and static libraries.
The [independent client package](evidence/m2_h2_client/README.md) and payload
helper remain pinned and unchanged.

The fixture builds through `Server.preset(...).build_https` with eight
connections, streaming enabled, 80 request header fields, 24 captures, H1 body
256, H2 body 4096, encoded header block 8192 and write queue 65536. Its measured
request stride is 5888, H2 session and aligned stride 281200, slab 4098304 and
router storage 884352 bytes. Actual configuration is in the server log.

Two caller-owned sink slots hash accepted spans incrementally; no upload body is
accumulated. Client reads and generated spans are at most 8192 bytes. Response
records, metadata, body capture, event types and server-output retention have
explicit bounds. This is source/capacity evidence, not an RSS or leak experiment.

Both fixture builds compile successfully in Debug and ReleaseSafe. Only the
ReleaseSafe binary, SHA-256
`d30cc8ab210d8b934e42c0bdafbc6d2fd5926eaa4bd0f17b924e7332c2c64fdc`,
was executed. Before that run, independent protocol and process reviewers found
four harness issues: executing-source identity, continuous log retention,
cleanup independence and closed-stream reset observation. The preserved real
codec regression fails against the original wrapper; revised offline checks
pass. Both reviewers accept the scoped fix with no new actionable findings.

Root independently checks all 25 bound inputs and five complete inventories,
ties the unchanged profile to both actual build records and binaries, and
records precise authorization before execution. The exact frozen runner checks
its own path/hash and explicitly loads the verified wire and helper files.
Raw-frame reset detection covers bytes read; it does not prove absence of a
future reset after observation stops.

The runner owns the loopback child, PID/start identity, nonce, listener inode
and ephemeral certificate fingerprint before health contact. Readiness,
ordinary-case, upload, total and graceful deadlines are 15/30/180/900/15 seconds.
The run exits zero without retry. Root checks raw counts/hashes, normal exit,
reaping, matching nonce markers, removed private key and unchanged inputs after
execution. The public archive excludes private-key material and build binaries.

## Remaining acceptance

Task 5b still requires pauses, empty/limit/Continue/quota behavior, queued
trailers and padding, concurrent routes, receive credit, metadata and controls.
Task 5c still requires producer/file output, pressure, reuse, public cancellation,
peer reset, application errors, ordinary disconnect, active shutdown and the
combined matrix with terminal totals through deinit. Idle shutdown proves none
of those additional lifecycle cases.

HTTP/3, multipart transport composition, genuine early data, physical lifecycle
verification, full native/sanitizer/compliance and platform gates, maintained
publication, production adoption and the original milestone requirements remain
open. Stopped native experiments and denied socket cases were not resumed.
