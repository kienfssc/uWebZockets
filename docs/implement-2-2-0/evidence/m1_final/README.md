# M1 combined checkpoint gates

The [manifest](manifest.json) binds broad checkpoint b2d2acb and final MIME
polish db92019 separately. The [archive](verification.tar.gz) retains unchanged
raw source identities before/after, diffs, commands, individual exits, logs and
protocol artifacts. Extract into a new directory and verify SHA256SUMS.portable.
Independent review verifies all 1,211 portable checksums and safe regular paths,
source/tool/pin bindings, counts, and raw protocol results with no findings.

All recorded gates pass. ASan/UBSan tests are 752/752; compilation covers native
ReleaseSafe/ReleaseFast, Windows GNU and macOS arm64. The polish repeats
sanitizers and ReleaseSafe/Windows/macOS compilation with its MIME assertions.
Smith requested 100K and completes 103,624 executions. Five LLVM ABI objects,
deterministic smoke, MSan C-boundary, public consumer and clean .paths package
checks pass. MSan does not instrument Zig. Foreign targets are compile-only.

Ordinary pinned HTTP/3, h1spec 33/33, and Autobahn's 517-case baseline pass.
h1spec owns and SIGTERMs its no-signal-handler example (expected 143); this is
not an application-level graceful request drain. The wrapper-only missing-rg
attempt is preserved beside its corrected run. Autobahn independently matches
514 OK and 3 INFORMATIONAL in both protocol and close classifications. Complete
live static/sidecar byte proof is a [separate artifact](../m1_static_live/README.md).

No performance, official-profile, Windows/macOS runtime, live WebTransport or
release-completion inference is made. The separate external-profile declaration
retains all restoration requirements.
