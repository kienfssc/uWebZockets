# H1 cold-state v3 recovery checkpoint

The [archive](h1-cold-state-v3.tar.gz) preserves the four-file overlay and
preimages, immutable V1 history, actual behavioral red, final V2 source and
verification, original C bindings, independent review and implementation
handoffs. Apply it over the [coherent baseline](../m2_h1_baseline/README.md).

SHA256: `0b867d0d827c5075eaefea9f9b53a013d713f77b826d8595cfa5a096e88da2dd`
(1,537,851 bytes). The [manifest](manifest.json) binds 270 safe regular members
and 269 inventory entries. Retained bytes passed credential-value and GitHub
token-pattern checks. Derived executables stay outside the archive; exact run
records retain their hashes.

Frozen V2 source digest:
`35bcfec2f32c0f0789b534f0832a37b2e3dd543d97ccdbed52655719005d4fb1`.
All 1,020 source/input files remain read-only, with no source-tree symlinks.
Focused 3/3 and whole App 20/20 pass in Debug and ReleaseSafe. Centralized
Linux/macOS/Windows graphs compile; foreign execution is not claimed.
Independent V2 review finds no actionable findings after a macOS test fixture
correction. Its earlier environment concern was withdrawn after checking the
actual explicitly supplied subprocess environment; the raw review is reconciled
in the retained independent-review record.

Each enabled owner grows 40 bytes; disabled slabs remain unchanged. No native
lifecycle, upload-consumer or full Root gate result follows from this data slice.
The explicit local libxev override remains
`c223bd886c6a51d2cd60def39dd9a68d701fea73`; Root pins and maintained refs remain
unchanged. Stopped native cancellation/fault experiments remain stopped.
