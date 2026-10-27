# TLS shutdown source recovery

The [archive](tls-shutdown-first-stage.tar.gz) preserves the actual reviewed
TCP/test overlay, preimages, frozen source manifest, red/green command records,
pinned-source shutdown proof, execution brief/report and both source reviews.

SHA256: `53f6daf40e390f61e0afb5612ffb90af5a212e1e4526f98233fefc8b7b3c3f6b`
(284605 bytes). The [manifest](manifest.json) binds 58 regular members and
57 inventory entries. Archive member hashes and credential checks pass.
Generated binaries and certificate/private-key material are excluded.

Apply close/snapshots/v1/src over the [v3 TLS driver](../m2_tls_driver/README.md).
The result is source digest
`b5cf3e793dde126c903abeed8586201274309dfad72fd6252ea54e9411e9aad8`.
See the [report](../../m1_tls_shutdown.md) for behavior, checks and limits.
This is a preserved component; production adoption remains open.
