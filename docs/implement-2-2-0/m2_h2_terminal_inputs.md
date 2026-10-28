# HTTP/2 terminal input closure and drained reset

The reviewed successor to [startup storage](m2_h2_native_startup.md) closes all
active request inputs before connection teardown and prevents driver reuse while
request state is still borrowed. It preserves ordinary GOAWAY response delivery
and receive-credit accounting. Native TCP composition and live H2/TLS upload
acceptance remain open.

The [recovery archive](evidence/m2_h2_terminal_inputs/README.md) contains the four
changed source paths and their preimages, complete source inventories, raw
verification records, measurements and independent reviews. The readable
[patch](evidence/m2_h2_terminal_inputs/terminal-inputs.patch) reconstructs final
source over the exact startup baseline. This component checkpoint changes no
Root production source or maintained dependency pin.

## Closure and reuse

`Session.close_body_inputs` snapshots stream identities, records first causes,
retires every identity before notification, and abandons pending output and
credit intents. A callback already borrowing request data delays its terminal
cleanup until unwind. Notification retains the guard through both body and
legacy callbacks, attempts queue and credit cleanup after errors, continues
through siblings, and preserves the first error without replaying notification.
Ordinary local reset queues its frame before retiring and notifying the stream.

An explicit default-false `ReceiveState.credit_abandoned` flag distinguishes
bulk teardown from GOAWAY. A closed Session with no remaining stream identities
does not identify teardown: ordinary GOAWAY must still return accumulated
connection credit and permit pending output for active streams. Retired stream
credit is cleared in both cases. The seven-byte pending-credit regression keeps
its original assertion.

`Driver.is_drained` examines initialized slot state without dereferencing Session,
admission or target storage. `reset_drained` preflights every slot before changing
any, returns `BodyStateBusy` for a live borrow/reservation/binding, and preserves
generations and stable owner/index associations. The caller must separately prove
Session, response and native transport quiescence. These operations alone do not
establish native release safety.

Root found excessive nesting after the initial reviews. A server-only refactor
extracts terminal-result validation and queue/credit retirement into helpers.
Both original reviewers rechecked that diff and classified the finding addressed,
with spec and quality pass and no new actionable findings.

## Verification

Final source is 1029 regular files, digest
`aa420a97e62062d78c0d3c2fd2f35df11115ef85b8b7cfe316d3734d592a6fd0`.
The final refactor changes only `server.zig` from the earlier reviewed component.
All of the following run on this final tree in both Debug and ReleaseSafe:

| Selected root | Results per mode |
| --- | ---: |
| Concrete H2 upload driver | 39 |
| H2 server, exact permitted filter | 40 |
| H2 refusal | 15 |
| H1 head | 12 |
| H1 upload driver | 30 |
| Healthy App filters | 8 |
| H2 config | 3 |
| H1 admission | 7 |
| H2 frames | 17 |
| HPACK | 8 |
| Body queue | 9 |
| Width/carve | 2 |
| Total | 190 |

Coverage includes callback reentry, error cleanup, sibling terminalization,
first causes, metadata borrows, Continue/DATA ordering, explicit close without
new output/credit, ordinary GOAWAY under bounded writer pressure, busy drain,
generation-preserving reset and reuse. The local-reset and seven-credit GOAWAY
regressions have retained failing-before/passing-after evidence. Intermediate
ordinary-reset failures and their corrections remain in the archive.

Central semantic compilation passes Linux, macOS and Windows; selected, queue
and matrix roots compile for eligible x86 32-bit. Formatting, conventions,
release version, documentation and identical-copy AST refresh pass. Full
`zig build test`, sanitizer runtime, h1spec and native live acceptance remain
unrun under the component restrictions. The stopped native experiment and
denied socket cases remain stopped.

Two compound error combinations were inspected but not executed directly:
an original callback error plus deferred terminal-cleanup error, and a buffered
handler closing all inputs before returning an error. Source preserves original
error precedence and legacy buffered error absorption after successful cleanup;
these are explicit coverage limits. The shared driver fixture grows from 985 to
1307 lines. Both reviews considered its structural size flag and found no
concrete complexity-reducing split for these cohesive cases.

## Measured storage and evidence provenance

The optional marker fits existing native eight-stream layout padding on all
three 64-bit OS targets. Native types, slab totals and offsets, and every
default-disabled shape, remain unchanged from startup. Enabled generic width 2
grows from 80 to 88 bytes for ReceiveState, 249720 to 249728 for Bundle, and
249712 to 249720 for carve. Enabled widths 1/3/4/8 do not grow on those targets.

Eligible x86 32-bit uses four-byte natural alignment: enabled widths 2/4/8 grow
by four bytes for ReceiveState, Bundle and carve. Widths 1/3, Session sizes and
disabled shapes remain unchanged. Root explicitly approved both measured
rounding cases. This is storage/compilation evidence, not complete 32-bit support.
CompileLog exit 1 is a measurement. Private offset inspection uses a separately
identified diagnostic copy with only function visibility changed.

The first 32-bit refactor comparison accidentally selected the same source twice.
Its records remain marked non-comparative; the corrected pair uses distinct
preimage/final trees and produces identical measurements. Historical runs remain
bound to their actual sources. Most older runtime logs lack individual historical
digests; publication inventory binds their current bytes without inventing an
earlier hash. New refactor records hash their raw logs immediately.

Root independently checks all final source files, 117 indexed artifacts,
24 compile/run pairs, binary and external input identities, all 93 reviewed
libxev override files, measurements and exact patch reconstruction. Native
callbacks, whole-operation borrows, async completion pins, producer/file and
transport release safety, live 100000000-byte uploads, production adoption and
the remaining M2 gates still require completion.
