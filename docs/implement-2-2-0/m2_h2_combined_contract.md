# M2: HTTP/2 combined acceptance contract

The combined-run preparation now has one catalogue for all 40 case IDs and an
independent expected-state model for 67 persistent body records. It preserves
each family's metadata, helpers, controls, failure causes, accepted prefixes and
separate hashes. Subsets retain exact unused defaults; pre/post-deinit checks
allow only the specified active-shutdown transition.

The catalogue requires a fresh idle child followed by a fresh main child ending
with active shutdown. It derives request counts and finite receive/debt budgets
with checked arithmetic, retaining inherited 4,096-read limits. Source ordering
supports one status request after flushing an action, with immediate failure on
mismatch. Continue and disconnect retain their additional ordering requirements.
These are contracts for the future combined harness, not measured traffic.

Independent review found three missing contracts: the idle read limit, exact
buffered/async results with unchanged sink state, and producer B's default and
post-deinit binding. The fixes add focused failing-before/passing-after checks.
All three covering scripts pass normally and with Python optimization; authored
checks remain active under `-O`. Source/specification and quality re-review pass.

The [source and evidence](evidence/m2_h2_combined_contract/README.md) retain the
current model, first-review history, requirements, source identities, raw check
results and reviews. Root independently verifies source equality and the
retained source bindings before publication.

No fixture, build or native execution is performed by this slice. Actual startup
serialization, formatter bounds, the combined client and runtime closure, fresh
Debug/ReleaseSafe builds, and the two-child 40-case execution remain open. The
[prior native checkpoint](m2_h2_output_live.md) proves 40 distinct IDs across
checkpoints; it does not establish the combined run or complete M2.
