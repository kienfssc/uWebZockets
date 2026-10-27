# M7 release acceptance frontier

Status: open, 2026-10-27. There is no final 2.2.0 release commit or publication.
The [metadata observation](evidence/m7_release_frontier/observation.json)
records the saved branch, current metadata hashes and local v2.1.6 tag value.
The release-version check passes for 2.1.6. No agent created, moved or pushed
a tag, and v2.1.6 remains untouched.

| Release requirement | Current state | Required before publication |
| --- | --- | --- |
| Version and ABI metadata | Existing 2.1.6 values remain consistent | Update version.zig, zon, flake, C header, ABI tests and documentation headers together |
| Changelog and carry-over | New work is under Unreleased; milestone reports preserve open limits | Dated 2.2.0 Added/Changed/Fixed/Limits/Security sections and complete TODO closure or dated re-declarations |
| Public documentation | Completed slices and explicit limitations are documented | Reconcile roadmap, API/HTTP/QUIC/protocols/architecture, dependency policy, CODEBASE and README against the final code |
| Decisions and pins | Accepted ADRs and current-pin/candidate archives are retained | Final ADR 0001, 0006 and 0008 status; reviewed maintained pins and ledger |
| Verification | Per-checkpoint source-bound results exist | Every required gate on the exact final commit |
| Performance and platforms | Shared-runner observations and compilation have bounded scopes | Named-host evidence or dated boundaries, second-machine pins and native Windows runtime |
| Tag and release | No new tag or Publish run | Maintainer-reviewed merge, v2.2.0 tag and matching successful release publication |

The final verification pass must include exact mirrors, an empty-cache rebuild,
full tests, sanitizers and MSan, the cross-target matrix, package consumer,
Smith and external fuzz integration, Autobahn, h1spec, HTTP/3, WebTransport and
native Windows. Existing M1 results and current parser/adapter checks do not
replace a same-commit release pass. Performance evidence must follow the
three-file policy with raw artifacts and truthful host classification.

Confirm no local maintained-dependency patch/overlay, CI patch step or generated
Perl build input reappears. Run AST-only graph refresh after the final source
change. Refresh final-pin archives, exact ancestry/protection proof and
second-machine resolution after any dependency update; current recovery bundles
alone do not prove final adoption or reproducibility on another machine.

M2's actual bounded upload matrix, M3 publication/provenance, M4's declared
capability boundary, M5 structural ownership and M6 evidence remain their own
acceptance contracts. No blanket completion is inferred from an individual
green test suite. The user's manual pull request and maintainer review happen
after concrete branch work is saved; release tagging and Publish confirmation
remain maintainer actions. Keep this milestone open until those outcomes exist.
