# TLS upload runtime recovery

The [archive](tls-upload-live-proof.tar.gz) contains the three actual fixture
variants, complete raw live records and safe runtime artifact trees, reviews,
execution handoff, compiler/client identity records and composed-source checks.
The initial 36/37 cluster failure is preserved alongside corrected 37/37 cluster
and 37/37 configured single-App results. See the [report](../../m2_tls_live.md).

SHA256: `db66aeb271fa679ad0a21e2153b88ce5a4c729a86362e55eabcf271de816eeff`
(1446950 bytes). The [manifest](manifest.json) binds 185 regular members and
184 inventory entries. Every member hash and credential scan passes. No generated
certificate, private key, binary, symlink or Python cache is included.

Source recovery requires the [plaintext](../m2_h1_plaintext/README.md),
[TLS driver](../m2_tls_driver/README.md), [shutdown](../m1_tls_shutdown/README.md)
and, for the single App, [constructor](../m2_configured_https/README.md) overlays.
Check preimages and the archived combined-configured/source-manifest-v1.json
before composing them. This archive does not change Root source or dependency pins.
