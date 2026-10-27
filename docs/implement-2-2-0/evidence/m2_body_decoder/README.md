# HTTP/1 body decoder verification evidence

The [archive](h0-body-decoder.tar.gz) preserves original H0/v2 preparation,
immutable-baseline oracle, exact sources and command bindings, raw failing and
passing results, and canonical root integration. It contains 227 safe regular
members and 226 inventory entries, independently checked by root after packaging.
SHA256: `34e0572c4bab264831572a01c70d22136d8b73b85be1cc8240ae560afcac2c40`
(174402 bytes). The [manifest](manifest.json) binds every retained file.
A credential scan found no matching environment values or GitHub token patterns.

The root native and C-sanitizer suites each pass 851/851 tests and 22/22 steps.
Default ReleaseSafe build passes 47/47; ReleaseSafe/Windows GNU/macOS ARM64 test
compilation each passes 20/20; the consumer passes 16/16. Whole Smith requested
100K and recorded 304,615 runs, 3/3 tests and 19/19 steps. Object and smoke fuzz
graphs each pass 14/14. Owned local h1spec passes 33/33 before recorded cleanup.
All 263 frozen source files are unchanged throughout the successful matrix.
Formatting, conventions, version, docs, whitespace and AST refresh pass.

Preparation retains four immutable-baseline differential groups on native and
actual Linux32, 21 focused cases, six-target fourteen-field layout proof and
the bounded v2 diagnostic saturation correction. Earlier sandbox SIGSYS,
expected arithmetic failures, and the root relative-import compilation failure
remain separate from successful corrected runs. Root changes only the test's
support import to the named module; production matches independent v2 review.

Historical command paths and compiler/cache locations are retained. Restore
the named source snapshots and recorded tool versions before reproducing a
preparation command. Source hashes, rather than ephemeral output paths, bind
those historical results. Generated caches and binaries are excluded.

This verifies a pure parser foundation and buffered compatibility. It does not
establish actual request transports, complete 32-bit App support, foreign native
execution, Zig ASan instrumentation, a live 100 MB upload or full M2 closure.
