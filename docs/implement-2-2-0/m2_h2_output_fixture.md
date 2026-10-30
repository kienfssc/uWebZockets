# M2: HTTP/2 output fixture preparation

The output fixture now compiles in Debug and ReleaseSafe against the retained
streaming candidate. It adds three independently owned chunk producers, borrowed
metadata checks across producer retries and body-slot reuse, file-transfer
observation, and diagnostics for the five remaining output cases. The fixture
binary has not been executed.

The [source and evidence](evidence/m2_h2_output_fixture/README.md) preserve five
current fixture files, 12 current client files, pinned pure codecs, original
compiler output, controlled build receipts, preparation checks and review history.
Both controlled compiler invocations exited zero with empty output. They used
the complete environment `{"LC_ALL":"C.UTF-8"}`. The earlier successful builds
retain their historical receipts; their inherited environment is unknown.

The three Zig files and guarded preparation helper match the controlled build
snapshot exactly. Its historical Python test differs from the current test.
The subsequent test-only rewrite has no new native build receipt. All authored
current checks use functions, explicit proof conditions and visible probe state.
Root independently passed four frozen preparation checks and all 37 frozen
client checks under Python optimization. These checks use protocol bytes and
doubles; they do not exercise fixture I/O.

Independent source review closed preparation-helper import effects, unrecorded
compiler environment and authored test-class findings. The producer stores
metadata independently of request body slots. Its positional-read and close
observers delegate through the original Io userdata and retain separate file
ownership state. Compilation and source review provide no runtime proof of these
lifetime or ownership properties.

Driver integration, current runtime input closure, returned-error ownership
evidence, the five native output cases and an actual combined 40-case matrix
remain required. M2 still has 35 native H2 case IDs proved. Full quality/platform
gates and production adoption remain open.
