# M2: typed loop callback preparation

Status: isolated successor verified and independently reviewed, 2026-10-27.
Production integration and H1 retirement remain open.

The [checkpoint](evidence/m2_loop_callbacks/README.md) extends prepared R2's
stable guarded handle with one actual pure cancellation-ACK classifier and a
typed callback-failure entry. Epoll success abandons the target; its NotFound
retains it. io_uring success, NotFound and ExpirationInProgress retain the target;
kqueue and IOCP success retain it. Every other representable error propagates
unchanged. Retain never reacquires a cleared pin or grants close permission.
Backend selection remains confined to core_loop.

Cancellation, retirement-timer and close failures use their existing closed
error types. The handle checks the owner/fence invariant and sets its existing
failure latch before a fixed category panic. It adds no stored error record,
application callback, native completion field, layout or root public export.
Disabled callers remain unchanged.

Three pure cases pass in Debug and ReleaseSafe, covering the actual decision
matrix and closed payload types. A conservative initial policy executes and
fails on NotFound before the final policy passes; earlier declaration/comptime
failures are separately retained. Unchanged body-app suites pass 14/14 in both
modes on io_uring. An initial assertion-only epoll expectation mismatch is
preserved separately; correcting the harness expectation changes no production
selector, assertion or test.

The broader core graph and observer compile without execution. Native, Windows
and macOS code generation checks the actual operations; observer IR shows the
latch store before panic. Fatal paths are never executed. Independent source
review finds no actionable findings and confirms source/input stability.

This is a separate two-file successor to prepared App/R2. All 905 base files
and the 93-file immutable local dependency export remain unchanged. Root pins
stay unchanged; the explicit compiler override is not maintained publication
or production adoption. Future integration must preserve the later root timer
correction and reconcile current tests.

The [V6 retirement review](evidence/m2_h1_retirement_v6/README.md) still blocks
the broad close/reuse claim on non-Darwin kqueue. The separate
[activation guard](m2_upload_platform.md) is verified and reviewed under the
user-confirmed community-BSD setup restriction. This checkpoint
adds no H1 consumer, physical-close algorithm, TLS hooks, native cancellation
probe or complete M2 acceptance.
