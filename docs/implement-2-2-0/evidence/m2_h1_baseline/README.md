# Coherent H1 baseline recovery checkpoint

The [archive](h1-coherent-baseline.tar.gz) preserves the 31 changed/new files,
available Root preimages, exact assembly patch, full frozen-source manifest,
authority/merge ledger, raw compile/run evidence and independent review. Restore
the recorded Root commit and apply the overlay to reconstruct this isolated
foundation. Earlier snapshots remain unchanged.

SHA256: `0486da63412631760e099fcb295187a13a4d93c5768847bfbaec1244cd8daf66`
(722,206 bytes). The [manifest](manifest.json) binds 154 safe regular members
and 153 inventory entries. Retained bytes passed credential-value and GitHub
token-pattern checks. Derived binaries remain outside the archive; exact run
records retain their hashes.

Source authority is Root `3d6b6f9dd829e4da04b960033f9b44f3a1608960`, with
production source at 3cc8f81. Later 9ea9c7b changes documentation only. Frozen
source digest: `2795e885505248822125ef5ae5a1d695aaf557cb040040fb23c1bad74ec43e3f`.

The full central ReleaseSafe graph compiles. Debug and ReleaseSafe each pass
134 pure/component, five decoder, 17 App, 69 H2 and 35 QUIC cases. Independent
composition review found no actionable findings. These selected checks are not
a full Root test/sanitizer or live transport matrix. The stopped native fault
experiment remains stopped.

The explicit test override is local libxev
`c223bd886c6a51d2cd60def39dd9a68d701fea73`, tree
`86c6944f53dc009d7503a9ab0bc873aef3cd7b79`. Its complete recovery history is in
the earlier [registration checkpoint](../m3_libxev_registration_rollback/README.md).
Root pins and maintained refs remain unchanged. This baseline has no actual H1
consumer or new lifecycle implementation; production integration remains open.
