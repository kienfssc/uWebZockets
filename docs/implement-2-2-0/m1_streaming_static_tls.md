# M1: streaming, static assets, and TLS payload closure

Status: implementation and local verification complete, 2026-10-26.
Official static/8gbit performance claims remain explicitly re-declared with
source evidence, owners, and restoration criteria.

Bounded file delivery, fresh sidecars, selected metadata/ranges, response
backpressure, and true 100 KiB TLS echo are implemented and reviewed. The
final native/sanitizer suites pass 752/752; five exact 100 MiB client bodies,
real decoding, protocol gates, portability compilation, fuzz, MSan C-boundary,
and clean package checks are archived below. This is not a release,
foreign-runtime, official-profile, or global-allocation claim. Earlier sections
retain the individual checkpoint history; the closure table records final scope.

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
  available for the corrected snapshot. Nix was absent at that attempt, which
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
were subsequently verified at the immutable checkpoint; its
[retained results](evidence/m1_a/frozen_verification/README.md) pass 663/663
sanitizer tests, 47/47 native ReleaseSafe default build steps, and 33/33 h1spec
tests. Later-source sanitizer and target results remain open. The library
remains on Zig 0.16.0;
Zig 0.17.0 was already used only to build the existing generator tool.

### Remaining M1-1 acceptance

The [response matrix report](m1_response_matrix.md) records slice B at
`105348524d9caa65d93cf9aa3c44b0ffafda1b07`: logical 1-byte, 16 KiB, and 64 KiB
emissions on HTTP/1, real TLS BIOs, HTTP/2, and HTTP/3, including pending/drain,
empty writes, bodyless refusal, source poisoning, fixed storage, and framed
completion. Slice A retains close/reset and once-only cleanup coverage.

The combined file-backend checkpoint and final static selection pass sanitizer
and target compilation as recorded in the closure archive below. Literal
TLS saturation and the 100 KiB record proof are under M1-3. The
[HTTP/2 file backend](m1_file_http2.md) records pending reset isolation and a
healthy sibling through real TLS write backpressure.

## M1-2: large static files and sidecars

The pure negotiation slice is implemented and independently reviewed under
[ADR 0009](../adr/0009-static-content-coding.md). It exposes named coding and
availability types plus `negotiate.select_encoding`, scans the full bounded
header with constant scalar storage, and preserves late refusals. Duplicate
codings use minimum quality; known codings with malformed weights are refused.
No file I/O, allocation, lock, or retained borrowed slice is added.

Two regressions reproduced the shared qvalue parser's incorrect fractional
bounds: both failed before the fix and passed afterward. The new helper's
focused suite passes 8/8 tests. The exact commands and raw results are under
[negotiation evidence](evidence/m1_e/README.md). Smith and LLVM query/negotiation
coverage now exercise availability and the invariant that later bytes cannot
erase an explicit refusal. The combined native suite passes 678/678, LLVM smoke
passes all 11 build steps, and the requested 100K fuzz run completes 103,733
executions with exit 0. The [package consumer](evidence/m1_e/package.log) passes
16/16 ReleaseSafe build steps. Current-source sanitizer results remain open.
That negotiation-only checkpoint precedes the later static integration below.

The [bounded file-streaming report](m1_file_streaming.md) records the first
HTTP/1 plaintext/TLS slice, ownership tests, and target-layout correction.
The [HTTP/2 backend](m1_file_http2.md) adds real TLS reset/healthy-sibling
pressure proof and passes 705/705 native tests after review corrections.
The earlier H1 slice passes 694/694 tests and macOS arm64 compilation. Its immutable
9ac0566 checkpoint also passes Nix sanitizers with 694/694 tests and
ReleaseSafe/Windows/macOS compilation. The final combined archive below
supersedes those earlier verification limits.

The [HTTP/3 backend](m1_file_http3.md) is integrated after independent review;
the combined native suite passes 713/713. Its immutable ee4bf1c checkpoint also
passes sanitizers with 713/713 tests, native/Windows/macOS compilation, the
47-step default build, and the pinned ordinary HTTP/3 compliance gate. These
predate static selection and do not establish live static delivery.

[Basic static integration](m1_static_streaming.md) passes 730/730 native tests,
including exact 100 MiB TLS HTTP/1 and HTTP/2 downloads, metadata, and ranges.
[Opt-in sidecars](m1_static_sidecars.md) now add complete-field selection,
coding-specific validators, encoded ranges, Vary, and freshness/confinement
coverage, with 752/752 native tests. The [full live client matrix](m1_static_interop.md) and
[final checkpoint gates](evidence/m1_final/README.md) now close local acceptance.
Official static-profile claims remain dated and re-declared below. The kTLS
and conditional splice boundaries are below and in the roadmap.

## M1-3: 100 KiB TLS echo

[The socket-response report](m1_tls_payload.md) records exact 100 KiB TLS and
plaintext delivery, at least seven decrypted application records, unchanged
record/queue limits, real pressure, source poisoning, and scoped allocator
proof. Its final 681/681 native suite and independent re-review pass.

[The true POST echo report](m1_tls_echo.md) now records exact received bytes,
fixed-length and chunked intake, keep-alive/pipelining, refusal boundaries,
measured explicit intake storage, and the final 684/684 native suite. The
default-cap probe justifies the plan's capacity exception; library defaults,
write queue, and TLS record limits do not change. Request/body lifetime is
documented and independently reviewed.

Official 8gbit evidence is re-declared on 2026-10-26 with
[immutable source evidence and restoration steps](evidence/httparena/README.md).
The generated GET test remains separately labeled as response proof. The
[dated roadmap](../roadmap.md) also records the
reviewed kTLS boundary and conditional splice decision.

M1 closure requires each original checklist item to have matching implementation
and evidence, or a documented re-declaration permitted by the original plan.
The final closure record below supplies that mapping. The user's instruction keeps work in the original repository's
feature branch for later manual review; no fork or PR workflow is required.


## M1 closure, 2026-10-26

Implementation and local verification are complete. External performance
claims remain explicitly re-declared under the plan's dated-limit policy;
this does not establish official benchmark activation or release readiness.

| Requirement | Result and evidence |
| --- | --- |
| S-1 response transport matrix | Existing API preserved; 1-byte/16 KiB/64 KiB emissions, pending/drain, fail-closed completion, reset/cleanup and bodyless cases; real TLS H2 reset/sibling pressure in the file backend |
| S-3/S-4 large static delivery | Bounded owned file transfers on H1/TLS/H2/H3; sidecar freshness/confinement, selected validators/ranges, complete-field coding and WOFF2 MIME; [slice reports](m1_static_sidecars.md) |
| Live file/sidecar matrix | Five exact 100 MiB client bodies across plain H1, TLS H1/H2, and H3 curl/aioquic; 84 small checks, real gzip/Brotli decoding, H3 sibling/reuse and clean owned teardown; [raw proof](m1_static_interop.md) |
| S-5 TLS echo | True fixed/chunked POST input echoed exactly through the producer, 100 KiB/multi-record/output-pressure and scoped allocation tests; [echo report](m1_tls_echo.md) |
| Required gates | Current db92019 native/SAN 752/752 and ReleaseSafe/Windows/macOS compilation; broad b2d2acb build, ReleaseFast, fuzz, LLVM, MSan, package and protocol gates; [checkpoint archive](evidence/m1_final/README.md) |
| Official static profiles | Re-declared 2026-10-26, reassess 2026-11-02; immutable contracts, adapter/ALPN gaps, public recipe and required authorized saved-host runs retained in [the external record](evidence/httparena_static/README.md) |
| Official 8gbit profile | Existing dated exception remains; [adapter/pin/access evidence and restoration](evidence/httparena/README.md), without a performance claim |
| kTLS and splice | kTLS stays at the accepted SB-31 boundary; splice stays conditional on a repeatable designated-host benefit probe. No key-handoff integration, splice measurement, or measured-not-needed claim is invented; [dated roadmap](../roadmap.md) |

The final gate archive records b2d2acb's 47-step default build, 752-test
ASan/UBSan suite, 20-step native ReleaseSafe/ReleaseFast and foreign compilation,
103,624 fuzz executions, 12-step LLVM object checks, 11-step smoke, 16-step
MSan C-boundary smoke, 16-step public consumer and clean package filtering.
h1spec passes 33/33; pinned ordinary HTTP/3 passes malformed/healthy-sibling,
QPACK and 300-rejection checks; Autobahn matches 517 cases (514 OK and 3
informational in both columns). The db92019 polish repeats sanitizers with
752/752 and ReleaseSafe/Windows/macOS compilation. All exit zero, with distinct
raw setup failures and intentional negative-case warnings preserved.

Independent source and artifact reviews find no remaining actionable M1 issue.
The final archives bind exact commits and scopes; foreign compilation is not
runtime support, MSan is not Zig instrumentation, and correctness is not an
official throughput/global-allocation claim. Default body/queue/record limits
and dependency pins remain bounded as documented. M2 can now proceed through
its compatibility revision and request/multipart implementation; M3 and the
remaining release milestones retain their own open requirements.

## TLS closure follow-up, 2026-10-27

The M2 TLS audit identified an inherited close-notify retry gap: shutdown is
marked started before SSL_shutdown, and WANT_WRITE is not retried after output
progress. A successful response under BIO pressure can therefore close without
an authenticated TLS EOF. The [source-bound driver checkpoint](m2_tls_driver.md)
retains the finding; a separate correction is being reviewed. This local closure
follow-up is open until the correction and strict owned TLS client evidence pass.
Earlier body/hash/benchmark results remain historical evidence with their original
scope; they do not establish this missing shutdown behavior.
