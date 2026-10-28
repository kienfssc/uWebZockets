# HTTP/2 receive queue and credit core

The independently reviewed pure core provides bounded per-stream receive
queues and separate pending connection/stream credit. It is a foundation for
the next Session and concrete sink driver; no actual HTTP/2 upload delivery is
claimed from this checkpoint.

The [recovery archive](evidence/m2_h2_body_queue/README.md) preserves the four
changed source paths, complete existing-file preimages, patch, frozen source
inventories, command records, task report and independent protocol review.
Root production source, layouts and dependency pins remain unchanged.

## Bounded storage and ownership

The caller supplies disjoint payload, block metadata and stream head/tail
storage. Blocks contain three u16 values and hold 1024 payload bytes. Append
preflights capacity before mutation and reuses each stream's tail. Partial
head consumption retains its entire credit until the block is reclaimed;
reset refunds held bytes exactly once and preserves sibling queues.

The accepted bound is round_up(65535 + max_streams * 1023, 1024): eight streams
require 73728 payload bytes, 72 blocks and 432 bytes of block metadata. Connection
credit stays capped at 65535. Queue operations perform no allocation or I/O.

Padding can become eligible without payload storage. Pending connection and
stream counters remain independent; only an explicitly accepted output scope
commits its credit/window change. Concrete Session code must still enforce
validation, actual complete WINDOW_UPDATE acceptance, identity and commit order.
That integration is required before adoption.

## Verification and limits

Nine caller-buffer tests pass in Debug and ReleaseSafe. They cover independent
streams, fragmented tails, held head prefixes, atomic exhaustion, reset/reuse,
padding, separate credit scopes and numeric capacity/window bounds. Eligible
32-bit and centralized native/macOS/Windows semantic compilation pass, together
with formatting, conventions, version and AST graph checks. Declaration-only
reds and an initial authoring-overlap failure remain explicitly classified in
the archive; neither is presented as a behavioral regression proof.

The source digest is
`580199bc84e81779dd050943fc0b1bb7a9b8f1af113fcb28e7fab560fc105af6`
across 1025 regular files. On 2026-10-28 Root restored this exact source after
temporary files were cleared: 982 files matched current Root bytes and 43
matched preserved snapshots. Every path and the full manifest digest agree.
The immutable 93-file c223 libxev override was separately restored from existing
local Git objects with its recorded tree and every file hash verified.

Real Session output retry, startup carving, enabled/disabled layout measurements,
shared App admission, retained per-stream metadata, callback/reset lifetime,
TCP/TLS composition and actual 100000000-byte HTTP/2 upload proof remain open.
No native fault/schedule experiment or full release gate was run for this core.
