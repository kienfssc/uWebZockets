# M6 evidence, platform and timer status

Status: partial, 2026-10-27. Optional API decisions are recorded; the other
acceptance items remain independently tracked below. No release, quiet-host
performance, GRO activation or native Windows claim follows from this report.

| Item | Current evidence | Remaining acceptance |
| --- | --- | --- |
| C1 quiet host | Re-declared below; fresh host observation and no benchmark run | Named quiet host, final freeze and every required profile |
| C2 receive GRO | No receive-side implementation in this checkpoint | Ancillary parsing, segment delivery, burst test, real H3 gates and cost evidence |
| C3 HttpArena async | Existing external boundary in the M1 report | Authorized external adapter change, validation and official fresh results, or its dated re-declaration |
| C5 optional APIs | [Three decisions](m6_optional_api_decisions.md) with scoped review | Reopen only against their named requirements |
| C6 timers | Source audit, existing wheel tests and isolated overflow correction below | Token semantics, native parked H2 reset coverage, independent review and combined integration |
| C13 provenance/platform | [Current-pin recovery archives](evidence/m3_pin_archives/README.md) and per-checkpoint cross compilation | Final pins, exact mirrors, second machine and native Windows release job |

## C1 re-declaration

No designated quiet host is available in the borrowed Codespace. The observation
at 2026-10-27 05:06 UTC records CPU affinity 0–1, an uncapped `cpu.max`, an 8 MiB
memlock limit and an unavailable scaling-governor file. CPU model/topology and
kernel output are retained in the [audit package](evidence/m6_timer_audit/README.md).
This shared runner is also executing build verification. No quiet interval,
benchmark backend, worker configuration, optimizer profile or performance sample
was established, and no benchmark was run for this record.

C1 is explicitly re-declared with reassessment on 2026-11-02. Restoration
requires verification's named host owner to provide an isolated machine and
record SMT, quota/affinity, kernel/governor, memlock, backend, optimizer and worker
count against the final source/pin freeze. Run idle-tick cost, pipelined 10M RPS,
baseline 3.5M RPS, the previously stated WebSocket contract, json-comp 400K RPS
with P99 below 50 ms, and latency-1m P99 at most 160 us. Resolve the exact
WebSocket contract number before execution. Preserve warmup, raw samples,
medians, spread, CPU/RSS and P99 in the append-only result directory. Shared
runner comparisons cannot close these targets.

The [M1 report](m1_streaming_static_tls.md) retains its external HttpArena and
profile boundaries. This checkpoint adds no external repository change or
official benchmark result and does not claim async profile activation.

## C6 timer audit and prepared correction

The actual wheel range is `(1 << 26) - 1` milliseconds. Four levels and the
intrusive overflow list allocate no nodes. The existing six pure wheel tests
pass, including the single far-deadline case. Scheduler stop deliberately lets
the bounded driving tick drain rather than cancelling it; existing native
scheduler regression coverage remains in the full suite.

A new pure regression exposes a narrower missed case: when a later overflow
entry is the list head, one large advance can miss an earlier due entry behind
it. The current next-event decision examines only the head. A preliminary test
that first advanced near the earlier deadline passed; its original source and
result are retained. The corrected single-advance test fails before the fix.

An isolated draft scans every overflow entry for the earliest migration time,
without changing storage, callback/count transitions, allocation or I/O. All
seven wheel tests pass in Debug and ReleaseSafe after that correction. It is
archived for review, not integrated: independent review and root combined gates
are still required. These scalar-deadline tests execute the real Wheel code;
they are not native clock, cancellation, crash or race experiments, and imply
no measured wall-clock delay or performance improvement.

The source audit also finds a plan/API mismatch. Repeating AsyncResponse.sleep
replaces one parked callback and re-arms the same node, but does not regenerate
or expire the response token. The C6 requirement to expire the previous token
therefore remains unimplemented. A source-compatible design needs resolution
before changing this API; the public guide documents actual current behavior.
HTTP/1 owns slot 0, HTTP/2 owns one slot per stream, and HTTP/3 has no parking
node. HTTP/1 header_read_timeout_ms covers its parser; H2 header blocks rely on
the encoded-block bound and connection idle deadline. No measured slow-header
workload or new H2 partial-header deadline is claimed.

Native H2 reset-during-parked-delay and explicit second-sleep token acceptance
remain open. Do not infer them from a producer flow-control pause or ordinary
async-token tests. No threshold, assertion or suite is weakened.

## C13 and final freeze

Current-pin archives and local candidate bundles are recovery evidence, not
final release pins. Maintained publication/protection and h1spec attribution
remain in [M3](m3_dependency_provenance.md). No second-machine resolution or
native Windows release run was performed here. Existing Windows/macOS results
are compilation checks only. Refresh archives and run every same-commit
provenance, protocol, package and native-platform gate after the final freeze.
