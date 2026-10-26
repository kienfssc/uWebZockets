# HttpArena 8gbit evidence boundary

Re-declared 2026-10-26 under the original M1-3 evidence exception. No official
profile run or performance measurement was performed. The current session has
read-only access to the external repository, and the reviewed feature commits
are not available there while original-repository pushes return 403.
[Provenance](provenance.json) records the immutable inspected revision, source
hashes, retrieval times, and observed permissions.

At [the inspected adapter](https://github.com/MDA2AV/HttpArena/tree/d92ece0b27c595cfae0434eb71568e9f7b5bd001/frameworks/uwebzockets),
the dependency is still v1.8.0, POST /echo is absent, and meta.json does not
subscribe to 8gbit. Its TLS path uses App.init_https defaults; the 2 KiB limit
in clusterConfig applies to the separate plaintext path.

[The profile contract](https://github.com/MDA2AV/HttpArena/blob/d92ece0b27c595cfae0434eb71568e9f7b5bd001/site/content/docs/test-profiles/h1/8gbit/implementation.md)
uses a 10 KiB POST body on TLS port 8081. The
[validator](https://github.com/MDA2AV/HttpArena/blob/d92ece0b27c595cfae0434eb71568e9f7b5bd001/scripts/validate.sh#L1752)
also compares larger, empty, binary, and chunked request bodies byte-for-byte.

## Required adapter change and restoration

1. Update frameworks/uwebzockets/build.zig.zon to an immutable reviewed 2.2.0
   source commit or release with its actual Zig fetch hash. Preserve Zig 0.16.0.
2. In src/main.zig, add POST /echo and stream the received body through the
   public producer response API. Keep bounded progress per active connection
   and worker; do not answer from a canned buffer or Content-Length alone.
3. Preserve the TLS path's existing single-worker and connection budget. Its
   configured initialization can use the current public composition:

   ```zig
   var app = try uz.App(5120).init_configured(
       init.io,
       std.heap.page_allocator,
       .{
           .max_connections = 5120,
           .max_body_size = 100 * 1024,
           .write_queue_size = 64 * 1024,
       },
   );
   defer app.deinit();
   app.tls_ctx = try uz.tls.TlsContext.init(
       try nullTerminated(init, certPath(init)),
       try nullTerminated(init, keyPath(init)),
   );
   ```

   This changes explicit intake storage after the local refusal probe; it does
   not change library defaults or output limits. Do not substitute the default
   init_https constructor afterward, which would discard that configuration.
4. Add 8gbit to meta.json's tests and run the official validate.sh uwebzockets
   checks, including both input framings and the 100 KiB comparison.
5. An authorized maintainer runs the official profile and retains raw output,
   host/tool configuration, source identities, correctness results, CPU, RSS,
   latency, and sample data under the plan's evidence contract. Only that fresh
   official artifact restores the external evidence claim.

The local socket and request-capacity tests are library correctness evidence.
The current parser also retains a bounded encoded request; this declaration
does not claim unbounded tiny-chunk intake or M2 upload streaming. External
benchmark data and result JSON were not edited.


A later [exact static-contract capture](../httparena_static/README.md) records
that four earlier scratch extractions append one LF to the exact Git bytes.
The original saved hashes and artifacts remain unchanged. Exact raw/Git blob
bindings and the additive equivalence record supersede any assumption that
those earlier extraction hashes were byte-identical Git object payloads.
