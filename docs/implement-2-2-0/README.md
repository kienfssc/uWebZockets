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
| M2 | Request streaming and incremental multipart | Common contract/response guards verified; intake open | [Request streaming](m2_request_streaming.md) |
| M3 | Dependency provenance gates and archives | In progress | [Dependency provenance](m3_dependency_provenance.md) |
| M4 | Live WebTransport and compliance | Delivery re-declared; activation gated | [WebTransport](m4_webtransport.md) |
| M5 | Cluster, timer, and limiter ownership | Awaiting feature stabilization | Pending |
| M6 | Performance, platform, GRO, and API decisions | C5 decisions recorded; other work open | [Optional APIs](m6_optional_api_decisions.md) |
| M7 | Release metadata and final verification | Awaiting M1 through M6 | Pending |

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

The original plan remains the acceptance contract. Reports supplement it;
they do not reduce its scope. The maintainer owns the final reviewed merge,
release tag, and publication.

The user requested implementation in the original repository's local feature
branch, with manual review later and no fork workflow. That instruction
supersedes the plan's per-milestone PR requirement. `origin` points to
`https://github.com/farbenbuilds/uWebZockets`; manual review happens later.
The user subsequently requested pushing each commit to that feature branch.
The first original-repository push returned HTTP 403: the current Codespace
account, `kienfssc`, has `push: false`. Local implementation continues while
write access is corrected; no fork is a delivery fallback.
