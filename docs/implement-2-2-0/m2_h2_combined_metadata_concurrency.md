# Combined HTTP/2 metadata and concurrent-route schedules

The combined client now implements `metadata_helpers` and `concurrent_routes`.
Together with the [credit/trailer unit](m2_h2_combined_credit_cases.md), 25 source
cases are reviewed. The remaining 15 selections fail before actions. Full40,
default/aggregate integration and native combined acceptance remain open.

The [evidence archive](evidence/m2_h2_combined_metadata_concurrency/README.md)
preserves all 23 current modules, preceding source, raw results and independent
review. Its [manifest](evidence/m2_h2_combined_metadata_concurrency/manifest.json)
binds every current source hash and the verification scopes.

| Case | Heads | Small responses | Request DATA flow |
| --- | ---: | ---: | ---: |
| metadata_helpers | 6 | 6 | 32 |
| concurrent_routes | 13 | 13 | 96 |

Metadata preserves the exact POST target/query, 66 initial headers including
regular `host: localhost`, and 17 route captures. The first 16-byte DATA span
precedes one paused observation. The second span and exact END trailers precede
the second paused observation, followed by resume.
The checks distinguish initial metadata from trailers and preserve the header
and capture overflow contracts, streaming helper refusals, and middleware,
begin and end diagnostics. The public codec emits `:authority: localhost`
separately; the previous incomplete test omitted the required regular host.

Concurrency holds one route, observes its pause, retains a 503 refusal with no
100 and an ordered NO_ERROR reset, then completes an independent upload.
Finite metrics require two active streams and one pause. Holder resume, its
accepted-prefix checkpoint, completion and route recovery follow the source
order. The refused stream remains retained until its specified retirement.
All five new body records survive fresh connections sharing one synthetic
application and final collection of 67 records plus metrics.

The 30-command normal/optimized baseline passes with empty stderr. A subsequent
test-only cleanup flattened excessive nesting. Four current checks cover the
changed test and all-module AST/inert imports; the other 22 modules are
unchanged. The archive preserves both source versions and all 34 receipts.
Independent source/spec/quality and structural review finds no actionable
findings. Formatting, conventions and release-version checks pass at 2.1.6.

Both initial REDs prove selection rejection only. Intermediate failures
calibrated two negative tests to the actual earlier status/reset diagnostics;
the expectations and thresholds were preserved. Seven direct header controls
prove oracle sensitivity, separately from the serialized schedule checks.
The original partial handoff and all failures remain in the archive.

Supplied model-derived peer records do not independently execute Zig helpers
or establish fixture, native transport, callback or performance correctness.
Six cancellation/application cases and nine lifecycle/output cases, full
default/aggregate integration, runtime closure, native acceptance, project
gates and source adoption remain required. M2 remains open.
