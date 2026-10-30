# M2: bounded HTTP/2 output observer preparation

The independent client can now count and hash large binary responses without
retaining DATA payloads. Explicit manual credit disables automatic acknowledgements
for both large responses and small status/control responses. The existing small
response limit remains below4096 bytes; raw frame, header and active-record bounds
remain unchanged.

The [source and evidence](evidence/m2_h2_output_observer/README.md) preserve exact
producer, selected-file-range and early-final payload contracts, the reviewed
observer, pinned pure Python codecs, regression history and independent reviews.
Thirteen pure observer tests pass on the frozen source. Three selected tests also
pass with Python optimization enabled. Root independently ran the13-test frozen
suite. These checks exercise protocol bytes and state machines without sockets
or a uWebZockets process.

Review found that the pinned codec omits reset events after a stream fully closes.
The corrected observer accepts that behavior while requiring the complete raw
final DATA/END followed by the expected NO_ERROR reset. A real codec regression
covers both closed and half-open streams; the original failure is retained.

M2 remains open with35 native H2 case IDs proved. Independent response-credit
accounting, request-refund ordering, stage work budgets, fixture/runner integration,
the five native output cases and the actual combined40-case matrix remain required.
Source-derived budget and file-I/O decisions are archived as requirements, not
implemented or executed proof. Full quality/platform gates and adoption remain open.
