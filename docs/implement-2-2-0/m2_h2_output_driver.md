# M2: HTTP/2 output driver preparation

The five-case driver now pairs public H2 calls with the reviewed request and
response credit ledgers, raw framing observer and work limits. It implements
producer reuse, held and ready output, a selected file range, and the early
response's eight-plus-nine-byte grants. One connection per case and the final
32 status responses plus metrics use bounded I/O and fixed deadlines.

The [source and evidence](evidence/m2_h2_output_driver/README.md) preserve
49 authored driver, test and preparation files, 19 frozen runtime files, reviewed
client and fixture sources, pinned codecs, exact inputs and original results.
Root independently checked all 2,413 direct inputs and ten source/tool trees.
The existing Debug and ReleaseSafe binaries and receipts remain unchanged.

Independent review found two preparation defects. Reuse expected stream 5 after
its diagnostic requests had already consumed streams 5 and 7; B now uses 9.
The shared test SETTINGS payload now matches the actual server's five settings.
The fixes include failing-before/passing-after regressions. The allocation check
uses the real case, adapter and public codecs, stopping after B's body arrives;
it does not prove full reuse completion. Scoped specification and quality review
passed after both fixes.

The initial 24 focused scripts passed in normal and optimized Python. After the
fixes, nine covering scripts passed in both modes with `-B -S`. Root also passed
three checks against the exact frozen v5 runtime under optimization. The closure
checker accepted the current inputs, rejected an actual owned-file mutation and
accepted exact restoration in both modes. Imports are inert; authored proof
conditions remain active under optimization.

The driver retains bounded response facts and hashes, process identity and
cleanup evidence. Its process, filesystem, socket and TLS behavior was checked
with doubles; the protocol checks use in-memory public codecs. No native fixture
was executed in this preparation. The five output cases, an actual combined
40-case run, exact-current returned-error runtime evidence, full quality/platform/
fuzz/package gates and adoption remain open. Native H2 coverage remains 35 IDs.

The [native-output successor](m2_h2_output_live.md) records the subsequent
five-case Debug run and independent audit. It brings coverage to 40 IDs across
checkpoints; the actual combined run and remaining gates stay open.
