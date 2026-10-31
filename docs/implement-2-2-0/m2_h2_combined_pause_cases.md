# Combined HTTP/2 pause and control schedules

The combined client now implements `partial_pause`, `final_pause`,
`begin_pause_empty` and `control_rules` alongside the four
[public and large upload schedules](m2_h2_combined_public_cases.md).
Eight source schedules are reviewed; the remaining 32 selections fail before
actions. Full default/aggregate and native combined acceptance remain open.

The [evidence archive](evidence/m2_h2_combined_pause_cases/README.md) preserves
all 14 current Python modules, B1 source for comparison, earlier B2 snapshots,
raw outcomes, immutable model/core/codec/fixture inputs and independent review.
The [manifest](evidence/m2_h2_combined_pause_cases/manifest.json) binds every
current source hash and the exact new per-case counts:

| Case | Request heads | Small responses | Request DATA bytes |
| --- | ---: | ---: | ---: |
| partial_pause | 7 | 7 | 12289 |
| final_pause | 6 | 6 | 32 |
| begin_pause_empty | 6 | 6 | 0 |
| control_rules | 20 | 20 | 64 |

Partial pause preserves the accepted-seven-byte record after queued EOF,
then resumes to completion. Final pause holds all 32 accepted bytes until
resume. Begin pause sends empty DATA with END while keeping chunk/end callbacks
pending. The control sequence checks callback/terminal diagnostics,
`BodyNotPaused`, expired controls and unchanged records. Held-stage release
follows resume serialization, preserving legitimate response ordering.

The immutable pause status schema exposes a tag. Its control route resolves
that tag to the server's private retained token; it exposes no token generation.
The client validates the observed tag and stale-control isolation. A wrong-tag
negative rejects before control serialization; another rejects premature
completion. Producer-binding generation proof remains a later requirement.

All 20 current focused commands pass in normal and optimized Python with
empty stderr. They check exact DATA size/END ordinals, header multiplicity,
payload digests, request order, shared application state across fresh
connections, final collection, unsupported selections and inert imports/AST
rules for all 14 modules. Existing large-upload and carried-debt regressions
also pass. The retained pre-change RED proves unsupported-selection rejection;
it is not a pre-change serialized-schedule failure. Earlier aggregate logs
are preserved as history. Independent source/spec/quality and structural
review finds no actionable findings.

Recovery provenance also authenticates the 1031-file frozen server source and
93-file local dependency override against their prior hashes. The archive
preserves recovery maps and three historical documentation inputs. Dependency
pins stay unchanged; compiled binaries were not restored or executed.

Peer records and time are synthetic caller input. Native FIFO/callbacks,
live fixture behavior, transport/process ownership, performance, full project
gates and source adoption remain unproved. The other 32 schedules and the
actual sequential two-child combined run remain required. Release metadata
stays 2.1.6; this checkpoint does not close M2.
