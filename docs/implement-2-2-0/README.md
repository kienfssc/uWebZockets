# 2.2.0 implementation record

The implementation follows [the milestone plan](../../2.2.0-TODO.md) on
`feat/implement-2-2-0`, branched from `main` at
`a96e41705ff24171039c0a6e486b19418bfe7e6e`.

Each milestone report records scope, architectural decisions, changes, raw
verification evidence, independent review, and remaining acceptance criteria.
A milestone stays open until its required evidence is present. External
results and release actions are recorded only when actually performed.

| Milestone | Scope | State | Report |
| --- | --- | --- | --- |
| M0 | Freeze the 2.1.6 baseline | Complete | [Baseline](m0_baseline.md) |
| M1 | Response streaming, static delivery, TLS payloads | Complete locally; external profiles re-declared | [Streaming, static, TLS](m1_streaming_static_tls.md) |
| M2 | Request streaming and incremental multipart | Common contract/response guards verified; multipart utility integrated; intake open | [Request streaming](m2_request_streaming.md) |
| M3 | Dependency provenance gates and archives | In progress | [Dependency provenance](m3_dependency_provenance.md) |
| M4 | Live WebTransport and compliance | Delivery re-declared; activation gated | [WebTransport](m4_webtransport.md) |
| M5 | Cluster, timer, and limiter ownership | Awaiting feature stabilization | [Structural ownership](m5_structural_ownership.md) |
| M6 | Performance, platform, GRO, and API decisions | API decisions and timer/host audit recorded; other work open | [Evidence and platform](m6_evidence_platform.md) |
| M7 | Release metadata and final verification | Awaiting M1 through M6 | [Release acceptance](m7_release.md) |

M1 slice reports: [response transport matrix](m1_response_matrix.md) and
[content-coding evidence](evidence/m1_e/README.md), plus the
[100 KiB socket response proof](m1_tls_payload.md) and
[true POST echo](m1_tls_echo.md).
The next slice records [bounded file streaming](m1_file_streaming.md).
Its [HTTP/2 backend](m1_file_http2.md) includes real TLS pressure isolation.
The [HTTP/3 backend](m1_file_http3.md) records copied partial-write ownership.
[Complete-field coding negotiation](m1_encoding_fields.md) prepares sidecar selection.
[Static delivery](m1_static_streaming.md) records real 100 MiB TLS/H2 downloads.
[Opt-in sidecars](m1_static_sidecars.md) record fresh representation selection and 752/752 native tests.
[The public interop matrix](m1_static_interop.md) records its harness and live-result boundary.

M2 slice reports: [common contract](m2_common_contract.md),
[response guards](m2_response_guards.md), and the standalone
[incremental multipart utility](m2_incremental_multipart.md).
The [part-sink adapter](m2_multipart_sink.md) records the next integration slice.
[Transport preparation](m2_transport_preparation.md) preserves separate reviewed
components, lifetime proposals, and interrupted header-refusal drafts.

The original plan remains the acceptance contract. Reports supplement it;
they do not reduce its scope. The maintainer owns the final reviewed merge,
release tag, and publication.

On 2026-10-27 the user authorized delivery to the existing
[kienfssc/uWebZockets feature branch](https://github.com/kienfssc/uWebZockets/tree/feat/implement-2-2-0)
and will open the pull request manually. This supersedes the earlier
original-repository-only instruction and the plan's per-milestone PR workflow.
The fork's parent is `farbenbuilds/uWebZockets`; its feature branch was
fast-forwarded from `4e49d2697a5ade22cc95d4d3b43e125c37366d1d` to
`00c85640de26823f02a9c5d1fb82ccecb832aea4`, then verified with `git ls-remote`.

Push each subsequent commit to the `fork` remote. The local branch tracks
`fork/feat/implement-2-2-0`; `origin` and `upstream` retain the original
repository URL. The Codespace account has write access to the fork and read
access to the original repository. Earlier original-repository HTTP 403
results remain historical evidence; remote delivery is now available.
