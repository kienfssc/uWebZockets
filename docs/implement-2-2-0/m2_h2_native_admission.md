# HTTP/2 native admission fact

The H2 head event now carries a default-false `early_data_forbidden` fact, and
the driver passes it to shared admission. Existing event literals and the Router
target remain compatible. Native TCP policy derivation and callback activation
are still required.

The [archive and readable patch](evidence/m2_h2_native_admission/README.md)
preserve this three-file successor to [terminal input closure](m2_h2_terminal_inputs.md).
Its final 1029-file source digest is
`9e4ccd66b9b4c888b97d2d8d39c7f25d700e6d3fe0302ddcf257bb789829d116`.
Root production source and maintained pins remain unchanged by this checkpoint.

The regression feeds encoded HEADERS through the actual Session, registered
driver and Router. A caller-owned adapter enriches one head with the policy
fact. With the field present but the old driver projection, compilation succeeds
and the test fails: `100` arrives instead of `425`. The corrected projection
rejects before middleware, quota reservation, sink begin or Continue. An ordinary
sibling then enters and completes with a one-upload quota, proving no leaked
reservation. This is policy propagation evidence, not live TLS early data.

Driver40 and shared admission7 pass in both Debug and ReleaseSafe, 47 results
per mode. Formatting, conventions, release-version checks, documentation links
and identical-copy AST refresh pass. The initial Graphify PATH lookup and
convention-tool PATH failure remain recorded; explicit workspace tool paths
resolve both. Independent spec/quality/structural review found no actionable
findings. The shared fixture grows from1307 to1331 lines with cohesive coverage.

Before adoption, twelve before/after CompileLog records measure the actual
declaration and slab offsets on Linux, macOS and Windows. Head stays32/8 and
BodyEvent40/8; the bool occupies offset31 without moving existing fields.
Session, TCP, Driver, Slot, other measured types and all four slab profiles
remain unchanged. Offset accounting changes only private-function visibility;
CompileLog exit1 is measurement. These are declaration measurements, not a full
foreign-target central test compilation or runtime result.

Root checks both complete source inventories, five compile/run pairs including
the real red, raw-log/binary/input identities, all93 override files, measurement
records and independent full patch reconstruction. Historical declaration/red
paths were reused later; preserved inventories and source deltas reconstruct
their original bytes without attributing new runs to them.

Full central/native runtime, sanitizer, h1spec, genuine TLS early-data derivation,
native adapter activation, live H2/TLS uploads and remaining M2 acceptance stay
open. Stopped experiments and denied socket cases remain stopped. No native
lifetime or release conclusion follows from this slice.
