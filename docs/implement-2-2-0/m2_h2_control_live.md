# M2: owned HTTP/2 cancellation and reset checks

Status: ready cancellation, paused cancellation, peer reset and idle shutdown
pass in an owned Linux ReleaseSafe TLS1.3/h2 run. The
[evidence](evidence/m2_h2_control_live/README.md) retains both attempts, actual
sources/builds, reviews, commands, results and independent audits. M2 and
production adoption remain open.

Ready cancellation accepts seven bytes before public cancellation. Paused
cancellation accepts the same seven bytes and leaves 25 queued bytes unaccepted.
Both assert one server CANCEL reset, one cancel callback, no end callback and
the exact accepted-prefix hash. Peer reset begins paused, accepts no bytes,
and records one server cancel callback with reason `reset`; no server reset
echo is required. No primary produces a successful final HTTP response.

Each case keeps a buffered sibling healthy and independently admits a later
32-byte upload on the same quota-one route. Copied controls return
`BodyControlExpired` before and after reuse, without changing terminal state.
Metadata, accepted counts and hashes are checked against independent values.

The client observes complete primary connection-credit refunds of **7, 32 and
32 bytes before sending sibling DATA**. Sibling credit has separate accounting.
Review caught an earlier ordering that could let its one-byte refund mask a
short primary refund; actual case/ledger regressions cover all three primaries.
The observer rejects payload after termination and uses bounded active records
without accumulating retired IDs. Offline tests include more than 32 sequential
responses, fragmented/coalesced frames and exact reset policies.

The passing run has six admissions, three ends, three cancellations, **110
accepted upload bytes**, no failed begin/end, no active bindings and no fixture
errors. Actual client DATA sent/refunded is 170 bytes, including queued data,
three buffered sibling bytes and recoveries. All 32 records, including 26
untouched spares, and final metrics match after deinit. Four fresh connections
use the same owned child; SIGTERM exits zero and reaps without forced cleanup.
The private key is removed and the log is 14,682 bytes below the 65,536 cap.

Two separately authorized attempts are retained. The first completed the three
case sequences but failed before idle shutdown/final verification with
`FileNotFoundError`; forced cleanup correctly makes it a failed run. Its exact
failed path was not retained. Source investigation found an enumerated FD could
vanish during listener ownership inspection. Synthetic tests reproduce that
helper defect; the correction tolerates only that disappearance and preserves
strict listener/PID/start/nonce/certificate checks. New diagnostics retain the
exception filename, stage and bounded traceback. The corrected runtime passed
independent review and the subsequent owned run. No automatic retry or claim
that the original exact failing path was recovered is made.

The native fixture and both Debug/ReleaseSafe compile receipts stay unchanged
through the two runtime fixes. Their exact input maps and the final separately
frozen nine-file Python runtime are bound by the current manifest. Independent
before/after audits verify 2,433 inputs, seven trees and six static archives.
The candidate remains the same 1031-file source with the reviewed c223 override;
ordinary root pins and production adoption remain separate.

This extends the [metadata checkpoint](m2_h2_metadata_live.md) to **29 proved H2
case IDs, with 11 remaining**. Application errors, disconnect, repeated reuse,
active shutdown, producer/file/output cases and the combined matrix remain
required, alongside H3/multipart/genuine early data and the wider platform,
compliance, physical-lifetime, maintained-publication and release gates. No
performance, RSS, leak or general native-safety claim follows. Stopped fault
experiments and historical denied socket cases were not resumed.
