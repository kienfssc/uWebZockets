# M1 response-streaming transport matrix

Status: implemented and independently reviewed, 2026-10-26. This is slice B
of M1; it does not close the milestone.

HTTP/1, real BoringSSL TLS through memory BIOs, HTTP/2, and HTTP/3 now exercise
two logical chunks at each of 1 byte, 16 KiB, and 64 KiB. A shared caller-owned
8 KiB fixture generates an offset-derived pattern, poisons accepted source
bytes, and validates exact output. Logical chunks are split into bounded
physical writes; queue and TLS record capacities remain unchanged.

The matrix forces pending returns and transport pressure, checks empty writes,
bodyless refusal, oversized atomic refusal, stable buffer addresses and sizes,
eventual terminal framing, and no producer calls after completion. HTTP/2
restores consumed credit through WINDOW_UPDATE rather than increasing the
initial window. HTTP/3 accepts 257 bytes per event before blocking, preserves
the saved suffix across callbacks, and rejects writes after shutdown. Its
shutdown assertion requires the final payload byte to be accepted first.
Slice A's existing close/reset tests retain once-only cleanup coverage.

The [initial combined run](evidence/m1_b/initial.log) exited 1: 676/678 passed
and two new fixtures crashed when completion tried to arm reads on dummy
sockets. They now model an already-armed read, as the existing fixture does.
The [corrected combined run](evidence/m1_b/green.log) exited 0 with 678/678
tests and 22/22 build steps passing. Both used:

```sh
ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache \
  /tmp/zig-x86_64-linux-0.16.0/zig build test --summary all
```

The combined run includes eight new negotiation tests being saved in the
separate content-coding slice. The transport matrix itself adds seven tests
to the prior 663-test checkpoint. It changes only tests and their shared
fixture, with no production edits. Independent review's two HTTP/3 fixture
findings were corrected and bounded re-review found no remaining actionable
issues.

Formatting, conventions, release metadata, and documentation-link checks pass.
The TLS matrix encrypts and decrypts real records, but it is not the literal
socket proof required by M1-3. Sanitizer, portability, large static transfers,
sidecars, the 100 KiB socket test, and external profiles remain open.
