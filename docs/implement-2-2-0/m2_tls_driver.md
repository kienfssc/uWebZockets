# TLS HTTP/1 upload driver checkpoint

The isolated TLS driver is implemented and independently source-reviewed.
It reuses the plaintext upload state machine for decrypted HTTP/1 bytes with
separate BIO receive and plaintext extraction bounds. The
[shutdown successor](m1_tls_shutdown.md) and [strict live TLS follow-up](m2_tls_live.md)
now pass; this report retains the original v3 component's scope.

The [recovery archive](evidence/m2_tls_driver/README.md) preserves the actual
three-file overlay, preimages, behavioral red/green evidence, complete checks,
source manifests, pinned-source retry proof and both independent reviews.
It applies over the reviewed plaintext source. Root production source and
dependency pins remain unchanged.

## Concrete implementation

Both actual receive submission and completed-receive retarget/rearm sample the
BIO write guarantee. Already submitted ciphertext remains admissible after a
sink pauses; paused plaintext extraction and further receive arming stop.
Every selected-H1 SSL_read recomputes its free-ingress bound and refuses zero.
Handshake/H2/WebSocket paths preserve their protocol selection.

Resume consumes retained HTTP bytes, then retained SSL/BIO input, without
depending on SSL_pending or another network packet. Existing callback borrows
cover TLS calls, sinks, output flush and batch cleanup. Peer close-notify and
source failures claim their proper cancellation reasons before generic close.
No field, layout, context policy, record/BIO capacity or allocation is added.

Each positive native write completion grants one gated TLS drain opportunity.
Failed-read WANT_WRITE retries require actual BIO removal and finite retained
TLS work; they introduce no new input or application callback in that branch.
Pending native arm work survives batch cleanup and retirement tails, preserving
the next real completion. SSL_want is not used as persistent retry state.

## Component verification

- Genuine capacity red: 19 pass, four fail on the predecessor's policies.
- Frozen candidate: 27/27 Debug and ReleaseSafe; unchanged App 31/31 and
  healthy buffered TLS 3/3.
- Full centralized semantic compilation passes native, macOS and Windows.
- Full-directory formatting, conventions, version, graph and source audits pass.
- Independent transport/spec/quality/maintainability and crypto reviews approve
  the component source. Later enabled-client results are recorded separately.

All 1023 inputs are bound to source digest
`2498622e3a120c6fd0cfee575ad1223b3961ce9e22cbeb9ba39b3d1d59be2cf7`.
Pure policy tests and old healthy TLS cases cannot prove enabled TLS delivery,
authenticated EOF, pressure behavior or native Windows operation.

## Inherited graceful-close follow-up

The closure audit found that begin_tls_shutdown marks its stage before
SSL_shutdown and never retries WANT_WRITE. Under BIO pressure, a successful
HTTP response can therefore close without close-notify. The source report in
the archive records the exact pinned-code basis. The separate
[frozen successor](m1_tls_shutdown.md) is reviewed and passes strict successful
TLS client EOF checks in the [live follow-up](m2_tls_live.md).
Intentional failed-begin/end-error aborts retain their separate contract.

The follow-up establishes ordinary live exact 100000000-byte fixed/chunked TLS
uploads, small ingress versus actual records, retained-data resume, protocol
selection, graceful-close evidence and configured constructor integration.
Genuine early data, sanitizers, maintained adoption and final M2 gates remain
open. No global liveness or allocator-wide claim follows here.
