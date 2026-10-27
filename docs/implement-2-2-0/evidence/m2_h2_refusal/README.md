# Isolated HTTP/2 refusal checkpoint

The [archive](h2-refusal-checkpoint.tar.gz) contains six exact source replacements
or additions and the v2 through v5 command/source evidence. It supplements the
[earlier recovery archive](../m2_transport_preparation/README.md); its SCOPE.md
and delta manifest describe reconstruction. The four-alias width support file
is verification-only. Historical command paths require the recorded toolchain,
dependencies and generated C bindings.

SHA256: `af0afe5e2e220a75701a6d6e0ef6165970c9582c2862dd1958e46e09ea804c17`
(507,008 bytes). Packaging verified 195 safe regular members and 194 inventory
entries. The [manifest](manifest.json) binds each retained file. A byte scan found
no matching environment credential values or GitHub token patterns.

Final v5 records bind all source changes before and after execution: 14 focused
and 69 unchanged HTTP/2 cases pass in Debug and ReleaseSafe. Pure native and
Linux32 executables pass one test containing seven wire cases per target.
Six target layouts resolve exported LLVM aliases. Earlier failing cases,
sandbox socket restrictions, an incorrect fixture, and an exploratory green
record with stale inherited hashes remain explicitly distinguished from final
successful immutable-source evidence.

This checkpoint is unintegrated and awaits independent review, live clients
and combined gates. The [report](../../m2_h2_refusal.md) records its limitations.
