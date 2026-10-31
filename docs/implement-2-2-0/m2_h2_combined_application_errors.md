# Combined HTTP/2 application-error schedules

The combined client now implements `sink_error`, `invalid_progress` and
`end_error`. Together with the [cancellation/reset unit](m2_h2_combined_cancel_reset.md),
31 source cases are reviewed. Nine lifecycle/output selections still fail
before actions; full40/default/aggregate and native acceptance remain open.

The [evidence archive](evidence/m2_h2_combined_application_errors/README.md)
preserves all 27 current modules, preceding source, failure history, raw results
and independent review. Its [manifest](evidence/m2_h2_combined_application_errors/manifest.json)
binds current source hashes and verification scope.

| Case | Heads | Small responses | Request DATA flow |
| --- | ---: | ---: | ---: |
| sink_error | 11 | 10 | 48 |
| invalid_progress | 11 | 10 | 48 |
| end_error | 10 | 9 | 65 |

Sink/progress cases send seven canonical bytes, observe accepted-seven/ready,
then send the canonical first eight bytes at offset zero. The failing callback
accepts no additional bytes. End-error sends 32 bytes with END, records one end
error and no cancellation. Complete-frame parsing and the fixture's callback
state support the exact prefix and callback-order checks, as confirmed in review.

Each primary requires INTERNAL_ERROR2 without a successful final response. The
adapter extends its existing reset completion policy while preserving complete
raw parsing, validated reset events and paired retirement. After terminal
status and completion, the first expired-control pair precedes earned credit
reclamation. The sibling then sends `s` with END; its echo precedes recovery,
the second expired-control pair and final health. Six new records and every
untouched record pass final 67-status-plus-metrics collection across fresh
connections sharing one synthetic app.

All 34 current normal/optimized checks pass with empty stderr, including prior
changed-seam regressions and AST/actual inert imports for all 27 modules. Each
mode includes six positive executions and 64 synthetic sensitivity controls.
The initial test remains byte-identical to the final test. Initial selection
RED is separate from each case's parsed INTERNAL_ERROR2 followed by finite
synthetic-input exhaustion in the old completion loop; no native hang is claimed.
The metadata path-alias audit correction and its failure receipt are preserved.

Independent source/spec/quality and structural review finds no actionable
findings. The audit verifies 119 retained identity rows, 114 unique entries and
all 42 codec files. Formatting, conventions and release metadata checks pass
at 2.1.6.

Supplied model-derived records do not execute Zig callbacks or independently
establish fixture, native transport, runtime or performance correctness. All
nine remaining schedules, full integration, runtime closure, native acceptance,
project gates and source adoption remain required. M2 remains open.
