# HTTP/2 output driver: reviewed source and pure preparation

[output-driver.tar.gz](output-driver.tar.gz) contains 608 safe regular text
members and a 607-entry byte/SHA256 inventory. SHA256:
`6ebc819a8407f43b8b9aafd26b0fe5c52f4345c43e30b32584f8eb896d4544dd`
(5538265 bytes). [manifest.json](manifest.json) records current identities,
checks, review scope and remaining work.

- `source/driver/`: 49 current authored files: 19 runtime modules, 26 focused
  scripts and four preparation tools. The current tools are `freeze_fix1.py`
  and `check_closure_fix1.py`; earlier tools retain historical provenance.
- `source/runtime/`: the exact 19-file v5 runtime, separately frozen read-only.
- `source/client/`, `source/fixture/`, `source/codecs/`: 12 reviewed client files,
  five current fixture files and 42 pinned pure codec files including licenses.
- `provenance/`: all five runtime input manifests and codec package records.
  Version 1 originally used unversioned temporary paths; versions 2–5 used
  their explicit suffixes. Only v5 is current.
- `history/`: the initial 45-file review subject, four superseded runtime
  snapshots and the actual five-file fixture compilation snapshot.
- `builds/`: unchanged controlled Debug/ReleaseSafe receipts and compiler logs.
  The current fixture's three Zig files and helper match the compiled snapshot;
  its later test rewrite is recorded separately.
- `evidence/`: requirements, reports, review findings/fix, original failure and
  success logs, mutation results and Root audits. Binaries, caches and private
  keys are excluded.

Current runtime manifest SHA256:
`aab3dda65e16b0475ccb59de28028a2d324ee81c7c05dc6c48daf909f6ae9890`.
Its 2,413 direct inputs and ten trees bind the actual driver, interpreter,
loader/tool inputs, SDK, 1,031-file candidate, 93-file override, codecs, helper,
current fixture, separate compiled fixture and both existing binaries. Root
independently hashed those actual inputs. Current runtime files match the owned
source; all 49 authored files have no class or Python assertion statements.

The initial preparation recorded 24 scripts passing in each Python mode. After
review, nine covering scripts passed normal and optimized with `-B -S`. Root
ran allocation, SETTINGS serialization and final collection checks against
frozen v5 modules, verifying six module origins. Those checks passed. The actual
owned `records.py` mutation was rejected, original bytes and mode restored, and
the closure accepted again in both modes. Old failed snapshots and raw results
remain clearly historical.

Independent review closed the wrong reuse-stream expectation and nonrepresentative
test SETTINGS payload. The new allocation regression reaches B's real upload
through both diagnostic requests and then deliberately stops; it is not a full
reuse run. The SETTINGS difference was a coverage defect, with no inferred native
failure. Specification and quality review pass for source/preparation only.

See the [compiled fixture checkpoint](../m2_h2_output_fixture/README.md) for its
original source and compiler history. Neither existing binary was executed or
recompiled by this driver task. Its host-operation tests use doubles; its H2
tests use public in-memory codecs. No certificate or transfer file was created,
and no socket or SSLContext was constructed. Exact-current returned-error
ownership execution remains distinct from the preserved historical M1 tests
and current source review.

Native coverage remains 35 case IDs. A separately released ordinary five-case
attempt, the actual combined 40-case run, full quality/platform/fuzz/package
gates and production adoption remain required.
