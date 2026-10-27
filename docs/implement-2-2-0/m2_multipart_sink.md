# M2 multipart part-sink adapter

Status: standalone adapter implemented and verified, 2026-10-27. This is a
standalone adapter checkpoint, not live request streaming or closure of M2.

`multipart.MultipartSink` connects the pure incremental parser to named
`PartSink` callbacks and returns the common `BodyProgress` contract. It validates
payload acknowledgement before advancing the parser. Framing bytes already
accepted before a pause remain included in outer progress. Begin and end events
commit once, including when paused; callers reoffer only the unaccepted suffix.

A successful begin owns one active part. A failed begin owns its own cleanup;
end takes cleanup ownership before calling the application. A consume error
retains active-part cleanup for outer cancellation after callback unwinding.
Finish owns cleanup on failure, and cancellation is terminal and idempotent.
An ended part receives no subsequent cancel callback. Outer terminal cleanup
must stop work retained by a paused end before releasing the upload or context.

The 95-line adapter has no file or transport I/O. Its context, parser working
buffers, and callbacks belong to the application; it supplies no file policy
or automatic HTTP status. The existing buffered multipart implementation's
7,900-byte prefix remains unchanged. Request, routing, transport slabs, and
default body limits are unchanged. The [public guide](../multipart.md) records
the callback and outer-cleanup contract.

## Verification and review

The prepared implementation and its test-only extension pass 19 focused cases
in Debug and ReleaseSafe. They cover partial and zero payload acknowledgement,
begin/write/end pauses and errors, multi-part transitions, once-only cleanup,
truncation, terminal reuse, and invalid progress. Composition checks use the
actual common BodyState and control types, including final end pause/resume
without an empty chunk and expired controls after terminal cleanup.

The original missing-adapter failure and an early fixture-offset mistake are
retained with the corrected fixture and successful checks. Independent adapter
and test-extension reviews found no remaining actionable findings. Root applied
both exact patches after checking every preimage against the committed P1
checkpoint `0a26e8e65f297fa69c058638266efecfc08379de`.

The public downstream consumer names every sink callback alias and compiles
actual consume, finish, and terminal cancellation calls through the package
namespace. Its legacy narrow and exhaustive multipart consumers remain in
place. Integration review required the explicit paused-end outer-cleanup rule
in the public guide; bounded re-review found no remaining findings.

The combined native and C-sanitizer suites each pass 830/830 tests and 22/22
build steps. ReleaseSafe test compilation, Windows GNU compilation, and macOS
ARM64 compilation each pass 20/20 steps. The public downstream consumer passes
16/16 steps. Formatting, conventions, release-version, documentation, and diff
checks pass. The full 260-file source freeze is unchanged throughout the matrix;
AST-only graph refresh also completes.

The [evidence package](evidence/m2_multipart_sink/README.md) preserves the
combined source binding, raw commands, focused failures, terminal canonical
results, and scoped reviews. Cross-target results establish compilation only.
The sanitizer graph instruments C/C++ dependencies and uses Zig ReleaseSafe;
it does not establish ASan instrumentation of Zig loads and stores.

## Remaining work

Actual request transport drivers and admission, multipart BodySink wiring,
real bounded 100 MB uploads, and final combined M2 verification remain open.
The accepted ADR defers a library file helper until a real consumer needs it.
