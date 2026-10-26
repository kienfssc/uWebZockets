# M1: HTTP/2 bounded file responses

Status: implemented and independently reviewed, 2026-10-26. Native proof
passes; combined sanitizer, target, and protocol gates follow HTTP/3 integration.

The HTTP/2 target arms one FileTransfer per existing stream slot. Session owns
known-length HEADERS/framing; TCP owns file I/O and descriptor lifetime. Slot
stream IDs protect reused transfers, and connection close sweeps owners.
Every returned error retains the caller's file; post-accept faults use teardown.
HEAD/empty close without reads. Bodyless statuses, successful CONNECT, occupied
slots, invalid ranges, and unsupported body capacity refuse before ownership.

Reads are bounded by scratch, frame, output, and both flow-control windows.
Completion precedes credit checks, so a final byte exhausting the window can
still send END_STREAM. File-only batching leaves a genuine drain opportunity
when pending; zero credit waits for WINDOW_UPDATE. Accepted bytes are copied,
allowing interleaved files to share worker-local scratch. No allocation, lock,
queue growth, or window increase is added.

## Regression evidence

The first [RED](evidence/m1_d_http2/red.log.gz) passes the existing 694 cases
and fails the new backend call with FileStreamingUnsupported. Eleven new
regressions cover exact bytes/Content-Length, tiny/final window credit, scratch
poisoning, refusals, HEAD/empty, EOF/truncation, reset/close/reuse, completion
logs, and actual TLS pressure. [Final GREEN](evidence/m1_d_http2/green.log.gz)
passes 705/705 tests and 22/22 steps, exit 0. Focused GREEN passes 11/11.

The TLS case holds ciphertext output with exactly 140 bytes free. A one-byte
DATA reservation can fit, but the TLS reset reservation needs 141. A failed
file retains its reset while the healthy producer stays active. The decoder
allows the already-queued healthy prefix, then requires reset before any new
healthy DATA. It checks one reset, exact 100 KiB healthy bytes, and END_STREAM.

That connection then streams a successful 100 KiB owned file through 8 KiB
scratch and completes an ordinary /health HEAD. The latter proves connection
reuse; file-HEAD semantics have separate connected-session coverage. The
supplied slab allocator observes one startup allocation/no resize, excluding
internal TLS allocator activity.

## Independent corrections

Review found HEAD/empty completion logging was skipped. A pre-terminal request
snapshot now logs once after acceptance. A real bounded Sink test first fails
with the missing HEAD line in [logging RED](evidence/m1_d_http2/logging_red.log.gz),
then checks method/path/status and no duplicate, refused, reset, or fault logs.

The initial TLS assertion only placed reset before END_STREAM. Preserving the
accepted pressure prefix and requiring reset-before-new-DATA closes that gap.
Bounded re-review found no remaining actionable ownership, flow-control,
cleanup, or structural findings.

## Capacity and remaining gates

Eight transfers and stream IDs add 608 bytes/connection on measured Linux/Mac
targets and 672 on Windows. Exact default totals: Linux 684,160,640; both Mac
architectures 684,078,720; Windows 684,660,352. Strict compile-time/runtime
equalities remain. Intentional compileLog probes measure layouts and do not
establish full target gates.

Formatting, conventions, release metadata, documentation, dependency checks,
and graph refresh pass. [The source record](evidence/m1_d_http2/source_manifest.json)
binds the snapshot, commands, and counts. Earlier immutable 9ac0566 sanitizer
and platform results verify only the predecessor. Repeat combined gates after
the reviewed HTTP/3 backend is integrated.
