# Combined HTTP/2 cancellation and peer-reset schedules

The combined client now implements `cancel_ready`, `cancel_paused` and
`peer_reset`. Together with the [metadata/concurrency unit](m2_h2_combined_metadata_concurrency.md),
28 source cases are reviewed. The remaining 12 selections fail before actions;
all40/default/aggregate and native combined acceptance remain open.

The [evidence archive](evidence/m2_h2_combined_cancel_reset/README.md) preserves
all 25 current modules, preceding source, failures, raw results and independent
review. Its [manifest](evidence/m2_h2_combined_cancel_reset/manifest.json) binds
current source hashes and verification scope.

| Case | Heads | Small responses | Request DATA flow |
| --- | ---: | ---: | ---: |
| cancel_ready | 12 | 11 | 40 |
| cancel_paused | 12 | 11 | 65 |
| peer_reset | 11 | 10 | 65 |

The adapter now completes each reset policy through canonical validation and
paired retirement. It rejects successful primary finals and waits for complete
raw frame parsing, including a reset split across reads. Public cancellation
requires incoming CANCEL8; peer reset emits outgoing CANCEL8. Healthy and
refusal behavior remains covered by the shared-adapter regressions.

Each case brackets its actions with health checks. An open one-byte sibling
precedes the primary. Finite observations check accepted-seven/ready,
accepted-seven/paused, or accepted-zero/paused respectively. After terminal
status and reset completion, the first expired resume/cancel pair precedes
earned connection-credit reclamation. Only then does the sibling send `s`
with END. Its healthy echo precedes recovery, the second expired-control pair
and final health. Legitimate remaining stream debt is retained separately.
All six new records and every untouched record pass final collection of 67
statuses plus metrics across fresh connections sharing one synthetic app.

All 32 current normal/optimized checks pass with empty stderr. They cover the
serialized schedules, split reset, 43 postimplementation synthetic negative
controls, earlier changed-seam regressions, and AST/actual inert imports for
all 25 modules. Initial RED proves selection rejection only. A subsequent
behavioral RED parsed CANCEL8, then exhausted finite synthetic input because
the old adapter waited for healthy END; this is not a native hang observation.
Intermediate test diagnostics, a role-test binding correction and metadata-only
audit failures remain archived. No threshold or rejection check was weakened.

Independent source/spec/quality and structural review finds no actionable
findings. The identity audit checks 119 retained rows, corresponding to 114
unique entries after five repeated paths, including the codec aggregate;
all 42 codec files are checked separately. Formatting, conventions and release
metadata checks pass at 2.1.6.

Supplied model-derived records do not independently establish Zig helper,
fixture, native callback, runtime or performance behavior. Three application
error cases and nine lifecycle/output cases, full integration, runtime closure,
native acceptance, project gates and source adoption remain required. M2 remains
open.
