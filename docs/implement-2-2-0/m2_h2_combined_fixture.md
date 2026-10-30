# M2: HTTP/2 combined fixture preparation

The combined fixture uses 67 persistent body records and two shared application
slots across the upload, pause, admission, credit, metadata, cancellation,
application-error, lifecycle and output cases. Family views stay in main-owned
storage. Three producer contexts and one file observer retain their bounded
scratch storage and ownership checks.

The fixture implements the [reviewed model](m2_h2_combined_contract.md), including
canonical body and metrics fields, paused totals, subset defaults and the separate
producer B binding marker. Common body fields are serialized once with named
extra-field groups selected through a bounded tag mapping. Compiler-exercised
comparisons preserve all 67 default body schemas and the metrics transitions.

Independent review found incompatible metrics keys, an unguarded diagnostic
helper, and duplicated serializers. The fixes include behavioral RED/GREEN
checks, shared serialization, actual paused-state aggregation, and guarded helper
imports. The source and fix reviews passed after correction.

Both Debug and ReleaseSafe compile from the same frozen final source with an
explicit `LC_ALL=C.UTF-8` environment. Root independently checks all candidate,
override, fixture and original direct-input identities, compiler streams and
artifact hashes. Failed and intermediate attempts are retained separately.
The actual compile-time formatter proof bounds each body at 768 bytes, each
output at 1,024, log prefixes at 64, and the retained dump below 62,144 bytes.
The diagnostic probe reports computed values with an intentional compiler error;
it is distinct from the two successful fixture builds.

The [source and evidence](evidence/m2_h2_combined_fixture/README.md) preserve
current and historical source, exact compiler receipts, pure-check results,
formatter observations, requirements and reviews. No fixture binary was run.
Combined client integration, startup serialization/grants, authenticated runtime
closure, the fresh two-child 40-case execution, broad gates and production
adoption remain open. This preparation does not complete M2.
