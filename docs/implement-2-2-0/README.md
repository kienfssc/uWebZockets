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
| M2 | Request streaming and incremental multipart | Plaintext live matrix passes; remaining transport acceptance open | [Request streaming](m2_request_streaming.md) |
| M3 | Dependency provenance gates and archives | In progress | [Dependency provenance](m3_dependency_provenance.md) |
| M4 | Live WebTransport and compliance | Delivery re-declared; activation gated | [WebTransport](m4_webtransport.md) |
| M5 | Cluster, timer, and limiter ownership | Awaiting feature stabilization | [Structural ownership](m5_structural_ownership.md) |
| M6 | Performance, platform, GRO, and API decisions | API decisions and timer overflow fix recorded; other work open | [Evidence and platform](m6_evidence_platform.md) |
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
The [HTTP/1 head/body decoder](m2_body_decoder.md) records pure framing and
buffered compatibility before transport activation.
[Transport preparation](m2_transport_preparation.md) preserves separate reviewed
components, lifetime proposals, and interrupted header-refusal drafts.
The [HTTP/2 refusal checkpoint](m2_h2_refusal.md) extends its isolated draft with
framing, output pressure, sibling, capacity and Linux32 verification.
Its [live TLS follow-up](evidence/m2_h2_refusal_live/README.md) records header-only
503 and same-connection health with curl/nghttp2 on an owned io_uring server.
The [HTTP/3 checkpoint](m2_h3_refusal.md) adds source compatibility, canonical
selection, queued-trailer, sibling and Linux32 verification to its saved draft.
Its [live HTTP/3 follow-up](evidence/m2_h3_refusal_live/README.md) records normal
refusal, a healthy sibling and reuse with a reviewed test-only libxev override.
The [pure HTTP/1 admission checkpoint](m2_h1_admission.md) verifies physical
ingress bounds and the atomic router-to-common-state reservation handoff.
The [typed loop-callback adapter](m2_loop_callback_adapter.md) prepares backend
ACK classification and fixed failure fencing without activating H1 retirement.
The [platform setup guard](m2_upload_platform.md) records the confirmed BSD
restriction, eligible-target compilation and refusal-before-mutation proofs.
The [coherent H1 baseline](m2_h1_baseline.md) combines the reviewed preparation
with current Root, preserving multipart/timer changes and exact layout evidence.
The [cold-state successor](m2_h1_cold_state.md) adds the head target, delivery
pin and payload accounting with pure reset/drain proof and unchanged disabled slabs.
The [pure retirement policy](m2_h1_retirement_policy.md) prepares coalesced timer
boundaries and one-shot close eligibility without native callback effects.
Its [typed invariant follow-up](evidence/m2_h1_invariant_failure/README.md)
preserves failure-latch ordering before the new fixed inactive-phase diagnostic.
The [plaintext implementation checkpoint](m2_h1_plaintext.md) preserves reviewed
App/driver code, both exact 100000000-byte live uploads, real-file ordering and
two initial client failures. Its [corrected client follow-up](evidence/m2_h1_plaintext_corrected/README.md)
passes 21/21 against the identical server. Production integration remains open.
The [TLS capacity clarification](m2_tls_capacity.md) records the reviewed
encrypted-receive/BIO boundary before TLS driver implementation.

The [reviewed libxev duplicate-cleanup candidate](evidence/m3_libxev_dup_verified/README.md)
adds independent source review, pure decisions, healthy-suite verification and
a complete recovery bundle without changing maintained refs or root pins.
The [reviewed IOCP cancellation-result candidate](evidence/m3_libxev_iocp_cancel/README.md)
adds missing-request classification, portable policy tests, healthy-suite and
foreign Windows compilation evidence, preserving public errors and layouts.

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
