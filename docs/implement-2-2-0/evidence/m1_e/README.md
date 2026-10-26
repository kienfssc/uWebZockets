# Pure content-coding negotiation evidence

Date: 2026-10-26. Source baseline: `fa7449e80334cef360cb32ec61e051d255c37249`.
The feature changes are included in this branch's negotiation commit.

The following focused command used official Zig 0.16.0:

```sh
ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache \
  /tmp/zig-x86_64-linux-0.16.0/zig test --dep test_support \
  -Mroot=src/tests/negotiate_tests.zig -Mtest_support=src/test_support.zig
```

- [Quality RED](quality_red.log): exit 1; 0/2 passing before the fix.
- [Quality GREEN](quality_green.log): exit 0; 2/2 passing after the fix.
- [Encoding RED](encoding_red.log): exit 1; the public contract is absent
  before implementation.
- [Encoding GREEN](encoding_green.log): exit 0; 8/8 tests passing.

The suite checks strict qvalue grammar, absent versus empty fields, weights,
availability, wildcard precedence, explicit refusal, duplicate minimums,
malformed known weights, and refusals beyond the media parser's entry capacity.
All fixtures use fixed caller-owned storage. Independent local review found no
actionable findings in source, tests, ADR, corpus, or dictionary.

The [combined native suite](../m1_b/green.log) exits 0 with 678/678 tests and
22/22 successful build steps. [LLVM smoke](fuzz_smoke.log) exits 0 with 11/11
steps. The [100K fuzz run](fuzz.log) exits 0 after 103,733 executions. Commands:

```sh
ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache \
  /tmp/zig-x86_64-linux-0.16.0/zig build oss-fuzz-smoke \
  -Doptimize=ReleaseSafe -j2 --summary all
ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache \
  /tmp/zig-x86_64-linux-0.16.0/zig build fuzz \
  --fuzz=100K -Doptimize=ReleaseSafe -j2
```

Formatting, conventions, release metadata, documentation links, online
dependency provenance, and graph refresh pass. The
[package consumer](package.log) exits 0 with 16/16 ReleaseSafe steps using
`zig build check -Doptimize=ReleaseSafe -j2 --summary all` from
`tests/package_consumer`. Sanitizer results for this source remain open; the
canonical sanitizer uses the earlier immutable
`fa7449e` worktree and does not yet cover this negotiation change.
