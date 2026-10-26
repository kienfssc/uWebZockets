# M0: freeze the 2.1.6 baseline

Status: complete, 2026-10-26.

## Scope and assumptions

Preserve the released 2.1.6 tag and dependency pins, establish a reproducible
starting test result, and keep all implementation on `feat/implement-2-2-0`.
The user-supplied `2.2.0-TODO.md` is the implementation contract. The baseline
tracked tree was clean; that plan was its only untracked input.

## Verified identity

- Starting `HEAD`, `main`, and `origin/main`:
  `a96e41705ff24171039c0a6e486b19418bfe7e6e`.
- `git rev-parse v2.1.6^{commit}`:
  `bd40454b559ba954935101372cdbb5f496a3ff21`.
- `gh release view v2.1.6 --repo farbenbuilds/uWebZockets --json
  tagName,isDraft,isPrerelease,publishedAt,url,targetCommitish` returned
  `isDraft=false`, `isPrerelease=false`, publication at
  `2026-10-25T19:55:24Z`, and the public
  [release](https://github.com/farbenbuilds/uWebZockets/releases/tag/v2.1.6).
- `git switch -c feat/implement-2-2-0 main` succeeded. No tag was changed.

## Environment preparation

Zig, Nix, Deno, and graphify were absent from `PATH`; `graphify-out/` was also
absent. Scoped source inspection is the fallback until graphify is available.
The official Zig 0.16.0 Linux x86_64 toolchain was downloaded to `/tmp` and
verified against the [official download index](https://ziglang.org/download/index.json):
SHA-256 `70e49664a74374b48b51e6f3fdfbf437f6395d42509050588bd49abe52ba3d00`.
`/tmp/zig-x86_64-linux-0.16.0/zig version` returned `0.16.0`.

The first online dependency check could not resolve a remote in the network
sandbox. The network-enabled retry verified the libxev and lsquic pins and
reviewed mirror records, then found `vendor/h1spec` uninitialized. Initializing
the submodule uses its recorded gitlink and does not update the pin.

## Source context

Read the inventory, sequencing, and acceptance criteria in the supplied plan,
ADR 0001, ADR 0006, the maintained dependency fork policy, and the carried
2.2.0 roadmap. `TODO.md` is absent from the starting checkout, although the
supplied plan references it. Preserve the supplied inventory and IDs rather
than inventing missing source content.

M1 is the first implementation milestone after the baseline gates pass.
The architect has audited its existing response, static, and TLS boundaries.
The ordered slices and acceptance criteria are in [architecture.md](architecture.md).

## Verification evidence

- [Identity and environment](evidence/m0/identity.log).
- [Initial sandboxed test attempt](evidence/m0/test.log): dependency fetch
  failed because network access was unavailable; no tests ran.
- [Network-enabled baseline test](evidence/m0/test_network.log): exit 0;
  22/22 build steps succeeded and 647/647 tests passed in Debug on Linux.
  Command: `ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache
  /tmp/zig-x86_64-linux-0.16.0/zig build test --summary all`.
  The log preserves warnings from negative TLS, accept-retry, and worker-start
  tests, including libxev's errno diagnostics. No check was weakened.
- [Online dependency provenance](evidence/m0/dependencies.log): passed after
  initializing h1spec. All four libxev/lsquic manifest views agree, and the
  h1spec checkout equals the recorded gitlink. This verifies reviewed mirror
  records, not the later exact-live-mirror or second-machine requirements.
- [Convention check](evidence/m0/conventions.log): passed.
- [Release version check](evidence/m0/release_version.log): passed.
- [Documentation links](evidence/m0/docs.log): passed.
- [Formatting](evidence/m0/format.log): passed.
- [Public release metadata](evidence/m0/release.json).

Build/vendor independently ran `sh scripts/check_dependency_forks.sh --offline`
and compared `git ls-tree HEAD vendor/h1spec` with the submodule HEAD. Both
confirmed the recorded identity; no manifest or ledger change was needed.

The graphify package was subsequently verified against the vendored skill
(version 0.9.92) and the official source repository, then installed from wheels
under `/tmp/uwz-graphify`. `graphify update .` completed with 5,489 nodes and
7,831 edges. It reported partial C-header extraction and some files without
symbols; source reads still verify those details. Graph artifacts stay ignored.

## Review and integration

The independent reviewer found one closure gap: M0 requires the selected next
milestone to be recorded in the implementation PR. No other findings were
reported. [Draft PR #1](https://github.com/kienfssc/uWebZockets/pull/1) now
records M1 as next, with owner `kienfssc` and existing label `enhancement`.
The initial PR head is `4e49d2697a5ade22cc95d4d3b43e125c37366d1d`.

The authenticated account lacks write access to `farbenbuilds/uWebZockets`.
Codespaces configured `origin` as `kienfssc/uWebZockets` and retained the
original repository as `upstream`. The requested feature branch and cumulative
draft PR therefore live in that fork. The user-requested single implementation
branch carries every milestone's reports and review checkpoints.

Root integration confirmed the baseline scope, identities, raw gate results,
and PR metadata. The baseline commit contains the supplied plan and reports;
source code, dependency pins, and release tags are unchanged. The missing
`TODO.md` reference remains an explicit input discrepancy; the supplied plan
retains its full inventory and acceptance criteria.
