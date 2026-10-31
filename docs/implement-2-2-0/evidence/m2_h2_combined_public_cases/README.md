# Combined HTTP/2 public-case evidence

The [archive](combined-public-cases.tar.gz) contains 424 safe regular text
members and 423 hashed inventory entries. SHA256:
`37a72f0947776024fdf752ca42b0fad9dbf56fc8cc3e950f294b6f4bba3d3836`
(326274 bytes). The [manifest](manifest.json) binds the 12 current source files
and exact verification scopes.

`source/current/` contains the reviewed adapter, four schedules and tests.
`history/` preserves completion snapshots/raw outcomes, the recovered initial
source and the final nesting correction. The 20 baseline command outcomes
precede that correction; four current shared-state/import outcomes cover it.
Eleven modules are unchanged. The lost original 14 unpublished receipts are
not included or counted as current proof.

`reference/` contains the unchanged five-module core, six-file model, original
helper, 42 pinned codec files with licenses, and source-only family/fixture
contracts. `evidence/` contains requirements, full source/fix diffs, reports,
Root audits and independent reviews. No native binary or private key is included.

For offline pure checks, extract the archive and set `PYTHONPATH` to its
`reference/model`, `reference/core`, `reference/packages`, `reference/helper`
and `source/current` directories. Run a selected `source/current/test_*.py`
with Python 3.14.2, `-B -S` and optionally `-O`. No install or network is needed.
The captured commands bind the Codespace environment; second-machine execution
remains unrun.

Synthetic application data and codecs do not prove native fixture behavior,
transport cleanup, performance or the combined 40-case run. The other 36
schedules, aggregate integration, runtime closure, native acceptance and full
project gates remain required.
