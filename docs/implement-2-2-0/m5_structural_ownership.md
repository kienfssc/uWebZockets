# M5 structural ownership closure

Status: open, 2026-10-27. No M5 extraction is implemented by this checkpoint.
The plan requires feature stabilization first and forbids concurrent ownership
refactoring while App or TCP feature work is active. M2 transport integration
is still open; its prepared changes are preserved separately for review.

## Cluster runtime

The existing worker-group lifecycle policy remains the baseline. Moving the
nested cluster runtime needs an explicit App-private seam and one runtime owner.
It must preserve every public Cluster method, field and error name, worker
release/free order, and publish-report behavior. Acceptance requires start,
join, failure, publish and concurrent-release coverage, plus cluster, sanitizer
and downstream-consumer checks. No new module or passing extraction result is
claimed here.

## Deadlines, parking and rate limiting

Connection deadlines and parking need one named owner, retaining HTTP/1 slot 0
and the HTTP/2 stream mapping. HTTP/3 parking remains unsupported until it has
a stream-owned node. The rate-limit table, index and LRU still need the planned
`src/http/rate_limit.zig` boundary and unchanged middleware re-exports.

Perform these as separate behavior-preserving slices after the transport
lifetime contract settles. Neither extraction may add request-path allocation,
locks, a second ownership surface, or forwarding-only wrappers. Run focused
timer/parking/limiter regressions, public compatibility and sanitizer checks,
then update CODEBASE.md and the architecture guide from the resulting code.

## Current evidence and next acceptance

A branch comparison from baseline
`a96e41705ff24171039c0a6e486b19418bfe7e6e` through the saved feature checkpoints
shows feature edits in App and TCP, with no changes to worker_group or middleware
and no new rate_limit module. Existing full-suite results establish those
checkpoints only; they do not establish the missing extraction or ownership
seam. Source snapshots in [M2 preparation](m2_transport_preparation.md) must be
reconciled before structural work begins.

The next required output is a scoped architecture plan against the stabilized
combined feature tree, followed by independent implementation review and the
named gates. This report keeps M5 open and preserves its full acceptance scope.
