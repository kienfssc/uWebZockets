# Pure HTTP/1 admission checkpoint

The [archive](h1-admission-checkpoint.tar.gz) contains five source replacements
or additions, the scoped plan, seed hashes and raw v1/v2 evidence. Restore the
prepared App source from the [earlier recovery archive](../m2_transport_preparation/README.md),
with repository metadata at its recorded baseline, then apply overlay/ as
described in SCOPE.md. All other archived source bytes match. The dedicated
test-support facade is verification-only; ordinary central support also reaches
the new helper.

SHA256: `6462b593737078902d5c967b7a1ce3ea4b57300a2011e9912576f531b16466c9`
(24,263 bytes). Packaging verified 45 safe regular members and 44 inventory
entries. The [manifest](manifest.json) binds every file. A byte scan found no
matching environment credential values or GitHub token patterns.

Seven cases pass in all three native optimization modes and actual Linux32
ReleaseSafe. A filtered central-root run verifies test wiring. Formatting,
conventions and the restored-metadata version check pass. The declaration-only
red and initial missing-metadata failure are retained separately.

The [report](../../m2_h1_admission.md) distinguishes this pure helper from the
missing live driver and records its review and integration requirements.
The [subsequent independent review](independent-review.json) checks this exact
archive and finds no actionable findings in the helper. Actual transport
consumption, retirement and combined integration remain open.
