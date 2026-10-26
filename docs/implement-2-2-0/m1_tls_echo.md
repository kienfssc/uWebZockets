# M1: true 100 KiB POST echo

Status: local echo proof implemented and independently reviewed, 2026-10-26.
Official profile evidence is re-declared with the restoration criterion below.

The new centralized tls_echo_tests suite returns bytes actually received from
the client through begin_stream. Its progress stores only an offset and reads
the current TCP request body on each callback. It retains no request pointer
or body slice between callbacks. Real TLS and plaintext sockets verify the
decoded response against the supplied binary bytes.

## Measured capacity exception

The default 16 KiB request limit rejects a 102,400-byte declaration with 413
before the handler runs. Under that unchanged configuration, both attempted
100 KiB echoes fail the expected-200 assertion. This is the
[behavioral RED](evidence/m1_f_echo/red.log): one probe passes and two echoes
fail.

Only the echo fixture then sets max_body_size to 102,400. Its request region
changes from 41,984 to 128,000 bytes: exactly 86,016 bytes, or 84 KiB, more per
connection slot. That measured region delta is asserted; no separate whole-slab
total is claimed. Library defaults and the HTTP/2, HTTP/3, WebSocket, 64 KiB
output queue, and 16 KiB TLS record limits remain unchanged. The supplied
allocator permits the single startup slab allocation and detects later
allocation/resize attempts; internal TLS allocators are outside that counter.

This is bounded buffered intake followed by streamed response output. M2 still
owns 100 MB uploads without full-body storage. The current encoded request is
also bounded: the tests use 8 KiB input chunks and do not claim unlimited
tiny-chunk overhead within the decoded-body limit.

## Coverage and lifetime

TLS covers empty bodies and distinct seeded binary variants of 1 byte, 1 KiB,
10 KiB, and 100 KiB, plus chunked 10/100 KiB input, keep-alive reuse, and refusal
at 100 KiB + 1. Same-length variants have distinct tags, so a canned response
cannot satisfy the byte comparisons. A plaintext POST control also echoes
100 KiB exactly. The large TLS cases retain the complete-application-record,
fixed queue/address, bounded callback, and genuine WouldBlock/drain checks.

The pipeline sends the first head and 96 KiB normally, then combines its final
4 KiB with the complete distinct 1 KiB following request in one TLS write below
8 KiB. On the server loop, a real pending return must observe that entire next
request already retained after the checked first-body boundary. The observation
is asserted after shutdown/join. This exercises deferred request-buffer
compaction while the producer still owns its input. The public HTTP/1 body
lifetime is now documented in [the API guide](../api.md#ownership-and-lifetime-rules).

The [pipeline coverage RED](evidence/m1_f_echo/pipeline_red.log) fails that
observation with separate TLS writes, while the
[final native GREEN](evidence/m1_f_echo/green.log.gz) exits 0 with 684/684 tests
and 22/22 steps. Independent bounded re-review found no remaining actionable
findings after the coalesced-record correction.

```sh
ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache \
  /tmp/zig-x86_64-linux-0.16.0/zig build test --summary all
```

Formatting, conventions, release metadata, and documentation checks pass.
Current-source sanitizer and target results remain open. Earlier checkpoint
results are retained with their exact source identity.

## External evidence

The official HttpArena adapter still pins 1.8.0, lacks POST /echo, and does not
subscribe to 8gbit at the inspected immutable revision. This session has
read-only access there. The original plan expressly permits a dated evidence
re-declaration: [the source record and exact adapter/restoration steps](evidence/httparena/README.md)
specify the required dependency pin, configured intake, real echo route,
subscription, official validation, and authorized profile artifact. No official
performance result is claimed and no external benchmark data was modified.
