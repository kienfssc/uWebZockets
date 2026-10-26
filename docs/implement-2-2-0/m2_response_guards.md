# M2 response starts before upload completion

Status: implemented and verified response-phase checkpoint, 2026-10-26.
No intake adapter or live upload route is established by this change.

[ADR 0008](../adr/0008-request-body-streaming.md) permits bounded fixed final
responses before request EOF and refuses outgoing producers in that phase.
Response now carries request_body_complete, default true. Existing buffered
construction keeps its behavior; future header-only admission supplies false.

After preserving ResponseAlreadyStarted precedence, begin_chunked, begin_stream
and stream_file return BodyNotComplete before status/header validation, target
calls, output, producer state or file ownership changes. JSON/SSE and the first
writable-stream write reach the same guard. append_header and fixed final
end/end_with_headers remain available.

Legacy send_file returns the existing BodyNotAllowed tag for this phase. Its
eleven-error inferred set stays unchanged, proved by the same narrow-return and
exhaustive public consumer before and after. ZeroCopyUnavailable is not used:
that would incorrectly invite fallback while the upload remains incomplete.
Every file refusal leaves the caller's descriptor readable and owned.

The new flag uses existing tail padding. Actual Response size stays 2160 bytes,
alignment 8 on Linux, Windows GNU and both macOS targets. All six existing
native field offsets also stay unchanged. The intermediate field placement
that shifted offsets was rejected and remains historical evidence. Existing
transport owners and default slab estimates are unchanged by this checkpoint.

[Raw evidence](evidence/m2_response_guards/README.md) retains six focused cases,
actual compiler consumers, layouts, ownership checks and combined-source gates:

- Native and sanitizer suites each pass 787/787 tests, 22/22 steps.
- Production/examples pass 47/47 steps.
- ReleaseSafe, Windows GNU and macOS arm64 compile gates pass 20/20 steps each.
- Actual package consumer passes 16/16; clean manifest package check passes.
- Formatter, conventions, release metadata, docs and dependency checks pass.

Independent source/test/evidence review found no actionable findings. The
initial sandbox socket EPERM is retained separately from the successful owned
loopback run. Root merged one suite import with the common checkpoint; the
reviewed response/test modules remain exact. Three final source hashes match
before and after verification on dirty base 1ff7873 plus the recorded changes.

Foreign compilation is not foreign native runtime. No adapter yet sets this
phase during live intake, and no global heap or performance claim follows.
Router registration, header admission, framing, control ownership and the full
100 MB upload matrix remain separate M2 requirements.
