# Combined HTTP/2 client core evidence

The [archive](combined-client-core.tar.gz) contains 2514 safe regular text members
and 2513 hashed inventory entries. SHA256:
`74c1f96d1334d7e87b8f0e5fbeacfd39539d44c16e7fa6cb7702371e1dba442a`
(562818 bytes). The [manifest](manifest.json) binds the current 26-file source,
all snapshot identities and separate verification scopes.

`source/current/` is reviewed v9. `history/snapshot-v8/` retains the 25-file
baseline and 40 successful normal/optimized commands; `history/snapshot-v9/`
retains the small-response fix, actual old-source RED and six current covering
commands. Earlier snapshots retain intermediate source and failure history.
The prior 40 outcomes are historical, not runs of amended `wire.py`.

`reference/` contains the immutable model, original helper, prior client,
42 pinned codec files with their licenses/provenance, and exact native source
used only to derive SETTINGS values. `evidence/` contains requirements,
source/fix diffs, reports, Root audits and independent source/fix reviews.

For offline pure checks, extract the archive and set `PYTHONPATH` to its
`reference/model`, `reference/packages` and `reference/helper` directories,
then run the desired script under `source/current/` with Python 3.14.2,
`-B -S`, and optionally `-O`. No install or network is required. The captured
commands bind the Codespace environment; second-machine validation is unrun.

The 100M request is an in-memory public-codec test with bounded retained data.
Final JSON and transport outcomes are synthetic. No native fixture, socket,
TLS context, build, process cleanup or actual combined 40-case execution is proved.
Full case schedules, runtime closure, two-child native acceptance, project
gates and source promotion remain required.
