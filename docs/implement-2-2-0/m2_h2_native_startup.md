# HTTP/2 startup storage and stable owner binding

The reviewed startup component extends the [Session/sink implementation](m2_h2_session_delivery.md)
with enabled-only native slab storage and stable owner binding. Native body
callbacks, TCP lifetime composition and actual H2/TLS upload acceptance remain open.

The [recovery archive](evidence/m2_h2_native_startup/README.md) preserves five
changed source paths, preimages, source inventories, raw verification, measurement
sources and independent review. Its readable
[patch](evidence/m2_h2_native_startup/startup-storage.patch) reconstructs every
final file over the exact Session baseline. Root production source and maintained
dependency pins remain unchanged by this checkpoint.

## Startup ownership

The existing streaming flag now reaches H2 capacities. Checked slab planning and
carving provide the Session receive pool, one concrete driver per enabled
connection, and separate per-stream capture-name/value overflow matrices. Disabled
regions stay empty. The receive pool remains independent of positive buffered body
stride; it is allocated once, through existing Session storage.

One typed H2 pointer lives in the existing H1 cold owner. App initializes drivers
in their final slab positions and calls bind once. Session, connection and slot
addresses remain stable. Router associations are bound later alongside the existing
guarded H1 target. Rollback/drain checks inspect initialized slot state without
dereferencing an unbound Session or target. Inert reset preserves the cold pointer
and generations. The named Router adapter preserves the supplied admission input,
including early_data_forbidden; deriving native policy remains later work.

Independent correctness, compatibility and strict structural review found no
actionable defects in this scoped component.

## Verification and measured memory

Final source digest is
`d69d1fb4f318f660ec5163315b1e70824a4a112803ad980bdcda7572b6d2c13f`,
1029 regular files. 140 selected tests pass per Debug/ReleaseSafe mode: config3,
healthy App8, filtered H2 server40, H1 head12/admission7/driver30, H2 refusal15
and concrete H2 driver25. Tests cover every populated carved-region pair,
alignment/bounds, real short/misaligned buffers, two connections/eight streams,
20-parameter capture overflow, body-stride independence and stable late binding.

Complete central semantic compilation passes Linux/macOS/Windows. Eligible32-bit
queue, width and Bundle/carve compilation passes; complete-driver32 limitations
remain. Formatting, conventions, release version, docs and independent AST refresh
pass. This is selected caller-buffer/healthy coverage, not full native runtime.

Measured64-bit slab totals:

| Target | Default disabled | Default enabled | Small8 enabled |
| --- | ---: | ---: | ---: |
| Linux | 684185216 | 764591744 | 5431552 |
| macOS | 684103296 | 764477056 | 5430656 |
| Windows | 684684928 | 765255296 | 5436736 |

Small8 uses eight connections,512-byte request lines,1024-byte headers and a
256-byte buffered body limit. Both supplied base profiles have zero capture overflow.

Disabled totals equal the Session checkpoint and preserve its8192-byte warm
increase over the composed pre-Session baseline. Each enabled connection adds
74336 receive/pool +1288 driver +8 cold-owner bytes over the preceding enabled
plan,75632 bytes before nonzero capture overflow. Two64-bit capture matrices add
connections*8*extra_params*16*2 bytes. SlabLayout adds three slice descriptors;
its measured size is424 bytes, not a per-connection slab charge.

Actual public-plan/type probes compile the frozen candidate. Private offset
inspection uses a separately identified diagnostic copy whose sole change exposes
layout_offsets; its function body and all layout types remain identical. All four
profile totals agree on all three targets. These compiler invocations intentionally
exit1 for compileLog and are measurements, not passing tests.

An initial compile overlapped source edits and is invalid evidence. The original
corrected baseline compile lacked a separate raw record; that gap remains explicit.
A later fully recorded frozen-baseline run compiles0 and fails the existing H2
capacity-propagation assertion. Its exact source/binary/input/environment bindings
are retained alongside the final passing runs. Earlier insufficient region-pair
coverage, diagnostic parser and tool-path failures are also preserved.

Root independently verifies every final source file,51 recorded checks,52 unique
compiler/module/library/probe inputs and16 compile/run pairs, and reconstructs
the exact final source from the patch. Reviewers do not rerun checks. Native body
activation, whole-Session borrows, no-output closure, active generation-preserving
reset, live uploads and the original full M2 gates remain open.
