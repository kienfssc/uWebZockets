# Live TLS HTTP/1 request streaming

The corrected cluster server passes 37/37 ordinary TLS cases, and the composed
configured single-App server passes the same 37/37. Both exact 100000000-byte
fixed and chunked uploads produce SHA256
`190f6457d88258809df90a042b0226dab5537a1984f708cfd5bb90005835cea2`.
These Linux io_uring results exercise the reviewed isolated implementation;
production adoption, genuine 0-RTT, other upload transports and final M2 gates
remain open.

The [recovery archive](evidence/m2_tls_live/README.md) preserves actual fixture
source, compiler/client/wrapper identities, raw commands/results, complete HTTP/2
health traces, reviews and combined-source checks. Generated keys/certificates
and binaries are excluded; their recorded identities remain. TLS clients verify
the ephemeral certificate and localhost hostname with TLS 1.3 fixed at both ends.
Successful responses require authenticated EOF; intentional application aborts
are separately classified and never counted as successful graceful closure.

## Retained data and ownership

The private configuration uses a 2816-byte request stride (512 request-line,
1024 headers, 256 buffered body). An actual SSLObject/MemoryBIO client generates
one TLS record with 7206 ciphertext payload bytes carrying 7189 plaintext bytes:
a 189-byte head and 7000-byte body. The remaining plaintext capacity after the
head is 2627 bytes. Delivery pauses at zero accepted bytes, resumes retained
input, completes all 7000 bytes and reaches actual SSL close-notify EOF with
zero application writes after the pause. This proves a record larger than
ingress; a single ordinary socket write alone would not prove that relationship.

The matrix also covers partial/final-byte and trailer pauses, coalesced input,
limits, Expect admission, three concurrent route bindings, same-route quota
reuse, metadata retained by a continuing response producer after upload-slot
reuse, real file response ordering, peer close-notify during a body and ordinary
peer disconnect. Buffered TLS, no-ALPN HTTP/1, HTTP/2 health and WebSocket health
remain usable. HTTP/2 health here is not HTTP/2 upload evidence.

## Shutdown correction and original failure

The first cluster run passed 36/37. Its fixture omitted the public
cluster.catch_shutdown_signals call; SIGTERM terminated child 274544 with status
-15, without a post-deinit marker. Source diagnosis and the complete failed run
are preserved. The reviewed fixture correction adds that one call before run
and keeps every client assertion unchanged.

The corrected cluster run passes 37/37; child 285505 exits zero, is reaped,
emits its post-deinit marker and needs no forced kill. The configured single-App
run also passes 37/37; child 310739 has the same clean outcome. Both observe the
active seven-byte upload's shutdown cancellation before deinitialization.
The [TLS first-stage shutdown fix](m1_tls_shutdown.md) is present in both sources.
Independent transport/fixture/live reviews approve the corrected results.

## Exact sources and checks

The cluster uses source digest
`b5cf3e793dde126c903abeed8586201274309dfad72fd6252ea54e9411e9aad8`.
Its reviewed profile is
`1074312cbf573ba5a35a6c831d4ce2707d699ff937b52834483aef49937cdfe1`;
executed binary is
`0236b0e165bb6db9748934aaa8dcc24b7d339032ab48fcdbfdbe367fae143aa6`.

The single App uses the [configured HTTPS constructor](m2_configured_https.md)
and source digest
`89dce088f5684c9173c45c572e785e7ff9c57991eb152ec76c46a58db481479d`.
Its profile is
`a4f1bd122f5889256559cc8f02ad6a432cec156fb027d9c01a53066df3431016`;
executed binary is
`cdb1b66aab749951f1820f6fdc9cc1f2164a11920c2af3cc8c3051a8249e611b`.
Both run the identical client
`0bbfba36bd9e9bfd51a48f094af5a62eb68670dded74fcd061a5a9997a9c040a`.
Before/after source, override, compiler, libraries, clients and binary identities
match. Runtime statuses are retained independently of final input auditing.

The composed source passes 35/35 selected tests in Debug and ReleaseSafe,
centralized semantic compilation for native Linux/macOS/Windows, full-directory
formatting, conventions and version checks. The four constructor paths overlay
matching preimages; the other 1019 source files remain identical. The dependency
override is the reviewed unpublished c223 libxev candidate, not a changed Root
pin. No sanitizer, allocator-wide, native Windows, full release or genuine
early-data acceptance claim follows from these runs.
