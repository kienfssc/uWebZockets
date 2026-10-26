# M2 typed request design evidence

The accepted [ADR0008](../../../adr/0008-request-body-streaming.md) preserves
legacy Request/OwnedRequest and uses a new metadata-only StreamingRequest.
This archive contains the unchanged architect proposal, corrected derivative,
root decision/review record and all 30 original declaration probe artifacts.
Its manifest binds five actual source files; the integrator verified every
original checksum and those source bindings before packaging.

The actual legacy Request.form narrow-return and exhaustive-catch consumers
coexist with a separate toy refusal type (exit 0). The toy layout probe uses
intentional compileLog failure: view 208 bytes, owner 176, Request 2752 on the
native target. These are proposed shapes, not implemented revised layouts.
Open response error-membership succeeds; send_file rejects BodyNotComplete
because its existing closed set lacks that tag. Reflection/setup diagnostics
remain labeled and retained, including their nonzero statuses.

Independent review required output state to survive upload cleanup. The
corrected lifetime contract also prevents synchronous end/reset from recycling
metadata beneath an active terminal callback. Bounded re-review found no
remaining findings; root accepted the revision. Runtime regression tests and
the revised public-source compiler consumers remain required before integration.

No C graph, linker, native gate, live upload, allocation or performance result
is established here. Internal absolute paths in original command records are
retained for provenance; the outer SHA256SUMS inventory is portable.
