# M3: dependency provenance and current-pin gates

Status: in progress, 2026-10-26. The cold acquisition and archived compliance
slice passes; HPACK synchronization and final provenance work remain open.
No dependency pin changes in this slice.

## Frozen source and cold acquisition

The source is fa7449e80334cef360cb32ec61e051d255c37249, with the original
maintained libxev, lsquic, and h1spec pins recorded in
[the fork policy](../dependency_forks.md). A separate clean Git worktree had
neither zig-pkg nor .zig-cache before any Zig command. The global, library-local,
and package-consumer-local caches were empty. No packages were copied from the
warm checkout or Nix store. Zig 0.16.0 ran inside that commit's pinned Nix shell.

The [cold evidence archive](evidence/m3_current_pins/cold_build.tar.gz) retains
the driver, trace, exact commands, source manifests, gate output, saved exit
statuses, environment, dependency views, licenses, and fetched source archives.
The run began at 13:59:33 UTC and finished at 14:13:48 UTC on 2026-10-26.

| Gate | Recorded result |
| --- | --- |
| ReleaseSafe library from empty caches | Exit 0; 20/20 steps |
| Existing .paths-filtered package-consumer script | Exit 0; separate fresh local cache |
| Existing online dependency-fork check | Exit 0; without --exact-mirrors |
| Six installed static archives | Checksums match; object members only |
| Frozen tracked source after the run | Exact and clean |

The package consumer reused only the global cache populated by the preceding
cold build. Its retained source package contains exactly the 217 selected Git
blobs, without removed patch paths, overlays, Git metadata, or caches. The full
current-pin source archives match their pinned Git trees. Intermediate verbose
compiler headings are preserved verbatim; the aggregate build and saved status
are successful. They are not evidence of a repaired source failure.

## Compliance evidence on the same source

The earlier [frozen verification record](evidence/m1_a/frozen_verification/README.md)
uses the same fa7449e source and dependency pins. Its h1spec run uses the actual
initialized maintained-fork checkout at 999ba9e8f318b1c0ebbff1278b98bc5833f1af18
and Deno 2.9.4: 33/33 cases pass. Its pinned curl/ngtcp2 and aioquic HTTP/3
archive includes raw traces, versions, qlog, malformed-request sibling checks,
the oversized-QPACK reset, and recovery after 300 rejected requests.

Root observed both original tool sessions finish with exit 0. The retained
h1spec and HTTP/3 artifacts lack separate terminal-status files, so the later
artifact-only reviewer independently validates their output assertions and
checksums, rather than independently recovering those process exit codes.
This slice reuses those runs and does not claim new protocol runs.

The later file checkpoint 9ac0566f1af87f50eebe56be6bd605f1adc671f3 has a
[fresh h1spec record](evidence/m1_c_h1/frozen_verification/h1spec/README.txt):
33/33 passes with dedicated build, runner, gate, and harness-termination statuses,
plus exact owned-listener evidence. The dependency pins remain unchanged. This
new run has recoverable statuses; it does not rewrite the earlier artifacts or
claim a new HTTP/3 run.

LSQ-001, LSQ-002, and H1S-001 remain in the ledger. Final WebTransport pins and
fresh final-source gates remain separate requirements.

## Hash semantics and review correction

The zlib JSON hash covers downloaded archive bytes; its Nix fetchzip hash
covers the unpacked NAR tree. Both independently match the official source.
No zlib dependency-view regeneration is necessary.

The initial [hash addendum](evidence/m3_current_pins/zlib_hashes.tar.gz)
misattributed the generator to a transitive lock node. Independent review
caught this. The [additive correction](evidence/m3_current_pins/zlib_generator_correction.tar.gz)
proves the frozen root generator is zon2nix 0.9.1 at
d5a6545496dfb17878fe23d026e0a880ee9e12c9, including structured lock resolution,
successful Nix evaluation, source NAR, and exact implementation excerpts.
That correction supersedes the earlier addendum's generator identity/version
claims. Original artifact bytes remain unchanged. All three outer hashes are
listed with the later candidate in [SHA256SUMS](evidence/m3_current_pins/SHA256SUMS).

## Remaining dependency work

The executable-step audit finds no local vendor patch, overlay, or Perl
generation. Literal matches include rejection guards and semantic-version
names; those safeguards remain. A follow-up removes two stale build comments
describing an overlay; the assembled pinned-source build remains unchanged.

The pinned lsquic tree records src/lshpack at
cf0f70dd10b352194c97448eb5d00b4aa484f531, while all four root views build
fda48e02491d865cce00612be8cc10c2622b8e55. That violates the documented child-pin
synchronization rule. Independent range review confirms the newer child
retains integer/Huffman validation and memory-safety repairs, with no public
header, ABI, license, or xxHash change. Reverting it is not an acceptable repair.

Prepare and review a minimal gitlink-only commit in the existing maintained
fork, publish it through the required integration review, then update all four
root parent-pin views from the published commit. Preserve both current child
pins and existing ledger entries; add LSQ-003 and child-gitlink validation with
a mismatch-fails regression. An unpublished local candidate is not a valid
root pin. This Codespace currently lacks push access to that fork.

The independently reviewed [local candidate archive](evidence/m3_current_pins/lsq003_local_candidate.tar.gz)
contains commit 87e318737657b2c6cde04ad94d583651340d6968, whose parent is the
published 85bd081c pin and whose tree is
73c9b29643d0c37c2ca2e93d3a0a539dfe4badc1. Direct object comparison proves the
sole change is the mode-160000 HPACK gitlink. An 880-byte incremental Git bundle
requires that published parent and restores the exact candidate, parent, and
tree. It is a review artifact, never an input applied by the root build.
LSQ-003 is proposed; no integration acceptance or root pin update is claimed.

Five Debug and five UB-trap HPACK configurations pass with saved compile/run
statuses. The initial exit-134 xxHash alignment abort is preserved. The final
supplemental harness excludes alignment checking only for the separately
compiled xxhash object, following its upstream intentional unaligned-load
implementation and documented exception. Decoder/test alignment checks and
assertions remain enabled. This establishes neither xxHash's freedom from C
undefined behavior nor replacement coverage for required project sanitizers.

Read-only ref capture also finds the fork mirror at
413ca7c1acb443b0f9f7aa28611ca723c6738844 and upstream at
02b10a9e620bc235e40baa8dd0b2d9f32ff96cab. The captured refs differ.
Mirror synchronization and security review must precede publication
and acceptance; the candidate alone cannot close M3.

The child HPACK code serves legacy gQUIC headers; the current engine excludes
gQUIC by default. IETF HTTP/3 uses QPACK, and TCP HTTP/2 uses the Zig HPACK codec.
The reviewed changes establish dependency hardening and metadata drift, rather
than a demonstrated live QPACK vulnerability.

Exact live mirror equality must be re-established before accepting a new pin;
the non-exact online check above does not establish it. Full final Git bundles,
branch protections, second-machine resolution, and native Windows runtime
remain M6 requirements. Repeat clean package and protocol proofs after the
WebTransport pin change. M3 is not complete.

## Independent review

The read-only reviewer checked all archive manifests, frozen blobs, package
filtering, source-tree identities, six archive contents, raw protocol assertions,
hash semantics, and credential/private-key candidates. The additive generator
correction resolves its sole new evidence finding. The HPACK mismatch and
terminal-status retention limits above remain explicit; no new heavy gate was
run by the reviewer.
