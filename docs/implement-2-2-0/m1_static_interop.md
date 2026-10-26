# M1: public static-route client matrix

Status: reviewed harness and successful consumer build, 2026-10-26.
Exact saved-revision live execution remains open.

The [public consumer](../../tests/static_interop/README.md) uses ordinary App
startup, static mounts, listeners, signal handling, shutdown, and deinit. It
runs plaintext HTTP/1, TLS HTTP/1, TLS HTTP/2, and live HTTP/3 with the existing
pinned curl/ngtcp2/nghttp3 and aioquic clients. Every run requires an exact clean
saved revision and a new artifact directory outside the source checkout.

The matrix compares every byte of 104,857,600-byte sparse assets, records exact
lengths/hashes and negotiated protocols, and requires connection reuse. Its
low-level public aioquic driver interleaves a healthy sibling and another health
request on the same connection. Comparison slices are at most 8192 bytes;
legal larger client events are accepted and measured. This functional driver
uses named plain records and no custom classes, subclasses, private SDK state,
or monkeypatching.

Small-representation checks cover actual gzip/Brotli delivery and client
decoding, defaults, all-field refusal, MIME, distinct ETags, Vary, HEAD, 304,
encoded ranges, If-Range, and 416. Owned-PID listener proof, separate command
and server statuses, graceful drain markers, raw headers/traces, body archives,
and curl transport qlogs are retained. The aioquic JSONL trace is explicitly
application events, not a transport qlog. Private keys live outside artifacts
and are removed by owned temporary-directory cleanup.

## Review and preliminary checks

[Retained preparation evidence](evidence/m1_static_interop/manifest.json)
binds exact staged hashes to successful syntax/AST and offline component
checks. It preserves an initial decoder-lookup environment failure separately.
The offline checks verify fixture hashes/decompression, bounded comparisons,
legal large events, corruption/premature-end/duplicate-length refusal, and
streamed trace/archive output. Independent harness review found no actionable
issues; root adjusted only README status and its milestone link afterward.
The [ReleaseSafe consumer build](evidence/m1_static_interop/consumer_build.log.gz)
then exits 0 in the pinned Nix shell, compiling the public listener and static
APIs. Its dirty staged-source warning is retained; the next live run must bind
a saved clean revision. These checks do not establish live server delivery.

The harness makes no throughput, official HttpArena activation, or global
allocation claim. Ephemeral test certificates support loopback correctness
only. The canonical repository and malformed-protocol gates remain required.


## First saved-revision run and harness correction

The [first live run](evidence/m1_static_interop/first_live_failed.json) at
`b2d2acb570eb0eae89bdb47e35889d1aa3264a6a` builds 17/17 steps, then fails
with aggregate exit 1. Before that failure, plaintext delivery compares all
104,857,600 bytes and reuses the same connection for health. Its five completed
curl invocations return zero; the owned server drains and exits zero without
forced killing. TLS/H3 cases never start. This partial proof does not close
the full matrix.

The failure is a harness FileNotFoundError: successful curl 304 reports zero
downloaded bytes without creating its output file. The correction precreates
one unique caller-owned empty output before each non-HEAD request, retains the
empty-file assertion, and additionally requires zero downloaded bytes for
bodyless responses. Existing paths are refused without overwrite, and failed
curl commands still fail before response checks. Focused retained RED/GREEN
cases and independent re-review support the correction; no gate was weakened.

The unchanged Brotli fixture contains 49 encoded bytes and decodes to 1376
bytes. Earlier preparation prose/log output incorrectly printed 47; actual
decoder checks used the full fixture. The original log remains unchanged and
the additive manifest records the correction and exact hash. README is fixed.
A fresh exact-source full live run remains required.


## Four-protocol curl proof and remaining aioquic run

The [second saved-revision run](evidence/m1_static_interop/second_live_failed.json)
at `1488ecc49721dde935ee628b6b5668e99d600836` passes every curl matrix:
plaintext H1, TLS H1, TLS H2, and live H3 each compare exactly 104,857,600 bytes,
validate Content-Length, and reuse the connection. Across 92 curl invocations
and 96 responses, all 84 small-file checks pass, including real gzip/Brotli
decoding. The archive retains 23 nonempty H3 transport qlogs. All three owned
servers exit zero without forced killing and log completed resource teardown.

The aggregate run still exits 1. Its low-level aioquic client receives the
healthy sibling's exact two bytes and END_STREAM, then incorrectly requires
Content-Length on that ordinary health response. The large static stream has
compared 65,415 bytes at that point; its completion is not claimed.

The reviewed correction makes the length policy explicit per request: static
files require one exact Content-Length; health may omit it, and any present
value still must be unique and exact. Body equality, source EOF, END_STREAM,
status, and encoding checks remain. Focused RED/GREEN cases retain missing,
duplicate, mismatched, corrupt-body, and incomplete-end refusals. A fresh full
live run must complete the large aioquic stream, healthy sibling, and reuse.
The original failed artifact and generated results remain unchanged.
