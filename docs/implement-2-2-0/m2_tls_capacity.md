# TLS input capacity clarification

ADR0008 now distinguishes encrypted receive capacity from retained HTTP
plaintext capacity. This is an independently reviewed design decision for the
next isolated TLS implementation; it is not a TLS upload result.

Raw reads and every enabled HTTP/1 SSL_read retain the
min(8192,free_ingress) bound. Selected TLS HTTP/1 additionally requires positive
plaintext capacity and readiness before another encrypted receive. Its byte
count uses min(8192,the network BIO write guarantee). Existing bounded BIO
storage retains ciphertext independently, so a small HTTP window need not force
one small socket receive per fragment of an encrypted TLS record.

The [source-bound evidence](evidence/m2_tls_capacity/README.md) records the
architect's plan, independent crypto review, explicit ADR preimage/amendment and
pinned header/implementation identities. BoringSSL's BIO pair has independent
direction buffers; the write guarantee reports available inbound acceptance.
The existing sole inbound writer, single active receive and deferred BIO
destruction preserve the reservation sampled at submission or rearm. If a sink
pauses after submission, that completion may retain its reserved ciphertext,
but must not extract plaintext or rearm while paused.

Handshake and selected H2/WebSocket processing retain their protocol paths and
BIO bounds. TLS HTTP/1 resume must consume retained HTTP bytes before extracting
more TLS plaintext, including ciphertext already in the BIO. SSL_pending alone
cannot establish whether this work is available. Zero-capacity SSL_read is
forbidden. No buffer, field, allocation or protocol discriminator is added by
this decision.

Concrete code review must verify both submission/rearm sites, callback and
metadata ownership, WANT_WRITE continuation from real output progress, actual
early-data state and peer/source cancellation reasons. The implementation,
ordinary TLS clients, sanitizer/platform checks and complete M2 acceptance are
still pending. Root production source and dependency pins are unchanged.
