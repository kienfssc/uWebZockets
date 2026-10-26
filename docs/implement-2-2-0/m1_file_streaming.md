# M1: bounded file streaming

Status: HTTP/1, HTTP/2, and HTTP/3 file backends implemented and independently
reviewed, 2026-10-26. Basic static delivery is integrated; sidecars and final
combined gates remain open.

## HTTP/1 ownership and framing

The first slice implements [ADR 0010](../adr/0010-bounded-file-streaming.md):
Response.stream_file accepts a named FileSource containing the descriptor,
Io context, borrowed scratch, offset, and declared length. The complete head
must be accepted before ownership commits. Every returned error leaves the
file with the caller; synchronous faults after acceptance use transport
teardown. Success ends the caller's Response while TCP drives its private
producer view.

A focused file_transfer module holds positional progress and performs at most
one bounded read per callback. It accumulates legitimate short syscalls,
refuses premature EOF, advances only accepted bytes, and checks completion
before testing credit. Descriptor ownership clears before close, including
fault, connection close, protocol reset, and reuse. Scratch remains borrowed
and separate from output/TLS storage; no allocation or lock enters this path.
The operations are bounded synchronous disk reads.

HTTP/1 emits the exact Content-Length and raw body bytes. Its file producer
holds pipelined dispatch until the final queued bytes drain, avoiding a later
response head competing for a full ring. This changes only the private file
completion path. HEAD and empty files close accepted descriptors without body
reads. Bodyless statuses, successful CONNECT, invalid source ranges, occupied
slots, unsupported targets, and head-capacity errors retain caller ownership.
Plaintext send_file retains its existing kernel path.

HTTP/2 and HTTP/3 gain default-null, named file-arming callback fields. Existing
custom target initializers remain valid and refuse unsupported file streaming
before ownership. [The HTTP/2 backend](m1_file_http2.md) implements its callback;
[The HTTP/3 backend](m1_file_http3.md) now implements its callback too.

## Verification

The API-absence [RED](evidence/m1_c_h1/red.log.gz) fails compilation at the
missing named source/method. The [native GREEN](evidence/m1_c_h1/green.log.gz)
passes 694/694 tests and 22/22 steps, exit 0. Ten new tests cover framing and terminal
state, offset/range bounds, caller ownership on error, short file/truncation
faults, close/reset/reuse, exact ring-boundary pipelining, and real 100 KiB TLS
and plaintext file sockets with 8 KiB scratch. Socket checks compare exact file
bytes, Content-Length, keep-alive reuse, bounded queue storage, and the supplied
allocator's observations.

Review caught an unconnected test socket that produced ENOTCONN during normal
read rearming. A real accepted socket and held-open peer correct that fixture.
This exposed an artificial full-ring setup that could actually flush: the
[connected-pressure RED](evidence/m1_c_h1/connected_pressure_red.log.gz) has
693 passes and one crash after unexpected file acceptance. The final test
establishes a real submitted write with callbacks unticked before checking
WouldBlock. Its cleanup tracks unexpected ownership transfer before reporting
assertions. The final GREEN above has no ENOTCONN path; initial output remains
under initial_green.log.gz. Independent re-review closes both findings.

The [downstream consumer](evidence/m1_c_h1/package.log.gz) compiles the public
FileSource and stream_file signature: 16/16 steps, exit 0, ReleaseSafe.
Independent runtime/test and public-surface review found no actionable issues.
The ownership contract is documented in [HTTP](../http.md#bounded-file-responses)
and linked from [the API guide](../api.md#response).

The native default slab grows by 73,728 bytes, exactly 72 bytes per connection,
to 683,538,048. The Windows file slot measures 80 bytes/alignment 8, giving an
exact expected total of 683,972,224. Actual-source probes measure both macOS
arm64 and x86_64 at 683,456,128, exactly 81,920 bytes below Linux across 1,024
connections. The kqueue Completion is 16 bytes smaller than the Linux dynamic
Completion, and each connection contains five of them. Full target compilation
remains required. Layout probes intentionally fail at compileLog and are
retained as measurements, not passing gates.

The preceding echo checkpoint's macOS compilation exposed the pre-existing
assumption that all POSIX backends share the Linux slab layout. Its unmodified
failure is retained with [the echo evidence](m1_tls_echo.md). Target-specific
measurement preserves strict equality for each layout. The corrected full
[macOS arm64 gate](evidence/m1_c_h1/macos_arm64_green.log.gz) passes 20/20
ReleaseSafe compilation steps, exit 0, on the same final bytes as native.
Formatting, conventions, release metadata, documentation, the online fork
check, and graph refresh also pass. The graph retains its documented partial
C-header extraction warning.

The clean 9ac0566f1af87f50eebe56be6bd605f1adc671f3 checkpoint subsequently
passes canonical Nix ASan/UBSan/leak checks with 694/694 tests, plus ReleaseSafe,
Windows, and macOS arm64 compilation with 20/20 steps each. All exits are 0.
[The frozen evidence](evidence/m1_c_h1/frozen_verification/SHA256SUMS) retains
the driver, launcher, exact commands, raw output, separate saved statuses, and
clean source identity. Its eight source-file hashes match the pre-commit
snapshot. The same checkpoint's fresh default ReleaseSafe build passes 47/47
steps and [h1spec](evidence/m1_c_h1/frozen_verification/h1spec/README.txt) passes
33/33 with runner/gate exits 0. Its driver verifies ownership of the listener
and records intentional SIGTERM termination as 143; this is not a graceful
shutdown claim. These results verify this checkpoint, not later H2/H3 work.

## Remaining integration

The HTTP/2 slice implements persistent slots, known-length headers, bounded
windows, close/recycle cleanup, and real TLS reset isolation.
The HTTP/3 slice adds persistent transfer state and retains accepted bytes in
its existing output storage through partial writes. The integrated native suite
passes 713/713; combined sanitizers, platforms, and live client gates follow.

[Basic static delivery](m1_static_streaming.md) now passes 730/730 native tests,
including real 100 MiB TLS HTTP/1 and HTTP/2 downloads. Next select fresh confined
gzip/br sidecars and apply validators/ranges to that representation. Large
plaintext/live-H3 static transfers and final-source gates remain open.
