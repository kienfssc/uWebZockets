# TLS H1 driver v3 recovery

The [archive](tls-h1-driver-v3.tar.gz) contains the reviewed TCP/upload/test
overlay, complete preimages and snapshots, command/raw evidence, manifests,
source-backed capacity/retry review and concrete transport/crypto approvals.

SHA256: `99161a277434c0d178e7a153b7821b730f12534202d7dc49d5e9de60c5365a82`
(571114 bytes). The [manifest](manifest.json) binds 92 safe regular members
and 91 inventory entries. Credential-pattern and available named credential-value
checks pass. Derived binaries are omitted with their build identities retained.

Apply the three files in `transport/snapshots/v3/src/` over the
[plaintext checkpoint](../m2_h1_plaintext/README.md). Source digest becomes
`2498622e3a120c6fd0cfee575ad1223b3961ce9e22cbeb9ba39b3d1d59be2cf7`.
The actual patch SHA256 is
`09ffeac7196065c87a0badc96023c18680b0fda1625f21fab9028dad7cb59a7a`.

Focused tests pass 27/27 in Debug and ReleaseSafe; unchanged App31 and TLS3
pass. Three-target semantic compilation and static checks pass. These are
component results, not enabled TLS upload runtime evidence. The archive also
retains the inherited shutdown retry finding; its correction is a separate
successor. Root source/pins and M2 completion remain open.
