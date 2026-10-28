# Native HTTP/2 request-streaming composition

The reviewed candidate connects native H2 selection, body events and controls to
registered sinks, using the existing startup slab and stable Router binding.
It derives the [admission fact](m2_h2_native_admission.md) from the connection's
existing TLS/method policy. The subsequent [core live matrix](m2_h2_core_live.md)
passes both actual 100000000-byte H2/TLS uploads; broader acceptance remains open.

The [archive and readable patch](evidence/m2_h2_native_tcp/README.md) preserve
seven changed paths, complete inventories, measurements, intermediate failures,
independent review and the source-failure correction. Final source has1031 files,
digest `fc69e66f18d404aff19a0b018b81dd35c02ec2a46ed8f38670eb926c794f72de`.
Root production source and maintained dependency pins remain unchanged here.

## Native ownership and output

Buffered and event dispatch share complete Response construction, retaining
response, producer, file and compression hooks. Producer-step Response remains
restricted. Buffered captures use indexed matrices; middleware headers and initial
metadata remain owned through callbacks. Output mutations check native close and
stream identity, including after callback-capable operations. Ordinary Session
GOAWAY does not alone prohibit valid output. Retired close events still reach
driver cancellation and quota cleanup.

Complete-operation borrows cover receive/TLS dispatch, write completion, response,
producer/file, async targets and body controls through their last connection
access. Batch defers precede final borrow release. Existing native active flags,
retirement acknowledgements and socket-close framework remain in place.

For initialized, bound, enabled H2, an existing warm async `completing` state pins
release across the common completion wrapper. Native close invalidates tokens
while retaining that phase; both release gates inspect it. The copied wake runs
after common success/error finalization and calls the final continuation. No new
stored state or common-response API is introduced. Legacy owner-null lifetime is
outside this proof.

Close publishes intent and first causes before abort effects, terminalizes H2
inputs without new output, and preserves deferred callback metadata. Cold drain
uses the driver predicate; reset follows drained preflight and preserves stable
associations and generations. Request metrics count each streamed head actually
delivered to the adapter; earlier malformed/unavailable refusals do not deliver it.

Fresh adversarial planning review and independent protocol/lifetime source reviews
were performed. Lifetime review found three reset-error catches that marked
siblings `cancelled` instead of `source_failure`. The existing cause-bearing
close entry now handles those catches. Both reviewers pass the scoped fix, with
no new actionable findings. Native reset-output failure was not injected or run.

## Evidence and remaining acceptance

The caller-owned cancellation helper regression compiles and fails with the
original cancellation operation. Final helper tests cover success, target error,
WouldBlock, generation invalidation, one wake after final state, expired old token
and disabled behavior. These are software callbacks without native I/O.

Initial reviewed source `8f2da41b` passes193 selected results per Debug/ReleaseSafe
mode across13 roots. Final `fc69e66f` passes79 covering results per mode: helper2,
driver40, H1 driver30 and shared admission7. Its fresh central Linux/macOS/Windows
semantic compilation, static checks, AST refresh and reconstruction pass. Earlier
eligible32 compilation and three-OS layout measurements retain their actual
`8f2da41b` identity. The exact three-callsite fix changes no type, field or carve
declaration. CompileLog exit1 is measurement; full-driver32 remains limited.

All measured native types, slab totals and offsets match the preceding candidate.
The four pre-review corrections remain bound to their intermediate sources.
Root's overstrict cache-path request interrupted one pure verification run;
shared content-addressed caches were valid, original binaries were preserved,
and the completed fresh run retains its own identities. No native experiment was
restarted. Initial audit lacked complete historical helper sources; later exact
byte reconstruction verifies all1031 red and all1031 green files. The original
audit and subsequent completion records remain distinct.

Root verifies34 initial/fix compile-run pairs, available red/green logs and
binaries, external inputs, all93 override files, source inventories and complete
cumulative patch reconstruction. Recorded runs stay attributed to their actual
sources. No throughput or native runtime safety claim follows from these checks.

The subsequent core run proves the exact100000000-byte count/SHA in both
framings and normal idle shutdown; the [pause/control successor](m2_h2_pause_control_live.md)
also passes partial/final/empty pauses and public validation. The
[admission successor](m2_h2_admission_live.md) verifies limits, Continue, quota
and recovery. Clients must still prove flow control, siblings, metadata,
producer/file completion, cancellation,
disconnect and active drained shutdown. Full native/sanitizer/h1spec gates, physical
cancellation/reuse safety, genuine early data, production adoption and complete
M2 acceptance remain open. Stopped experiments and denied socket cases remain
stopped; authenticated SSL_in_init early EOF retains its existing abort boundary.
