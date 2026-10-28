# HTTP/2 Session delivery to registered body sinks

The reviewed component connects encoded Session HEADERS/DATA to registered
body-route begin/chunk/end callbacks through shared router admission. It extends
the [receive queue](m2_h2_body_queue.md) and
[measured delivery contract](m2_h2_layout.md). Native App/TCP activation and the
100000000-byte H2/TLS proof remain open.

The [recovery archive](evidence/m2_h2_session_delivery/README.md) contains the
eleven changed source paths, preimages, cumulative Git patch, complete source
inventories, raw commands/results, initial reviews and clean scoped re-reviews.
Its readable [patch](evidence/m2_h2_session_delivery/session-delivery.patch)
reconstructs all 1029 final files over the exact queue baseline. Root production
source and maintained dependency pins are unchanged by this checkpoint.

## Behavior and ownership

The actual neutral admission/reservation policy serves H1 and the concrete H2
driver. Buffered APIs, legacy nullable Content-Length and read-only header policy
remain compatible. Selection, full-u64 framing and admission precede begin/100.
Metadata and overflow captures belong to each stream through response ownership;
trailers validate in scratch. Fresh Responses never survive their effect calls.

Fresh DATA is observed once even while Continue output or older queued bytes
prevent delivery. Synthetic delivery holds do not change actual sink readiness.
The queue drains FIFO, final-byte pause requires resume, and complete accepted
100 HEADERS gates both chunk and end. Padding, current DATA and reclaimed blocks
enter independently pending credit; windows change only after accepted output.
Callback borrows defer metadata reuse and terminal cleanup through unwind.

Independent review found four defects in the first frozen version. Each new
regression failed against its genuine production bytes before fixes:

- Peer reset reclaimed a full held connection window without advertising credit.
  Reset now flushes that credit, retaining blocked intent without duplication.
- A buffered callback that retired its stream and then errored skipped cleanup.
  Success/error exits now share deferred cleanup before slot reuse.
- Reset-and-error could leave the current DATA refund pending after retirement.
  Both retired-identity failure exits now flush, including queued/padded cases.
- DATA-limit413 omitted retained middleware headers. A default-false stack event
  flag routes this failure through the concrete driver's fresh Response. Controls
  expire before cancel, quota releases afterward, fitting headers are restored,
  and final acceptance precedes NO_ERROR reset. Callback retirement suppresses
  later output; blocked/queued variants retain exact-once terminal behavior.

The same two reviewers mark all four findings addressed and find no additional
actionable defect in the fix. The stack flag adds no stored field or retained
Response/factory. The unretainable pre-admission middleware case still produces
a bounded503 before begin/100.

## Verification and storage

The final frozen source is
`1d53c6704d8f31c333052998a85a293834276f386b4239fdbf44556496a5342e`.
173 selected tests pass in each Debug and ReleaseSafe mode,346 executions total:

| Root | Tests per mode |
| --- | ---: |
| Concrete driver and encoded Session | 25 |
| H2 frames / HPACK / queue | 17 / 8 / 9 |
| H2 refusal / full-u64 width | 15 / 2 |
| H1 admission / driver / App head resolver | 7 / 30 / 12 |
| Filtered H2 server / healthy App | 40 / 8 |

The H2 filter selects40/69 tests; healthy App filters select8/31. Complete central
semantic compilation passes Linux, macOS and Windows. Eligible32-bit checks cover
the queue, selected Session width and Bundle/carve roots. Full concrete-driver32
still encounters existing atomic-u64 and masking conversion blockers. Formatting,
conventions, version/docs checks and independent AST refresh pass. Reviewers did
not rerun checks; Root independently binds source bytes and command/result hashes.

Three-target layout measurements preserve every v3 stored size, field offset,
carve size and profile total. Measurements intentionally exit1 for compileLog;
they are not test passes. Session8 is1392 bytes, receive state144, driver1288 and
slot152. Enabled pool/receive storage adds74336 bytes per eight-stream Session;
the concrete driver remains separately caller-owned. Default disabled component
slabs grow8192 bytes relative to the preceding composed baseline. H1 cold owners
have no H2 pointer yet, and native H2 startup remains disabled.

The earlier Bundle alignment repair aligns existing arrays to the common carve
alignment and proves it dominates their natural alignments. Default/private8
totals stay unchanged. Previously undersized nonaligned shapes gain only required
inline padding; aligned/misaligned span, disjointness and bounds checks remain.
No capacity or assertion was weakened.

Preserved failures include incorrect early fixture expectations, real middleware
and alignment reds, an initial patch-format failure, and a stopped broad batch
that reached two sandbox-denied socket tests. Those socket cases were not retried;
final runtime uses the explicit safe filters. Original stopped experiments remain
stopped. The archive retains each diagnosis and exact coverage limits.

Next are enabled-only native storage/late binding, whole-Session operation borrows,
generation-preserving drained reuse and no-output closure. Actual H2/TLS uploads,
HTTP/3 and multipart transport composition, complete applicable runtime/compliance/
sanitizer/fuzz/package gates and native Windows evidence remain M2 requirements.
