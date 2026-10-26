# Implementation architecture and checkpoints

The user authorized execution of the supplied milestone plan. The original
acceptance criteria remain binding; this record orders the first implementation
slices without changing the goal.

## M0 architecture review

The read-only architect confirmed the starting commit and identified the absent
`TODO.md` source reference. Use the supplied plan's inventory and IDs and record
the missing reference explicitly. Build/vendor independently confirmed the
existing pins and ledger; the online provenance log must be green before M0
closes. The starting test result must precede source changes.

## M1 scope and ordering

| Slice | Ownership | Acceptance and verification |
| --- | --- | --- |
| A: producer completion | Transport I/O and QUIC | Returning `.done` without `end_chunks` fails closed on HTTP/1, HTTP/2, and HTTP/3. Slots clear once; an HTTP/2 sibling survives. Add failing regressions before fixing production code. |
| B: response matrix | Verification and HTTP | Plaintext, real TLS, HTTP/2, and HTTP/3 cover logical 1-byte, 16 KiB, and 64 KiB emissions, pending/drain, empty writes, bodyless responses, close, and reset. Document the contract. |
| C: file-transfer contract | Transport I/O, HTTP, and QUIC | Explicit bounded per-transfer ownership, exact known-length framing, and descriptor cleanup on completion, fault, reset, and connection close. |
| D: file streaming | Same owners | Large TLS, HTTP/2, and HTTP/3 files stream through bounded storage; exact bytes, HEAD, ranges, If-Range, and validators remain correct. Plaintext uses sendfile. |
| E: sidecars | HTTP | Pure content-coding negotiation plus confined file selection; test quality values, identity refusal, missing/stale files, representation validators, and encoded ranges. |
| F: 100 KiB echo | Transport I/O, TLS, and verification | Real TLS loopback proves exact bytes, at least seven application-data records, bounded queue occupancy, and retries; plaintext control uses the same logical body. |
| G: acceptance evidence | Integrator and independent reviewer | Required repository and sanitizer gates pass; static profiles and HttpArena results are archived or explicitly reported as missing under the original acceptance contract. |

Existing buffered handlers, streaming signatures, queue capacities, and
plaintext sendfile remain compatible. M2 starts after M1; M3 can run alongside
independent feature work. M4 requires M3, M5 follows stabilized feature files,
M6 follows code and pin freeze, and M7 follows all acceptance evidence.

## Design constraints located by the architect

- `src/core/tcp.zig` currently clears `.done` producers without proving
  terminal framing. `src/quic/stream.zig` silently finishes them. Existing
  producer-failure paths are the intended cancellation seam for slice A.
- A direct atomic 64 KiB `write_chunk` cannot fit a 64 KiB queue with framing
  or TLS overhead. Split logical emissions into bounded writes; preserve the
  existing refusal of permanently oversized writes.
- `src/http/static_files.zig` currently has one route-owned buffer and returns
  413 for larger framed files. Multiple in-flight files need bounded state
  per transfer; a shared active descriptor would corrupt concurrent requests.
- `StreamProducer` lacks a cancellation/finalizer callback. Design explicit
  descriptor cleanup before arming asynchronous file transfers.
- `begin_stream` uses HTTP/1 chunked framing and rejects caller-supplied
  Content-Length. It alone cannot satisfy exact-length static-file delivery.
  Prefer transport-owned file-transfer state reached through the existing
  file-response surface and reuse the producer pump internally.
- Real TLS BIO and record helpers already exist in `src/tests/tls_tests.zig`.
  Use those for runtime proof; plaintext queue tests do not prove TLS records.

Slice A is implemented and independently reviewed at `71b835f`; its Nix
environment repair is saved at `fa7449e`. The native Debug suite passes
663/663 tests. Sanitizer and target checks run against the immutable saved
commit in a separate verification worktree. Their results remain pending.
Review each completed slice independently before integrating it into the
milestone result.

## Response matrix acceptance

Slice B uses a shared, caller-owned 8 KiB producer buffer and an offset-derived
payload validator. Each transport emits two logical chunks for each size:
1 byte, 16 KiB, and 64 KiB. Logical boundaries force a pending return; actual
queue pressure must also preserve the producer offset. Poison accepted input
bytes before the next drain to expose any retained caller slice.

HTTP/1 validates complete chunk framing and exactly one terminator. The TLS
matrix uses a real BoringSSL handshake and encryption/decryption through memory
BIOs; it does not replace slice F's literal socket proof. HTTP/2 validates DATA
and END_STREAM after draining output, using ordinary WINDOW_UPDATE frames to
restore the default flow-control credit. HTTP/3 validates bytes through bounded
short writes rather than relying on a byte count alone.

Each case also checks unchanged storage addresses and capacities, empty writes,
bodyless-response refusal, and no producer callback after completion. Existing
slice A close/reset regressions remain the once-only cleanup proof. Oversized
atomic writes retain their existing transport errors and must consume neither
payload nor credit. No fixed queue or flow-control window grows for this matrix.

The [slice B report](m1_response_matrix.md) records the corrected 678/678
combined native run, initial fixture failure, and independent re-review.

## Bounded file-transfer contract

[ADR 0010](../adr/0010-bounded-file-streaming.md) is accepted after architectural
review and independent ownership/framing review. It adds a typed file source,
one transport-owned transfer slot per response, borrowed worker-local route
scratch, and exact known-length framing. The caller's response becomes ended;
an internal streaming view owns subsequent file writes. Returned errors retain
caller descriptor ownership, while accepted transfers close once through the
transport teardown paths.

The review resolved terminal caller state, zero-credit completion, bodyless
framing, permanent zero capacity, scratch aliasing/reentrancy, default-null
target callbacks, positive short reads, and HTTP/2 connection-close cleanup.
Implementation proceeds through HTTP/1 TLS, HTTP/2, HTTP/3, then static
selection, with independent review between slices. No file-transfer source
implementation has landed with this contract record.
