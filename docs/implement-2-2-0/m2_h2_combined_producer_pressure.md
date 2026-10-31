# Combined HTTP/2 producer reuse and output pressure

The combined client now implements `producer_reuse`, `output_pressure_window`
and `output_pressure_ready`. Together with the [application-error unit](m2_h2_combined_application_errors.md),
34 source cases are reviewed. Six selections still fail before actions;
full40/default/aggregate and native combined acceptance remain open.

The [evidence archive](evidence/m2_h2_combined_producer_pressure/README.md)
preserves all 29 current modules, preceding source, raw results, failures and
independent review. Its [manifest](evidence/m2_h2_combined_producer_pressure/manifest.json)
binds the source and verification scope.

| Case | Heads | Small responses | Request DATA flow |
| --- | ---: | ---: | ---: |
| producer_reuse | 9 | 8 | 64 |
| output_pressure_window | 8 | 7 | 33 |
| output_pressure_ready | 6 | 5 | 33 |

Each producer response has exactly 16777313 canonical bytes and its independent
streaming SHA-256. Output setup requires two parsed SETTINGS acknowledgements,
the exact connection bootstrap, and canonical auxiliary/special grants.
Controlled cases start with stream window zero; ready uses 33554432. Hash-only
completion validates length, digest and END without retaining the response body.

Reuse holds producer A while upload B completes on the reused binding. B must
have the same index and generation exactly A+1; A retains its original identity.
The window case completes a healthy sibling before granting 8192 bytes, checks
the held prefix, then grants the remaining 16769121. Ready waits for both actual
responses, including an echo arriving after producer END. Latest validated
producer diagnostics and B binding remain caller-owned through fresh contexts
and final collection; no extra observation requests are added.

All 36 current normal/optimized checks pass with empty stderr. Each new-suite
mode has five positive executions and 44 synthetic sensitivity controls,
including alternate slot/generation, grant/held/prefix ordering, time limits,
paired completion and retained snapshots. Four new body records and every
untouched record pass final collection of 67 statuses plus metrics. Actual
AST/inert-import checks cover all 29 modules.

Initial RED establishes selection rejection only. Peer grant-order and bounded
read-coalescing corrections, followed by exact negative-diagnostic corrections,
remain archived. The peer's 2400-read test bound was retained. For zero-window
cases, early DATA is rejected by the public codec before the manual response
ledger. These failures
are not pre-fix behavioral or native RED.

Independent source/spec/quality and structural review finds no actionable
findings. The identity audit checks 119 retained rows, 114 unique entries and
all 42 codec files. Formatting, conventions and release metadata checks pass
at 2.1.6. Supplied model-derived diagnostics do not establish Zig callback,
native fixture, runtime, post-deinit or performance correctness. Six remaining
schedules, full integration, native acceptance, project gates and source
adoption remain required. M2 remains open.
