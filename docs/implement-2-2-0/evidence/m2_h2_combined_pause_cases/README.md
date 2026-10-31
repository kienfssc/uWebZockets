# Combined HTTP/2 pause/control evidence

The [archive](combined-pause-cases.tar.gz) contains 216 safe regular text
members and 215 hashed inventory entries. SHA256:
`67783e244c3d6ed7bcd1391a33025146e8aab5b81fa9f829fbd712cad4bc3ea6`
(341764 bytes). The [manifest](manifest.json) identifies all 14 current modules,
five changed/new files, nine unchanged B1 modules and 20 current passing
normal/optimized commands.

`source/current/` contains the eight-case client subset and tests.
`history/b1-source/` binds the comparison base. `history/b2/` preserves
selection RED, intermediate failures, earlier logs/snapshots and the final
`completion/` source and separate stdout/stderr/exit receipts. The selection
RED is not a serialized-schedule RED; older logs remain historical.

`reference/` contains the model, core, helper, 42 pinned codec files/licenses,
source-only family/fixture contracts and three recovered historical documents.
`evidence/` contains requirements, identity ruling, report, full source diff,
independent review, Root audits and source-recovery provenance. Native binaries
and private keys are absent.

For offline pure checks, extract and set `PYTHONPATH` to `reference/model`,
`reference/core`, `reference/packages`, `reference/helper` and `source/current`.
Run a selected `source/current/test_*.py` using Python 3.14.2 with `-B -S`
and optionally `-O`. No installation or network is needed. Second-machine
execution remains unrun.

These supplied synthetic peers establish client/codec behavior. Native
callbacks, FIFO, transport cleanup, full40/default acceptance, project gates
and production adoption remain required.
