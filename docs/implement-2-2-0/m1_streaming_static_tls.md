# M1: streaming, static assets, and TLS payload closure

Status: in progress, 2026-10-26. M0 is complete.

## Scope

Extend the shipped response-streaming and static-file surfaces without
redesigning their public APIs or increasing fixed queue capacities. Preserve
plaintext sendfile, exact representation metadata, bodyless responses, and
bounded memory on every supported transport. The ordered architecture and
ownership are recorded in [architecture.md](architecture.md).

## M1-1: response streaming

The first slice covers premature producer completion and completion ownership:

- Regressions must first prove that `.done` without successful `end_chunks`
  fails to close or reset the response.
- HTTP/1 uses its existing connection-abort path; HTTP/2 resets the affected
  stream while preserving siblings; HTTP/3 uses its existing producer-failure
  path, returning 500 before headers or closing an already-started stream.
- Once `end_chunks` succeeds, even a subsequent `.pending` return must disarm
  the producer so terminal framing cannot be emitted twice.
- The producer callback, context, and transport-owned completion state must
  clear once without hot-path allocation or locking.

Implementation and RED/GREEN verification are in progress. No new passing
test or runtime behavior is claimed at this checkpoint.

Still required for the full M1-1 acceptance:

- HTTP/1, real TLS, HTTP/2, and HTTP/3 matrix with logical 1-byte, 16 KiB, and
  64 KiB emissions, including pending/drain progress.
- Framed transport close/reset and once-only cleanup proof.
- Empty writes and HEAD/204/304 rejection coverage.
- Documented backpressure and caller-buffer ownership, allocation audit,
  sanitizer gate, and independent local review.

## M1-2: large static files and sidecars

Not implemented yet. Required: per-transfer bounded file lifetime and exact
length framing for TLS/HTTP/2/HTTP/3; files larger than the existing buffer;
validators, HEAD, ranges and If-Range; pure quality-aware Accept-Encoding;
fresh `.gz`/`.br` sidecars with representation-specific validators and Vary;
confinement and missing/stale-sidecar coverage; external static profile
artifacts; dated kTLS and measured splice decisions.

## M1-3: 100 KiB TLS echo

Not implemented yet. Required: real TLS loopback with exact bytes, at least
seven application-data records, unchanged record/queue limits, plaintext
control, caller-buffer and allocation audit, and external `8gbit` evidence or
the plan's explicit dated re-declaration.

M1 remains open until every original checklist item has implementation and
matching evidence, or the original plan expressly permits a documented
re-declaration. The user's instruction keeps work in the original repository's
feature branch for later manual review; no fork or PR workflow is required.
