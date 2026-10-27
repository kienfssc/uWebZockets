# M2 incremental multipart utility

Status: standalone utility implemented and verified,
2026-10-27. This checkpoint does not close M2 or establish live upload delivery.

The standalone `multipart.StreamingParser` implements the accepted
[ADR0011](../adr/0011-incremental-multipart.md) event and acknowledgement
contract. It copies the validated boundary, uses caller-owned headers and at
most `boundary.len + 4` carry bytes, and retains no input pointer. Acknowledged
payload advances current input or replay with exact separate accounting.
Every post-init error is terminal; EOF validates without flushing payload.

Strict metadata validation is isolated from the existing buffered parser.
The original multipart module's 7,900-byte prefix is byte-identical, with
SHA256 `b337a5f8310d740d8f4e8de82eb490b7c85c7a4fbd97431fc77174004d070783`.
Request/OwnedRequest, transport storage, routing, and default body limits are
unchanged. The new public package consumer includes narrow and exhaustive
legacy multipart error handling and exercises incremental public types.
Its downstream build and the clean package-path build both pass.

The native x86_64 parser occupies 176 bytes, alignment 8, plus caller working
buffers. It imports no transport, callbacks, file, I/O, or allocator. No
request-path allocation or default connection-slab addition is introduced.
The [API guide](../multipart.md) documents metadata borrows, accepted prefixes,
terminal errors, and the explicit MP-L1 delimiter-padding limitation.

The [preparation archive](evidence/m2_multipart_preparation/README.md) preserves
source freezes, raw commands, intermediate failures, and final focused results.
Root checked all 254 safe regular members and 253 inventory checksums.
Its SHA256 is
`b1c12f9169235b59aa6bb2f5c0134f2c494d295606b3d7c562eb8e28c7009c48`.
Independent source and evidence review found no remaining actionable findings
after adding the boundary-length-one replay cases.
The [integrated verification archive](evidence/m2_multipart_integrated/README.md)
binds the combined source tree and canonical results. Its initial sanitizer
setup failure is retained separately from the successful configured rerun.

## Executed evidence

- All 22 focused parser tests pass in Debug and ReleaseSafe, including every
  split, exact bounds, guarded B+4 carry, false prefixes, relocated input,
  strict metadata, truncation, and invalid acknowledgement preservation.
- The fixed-block proof accepts exactly 100,000,000 logical entity bytes,
  checks every payload byte and metadata/hash/count result, and preserves
  storage guards. It does not materialize a complete upload.
- Focused Smith requested 100K and recorded 100,999 runs. The real external
  LLVM target completed 10,000 runs with leak checks enabled. Its 9,075
  registered counters include parser code. Six-target object and smoke
  graphs each passed 14/14 steps; external build enumeration retains each
  target, corpus, options, and applicable dictionary.
- The integrated native and C-sanitizer suites each pass 811/811 tests and
  22/22 build steps. The restarted shell initially lacked sanitizer runtime
  paths; that setup failure is retained, then the unchanged source passed
  with the pinned Nix runtime configuration.
- ReleaseSafe test compilation and the ReleaseFast library build pass. The
  default ReleaseSafe build passes 47/47 steps; Windows GNU and macOS ARM64
  compilation each pass 20/20 steps. The public package consumer passes 16/16
  steps, and the clean package-path build passes. These cross-target results
  establish compilation, rather than execution on those platforms.
- The memory-sanitizer smoke graph passes 16/16 steps, and the owned local
  HTTP/1 compliance server passes all 33 h1spec cases. The server is stopped
  after the client finishes; its cleanup status is retained with the result.
- The canonical whole Smith invocation requests 100K and records 204,495 runs,
  2/2 passing tests and 19/19 build steps. The final six-target OSS-Fuzz object
  and deterministic smoke graphs each pass 14/14 steps.

The external engine links ASan, while Zig code uses ReleaseSafe and coverage;
this does not claim ASan instrumentation of Zig loads and stores. All canonical
checks above used the same frozen production and test source bytes. Subsequent
documentation changes correct the six-target inventory and record these results;
the evidence identifies that documentation-only delta.

The separate ReleaseFast comparison prepares the same complete 100 MB fixture
before timing. Both parsers check the same 99,999,869 payload bytes, payload
hash `3d5779fe5019c3ac`, and metadata hash `65d1d2a60ef48ce`. Two warmups and
seven alternating samples per parser are retained. Median times were
357,421,486 ns buffered and 363,758,402 ns incremental with 4,096-byte input
splits on a shared runner. These samples imply no speedup, quiet-host result,
or official performance-threshold claim.

## Remaining integration

The part-sink adapter is prepared and independently reviewed separately; it is
not part of this utility checkpoint. Working request transport adapters,
multipart-to-body-sink integration, real 100 MB uploads on every transport,
and final combined verification remain required. The accepted design defers a
library file helper until a real consumer needs it.
