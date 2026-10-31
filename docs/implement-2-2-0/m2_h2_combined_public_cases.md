# Combined HTTP/2 public and large upload schedules

The combined client now implements `ready_buffered`, `async_delayed`,
`large_declared` and `large_undeclared` through the reviewed public-codec core.
Its adapter takes explicit caller-owned send/read hooks and integer time,
preserves per-connection ledgers and inherited deadlines, and checks the
immutable model's response records and counters. Unsupported selections fail
before actions. This four-case checkpoint leaves the other 36 schedules and
full default/aggregate acceptance open.

The [source and evidence archive](evidence/m2_h2_combined_public_cases/README.md)
preserves all 12 current Python modules, earlier source snapshots, actual raw
outcomes, immutable model/core/helper inputs, pinned codec sources/licenses and
independent reviews. Its [manifest](evidence/m2_h2_combined_public_cases/manifest.json)
binds every current module and distinguishes the verification scopes.

The schedules verify exact serialized methods, paths, headers, declarations and
terminal flags. Ready returns the exact 257-byte binary echo without changing
sink totals. Delayed checks `delayed-ok`, `text/plain` and END without requiring
an unsupported middleware header. Both logical 100000000-byte uploads use the
canonical bounded payload generator and hash, one DATA-bearing stream and
independent earned connection/stream credit. No whole upload is retained.

The shared-state proof runs ready then large-declared on separate connections
against one synthetic application. Ready's 257-byte debt stays isolated on its
connection. The large case carries actual 1781-byte debt in each credit scope
into collection of 67 statuses plus metrics. Split/coalesced refund frames preserve
the parser, ledgers, inherited deadlines and cumulative counters. The measured
synthetic final collection consumes 28992 bytes in 69 reads under its 3110658-byte
budget; its upload uses 12208 DATA frames. These are codec observations.

The baseline's ten focused scripts pass in normal and optimized Python:
20 commands exit 0 with empty stderr. They cover the four schedules, malformed
and duplicate credit/terminal input, valid refund controls, caller-time expiry,
types and reversal, exact request contracts, and silent/inert imports with AST
restrictions. An actual pre-implementation RED/GREEN proves the caller-time
API change; later deliberate mutation controls are labeled separately.

Independent review found no functional defect and one required nesting
correction in the shared-state test. Extracting the upload accounting/refund
decision removes the fourth control-flow level. Scoped re-review passes with
no new findings. Both shared-state and import checks pass in both modes after
that correction: four current covering commands, with 11 modules unchanged.
The earlier 20 outcomes remain historical for the preceding source. The original
unpublished 14 receipts were lost during an environment reset; they are not
presented as current evidence.

All peers and records are synthetic, and time comes from caller input. This
checkpoint establishes source and in-memory codec behavior. Native fixture
behavior, TLS/EOF/process ownership, performance, full project gates and source
adoption remain required. Release metadata stays 2.1.6. M2 and the combined
two-child 40-case acceptance matrix remain open.
