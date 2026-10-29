# Owned HTTP/2 application-error evidence

The [archive](application-error-live.tar.gz) retains actual current/historical
fixture and runtime sources, compiler recipes/receipts/full input maps,
offline failures and regressions, initial/scoped source reviews, Root input
audits, exact authorization/command, raw output/results/public certificate and
independent host result audit. All 118 safe regular files have
117 inventory entries. No private key, credential, compiled
executable or Python cache is included.

Archive SHA-256: `32615c2d13833f059d55ad118de3a8c72ce3755fda8ba051795aa8d3495e89cc` (3706228 bytes).
See [manifest](manifest.json) and [component report](../../m2_h2_application_error_live.md).

One owned Linux ReleaseSafe TLS1.3/h2 run passes sink_error, invalid_progress,
end_error and idle shutdown. Chunk/invalid cases retain exactly7/H7, one cancel
and no end. End error retains32/H32, one end/error and no second cancel. All
three assert one INTERNAL_ERROR reset with no final HTTP response. Each has
independent same-route recovery, expired old controls and a healthy sibling.
Primary refunds15/15/32 precede sibling DATA; sibling accounting is separate.

Actual totals: six admissions, four ends, two cancels,142accepted, one each
chunk/invalid/end error, no failed begin/fixture errors/active binding. DATA
161sent/refunded, all32records/finalmetrics equal through deinit, four fresh
owned connections, normal SIGTERMexit0/reaped/keyremoved, log15942<65536.
Before/after audits match for2436inputs/7trees/six archives and current native
builds. Neither callback sizes nor packet segmentation is an oracle.

Current fixture-v2 and runtime-v2 remain unchanged for the preparation-tool fix;
manifest-v3 `d2bb368da8f912f3b37ed97376d8d73a11259570b44aae893981609e3ac5a62f` additionally binds the guarded
checker/test/binder. Review caught checker import-time validation/temporary
writes. Its actual-source regression detects attempted effects even if restored,
and the explicit CLI still accepts/mutates/rejects/restores/accepts. Scoped
re-review passes. Initial counter-schema omission and corrected v2 builds,
policy RED, inherited ledger mismatch and checker-handler failure remain in
history. Twenty runtime-harness tests plus one import regression prove
preparation; the separately released run proves the stated live observations.

The unchanged1031-file [candidate](../m2_h2_native_tcp/README.md), reviewedc223
override, original C binding/six archives and
[pinned client](../m2_h2_client/README.md) remain the source/tool basis. Complete
changed candidate src bytes are in the [metadata archive](../m2_h2_metadata_live/README.md).
This archive does not activate candidate code or unpublished dependency pins.

32 H2 case IDs are proved; eight and the full combined matrix remain. Other
lifecycle/output, H3/multipart/genuine early data and fullquality/platform/
compliance/physical/provenance/adoption/release requirements remain open. No
performance/RSS/leak/general native-safety claim, automatic retry, native fault
injection or stopped/denied-case reconstruction is made.
