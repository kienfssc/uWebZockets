# HTTP/2 output: one ordinary native Debug attempt

[output-live.tar.gz](output-live.tar.gz) preserves 23 safe regular text members
with a 22-entry byte/SHA256 inventory. SHA256:
`fe24a8cd55ad6153f5400464d6d66dec9cdb023c89429824f28809301531d65d`
(1045148 bytes). [manifest.json](manifest.json) records the exact scope and
remaining work.

The original result hashes to
`49a9229b4490be5d991dc9c978a2f139e511f4c7f04ce6a00315be0498e5ffbb`
(193619 bytes); the server log hashes to
`3f52cb1670dd55912963b8e6f2486d5d28a5cef0d30bce1e9a008943f70b3ea2`
(17480 bytes). The driver exited zero with empty stdout/stderr. The existing
Debug binary, runtime manifest v5 and all inputs retained their approved hashes.
No compilation or automatic retry occurred.

The archive includes the actual result/log and public certificate; exact Root
authorization and tool completion; independent input, pattern/hash, body/output,
header, range, prefix and cleanup audits; review returns; and the full input
manifest. The matching [source preparation archive](../m2_h2_output_driver/README.md)
has SHA256
`6ebc819a8407f43b8b9aafd26b0fe5c52f4345c43e30b32584f8eb896d4544dd`.
It contains the exact 19-file runtime, current authored sources, pinned codecs,
fixture and preserved compilation history. Binaries, private keys, transfer data
and caches are excluded from this archive.

All five cases passed on one owned fixture and five fresh TLS1.3/h2 connections.
The exact primary hashes cover three 16,777,313-byte producers, the 24,593-byte
selected file range and the 17-byte early response. Recorded body totals are
seven middleware visits, six attempts/begins/ends, 192 bytes, zero errors/cancels/
failures and 63 buffered visits. The 70 completed responses include the final
32 status responses and metrics. Closed-stream request debt remains accounted
per connection; the test does not require a refund that the server legitimately
omits after stream closure.

Reuse compared binding generation 3 with 4 online while A was held. The file
close count was one before and after App deinit. Prefix, response and metadata
checks passed. TLS identity and END-before-NO_ERROR sequencing are supported by
successful execution of the authenticated driver/observer checks; the stored
terminal booleans alone do not reconstruct that wire validation. The child and
owned listener were absent, exit was zero, the child was reaped, the collector
joined, and key/file removal was verified. No forced cleanup occurred.

Independent source, fix and native-evidence reviews are preserved in this
checkpoint sequence. These five additional case IDs bring coverage to 40 IDs
across checkpoints. The actual combined 40-case run, ReleaseSafe runtime,
exact-current returned-error runtime evidence, full quality/platform/fuzz/package
gates and adoption remain open.
