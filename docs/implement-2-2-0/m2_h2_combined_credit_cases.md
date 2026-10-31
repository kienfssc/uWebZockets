# Combined HTTP/2 trailer and request-credit schedules

The combined client now implements `queued_trailers_padding` and
`receive_credit`. Together with the [Continue/quota unit](m2_h2_combined_continue_quota.md),
23 source cases are reviewed. The remaining 17 selections fail before actions;
full40/default and native combined acceptance remain open.

The [evidence archive](evidence/m2_h2_combined_credit_cases/README.md) preserves
all 20 current modules, prior source, raw outcomes, immutable inputs and
independent review. Its [manifest](evidence/m2_h2_combined_credit_cases/manifest.json)
binds every current source hash and the separate verification scopes.

| Case | Heads | Small responses | Request DATA flow |
| --- | ---: | ---: | ---: |
| queued_trailers_padding | 6 | 6 | 12297 |
| receive_credit | 7 | 7 | 65536 |

The queued case sends 8192 bytes, observes accepted-seven/paused, then queues
4097 bytes with seven padding bytes and their length byte, followed by the
exact trailers. Its second checkpoint must stay identical before resume.
Connection and stream early refunds are independently bounded by 15. The
canonical wire accounts for 12289 logical bytes plus eight padding-flow bytes.

Receive credit sends exactly 65535 bytes on one upload stream, verifies both
exhausted windows and their independent debts, then follows the finite
resume/accepted-prefix sequence. It waits for both earned refunds, checks
restored windows and zero aggregate stream debt, and sends the final byte
with END. The client introduces no grant frames or extra observation heads.

The 28-command normal/optimized baseline passes with empty stderr. It checks
actual serialized headers/multiplicity, DATA stream/ordinals/padding,
trailers/END, independent incremental digest/length/flow, source paths,
fresh connections sharing one synthetic application and final collection of
67 statuses plus metrics. Existing source-unit regressions remain covered.
Initial REDs establish selection rejection only. Synthetic negatives reject
changed paused evidence and an omitted stream refund; the latter ends on
finite synthetic-input exhaustion, not an observed native timeout/server fault.

A stale case-count description was then corrected without changing behavior.
Two current normal/optimized import checks pass, covering all 20 modules with
19 unchanged. The earlier 28 remain preceding-source evidence. Independent
source/spec/quality and structural review finds no actionable findings.

Model-derived peer records do not independently establish native fixture,
callback, transport/runtime or performance behavior. Eight other B5 cases,
nine lifecycle/output cases, full default/aggregate integration, owned runner,
runtime closure, native acceptance, project gates and adoption remain required.
Release metadata stays 2.1.6; M2 remains open.
