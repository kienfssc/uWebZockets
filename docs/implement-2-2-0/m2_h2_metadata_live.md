# M2: owned HTTP/2 metadata and body-helper checks

Status: `metadata_helpers` and idle shutdown pass in one owned Linux
ReleaseSafe TLS1.3/h2 run. The [evidence](evidence/m2_h2_metadata_live/README.md)
records the sources, build history, exact command and raw results. M2 and
production adoption remain open.

Middleware, begin and end validate all **66 visible headers** and **17 route
captures**, including overflow `x-h62`, synthesized Host and `p16`. Initial
metadata survives conflicting discarded trailers. Method, target, path, query,
empty ordinary-POST protocol and case-sensitive parameter lookup also pass.

The request contains 65 ordinary and four pseudo fields. Its actual initial
HPACK block is **725 bytes**, checked before sending against the 8192-byte bound.
The separate decoded cost is 684 name/value bytes and a 2892-byte header-list
cost. The pure fresh-encoder observation was 732 bytes; it is not a native size
oracle. Production capacities and the two reusable sink slots are unchanged.

Both callbacks exercise JSON, schema, detailed schema, form and multipart
helpers, each requiring `BodyNotBuffered`. Text and bytes stay empty, query
helpers work, the caller's zero-length allocator stays unused, and the detailed
Issue's pointer, length, content and kind remain unchanged. A reachable untagged
union guards against accidentally instantiating JSON parsing. Each callback
records one completed helper suite after all checks pass.

The client sends 16 bytes, verifies the paused zero-consumption barrier, then
sends 16 more bytes and trailer EOF and verifies the same barrier. Copied public
resume produces exactly 32 bytes with SHA-256
`7f0c5881a9ae2683debba016a4786b6c08dc684c5a334fa0b9876e6e32c390b5`.
There is one admission and end, no cancel or failed begin, no fixture errors,
and one retained middleware header. Healthy traffic forbids resets,
informational responses, response trailers, GOAWAY and premature EOF.

All 32 records, including 31 untouched spares, and final metrics match after
deinit. Two fresh connections use the same owned child. Final status reads
precede metrics, and owned SIGTERM exits normally with reaping and no forced
cleanup. Root independently verifies the host PID and private key are gone.
The log is 14,129 bytes, below the 65,536-byte cap.

The pause cleared temporary artifacts. Candidate, override, client and fixture
source bytes were restored against their recorded hashes. Fresh compiler
replays passed but did not reproduce the historical binary hashes; the cause
remains unproved and original records are preserved. The current proof uses
separately bound fresh builds. Source review removed unused credit-case
scaffolding and state; both new Debug and ReleaseSafe builds and scoped reviews
pass. No historical executable or binary reproduction is claimed.

The [native candidate](m2_h2_native_tcp.md) remains the same 1031-file source,
with the reviewed c223 override and original bindings/libraries. The fixed
fixture is separate from production. Current input identities match before and
after the run; the archive includes restoration, mismatch and fix evidence.
It also retains complete replacement bytes and base/new hashes for the 40
candidate source paths that differ from Root commit `30f27ab`, for review and
recovery. Those archived files do not activate the candidate in the library.

This checkpoint brings the H2 case inventory to 26 proved IDs and 14 remaining.
The later [control successor](m2_h2_control_live.md) proves ready/paused
cancellation and peer reset, extending it to 29 proved IDs and 11 remaining.
Producer/file/output pressure, application errors,
disconnect, reuse, active shutdown and the combined matrix remain required.
H3, multipart transport, genuine early data, full quality/platform/compliance/
physical gates, maintained publication and production adoption remain open.
No performance, RSS, leak or general native-safety claim follows. Stopped
experiments and historical denied socket cases were not resumed.
