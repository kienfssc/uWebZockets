# M2 common request-streaming contract

Status: implemented and verified common checkpoint, 2026-10-26. M2 remains
open: no live upload route, admission or transport is established here.

The [accepted typed design](../adr/0008-request-body-streaming.md) preserves
legacy Request/OwnedRequest and their buffered helper error sets. It adds a
distinct StreamingRequest metadata view, a flat owned metadata snapshot and
the pure body lifecycle/control contract. The rejected runtime-mode prototype
remains isolated; none of its Request/slab growth was integrated.

## Changes and ownership

StreamingRequest projects method, target, path, protocol, query, initial headers
and bounded primary/overflow captures without copying their arrays. There is
no raw body or legacy Request pointer. text/bytes are empty; fallible body
helpers return the closed BodyNotBuffered error before parsing, media checks,
allocation or issue mutation. Headers, query and capture lookup remain usable.

Its explicit clone copies metadata into owned byte/header/capture allocations.
The owned view derives its array slices after construction and remains valid
when the owner is returned by value. Checked size arithmetic and failure cleanup
cover all five allocations. No body, future payload, control, response or
transport pointer is copied. Clone is an explicitly allocating caller operation.

request_body.zig contains named sink callbacks, limits/progress, cancellation
reasons, generation-checked inline controls and pure lifecycle transitions.
It enforces accepted-prefix/readiness and terminal ownership; adapters still
must supply actual input, callbacks, quota, I/O and persistent metadata storage.
BodyRoute defaults to reject_legacy middleware policy. This checkpoint does
not implement that policy's route registration or admission behavior.

Release exports and the actual package fixture reference the new types. Both
unchanged narrow-return and exhaustive-catch consumers retain Request.form's
four original errors. The consumer's existing swallowed hello-write error now
uses the established best-effort response helper, following project conventions.

## Verification and review

[Raw evidence](evidence/m2_common/README.md) retains exact sources, patches,
commands, logs, numeric statuses, declaration probes and checksums. The run
uses dirty base cdd7ff7 plus the eight recorded source hashes, checked before
and after; it does not claim execution on a later clean commit.

- Final native suite: 781/781 tests, 22/22 steps.
- Canonical sanitizer suite: 781/781 tests, 22/22 steps.
- Production/examples build: 47/47 steps.
- ReleaseSafe, Windows GNU and macOS arm64 compile gates: 20/20 steps each.
- Actual package consumer: 16/16 steps; clean manifest-filtered package passes.
- Formatter, conventions, release metadata, docs and dependency checks pass.
- Eight metadata/compatibility tests and 21 pure lifecycle tests have retained
  focused results. Independent source/evidence review found no actionable issue.

Canonical integration formatting exposed a test-fixture naming conflict: Zig
normalizes a quoted JSON hook alias, after which the naming gate rejects it.
The final fixture instead uses an untagged-union parser canary. A direct parser
probe intentionally fails to instantiate that type, while the helper tests
pass without parsing. This proves parser non-instantiation, without claiming
direct custom-hook execution coverage. Original setup/naming failures remain
retained; no lint or assertion was weakened. Bounded independent review accepted
the replacement.

## Measured layout boundary

Actual before/after declaration probes cover Linux x86_64, Windows GNU x86_64,
macOS arm64 and macOS x86_64. CompileLog exits are intentional measurements.
Request stays 2752 bytes and OwnedRequest 2848 on all four. Existing TCP/H2/H3
owners, HeaderSet and default slab estimates remain unchanged.

| Target | Default TCP slab bytes |
| --- | ---: |
| Linux x86_64 | 684160640 |
| macOS arm64/x86_64 | 684078720 |
| Windows GNU x86_64 | 684660352 |

New actual types are StreamingRequest 208, OwnedStreamingRequest 176, BodyState
120, BodyControl 16 and BodyRoute 64 bytes, all alignment 8. These types are not
yet reserved per connection. Later optional adapter storage requires its own
measurements; these results do not approve future layout assertions.

Foreign compilation is not native runtime evidence. No throughput, official
host, global heap or real 100 MB upload claim follows from this checkpoint.
The next slice adds response-phase guards, followed by the first working H1
admission/ingress consumer. H2/H3, multipart integration, fuzzing and the full
upload matrix remain required before M2 closes.
