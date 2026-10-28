# Owned HTTP/2 admission and recovery evidence

The [archive](admission-live.tar.gz) preserves partial observer work, both fixture
snapshots, combined and fixed packages, actual compile receipts, full inventories,
pure codec/ledger/module-binding checks, initial and fix reviews, Root audit and
precise authorization, exact executed command, raw result/server log/public
certificate and result audit. All 130 members are safe regular files;
129 inventory entries verify. No private key or compiled executable is included.

Archive SHA-256: `5625e12091f9db51f3a39fdbac9ee5b6b16fd7e4a1381b03d3f858a352b6c49c` (805391 bytes).
See the [manifest](manifest.json) and [component report](../../m2_h2_admission_live.md).

All13 admission cases plus idle shutdown pass in one owned Linux ReleaseSafe
TLS1.3/h2 run. Actual totals:22bodyheads/middleware,19beginattempts,18bindings,
16ends,2cancels,1failedbegin,384acceptedbytes,zeroactive/errors. Both cancellations
are body_too_large. Each Continue case has one100 beforepositiveDATA; six refused
primaries have413/503 emptybody followed by one rawNO_ERROR reset afterfinalEOS.
Every finalbody response retains the middleware header. Same-route recovery and
TWO simultaneous quota2 recoveries are asserted by the executed driver.

All32 records, including ten untouched spares, and finalmetrics match after
deinit. All76finalresponses end;54bufferedmiddleware+22bodymiddleware agree.
OwnedSIGTERM exits0/reaps/no force orretry; keyremoved. Raw observations cover
the stated barriers, not arbitraryfutureunreadframes or exceptionalcleanup.

Source is unchanged1031-file
`fc69e66f18d404aff19a0b018b81dd35c02ec2a46ed8f38670eb926c794f72de` from the
[native checkpoint](../m2_h2_native_tcp/README.md), with unchanged reviewedc223,
bindings/libraries and [pinned client](../m2_h2_client/README.md). The
[core upload](../m2_h2_core_live/README.md) and
[pause/control](../m2_h2_pause_control_live/README.md) results remain separate.
Exact original and corrected compiler argv/source/input/binary hashes are under
`evidence/fixture-*` and `evidence/fix1/fixture-*`. Runtime argv/environment are
in `evidence/fix1/stage-b-authorization.json`; that describes only this completed
run, not arbitrary future execution permission.

Initial source review passes protocol but requires two four-level branches to
be flattened. Both scoped re-reviews pass the helper extractions; the corrected
profile is newly compiled in Debug and ReleaseSafe, with only ReleaseSafe run.
No behavioralred is fabricated for the control-flow refactor. Pure checks and
compiler acceptance do not substitute for the separate native result.

All18 further planned H2 cases and the combined matrix remain required. H3,
multipart transport, genuine earlydata, fullquality/platform/compliance/physical
lifetime, maintained publication, production adoption and M2 remain open.
Fixed-capacity evidence is not RSS/leak/native safety proof. Stopped experiments
and denied socket cases were not resumed.
