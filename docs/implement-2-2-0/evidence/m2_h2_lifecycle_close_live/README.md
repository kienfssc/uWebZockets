# Owned HTTP/2 lifecycle-close evidence

The [archive](lifecycle-close-live.tar.gz) retains the actual current/historical
fixture and runtime sources, compile commands/receipts/input maps, offline
regressions and failures, source reviews, Root audits, exact authorization and
execution receipt, actual result/log/public certificate, and independent host
result audit. Its 163 safe regular members have 162 inventory
entries. No private key, credential, compiled executable or Python cache is included.

Archive SHA-256: `1e08922e4d0456335c6e640ca8346e83d5484cd18c6847693f6bbbce1ec9795e` (4587640 bytes).
See [manifest](manifest.json) and [component report](../../m2_h2_lifecycle_close_live.md).

One owned Linux ReleaseSafe run passes strict TLS unwrap/normal EOF followed by
actual peer_closed cancellation and recovery, nine same-connection requests with
72 expired-control checks while later bodies remain active, and active-upload
SIGTERM with actual shutdown cancellation. All32rows/metrics match post-deinit
logs. The active target intentionally changes cancel/active/paused/reason after
signal; other rows remain unchanged. Four owned TLS1.3/h2 handshakes, 12begins,
10ends, 2cancels,334accepted,384clientDATA,zeroerrors/activebindings, exit0/reaped/
keyremoved and no forced cleanup. Buffered middleware count436 derives from
issued requests. Observed connection refund334 is recorded without an exact
refund oracle on departed connections. Active shutdown records TLS EOF and zero
closing H2 frames; only the disconnect case requires successful TLS unwrap.

Current fixture-v1 and runtime-v2 bind to manifest-v4
`fc64a55cb7de3f1473a1883d12911366fe26aea745ec424cba4f0ff863258da9` with2452inputs/7trees. Native Debug and
ReleaseSafe builds remain unchanged. Review caught active shutdown extending
the30-second case budget; the corrected clip preserves case/whole/15-second
grace and independent idle teardown. Raw failing clock tests,14covering passes,
3optimized passes, normal/optimized actual-input mutation rejection/restoration,
initial/scoped reviews and oldruntime/oldmanifests are retained. Preparation's
53ordinary and8optimized adapter checks remain evidence for unchanged modules.

The unchanged1031-file [candidate](../m2_h2_native_tcp/README.md), reviewedC223
override, originalC/sixarchives and [pinned client](../m2_h2_client/README.md) are
the source/tool basis. Complete changed candidate src bytes are in the
[metadata archive](../m2_h2_metadata_live/README.md). Paths/recipes record the
original run; restoring a new native environment requires the recorded sources,
dependencies and fresh validation. This package does not activate candidate
code or unpublished dependency pins.

35H2IDs are proved; five output IDs and the full combined matrix remain.
H3/multipart/genuineearlydata, fullquality/platform/compliance/physical,
provenance/adoption/release and all original milestone requirements remain open.
No performance/RSS/leak/general native-safety claim, automatic retry, native
fault injection or reconstruction of stopped/denied cases is made.
