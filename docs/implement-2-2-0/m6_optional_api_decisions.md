# M6-4: optional API decisions

Branch decisions recorded 2026-10-26 for later maintainer review. This resolves
the three C5 decision items through the plan's named-boundary alternative;
it does not complete M6. No public API, capacity, or runtime behavior changes.
[Source bindings](evidence/m6_api_decisions/manifest.json) identify the inspected
checkpoint. Independent review found no actionable decision-record issues.

| Item | 2.2.0 decision | Owner and reopening criterion |
| --- | --- | --- |
| Per-listener credentials | Retain the App's shared TCP certificate/context policy | dx_router + crypto_tls: reopen when a named deployment needs distinct credentials within one App and separate instances/termination are inadequate |
| TRACE reflection example | Add no automatic or owned reflection example | dx_router + http_protocol: reopen for a concrete example requirement with explicit size caps and secret redaction |
| C ABI listen_all | Add no batch symbol without a concrete C consumer | ffi_edge + dx_router: reopen when a caller needs the fixed startup barrier and supplies ownership/error requirements |

## Credentials and rolling restart

A TCP App owns one TLS context shared by its TLS listeners; each cluster worker
still owns its own context. HTTP/3 has a separate QUIC TLS context initialized
from the same credential pair. The four-endpoint listen_all barrier chooses TLS
per endpoint, without certificate slots, SNI selection, context mutation, or
same-port process takeover. Existing separate Apps/processes or an external
terminator can isolate credentials. [ADR 0003](../adr/0003-tls-cluster-operational-boundaries.md)
retains startup-only PEM loading and process rolling restart.

Start a replacement on an independently managed backend, verify readiness and
a real trusted/hostname-checked handshake, then move new traffic to it. Drain
old requests externally before asking the old process to stop; apply an
operator-owned retirement policy to long-lived streams/WebSockets. Shutdown
closes active connections, cancels producers/tokens, and drains completions;
it does not finish all in-flight responses. Deinit follows run/cleanup. Keep
a deployment-owned rollback path. No automatic zero-downtime handoff or
production certificate-rotation proof is claimed.

A future per-listener/reload design needs an ADR covering fixed context slots,
configuration lifetime, in-flight SSL safety, rollback, and cleanup, followed
by verified peer-certificate, overflow, bad-PEM, shutdown, package/C, sanitizer,
and target tests. No speculative slots or reload hook are added now.

## TRACE and the C surface

Explicit TRACE/ANY routing remains opt-in; the library synthesizes no RFC 9110
reflection. Applications own bounds and must redact Authorization, Cookie,
Proxy-Authorization, and application secrets. No owned runnable reflection
example was found in the registered examples. This is a scoped repository
observation, not a survey of deployments.

C keeps its existing single-endpoint operations. The Zig barrier's four-endpoint
limit does not imply a C symbol or endpoint-ownership contract. No requester
was recorded in the inspected repository; this does not establish that no
outside consumer could want batching. If requested, define fixed capacity,
string lifetime, error codes, rollback, repeated calls, and C/C++ compatibility
before implementing it.

These decisions need documentation and existing-behavior preservation, without
new runtime tests that would imply a feature was added. M6's performance,
platform, GRO, timer, archive, and final-pin evidence remain separately open.
