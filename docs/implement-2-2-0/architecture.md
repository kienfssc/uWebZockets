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

No source implementation has landed at this checkpoint. Review each completed
slice independently before integrating it into the milestone result.
