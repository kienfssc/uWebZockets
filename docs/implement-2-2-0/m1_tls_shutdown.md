# TLS graceful shutdown correction

The reviewed successor now retries the first SSL_shutdown stage after actual
output progress and closes only after the alert, BIO and native write ownership
have drained. Strict ordinary TLS clients pass against the isolated source.
Production adoption and genuine early-data graceful closure remain open.

The [source recovery archive](evidence/m1_tls_shutdown/README.md) contains the
two changed files, complete preimages, patch, command records, pinned BoringSSL
analysis and independent transport and crypto approvals. It follows the
[TLS upload driver](m2_tls_driver.md) without adding stored fields, capacities,
public errors, context policy or dependency changes.

## Ownership and progress

The existing tls_shutdown_started flag records successful completion of the
first shutdown stage. WANT_WRITE leaves it pending; a positive native write
completion retries it under the existing callback borrow. Successful first-stage
completion does not wait for the peer's reciprocal alert. TLS graceful batching
arms real output rather than reaching the older ring-only synchronous close.
Both physical-close gates require completed TLS shutdown, empty BIO/ring and
no active write. Pending native arm work survives cleanup and retirement tails.

Pinned BoringSSL source establishes pending application ciphertext and alert
ordering. The correction explicitly aborts when SSL_in_init is true, including
accepted early-data states: BoringSSL can otherwise report shutdown success
without emitting an alert. Authenticated graceful early-data EOF is therefore
unsupported by this slice; replay admission is unchanged.

## Evidence

The predecessor executes 28 passing and two failing policy cases. The frozen
successor passes 30/30 in Debug and ReleaseSafe, unchanged App tests 31/31 and
healthy buffered TLS tests 3/3. Full centralized semantic compilation passes
native Linux, macOS and Windows. Formatting, conventions, release-version,
AST graph and source audits pass.

The [strict live TLS follow-up](m2_tls_live.md) passes 37/37 using the cluster
and 37/37 using the configured single App. Successful responses require an
authenticated TLS EOF. Both runs finish owned active-upload shutdown, emit the
post-deinit marker and reap an exit-zero child without a forced kill. These
Linux results do not establish native Windows behavior or the full release gate.

The candidate's 1023-file source digest is
`b5cf3e793dde126c903abeed8586201274309dfad72fd6252ea54e9411e9aad8`;
its patch SHA256 is
`751f35a26135e3b750ee4966b3090efb4bed72682f6fe4a0e97a152d43e989a5`.
Root source and maintained dependency pins have not adopted this candidate.
