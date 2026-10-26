# M1: streaming, static assets, and TLS payload closure

Status: in progress, 2026-10-26. M0 is complete.

The first implementation slice has passed 663/663 native Debug tests and
independent local re-review. Sanitizer, ReleaseSafe, cross-target, real TLS
saturation, and the remaining M1 features still require verification or work.

## Scope

Extend the shipped response-streaming and static-file surfaces without
redesigning their public APIs or increasing fixed queue capacities. Preserve
plaintext sendfile, exact representation metadata, bodyless responses, and
bounded memory on every supported transport. The ordered architecture and
ownership are recorded in [architecture.md](architecture.md).

## M1-1: response streaming

The first slice covers premature producer completion and completion ownership:

- Regressions must first prove that `.done` without successful `end_chunks`
  fails to close or reset the response.
- HTTP/1 uses its existing connection-abort path; HTTP/2 resets the affected
  stream while preserving siblings; HTTP/3 uses its existing producer-failure
  path, returning 500 before headers or closing an already-started stream.
- Once `end_chunks` succeeds, even a subsequent `.pending` return must disarm
  the producer so terminal framing cannot be emitted twice.
- The producer callback, context, and transport-owned completion state must
  clear once without hot-path allocation or locking.

The first slice is implemented in `src/core/tcp.zig` and
`src/quic/stream.zig`, with seven regressions in the existing HTTP/1, HTTP/2,
and HTTP/3 suites. The canonical [RED run](evidence/m1_a/red.log) exits 1:
648/654 tests pass and six assertions expose the original completion defects.
The [GREEN run](evidence/m1_a/green.log) exits 0 with 654/654 tests and 22/22
build steps passing in Debug. Both runs used:

```sh
ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache \
  /tmp/zig-x86_64-linux-0.16.0/zig build test --summary all
```

The initial sandboxed RED attempt stalled in the existing loopback client
helper after its listener could not start. A
[symbolic stack](evidence/m1_a/red_sandbox_stack.log) located the wait in
`client_tests.PortSlot.wait`; the identified process was stopped and the
unchanged tests rerun outside the sandbox. The
[sandbox log](evidence/m1_a/red_sandbox.log) is retained. No timeout, test, or
assertion was relaxed.

The [source snapshot](evidence/m1_a/source.diff) records the tested slice.
Its new branches only inspect callback completion and use existing close/reset
paths. They add no allocator, lock, retained chunk slice, public API, or queue
capacity. The producer context is cleared through existing teardown ownership.
The contract is documented in [HTTP](../http.md#response-producer-backpressure)
and linked from [the API guide](../api.md#response).

## First-slice verification

- [Formatting](evidence/m1_a/format.log),
  [conventions](evidence/m1_a/conventions.log),
  [release metadata](evidence/m1_a/release_version.log), and
  [documentation links](evidence/m1_a/docs.log): passed.
- [Dependency provenance](evidence/m1_a/dependencies.log): passed; pins unchanged.
- [Graph refresh](evidence/m1_a/graphify.log): completed after source edits.
  The same extractor limitations recorded in M0 remain visible.
- [Initial ASan/UBSan build](evidence/m1_a/sanitizer_initial_interrupted.log)
  and [ReleaseSafe compilation](evidence/m1_a/release_safe_initial_interrupted.log)
  were deliberately stopped, both exit 143, before applying the required review
  fix below. Neither result is passing verification. Compiler caches remain
  available for the corrected snapshot. Nix is absent; the sanitizer attempt
  used the supported `-Dsanitizer-lib-dir` option with the installed LLVM 18
  runtime, `-Dsanitize=true`, and `-Doptimize=ReleaseSafe`. The later Nix-wrapped
  release matrix is also still required.
- Independent local correctness and completion-ordering review first found a
  saturation-isolation defect: if fewer than 13 bytes remain in the HTTP/2
  output ring, its reset cannot be queued and the existing abort helper closes
  the whole connection. The first-slice tests do not cover this condition.
  The bounded control-frame fix and its regressions are recorded below.

The revised architecture assigns deferred reset intents to the HTTP/2 session,
using a FIFO bounded by its existing stream capacity. It stores stream IDs and
error codes independently of recycled stream slots, retries before response
HEADERS/DATA, and releases stream-owned state once when the intent is accepted.
Queue exhaustion remains an explicit error; ordinary output backpressure
retains the intent. No wire-encoding policy moves into TCP and no queue grows.
The correction is implemented in `src/http2/server.zig`. Seven additional
regressions first failed against the previous code (654/661 passing), then the
full Debug suite passed at 661/661 with 22/22 build steps, exit 0. It covers
plain atomic-writer pressure; real TLS ciphertext saturation is still required
by the transport matrix.
The FIFO adds 80 inline bytes per default connection, or 81,920 bytes over
1,024 connections. The exact slab-size test retains equality assertions and
now checks the default total at compile time too, so cross-target compilation
can verify platform layout. Native POSIX total: 683,464,320 bytes. The Windows
expectation is 683,890,304 and still awaits its target compile check.
The wire contract follows [RFC 9113 stream-error handling](https://www.rfc-editor.org/rfc/rfc9113.html#section-5.4.2)
and the [RST_STREAM frame definition](https://www.rfc-editor.org/rfc/rfc9113.html#section-6.4):
the reset identifies the affected stream and carries its four-byte error code.
The FIFO is a local bounded scheduling decision; it does not change that frame.

A second independent review found a duplicate-abort case: a producer can
already reset its stream through `end_best_effort`, then return `.done` with
its local response still marked streaming. The completion check aborts again,
and treating `StreamClosed` as fatal closes healthy siblings. An idempotent
transport-abort guard and immediate/pressured sibling regressions resolve it.
The guard preserves the session's public `StreamClosed` refusal. The
[RED run](evidence/m1_a/abort_red.log) exits 1 with 661/663 passing; the
[final GREEN run](evidence/m1_a/abort_green.log) exits 0 with 663/663 passing
and 22/22 successful build steps. Independent re-review found no remaining
actionable issues in this slice. The queue snapshot's ASan, ReleaseSafe, and Windows compile builds
were stopped for this correction, all exit 143; their raw logs are retained as
`sanitizer_queue_interrupted.log`, `release_safe_queue_interrupted.log`, and
`windows_queue_interrupted.log`. They are not passing gate evidence.

The [final source delta](evidence/m1_a/final_source.diff) records this reviewed
checkpoint against `7e50eb1210590c270ba47b1a446c6b55770bba2a`.
Sanitizer, ReleaseSafe, and target compilation will restart against the saved
checkpoint; those gates remain open. All implementation stays on the original
repository's `feat/implement-2-2-0` branch. Per the user's request, commits are
to be pushed individually; the current GitHub account still lacks write access.

The full M1 milestone is not closed by this first slice.

### Canonical verification environment

The official Nix 2.31.6 binary archive was verified against SHA-256
`34fe86212dbca0854f687c868e95602067d297a09acfe6447f7cddf1735717b2`
and [installed](evidence/environment/nix_install.log) without a daemon,
channels, or shell-profile edits.

The first canonical [sanitizer attempt](evidence/m1_a/nix_sanitizer.log)
exited 1 during flake evaluation, before compilation: the nested zon2nix
compiler URL at `git.jcollie.dev` returned HTTP 403. A direct git fetch
reproduced it. The maintainer's existing GitHub mirror resolves to the same
full commit `1a73bc5e8ae4d0223fefbd00afc58fe0b7f7e718` and
[identical NAR hash](evidence/environment/nix_zig_mirror.json),
`sha256-fjtjxWEofW5cbzXm3SqvjC2QZIbtp3lij2k8e1Jmj0w=`.

`flake.nix` now overrides only that URL and explicitly retains the original
`zon2nix/nixpkgs` follows relationship. The
[regenerated lock](evidence/environment/nix_lock_repair.log) preserves every
other node, nested relationship, commit, hash, timestamp, and revision count.
All four zon views remain unchanged. Independent build/vendor review found
no issues, and [frozen-lock shell evaluation](evidence/environment/nix_shell_evaluation.log)
passed. Actual shell construction, `zig version`, and sanitizer execution
still require their runtime results. The library remains on Zig 0.16.0;
Zig 0.17.0 was already used only to build the existing generator tool.

### Remaining M1-1 acceptance

- HTTP/1, real TLS, HTTP/2, and HTTP/3 matrix with logical 1-byte, 16 KiB, and
  64 KiB emissions, including pending/drain progress.
- Framed transport close/reset and once-only cleanup proof.
- Empty writes and HEAD/204/304 rejection coverage.
- Sanitizer gate, independent local review, and transport-matrix allocation
  and caller-buffer lifetime audit.

## M1-2: large static files and sidecars

Not implemented yet. Required: per-transfer bounded file lifetime and exact
length framing for TLS/HTTP/2/HTTP/3; files larger than the existing buffer;
validators, HEAD, ranges and If-Range; pure quality-aware Accept-Encoding;
fresh `.gz`/`.br` sidecars with representation-specific validators and Vary;
confinement and missing/stale-sidecar coverage; external static profile
artifacts; dated kTLS and measured splice decisions.

## M1-3: 100 KiB TLS echo

Not implemented yet. Required: real TLS loopback with exact bytes, at least
seven application-data records, unchanged record/queue limits, plaintext
control, caller-buffer and allocation audit, and external `8gbit` evidence or
the plan's explicit dated re-declaration.

M1 remains open until every original checklist item has implementation and
matching evidence, or the original plan expressly permits a documented
re-declaration. The user's instruction keeps work in the original repository's
feature branch for later manual review; no fork or PR workflow is required.
