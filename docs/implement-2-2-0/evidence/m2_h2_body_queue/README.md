# HTTP/2 queue core recovery

The [archive](h2-body-queue-core.tar.gz) contains actual reviewed source,
preimages, patch, full inventories, raw command records, report and protocol
review. SHA256:
`0756837a301e08c6769813169f4819b274c16ade047d6253ddb815bf0bab9f3d`
(490031 bytes). The [manifest](manifest.json) binds 54 regular members and
53 inventory entries; all hashes and credential checks pass.

Apply body-queue/final over the reviewed composed source described in the
[TLS runtime recovery](../m2_tls_live/README.md), checking existing preimages.
The resulting 1025-file digest is
`580199bc84e81779dd050943fc0b1bb7a9b8f1af113fcb28e7fab560fc105af6`.
The baseline digest is
`89dce088f5684c9173c45c572e785e7ff9c57991eb152ec76c46a58db481479d`.

The [report](../../m2_h2_body_queue.md) records the nine tests in each build mode,
compilation/static checks and required concrete integration. No enabled HTTP/2
delivery, Root source adoption or dependency publication follows from this core.
