# M1: 100 KiB socket response proof

Status: response proof implemented and independently reviewed, 2026-10-26.
True request echo and official HttpArena evidence remain open.

Two real TCP loopback tests now deliver an exact 102,400-byte producer response
over plaintext and TLS. They use the default 64 KiB write queue, an 8 KiB
caller-owned source buffer, source poisoning after accepted writes, bounded
callback counts, and genuine WouldBlock/drain progress. Queue address and
capacity stay fixed. The supplied Zig allocator permits startup allocation
only; the tests detect further successful allocations, resize, or allocation
failure. This observation does not cover BoringSSL or libxev internal setup
allocators.

The TLS client reads with a full 16 KiB buffer and requires SSL_pending to be
zero before and after each successful read. The pinned BoringSSL implementation
opens one application record at a time and discards handshake records before
returning application data: [ssl_lib.cc](https://github.com/google/boringssl/blob/d3bf4795ad5b79d646cddf2fec687da5b9b502db/ssl/ssl_lib.cc#L846)
and [s3_pkt.cc](https://github.com/google/boringssl/blob/d3bf4795ad5b79d646cddf2fec687da5b9b502db/ssl/s3_pkt.cc#L236).
The test asserts at least seven complete decrypted application records and
the unchanged 16 KiB plaintext record bound. It does not classify TLS 1.3
encrypted handshake tickets from their outer record type.

The first plaintext fixture returned pending at a synthetic logical boundary
after direct-send had delivered the body, leaving no completion to resume its
terminator. [State evidence](evidence/m1_f/plain_state.log) identifies that
fixture misuse. The corrected socket producer yields only on real pressure
and uses balanced existing write batching to exercise the unchanged ring.
The [corrected run](evidence/m1_f/socket_green.log) passes 680/680 tests.

Independent review then identified that Threaded netRead turns a socket-option
timeout into a process abort. A real silent-peer regression reproduced it in
the [RED run](evidence/m1_f/timeout_red.log). A narrow test-local recv helper
now maps timeout errors and bounds interrupted retries on POSIX and Windows,
allowing ordinary deferred shutdown/join. The existing streaming timeout stays
five seconds; the dedicated silent-peer check uses 50 ms. The
[final GREEN run](evidence/m1_f/green.log) exits 0 with 681/681 tests and 22/22
steps. Independent bounded re-review found no remaining actionable findings.

```sh
ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache \
  /tmp/zig-x86_64-linux-0.16.0/zig build test --summary all
```

Formatting, conventions, release metadata, and graph refresh pass. The new
Windows receive branch still requires compilation and native runtime evidence.
Sanitizer results for this new test checkpoint remain pending; the earlier
immutable runtime checkpoint has its separate sanitizer evidence.

These tests trigger a generated response with GET and preserve default request
limits. A true 100 KiB incoming-body echo requires its own request-capacity
probe and bounded configuration or streaming contract. HttpArena's
[official adapter contract](https://github.com/MDA2AV/HttpArena/blob/d92ece0b27c595cfae0434eb71568e9f7b5bd001/site/content/docs/test-profiles/h1/8gbit/implementation.md)
requires POST /echo and returning the received bytes. That adapter and its
official run are external work; these socket tests do not close them.
