# M2: H1 cold-state preparation

Status: isolated data-only successor verified and independently reviewed,
2026-10-27. H1 delivery and native retirement remain open.

The [checkpoint](evidence/m2_h1_cold_v3/README.md) extends the coherent baseline
with named head-resolution contracts and optional HeadTarget storage. It adds
a delivery pin, pending-payload accounting and an admission callback phase.
The target remains unbound. No resolver, sink, TCP callback, scheduling,
cancellation, physical close, TLS or decoder behavior is activated.

Actual pure regressions first expose two failures: active delivery incorrectly
reports drained, and reset retains pending payload. The final drain guard and
reset assignment fix both. Reset preserves the target, loop handle, generation,
timer and both inline completion objects; tests inspect initialized completion
contents and source review confirms reset never reconstructs native storage.
No native operation is submitted by these tests.

Final focused tests pass 3/3 and whole App tests 20/20 in Debug and ReleaseSafe.
The complete centralized graph compiles for Linux, macOS and Windows without
execution. Formatting, conventions, release metadata and isolated AST update
pass. Existing admission tests pass 7/7 in both modes against identical inputs;
the final test-only correction does not change their graph.

Actual compiler measurements show owner growth of 40 bytes on every target:
Linux 2,840 to 2,880, macOS 2,808 to 2,848, Windows 3,000 to 3,040; alignment
remains 8. Enabled slabs grow by 40,960 bytes for 1,024 owners. All three
disabled slab totals remain exactly equal to the coherent baseline. No capacity,
layout assertion or configuration arithmetic changes.

Independent review finds a macOS fixture error before acceptance: its native
timer timestamp is a timespec rather than a scalar. A two-line test correction
uses the actual timestamp type. Final V2 compilation passes and bounded
re-review reports no actionable findings. V1, behavioral red, compiler failures
and sandbox backend mismatches remain preserved separately. Final runs bind
source, compiler inputs, the requested backend and executable hashes.

The four-file successor preserves all other baseline inputs and the immutable
93-file dependency export. Root production source and pins remain unchanged.
Foreign results are compile-only; these checks establish no native retirement,
live upload, sanitizer or full Root gate result. The next slice must implement
the bounded retirement policy and later bind real delivery and terminal cleanup.
