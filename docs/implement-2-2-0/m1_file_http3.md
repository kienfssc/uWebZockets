# M1: HTTP/3 bounded file responses

Status: implemented, independently reviewed, and integrated, 2026-10-26.
Combined native, sanitizer, target compilation, and ordinary HTTP/3 interop
proof pass at the frozen backend checkpoint. Live static files follow.

Each QuicStream owns one FileTransfer. Its file callback validates and prepares
the known-length head within existing header bounds before accepting ownership.
Returned errors retain the caller's descriptor; subsequent synchronous faults
use normal failure teardown. HEAD/empty close without reads. Bodyless/CONNECT,
range, occupied-slot, header, and actual body-storage refusals happen first.

Accepted bytes copy into existing response-body storage before partial lsquic
writes. The pump checks completion before writable capacity, retains pending
progress, and clears ownership before close on completion/fault/reset/reuse.
Shared scratch is safe under the existing loop/nonreentrancy contract. TLS,
QPACK, dependency pins, queue capacities, and backend capability bits do not change.

## Tests and review

The [behavioral RED](evidence/m1_file_h3/red.log.gz) passes 694 existing cases
and fails seven new file calls with FileStreamingUnsupported. The earlier
[sandbox failure](evidence/m1_file_h3/red_environment.log.gz) is a translation
cache permission failure, separate from that RED. Escalated execution keeps
the same cache/gate flags.

Eight regressions cover a 64 KiB + 41 byte ranged source using 8 KiB scratch
and 16 KiB transport storage, positive short reads, blocked/partial fake writes,
exact Content-Length/body/FIN, scratch poisoning, two interleaved streams,
pre-accept refusals, HEAD/empty, read/write/header faults, truncation, reset,
and descriptor reuse. Fake writes accept at most 113 bytes and 151 bytes per
event, so accepted data must survive later partial drain.

The isolated [GREEN](evidence/m1_file_h3/isolated_green.log.gz) passes 702/702.
Independent ownership, framing, isolation, structural, and measurement review
finds no actionable issues. The root verifies identical production/test hashes,
merges only the central test import, and obtains
[713/713 combined native tests](evidence/m1_file_h3/green.log.gz), 22/22 steps,
exit 0. Raw logs retain existing deliberate fault warnings; they are not
described as warning-free.

## Storage and next gates

Declaration probes measure QuicStream 808 to 880 bytes on x86_64 Linux and
808 to 888 on x86_64-windows-gnu. At 1024 streams the requested object payload
grows by 73,728 and 81,920 bytes respectively. This excludes unchanged pool
bookkeeping and makes no page-rounding, RSS, performance, or Windows runtime
claim. h3_engine_bytes counts separate byte slabs/pointer arrays and excludes
stream objects; its estimator is unchanged. No TCP slab assertion changes here.

The [source manifest](evidence/m1_file_h3/source_manifest.json) and raw layout
logs bind these results. Formatting, conventions, version/docs, dependency
checks, and graph refresh pass.

The [frozen verification archive](evidence/m1_file_h3/frozen_verification/SHA256SUMS)
binds combined gates to `ee4bf1c9180533cd429c75ed427d8766f467e17d` and Zig 0.16.0:

- ReleaseSafe ASan/UBSan full tests: 713/713, 22/22 steps, exit 0.
- Native ReleaseSafe, Windows GNU, and macOS arm64 compilation: 20/20 steps
  each, exit 0. These are compilation claims, not non-Linux runtime claims.
- Default ReleaseSafe build: 47/47 steps, including http3_server, exit 0.
- Pinned curl 8.21.0/ngtcp2 1.22.1/nghttp3 1.15.0 and aioquic 1.3.0 HTTP/3 gate:
  exit 0. Positive/trailer, malformed/sibling, oversized-QPACK/sibling, and
  300/300 rejection-soak checks pass, followed by healthy requests.

Independent artifact review verifies hashes, exact source/scripts/pins/client
versions, individual statuses, and safe archive paths. No sanitizer violation
appears; deliberate fault warnings remain. The HTTP/3 tar SHA-256 is
`0c96cca12dbbec74ed2cb2a1a240208cc458676526124814ef6f461535eebd34`.
It retains ordinary closed-test QUIC protocol metadata, with no private keys,
credentials, or TLS traffic-secret keylogs. These gates do not prove live static
files, package consumption, MSan, cold fetching, or performance. Later static
and sidecar slices require matching evidence; the 100 MB live matrix remains
M1 acceptance work.
