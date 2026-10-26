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
