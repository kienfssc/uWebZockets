# Combined HTTP/2 Continue/quota evidence

The [archive](combined-continue-quota.tar.gz) contains 300 safe regular text
members and 299 hashed inventory entries. SHA256:
`7ecbe95a2bc9b33d1015a907b4b0241dd6398fe26974aae5952ec15a6596d639`
(328283 bytes). The [manifest](manifest.json) binds all 18 current modules,
seven changed/new files and 11 unchanged B3 modules.

`source/current/` contains the reviewed 21-case subset. `history/b3-source/`
binds the comparison base. `history/b4/` preserves the initial selection-only
RED/test source, intermediate failures, the 26-command baseline and its
snapshot. Its `completion/` retains the later constant deletion, current
snapshot and four covering normal/optimized Continue/import outcomes.
Seventeen modules are unchanged; the earlier 26 are not relabeled current runs.

`reference/` contains the unchanged model/core/helper, 42 pinned codec files
and licenses, and source-only fixture/family contracts. `evidence/` contains
requirements, complete source diffs, report, independent review and Root
audits. The report retains editing-invocation and graphify-order deviations;
current binary identity does not retrospectively verify historical commands.
No native binary or private key is included.

For offline pure checks, extract and set `PYTHONPATH` to `reference/model`,
`reference/core`, `reference/packages`, `reference/helper` and `source/current`.
Run a selected `source/current/test_*.py` using Python 3.14.2 with `-B -S`
and optionally `-O`. No installation or network is needed. Second-machine
execution remains unrun.

Synthetic peers prove client/codec handling only. Native fixture/runtime,
full40/default behavior, project gates and source adoption remain required.
