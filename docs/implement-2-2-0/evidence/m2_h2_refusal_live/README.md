# Owned TLS/HTTP/2 refusal evidence

The [archive](h2-refusal-live.tar.gz) supplements the
[isolated H2 checkpoint](../m2_h2_refusal/README.md) with an executable server
fixture, commands, raw curl/server output and complete draft source bindings.
Its underlying production H2 source bytes are unchanged.

SHA256: `3e5bb1757169134a33727ff055363cf620eb9ed30c88b1c96fb618681c632d4e`
(33,048 bytes). Packaging verified 20 safe regular members and 19 inventory
entries. The [manifest](manifest.json) binds each file. A byte scan found no
matching environment credential values or GitHub token patterns.

Curl 8.5.0/nghttp2 receives an empty HTTP/2 503 over TLS before sending any
bytes of its valid 100,000,000-byte upload source, with no 100 Continue. A second
healthy HTTP/2 request reuses the same TLS connection and returns 200 with `ok`.
The io_uring server records zero sink calls and quota, with exactly one
middleware and handler invocation for the healthy request. Both processes exit
zero; the owned server drains and is reaped. The sparse upload fixture is removed.

The initial fixture compile failed on an ignored App.use return value; the
corrected harness explicitly discards it. No production fix was needed.
Derived binaries and ephemeral TLS key material are not archived. This proves
normal header refusal and connection reuse, not a successful 100 MB upload or
full M2 acceptance. Independent review and combined integration remain open.
