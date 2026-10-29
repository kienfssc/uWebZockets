# M2: owned HTTP/2 application-error checks

Status: sink error, invalid progress, end-callback error and idle shutdown pass
in one owned Linux ReleaseSafe TLS1.3/h2 run. The
[evidence](evidence/m2_h2_application_error_live/README.md) retains actual
sources, compiler/input records, offline failures, reviews, command, results
and independent audits. M2 and production adoption remain open.

The chunk-error case accepts the first seven bytes of a 32-byte payload, then
returns an application error before accepting or hashing the next offered
bytes. Invalid progress returns zero consumed with ready status on a nonempty
offer. That is invalid regardless of callback segmentation. Both assert one
INTERNAL_ERROR reset, one cancel with `sink_failure`, no end, and the exact
seven-byte hash. Sixteen sent bytes across the two rejected suffixes remain
unaccepted.

The end-error case accepts all 32 bytes and validates their hash and metadata.
Its end callback records one error before any response operation. It asserts
one INTERNAL_ERROR reset, one end and **no second cancellation**. None of the
three primaries produces a successful final HTTP response.

Each case observes complete primary connection-credit refunds of **15, 15 and
32 bytes before sibling DATA**. A buffered one-byte sibling then completes,
with separate accounting, followed by an independent 32-byte recovery on the
same quota-one route. Copied controls expire before and after reuse. Metadata,
accepted-prefix hashes, callback counts and middleware are checked independently.

The passing run records six admissions, four ends, two cancellations, one
chunk error, one invalid-progress result, one end error and **142 accepted
upload bytes**. Client DATA sent/refunded is 161 bytes, including rejected
suffixes, siblings and recoveries. No failed begin, fixture error or active
binding remains. All 32 records, including 26 untouched spares, and final
metrics match after deinit. Four fresh connections use the same owned child;
normal SIGTERM exits zero and reaps without forced cleanup. The key is removed;
the log is 15,942 bytes below the unchanged 65,536-byte cap.

Both actual Debug and ReleaseSafe builds pass. Twenty offline protocol,
credit-order and listener tests pass; a separate regression catches import-time
validation and temporary writes in the preparation checker. Review required
that checker to run only through guarded `main()`. Its explicit CLI still
accepts current inputs, rejects an actual input mutation, restores the file and
accepts the restored closure. Scoped re-review passes. Native fixture/runtime
bytes did not change for this tool-only correction.

The final closure binds 2,436 inputs, seven trees, both actual build receipts,
the separate one-file fixture and nine-file runtime, original C binding, six
archives and pinned client/tools. Independent before/after audits match. The
1031-file candidate, c223 override, production capacities and ordinary root pins
remain separate from production adoption. This was one authorized run with no
automatic retry, native fault injection or resumed stopped experiment.

Together with the [control checkpoint](m2_h2_control_live.md), this establishes
**32 proved H2 case IDs, with eight remaining**. Ordinary disconnect, repeated
reuse, active shutdown, producer/file/output cases and the combined matrix are
still required. H3 uploads, multipart composition, genuine early data, full
quality/platform/compliance/physical/provenance gates and final adoption/release
remain open. These results establish no performance, RSS, leak or general
native-safety claim.
