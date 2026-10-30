# Combined HTTP/2 client core preparation

The combined client now has reviewed source for catalogue-bound request credit,
response/reset/transport retirement, bounded response stages and one public-codec
action/observation path. The implementation preserves separate late request debt,
connection identity, cumulative disconnect counters and the existing parser,
ledgers, read limits and deadlines during final collection. Case schedules,
the owned runner and close adapter, runtime closure and the actual combined run
remain required. This checkpoint does not close M2.

The [evidence directory](evidence/m2_h2_combined_client_core/README.md) preserves
the current 26 Python files, all nine snapshots, pinned codec
sources and licenses, immutable model/helper inputs, exact command outcomes,
source derivations and independent reviews. The
[manifest](evidence/m2_h2_combined_client_core/manifest.json) binds every current
source hash and distinguishes the two verification scopes:

- The v8 baseline ran 20 focused scripts in normal and optimized Python:
  40 commands exited 0 with empty stderr. Checks include actual public-codec
  100000000-byte request flow, exact startup/settings, grants, padding/trailers,
  ordered resets, replacement isolation and idle/held 68-response collection.
- Independent review found that hash-only storage could bypass the 4095-byte
  small-response ceiling. The two-line fix binds that ceiling to the staged
  role. Its new regression proves rejection before state/codec mutation and
  successful 4095-byte hash-only completion and retirement. Bound regression,
  special-output and structure/import checks pass in both modes: six current
  covering commands, with 24 original files unchanged. V8's 40 outcomes remain
  historical; they are not relabeled as runs of the amended module.

Fresh source/spec/quality review and the requested structural lens found one
Important issue above. Scoped re-review closes it with no new actionable
findings. All 26 current files receive AST and actual silent import checks under
empty/foreign argv; authored classes and assertion-based proof statements are
rejected. No reusable temporary Python recorder was added.

The pure large transfer used bounded DATA and drain spans, retaining no request
body; its observed 12208 frames are not a throughput result. Final diagnostic
JSON is model-generated input passed through the real codec. Transport endings
are supplied test records. These establish state/codec handling, not native
fixture output, TLS unwrap/TCP EOF, process cleanup or two-child execution.

The actual helper serializes 75 startup bytes: 24-byte preface, 9-byte header and
42-byte SETTINGS payload. Frozen fixture/config/storage/server sources derive
server settings `(1,4096),(2,0),(3,8),(6,4096),(8,1)`, a 30-byte payload/39-byte
frame. The model, fixture, cases, capacities, byte/read bounds and deadlines are
unchanged. Historical model preparation flags remain unchanged; this successor
records the newly earned pure startup proof separately.

Repository formatting (`zig fmt --check src builds examples tests fuzz`),
convention, release-version and documentation-link checks pass. Release metadata
remains 2.1.6. Full Zig/native, sanitizer and compliance suites remain unrun in
this source/pure-codec slice.

The next work remains all 40 finite case schedules, strict close and owned-runner
integration, authenticated runtime closure, a new sequential two-child combined
run, full quality/platform/fuzz/package/compliance gates and production adoption.
No native build/server/socket/TLS context or fault/scheduling experiment ran in
this slice. Forty native IDs proved across earlier checkpoints remain separate
from the still-unrun combined acceptance matrix.
