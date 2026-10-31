# Combined HTTP/2 Continue, quota and failed-begin schedules

The combined client now implements `continue_ready`, `continue_paused`,
`quota_refuse` and `begin_failure_rollback`. Together with the
[admission schedules](m2_h2_combined_admission_cases.md), 21 source cases are
reviewed. The remaining 19 selections fail before actions; full40/default
and native combined acceptance remain open.

The [evidence archive](evidence/m2_h2_combined_continue_quota/README.md) preserves
all 18 current modules, prior source, immutable inputs, initial test, actual
failure history and independent review. Its
[manifest](evidence/m2_h2_combined_continue_quota/manifest.json) binds source
identities and separates the two verification scopes.

| Case | Heads | Small responses | Request DATA bytes |
| --- | ---: | ---: | ---: |
| continue_ready | 3 | 3 | 32 |
| continue_paused | 5 | 5 | 32 |
| quota_refuse | 11 | 11 | 128 |
| begin_failure_rollback | 4 | 4 | 32 |

Continue paths require exactly one 100 before positive DATA. The paused path
checks its finite status barrier and pending response before using the
admission-specific `/resume/:tag` route. Quota checks four active-count
barriers, `2,0,2,0`, against all model counters, strict response types, slot
occupancy and middleware totals. Distinct holders, refusal and recoveries
retain independent diagnostics. Failed begin keeps its attempt/failure record
while the separate healthy recovery completes. Refusals use explicit 503,
zero informational/body allowances and ordered final-before-NO_ERROR reset.

The baseline's 26 normal/optimized commands exit 0 with empty stderr. They
check exact headers, declarations, Expect/END, DATA sizes/digests, request
order, active barriers, nine shared records across fresh connections and final
67-status-plus-metrics collection. Negatives reject DATA before Continue,
missing/unsolicited Continue, refusal DATA, early reset/completion, incorrect
active/paused evidence, wrong failure counters and an unrelated-record change.
Existing source units remain covered.

Before review, an unused duplicate constant was deleted. The focused Continue
and import tests then pass in both modes: four current commands, with 17
modules unchanged. The earlier 26 results remain prior-source evidence. AST
and actual inert imports cover all 18 current modules. Independent source,
quality and structural review finds no actionable findings.

The retained RED proves selection rejection only. Later negatives are
synthetic sensitivity controls; intermediate failures and their corrections
are preserved. Editing commands omitted exact-path/`-B -S` discipline, and one
search preceded graphify. Current workspace Python resolves to the pinned
3.14.2 binary, but historical commands were not replayed. The review approves
current source with these process qualifications; it does not certify a clean
historical process. Behavioral tests used the pinned invocation.

Synthetic model-derived records do not independently establish native fixture,
callback, FIFO, transport/runtime or performance behavior. The other 19
schedules, full default/aggregate integration, owned runner, runtime closure,
native acceptance, project gates and source adoption remain required. Release
metadata stays 2.1.6; M2 remains open.
