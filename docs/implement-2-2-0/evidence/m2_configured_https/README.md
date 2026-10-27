# Configured HTTPS constructor recovery

The [archive](configured-https-constructor.tar.gz) preserves four reviewed source
snapshots/preimages, patch, complete command records, frozen inventories,
preserved failure diagnostics, execution plan/report and API/crypto reviews.

SHA256: `9bd9ccb7ae15d591dff6df9a531d8bfb7cce38915dffdc2312bb043826bc9d78`
(969267 bytes). The [manifest](manifest.json) binds 98 regular members and
97 inventory entries. Member hashes and credential checks pass. Generated
certificate/private-key material and binaries are omitted.

Apply the four implementation/snapshot source paths over the
[plaintext checkpoint](../m2_h1_plaintext/README.md), checking the full preimages
and manifest before overlay. Result digest:
`f6f6e7d62a5b33c33f5c466f225b6476778094582759efc63482913e08ed9458`.
The [report](../../m2_configured_https.md) records composition with TLS and the
live acceptance boundary. Root source and pins remain unchanged.
