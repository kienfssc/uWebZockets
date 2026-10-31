# Combined HTTP/2 credit evidence

The [archive](combined-credit-cases.tar.gz) contains 301 safe regular text
members and 300 hashed inventory entries. SHA256:
`0a16510d61f7803aecf5aca15d92bccf70b139ac919a216a74ad3410dbddf716`
(349472 bytes). The [manifest](manifest.json) binds 20 current modules,
eight changed/new files and 12 unchanged B4 modules.

`source/current/` contains the reviewed 23-case subset. `history/b4-source/`
binds its comparison base. `history/b5a/` preserves initial test/selection RED,
intermediate outcomes, 28 passing baseline commands and their snapshot.
Its `completion/` contains the description-only correction, current snapshot
and two passing normal/optimized import checks. Nineteen modules are unchanged;
the preceding 28 commands are not relabeled current-source executions.

`reference/` preserves model/core/helper, 42 pinned codec files/licenses and
source-only fixture/family contracts. `evidence/` contains original and narrowed
requirements, the earlier incomplete parent handoff, report, complete diffs,
independent review and Root audits. No native binary or private key is included.

For offline pure checks, extract and set `PYTHONPATH` to `reference/model`,
`reference/core`, `reference/packages`, `reference/helper` and `source/current`.
Run a selected `source/current/test_*.py` with Python 3.14.2, `-B -S`, optionally
`-O`. No installation or network is needed. Second-machine execution is unrun.

Supplied model-derived peers establish client/codec behavior. Native fixture,
timeout, runtime ownership, full40/default acceptance, project gates and source
adoption remain required. Missing-stream-refund sensitivity is finite synthetic
input exhaustion, not native server-fault proof.
