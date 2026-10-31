# Combined HTTP/2 admission schedules

The combined client now implements nine empty-body, limit and refusal/recovery
schedules. Together with the [public](m2_h2_combined_public_cases.md) and
[pause/control](m2_h2_combined_pause_cases.md) units, 17 source schedules are
reviewed. The remaining 23 selections fail before actions; full40/default and
native combined acceptance remain open.

The [source/evidence archive](evidence/m2_h2_combined_admission_cases/README.md)
preserves all 16 current modules, B2 source for comparison, raw results,
immutable model/core/codec/fixture inputs and independent review. Its
[manifest](evidence/m2_h2_combined_admission_cases/manifest.json) binds the
current source and verification scope.

| Case | Heads | Small responses | Request DATA bytes |
| --- | ---: | ---: | ---: |
| empty_headers | 3 | 3 | 0 |
| empty_data | 3 | 3 | 0 |
| empty_declared | 3 | 3 | 0 |
| limit_declared | 3 | 3 | 32 |
| limit_undeclared | 3 | 3 | 32 |
| limit_declared_reject | 4 | 4 | 32 |
| limit_observed_reject | 5 | 5 | 65 |
| zero_declared_reject | 4 | 4 | 0 |
| zero_observed_reject | 4 | 4 | 1 |

The adapter preserves explicit final status and reset policy, waits for
refusal END and complete NO_ERROR reset framing, and pairs retirement through
the existing wire/ledger path. Refusal records stay retained through separate
recovery and health requests. Empty framing and declarations remain distinct;
valid limit uploads use the canonical payload. Observed-limit refusal checks
the accepted 32-byte prefix through one finite status barrier before sending
the offending byte. Declared refusals preserve Expect but allow no Continue
or primary DATA. Refusal response body and informational allowances are zero.

All 24 current focused normal/optimized commands exit 0 with empty stderr.
They cover exact header values/order/multiplicity, DATA ordinals/END/digests,
response-before-reset order, healthy recovery, and nine sequential cases on
fresh connections sharing one synthetic application. Final collection checks
all 13 admission records and the unchanged 67-status-plus-metrics contract.
Negative controls reject reset before END, unsolicited 100, positive refusal
DATA and an incorrect accepted-prefix record. Existing B1/B2 regressions and
AST/inert imports for all 16 modules pass. Independent source/spec/quality and
structural review finds no actionable findings.

The retained pre-change RED proves unsupported-selection rejection only.
Its initial test source was later expanded without a separate snapshot. One
intermediate synthetic final-collection test failure lacks a standalone raw
receipt. These historical limits are recorded; the archived 24 current
commands have separate stdout, stderr and exit evidence.

All peer responses and records are synthetic input. Native callbacks, fixture
execution, transport/runtime safety, performance, full project gates and source
adoption remain unproved. The other 23 schedules, owned runner, runtime closure
and actual sequential two-child combined acceptance remain required. Release
metadata stays 2.1.6; M2 remains open.
