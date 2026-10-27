# M2: request-streaming platform setup

Status: isolated activation guard verified and independently reviewed,
2026-10-27. H1 delivery and production integration remain open.

The user confirmed that request streaming must refuse setup on community BSD
until worker wakeups and native validation are available. The
[checkpoint](evidence/m2_upload_platform/README.md) implements that policy over
the prepared App/R2 and typed loop adapter. Enabled Linux, macOS and Windows
setup is eligible; other targets return the existing
InvalidTransportConfiguration error. Windows still requires its native release
gate. Eligibility alone establishes no new runtime-support claim.

One pure decision in core_loop owns the platform policy. Config, both cluster
constructors, borrowed owner binding and standalone storage check it before
allocation or mutation. Nonfallible owner/TCP entry points retain their existing
invariant contracts and check before touching enabled state. Direct assignment
to the public upload-owner field cannot bypass those entry checks. Disabled
configuration, generic loops, decoders, registries and BodyState remain usable.
No stored field, default layout, root export or existing error set changes.

The actual policy has executed failing-first evidence, followed by 2/2 passing
cases in Debug and ReleaseSafe. Linux App tests pass 17/17 in both modes with
no skips; configuration, BodyState and decoder checks also pass. Final V2 App
graphs compile for Windows and macOS without execution. FreeBSD compile and
comptime proofs cover refusal before allocation, binding or caller-memory
mutation, plus disabled/generic use. Its complete App test graph compiles;
seven feature-only cases use eligibility derived from the actual policy.

FreeBSD proofs require two explicit u64 result annotations in a temporary
generated C binding for sys/time.h. The raw translation, original header and
exact delta are retained. Product, dependency and compiler sources are
unchanged. These are compile proofs with a documented translation workaround,
not native BSD execution or wakeup validation. Other BSD tags have pure-policy
coverage only. Independent source review found no actionable findings; the
subsequent final V2 Windows/macOS compile records bind the reviewed source.

The unrestricted [V6 retirement claim](evidence/m2_h1_retirement_v6/README.md)
remains rejected. Root accepts its finite-retirement design as an implementation
plan only within the enforced eligible-runtime and ordinary retained TCP
operation contracts recorded in this archive. Actual cold state, callback and
delivery pins, two retirement stages, physical close, final release and TLS
hooks still require implementation and review. This checkpoint supplies none
of those runtime results.

All 905 predecessor files and the immutable 93-file local libxev export remain
unchanged. The explicit compiler override is not a dependency pin adoption.
Future assembly must preserve the later Root multipart and timer changes;
prepared files cannot replace the current Root tree wholesale. No native
cancellation or fault experiment was added or resumed.
