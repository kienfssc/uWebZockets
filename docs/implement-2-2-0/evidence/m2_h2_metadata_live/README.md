# Owned HTTP/2 metadata and helper evidence

The [archive](metadata-live.tar.gz) contains the actual original and fixed
fixture sources, compile recipes and receipts, complete input maps, recovery
records, independent reviews, authorization, raw results/logs, public
certificate and independent result audit. Its 152 safe regular
members have 151 independently checkable inventory entries.
No private key, compiled executable or generated Python cache is included.

Archive SHA-256: `a08dbf448de76b3642816b0eed9388b59d83356b0d3d1fc8a7025b3718ec7d59` (8415267 bytes).
See the [manifest](manifest.json) and [component report](../../m2_h2_metadata_live.md).

One owned Linux ReleaseSafe TLS1.3/h2 run passes metadata_helpers and idle
shutdown: 66 visible headers, 17 captures, five BodyNotBuffered helpers in
each begin/end callback, unchanged caller allocator/Issue and initial metadata
retained despite conflicting trailers. Actual initial HPACK size is 725 bytes
within 8192. Both paused zero-consumption barriers precede public resume;
exactly 32 bytes arrive with the independently expected hash. All 32 records
and final metrics match after deinit; the child exits zero, is reaped and its
key is removed. The process log is 14129 bytes below the unchanged 65536 cap.

The pause removed temporary artifacts. Restored sources match recorded bytes;
fresh original-argv builds succeeded but did not reproduce historical binary
hashes. Their cause remains unproved. Original records and mismatches remain
intact. Current execution uses separately bound fresh fixed builds, manifest
`1cc2e55ec90df730ddb8b0765225dc4e8c8191c76452a899564a1bbd96ff6fd7`, not a recovered historical executable.
Independent review removed dead fixture scaffolding; both Debug/ReleaseSafe
compiles and scoped re-reviews pass. The exact one-run command and environment
are in evidence/fix1/stage-b-authorization.json and reports/task-5b4-stage-b-report.md.

The archive also includes complete replacement bytes for 40 changed
candidate src paths against Root commit `30f27ab80f0471437c34adcdf7b2d42f58227b74` in candidate/source, with
base/new hashes in candidate/delta.json. These support review and recovery;
they do not activate the candidate in the library. The unchanged 1031-file
[native candidate](../m2_h2_native_tcp/README.md), reviewed c223 override,
original binding/six static libraries and [pinned offline client](../m2_h2_client/README.md)
remain the source/tool basis. Current closure checks 2455 inputs and six trees
before/after execution. The restoration scripts preserve the actual recovery
history; they are not a new requirement to reconstruct unrelated old binaries.

The independent case inventory is 26 proved IDs and 14 remaining. All remaining
H2 lifecycle/output cases, combined matrix, H3/multipart/genuine early data,
quality/platform/physical/compliance gates, maintained publication, production
adoption and original milestones stay open. This is functional evidence,
with no performance, RSS, leak or general native-safety claim. No stopped
experiment or historical denied socket case was resumed.
