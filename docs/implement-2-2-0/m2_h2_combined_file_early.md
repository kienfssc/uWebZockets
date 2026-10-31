# Combined HTTP/2 streamed-file and early-final schedules

The combined client now implements `stream_file` and `early_final_order`.
Together with the [producer/pressure unit](m2_h2_combined_producer_pressure.md),
36 source cases are reviewed. Four selections still fail before actions;
full40/default/aggregate and native combined acceptance remain open.

The [evidence archive](evidence/m2_h2_combined_file_early/README.md) preserves all
31 current modules, preceding source, failures, raw results and independent
review. Its [manifest](evidence/m2_h2_combined_file_early/manifest.json) binds
source identities and verification scope.

| Case | Heads | Small responses | Request DATA flow |
| --- | ---: | ---: | ---: |
| stream_file | 7 | 6 | 33 |
| early_final_order | 7 | 6 | 32 |

File output selects 24593 bytes at offset 37 from a 24659-byte canonical file.
The generated spans use that full-file total and offset, with a separate range
hash and exactly one content-length header. The client validates the supplied
held-file diagnostic, checks a zero-byte response checkpoint, then completes
the healthy sibling before granting file credit.
After hash-only completion, validated close-once/range diagnostics are retained
alongside earlier parsed producer observations and B binding. No data file or
native handle is opened, read or transferred by this synthetic test.

Early final keeps a healthy holder open while refusal stream 7 receives 403
HEADERS with no 100, DATA, END or reset. One body-status observation precedes
grant 8 and the exact `early-fi` prefix; another body-status observation precedes
grant 9. The resulting 17-byte `early-final-order` response must accept END
before NO_ERROR reset zero. Only then does the holder send its 32-byte body.
Returned reset presence uses an explicit test; zero is a valid reset code.

All 38 current normal/optimized checks pass with empty stderr. Each new-suite
mode has five positive executions and 44 synthetic sensitivity controls,
including an actual earlier serialized producer-reuse run feeding the shared
file/early contexts. Three new body records and all untouched records pass
final collection of 67 statuses plus metrics. AST/actual inert-import checks
cover all 31 modules.

Initial RED proves selection rejection only. Binding setup and exact prefix,
reset-order and public content-length rejection corrections are retained.
An earlier passing matrix and its source version remain distinct from the
current matrix after additional frame/reset assertions. Synthetic output-frame
counts describe peer coverage, not a requirement on native fragmentation.

Independent source/spec/quality and structural review finds no actionable
findings. The identity audit checks 119 retained rows, 114 unique entries and
all 42 codec files. Formatting, conventions and release metadata checks pass
at 2.1.6. Supplied diagnostics do not establish native file ownership, callback,
runtime, post-deinit or performance correctness. Disconnect, reuse, both
shutdown cases, full integration, native acceptance, project gates and adoption
remain required. M2 remains open.
