# M2 transport preparation and recovery

Status: prepared and partial work archived, 2026-10-27. These sources are not
integrated into the production library and do not establish live uploads.

The [recovery archive](evidence/m2_transport_preparation/README.md) preserves
separate source trees and evidence for router admission, App/config, guarded
loop handles and cold HTTP/1 storage, plus interrupted H2/H3 refusal drafts.
The account usage limit interrupted the latter workers; their actual saved
files and command results are retained without claiming completed acceptance.

## Prepared components

The router slice introduces a separate BodyMatch and enabled-only storage,
preserves the four legacy handler tags and canonical method/path matching,
and preflights bounded registration before mutation. Admission counters pair
with the common BodyState reservation/terminal authority; counters alone cannot
detect an individual duplicate release while another upload remains active.
Fourteen focused cases pass in Debug, ReleaseSafe and ReleaseFast. Existing
router cases and closed public consumers also pass. The buffered split
preflight improvement has source justification but no retained behavioral
failing-first case of its own. This slice must land with a working consumer.

The guarded loop slice supplies a stable owner handle and explicit caller-owned
failure fence for enabled loops. Infrastructure run/submit failure terminates
before cleanup, retry or reuse; ordinary socket/sink errors retain callback
handling. Borrowed low-level clients must receive a matching handle explicitly.
The original low-level loop pointer API remains available with its original
contract. Focused retargeting, lifecycle and compatibility checks are scoped to
the retained source snapshots and candidate dependency bytes where recorded.

App/config preparation defaults streaming off and reserves typed cold owners
before router allocation. Initialization rolls back its initialized prefix;
binding occurs after stable App/loop placement and before I/O. First-use TCP
owner pointers are explicitly cleared before binding. Prebound routers cannot
bypass the owner-reservation guard. Fourteen focused cases pass in all three
optimization modes with io_uring asserted; old closed error consumers, four
examples and target/layout checks pass. Partial timer initialization failure
has source review only. Full Linux32 App compilation retains reproduced
baseline blockers; this is not a new platform-support claim.

Independent reviews found no remaining actionable findings within those
prepared component scopes. Their complete H1/TLS consumer, protocol fallback,
physical-close/reuse algorithm and combined gates remain absent. The layout
records are provisional per-snapshot measurements, not final cumulative
capacity guarantees.

## Lifetime and head/admission frontier

R3 proposes two fresh retirement timer stages per direction, target callback
pins, and cancellation flags retained through acknowledgement callback frames.
It never closes from the acknowledgement callback. The final timer tail must
be release-safe on each backend. New callback-level failure handling and the
full physical-close proof remain unimplemented and unaccepted.

The maintained epoll dead-target candidate is archived separately in
[M3](m3_libxev_lifetime.md). It does not resolve owned duplicate cleanup.
The retained source-only duplicate proposal distinguishes private registered
state from adding/deleting/worker work, covers accept/recv/send, preserves fd 0,
and invalidates the duplicate cache before closing and acknowledging. No
native leak/cancellation/race experiment follows from it. Later bounded source
corrections are independently reviewed and saved in the linked M3 report:
registered duplicate cleanup, IOCP result classification and worker publication.
The separate failed-registration rollback candidate is now reviewed and saved
there too. The [fresh V6 review](evidence/m2_h1_retirement_v6/README.md) finds a
non-Darwin kqueue worker-wakeup gap that can strand final close. The broad
lifetime proposal remains unaccepted. Root is proceeding with explicit streaming
setup refusal on community BSD as its default assumption; the guard still needs
separate implementation and review. The typed loop-adapter work is independent.

Root provisionally accepts a header resolver returning an unreserved BodyMatch,
followed by an atomic reserve-to-pure-BodyState.arm handoff. No callback or I/O
may intervene. One local rollback exists only before that transfer; afterward
BodyState's reservation and terminal results own every release. The source
proposal also retains pinned headers, bounded tail input and pending response
headers. Its concrete driver and TLS BIO hooks still require implementation
and domain review.

## Interrupted H2/H3 drafts

The accepted narrow plan returns an empty 503 for a valid selected body route
at headers until the respective upload driver exists, before middleware,
quota, sink callbacks, 100 Continue or body accumulation. Strict known framing
errors and existing buffered results retain precedence.

The partial H2 draft begins optional named header classification and deferred
reset after final response headers enter ordered output. The partial H3 draft
begins readonly route classification, checked u64 declared lengths and read
shutdown while response output drains. Their first red/green checks do not
prove blocked output, flow credit, HPACK/QPACK synchronization, sibling
isolation, complete routing/error precedence, target layouts or real clients.
Neither draft has final independent review or permission to land alone.

The subsequent [HTTP/2 checkpoint](m2_h2_refusal.md) completes additional scoped
framing, output-pressure, sibling and capacity checks and preserves exact
source deltas from this recovery archive. Its later reviewed reset-writer
correction remains isolated;
the initial interrupted status above describes the original archived snapshot.
The [HTTP/3 checkpoint](m2_h3_refusal.md) similarly extends the saved H3 draft
with compatibility corrections, completed component checks and independent
review. Both still require combined transport integration and complete gates.

Resume from the archived seed manifests and exact source snapshots, reconcile
root's subsequent integration corrections, and complete those acceptance
criteria. Do not treat any of these separate snapshots as an authoritative
combined build or advertise streaming capability from this recovery record.

The [pure H1 admission checkpoint](m2_h1_admission.md) implements physical bounds
and the atomic reservation transfer separately. It establishes no live driver,
native lifetime algorithm or production activation.
