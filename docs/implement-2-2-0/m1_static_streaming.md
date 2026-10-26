# M1: bounded static-route delivery

Status: implemented and independently reviewed, 2026-10-26. Native proof
passes; sidecars and remaining transport/final gates follow.

Static serving preserves confinement, MIME, validators, HEAD, ranges, If-Range,
304, and 416. It prefers send_file, then stream_file with stable handler scratch.
Only ZeroCopyUnavailable advances past send_file; only FileStreamingUnsupported
permits the old bounded small-file fallback. WouldBlock/other errors propagate
without a full-file read. Returned errors retain one handler-owned close;
success transfers once. App drains transports before destroying handlers.

Real framed adapters no longer require the file to fit the route buffer.
Legacy custom targets retain their small-file fallback. No queue, body, or
route-buffer capacity increases. Tests reuse the existing accepted-socket
fixture through three public test-only declarations.

## Evidence

The [pre-integration RED](evidence/m1_static_streaming/red.log.gz) reproduces
FileTooLarge/no handoff. A separate H3 HEAD fixture needed its deferred write
flush. Real App.static instantiation exposed the removed Zig 0.16 trimRight
name; one trimEnd replacement retains slash normalization. Both distinct
failures are archived alongside the meaningful behavior RED.

Focused GREEN passes 11/11. The [combined native suite](evidence/m1_static_streaming/green.log.gz)
passes 730/730 tests and 22/22 steps, exit 0. Real TLS HTTP/1 and TLS HTTP/2
each download exactly 104,857,600 sparse bytes with nonzero boundary sentinels
and zero interior, validating every byte and full length with fixed 8 KiB
client buffers. HEAD/empty avoid reads; metadata/range/health-reuse cases pass.

A submitted-writer plaintext test forces genuine send_file WouldBlock,
asserting zero fallback reads and one close. H3 uses an injected adapter,
not a live client. The supplied allocator is guarded after setup; existing
page-allocated handlers and TLS C heaps remain outside that counter.

Independent ownership, fallback, lifetime, metadata, large-transfer, and
structural review finds no actionable issues. Formatting, conventions,
release metadata, and graph refresh pass. The
[source record](evidence/m1_static_streaming/source_manifest.json) binds exact
code, commands, counts, and scope. No global allocation/throughput claim is made.

## Remaining closure

Add opt-in fresh confined sidecars, distinct validators, encoded ranges, and
all-field quality negotiation. Complete large plaintext and live H3 static
downloads and final-source sanitizer/platform/package/fuzz/protocol gates.
Local correctness is separate from official static-profile performance evidence.
