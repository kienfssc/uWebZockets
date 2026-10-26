# Incremental multipart contract evidence

[ADR0011](../../../adr/0011-incremental-multipart.md) records the accepted pure
parser/part-sink seam, accepted-prefix ownership, boundary.len + 4 carry, exact
EOF behavior, strict new metadata rules and once-only cleanup. The archive
preserves the frozen architect proposal, corrected derivative and root review
record. Its portable inventory covers all three files. The manifest binds six
actual source files to the recorded context.

Independent review required preserving legacy Request.multipart/Parser.init
error sets and assigning BodyNotBuffered only to new streaming views. ADR
compression review restored the explicit init carry minimum, refusal timing,
storage lifetime and minimum-bound tests. Bounded re-review found no remaining
findings; root accepted the contract. Original proposal bytes remain unchanged.

MP-L1 explicitly excludes ordinary delimiter transport padding; this does not
establish general RFC 2046 conformance. Source, compiler, split/pause/carry,
100 MB, fuzz, performance-comparison and live integration gates remain open.
No tests, server or benchmark ran as part of this contract review.
