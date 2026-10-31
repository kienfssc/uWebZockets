# Combined HTTP/2 metadata and concurrent-route evidence

[combined-metadata-concurrency.tar.gz](combined-metadata-concurrency.tar.gz)
contains reviewed source for two additional combined-client schedules and their
pure in-memory codec evidence. The [manifest](manifest.json) records the archive
identity and all 23 current source hashes. `INVENTORY.json` binds every other
member's size and SHA-256; members are regular UTF-8 files with safe paths.

The archive includes current source, the pushed 20-module B5a baseline, both
B5b implementation handoffs, initial tests and failures, preceding and current
normal/optimized receipts, both cleanup snapshots, immutable source references,
source review and Root audits. The 30 baseline executions predate test-only
nesting cleanup; four subsequent executions cover the changed test and imports,
with 22 modules unchanged. These are distinct verification scopes.

The cases preserve exact J/C/R 6/6/32 and 13/13/96, five new body records,
metadata/overflow/helper contracts, route isolation and ordered refusal/reset
retirement. The supported source subset is 25/40; 15 selections still fail
before actions. Initial REDs are selection-only; direct header controls prove
test-oracle sensitivity. Supplied peer records are synthetic and do not execute
Zig helper implementations or prove native fixture behavior.

Reproduction uses the exact pinned Python, codec packages, helper and immutable
core/model recorded in the completion report. The archive includes source and
licenses, with no native binaries or cache. Full40/default/aggregate integration,
runtime ownership, native execution, project gates and production adoption are
unverified. See the [focused report](../../m2_h2_combined_metadata_concurrency.md).
