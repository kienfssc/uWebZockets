# Combined HTTP/2 admission evidence

The [archive](combined-admission-cases.tar.gz) contains 224 safe regular text
members and 223 hashed inventory entries. SHA256:
`fd470a0a0a580f919e055b78a712c9255ff580a13aa870c66ce74a995d32585b`
(286597 bytes). The [manifest](manifest.json) identifies 16 current modules,
six changed/new files, ten unchanged B2 modules and 24 current passing
normal/optimized commands.

`source/current/` contains the reviewed 17-case client subset and tests.
`history/b2-source/` binds the comparison base. `history/b3/` contains the
selection RED, current snapshot/hash comparison and distinct stdout/stderr/exit
receipts. The initial RED test source and a separate intermediate-failure
receipt are unavailable; no serialized pre-change RED is claimed.

`reference/` contains the unchanged model/core/helper, 42 pinned codec files
with licenses, and source-only fixture/family contracts. `evidence/` contains
requirements, report, full source diff, independent review and Root audits.
No native binary or private key is included.

For offline pure checks, extract and set `PYTHONPATH` to `reference/model`,
`reference/core`, `reference/packages`, `reference/helper` and `source/current`.
Run a selected `source/current/test_*.py` using Python 3.14.2 with `-B -S`
and optionally `-O`. No installation or network is needed. Second-machine
execution remains unrun.

Synthetic peer input establishes client/codec handling only. Native fixture,
callbacks, runtime ownership, full40/default acceptance, project gates and
production adoption remain required.
