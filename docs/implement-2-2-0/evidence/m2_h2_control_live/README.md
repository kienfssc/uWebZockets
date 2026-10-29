# Owned HTTP/2 control evidence

The [archive](control-live.tar.gz) contains actual fixture and runtime sources,
all retained versions, exact compiler recipes/receipts, full input maps,
offline regressions and failures, initial/scoped reviews, Root identity audits,
both exact authorizations and both owned outcomes, public certificates, raw
logs/results and the independent successful-result audit. All 117
members are safe regular files; 116 inventory entries bind them.
No private key, compiled executable or Python cache is included.

Archive SHA-256: `b3f4d56dd8173ba1795734eafadc6b5aabcb77c786cb996aa3cffde382835eb2` (5561622 bytes).
See [manifest](manifest.json) and [component report](../../m2_h2_control_live.md).

Ready/paused public cancellation and ordinary peer reset plus idle shutdown
pass on the current source. Six admissions, three ends, three cancels,
110 accepted bytes, zero failed begin/end/active/errors. Three independent
same-route recoveries, stale controls and healthy buffered siblings pass.
Primary connection refunds of 7/32/32 bytes are observed before sibling DATA;
separate sibling accounting prevents credit masking. Actual DATA: 170 bytes
sent and refunded. All 32 records and final metrics match after deinit. Four
fresh TLS1.3/h2 connections, normal SIGTERM exit zero, reaping and key removal
pass; the log is 14,682 bytes below the 65,536-byte cap.

The first v4 attempt completed three case sequences but FileNotFoundError interrupted
idle/final verification; forced cleanup correctly records failure. The exact
original path was not retained. Source investigation found a volatile FD-entry
enumeration defect. Only a vanished enumerated readlink is now tolerated;
listener/PID/start/nonce/certificate guards and other errors stay strict.
Synthetic actual-helper tests prove that correction, not the lost original
path. Future failures retain filename/stage/traceback. The independently reviewed
v5 passes in a separately authorized second attempt. Both outcomes remain;
this is not a zero-failure history or an automatic retry.

Current subject is source/fixture-v1 plus source/runtime-v5; native builds did
not change across runtime fixes. Manifest SHA: `d74acb0bf0586bdcace73bb772c376ea39e4ea7036da826828a59ee321882f18`
binds 2,433 inputs and seven trees, both actual build maps, original binding/six archives,
compiler/stdlib, client/interpreter/loader/TLS tools/helper and frozen sources.
Before/after Root audits match. Initial review also fixed sibling credit masking
with actual case/ledger RED/GREEN coverage; source re-reviews pass. Offline
seven listener, two credit and eight observer tests establish harness preparation.
Actual owned results establish the scoped protocol/application observations.

The unchanged 1031-file [native candidate](../m2_h2_native_tcp/README.md) and
reviewed c223 override remain the source basis. The
[metadata archive](../m2_h2_metadata_live/README.md) retains complete changed
candidate src bytes against Root30f27ab, and the
[pinned client](../m2_h2_client/README.md) restores offline packages. Archive
delivery does not adopt candidate code or unpublished dependency pins.

29 independent H2 IDs are proved; 11 and the full combined matrix remain. Application errors,
disconnect/reuse/active shutdown, output/producer/file, H3/multipart/genuine
earlydata and wider quality/platform/compliance/physical/provenance/release
requirements remain open. No performance/RSS/leak/general native-safety claim
or stopped-experiment/denied-socket-case reconstruction follows.
