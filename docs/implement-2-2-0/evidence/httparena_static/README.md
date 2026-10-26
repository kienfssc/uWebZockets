# Official static-profile evidence boundary

Re-declared on 2026-10-26 under the plan's dated-limit policy; reassess on
2026-11-02 or earlier when authorized reviewed source and an official host are
available. No official validation, performance run, result publication, or
external adapter mutation occurred. The [manifest](manifest.json) and
[archive](official_contract_evidence.tar.gz) preserve the inspected immutable
HttpArena commit, complete tree, 29 Git-blob-verified files, primary MIME
references, validator/load contracts, access observations, and corrected recipe.
Extract into a new directory and verify SHA256SUMS.portable.

## What remains external

At the inspected revision, the adapter uses uWebZockets 1.8.0, has no static
mount/subscriptions, and its H3 mode opens UDP8443 without the needed TCP8443
listener. The profiles serve 20 assets and 50 representations from /data/static:
static-tls on TCP8081, static-h2 on TLS TCP8443, and static-h3 on UDP8443.
The exact asset/load/validator requirements remain in the raw evidence.

The static-tls implementation document requires h1-only ALPN, while its
validator merely offers h1 and accepts the normal h2+h1 public server setup.
Official activation needs clarification or an accepted normal configuration;
do not add a benchmark-specific private API or claim that passing validation
settles the stricter prose. The WOFF2 mapping gap is now fixed and tested in
the library. Actual official asset payloads were not downloaded/verified here.

## Authorized restoration recipe

1. Publish a reviewed immutable original-repository source revision and use its
   actual Zig package hash in the external adapter, preserving Zig 0.16 and
   normal capacities. There is no fork, invented hash, or cache patch fallback.
2. Register `app.static("/static", "/data/static", .{ .precompressed = true })`
   through normal startup on each serving App/worker. Preserve real mtimes,
   confinement, route scratch, and cleanup. Keep TLS8081; use the stable public
   init_http3 App's listen/listen_udp for TCP8443 and UDP8443. This does not
   create a cross-protocol atomic startup guarantee.
3. Add the three static profile subscriptions, resolve ALPN interpretation,
   build the official adapter, and run `./scripts/validate.sh uwebzockets` with
   complete logs, separate failures/skips, and an available H3 validator.
4. An authorized official operator on the designated host runs:

   ```sh
   ./scripts/benchmark.sh uwebzockets static-tls --save
   ./scripts/benchmark.sh uwebzockets static-h2 --save
   ./scripts/benchmark.sh uwebzockets static-h3 --save
   ```

   Without --save the inspected driver performs a dry run and does not retain
   generated result JSON/Docker logs. Preserve complete stdout/stderr and raw
   samples as well. Record source/pins, tool/container versions, CPU/quota/
   affinity/SMT, kernel/backend, worker/connection/stream settings, TLS, warmup,
   spread/statistics, CPU/RSS, latency, errors and listener/run ownership.
   Preserve the official best-of-three statistic and separate plan medians;
   never synthesize result JSON or substitute shared-runner numbers.

Owner: external adapter maintainer and verification/designated-host operator;
root integration supplies the reviewed public library revision. The concrete
criterion for restoring the claim is a fresh official validator and all three
saved designated-host artifacts meeting the original evidence contract.

Independent review confirms the bindings, requirements, public adapter recipe,
and dated scope. Its missing --save finding is corrected above and in the
retained derived recipe. The local five 100 MiB client transfers and sidecar
checks establish library correctness for their configuration, with no official
profile or global-allocation inference.

## Prior extraction correction

Four earlier 8gbit scratch files equal the exact Git bytes plus one final LF.
Their old hashes describe the saved extraction, rather than byte-identical Git
blobs. Original earlier evidence remains unchanged; this archive retains exact
raw bytes, Git object bindings, and the additive equivalence record. No source
behavioral difference or retroactive official run is inferred.
