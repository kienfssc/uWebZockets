# Buffered-helper compatibility compiler proof

The [archive](compiler_proof.tar.gz) preserves two unchanged consumer probes,
exact commands, stdout/stderr, exits, inferred error members, source bindings,
and a 50-file checksum inventory. The [manifest](manifest.json) records the
specific failure and revision boundary. Extract into a new directory and verify
its SHA256SUMS. Initial module-root setup errors and intentional compileLog
measurements remain distinguished from the actual baseline-0/draft-1 proofs.

No public request-streaming implementation has been integrated. The existing
buffered helpers must keep their closed error contracts; the new streaming
surface is under architectural revision. The working isolated lifecycle/control
prototype is retained, with no claim of live upload support.
