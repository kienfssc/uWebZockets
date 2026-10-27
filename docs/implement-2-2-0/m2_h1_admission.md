# M2: pure HTTP/1 admission preparation

Status: isolated helper verified, 2026-10-27; independent review and the concrete
HTTP/1/TLS consumer remain open. This implements the pure bounds and reservation
handoff from the accepted head/admission seam, without native I/O or callbacks.

Physical ingress derives tail capacity using checked subtraction. Empty bodies
need no tail, positive fixed bodies need one byte and chunked framing needs
three. Chunk-line content is bounded by min(H, R - 2). Logical u64 lengths never
narrow to usize during this physical-capacity decision.

The handoff rejects busy or already reserved common state before changing
router counters. It reserves the actual selected BodyMatch and immediately
calls BodyState.arm, with no I/O or user callback between them. If pure arm
validation fails, one untransferred reservation is released. After success,
common-state rejection and terminal booleans remain the sole release authority.
No second ticket or stored reservation flag is added.

## Verification

The [checkpoint](evidence/m2_h1_admission/README.md) preserves five source
replacements/additions over the prepared App tree, the scoped plan and raw
command/source bindings. Seven cases pass on native Debug, ReleaseSafe and
ReleaseFast, and actual Linux32 ReleaseSafe. They cover physical bounds near
machine-width limits, a successful reservation transfer, failed-arm rollback
while another reservation remains active, quota/stale-route rejection, busy
state and terminal release authority. All application callback counters remain
zero. The central test root also passes those seven filtered cases, verifying
wiring without claiming the full combined suite.

The first red is missing-declaration compilation, not a behavioral reproduction
of an existing production defect. Formatting and conventions pass. The initial
version check failed because the new isolated tree omitted CODEBASE.md; copying
unchanged prepared-baseline metadata restores the passing 2.1.6 check. Both
records remain; no release version changed.

This helper is not connected to the production library. It adds no HeadTarget,
App resolver, middleware execution, sink delivery, pending-response storage,
read/write scheduling, TLS hook or close/retirement algorithm. The earlier
native experiment remains stopped. Final independent review is unavailable
under the current account usage limit. The actual driver, backend lifetime
prerequisite, crypto review, live plaintext/TLS uploads, H2/H3 integration and
combined gates remain required before exposing the prepared public surface.
