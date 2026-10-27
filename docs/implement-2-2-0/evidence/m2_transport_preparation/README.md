# M2 prepared and partial source recovery

The [archive](m2-transport-preparation.tar.gz) preserves five separate draft
source trees and their evidence namespaces. It contains prepared router,
App/config and guarded-loop work, source-only lifetime proposals, and partial
unreviewed H2/H3 header-refusal drafts interrupted by account usage limits.
It introduces no production integration or live-upload capability.

Archive SHA256:
`a079931a4c13dac96546390f316e708a8f491c4a2392c6c19be6f1dbcd6a968b`
(8,217,875 bytes). Root verified all 1,693 safe regular members and 1,692
inventory entries after packaging. The [manifest](manifest.json) binds every
retained file and identifies the different review states. A scan found no
matching environment credential values or GitHub token patterns in retained
file bytes; compressed historical inputs were not exhaustively decoded.

The archive retains original source/command bindings and historical paths.
Its internal SCOPE.md distinguishes prepared proofs from incomplete work.
Twenty-six derived executables/objects are omitted with hashes and sizes;
compiler caches and symlinks are excluded. Reproduction requires the recorded
root baseline, tool versions and explicitly scoped dependency candidate where
applicable. These are separate snapshots, not one verified combined tree.

The [preparation report](../../m2_transport_preparation.md) records the remaining
consumer, lifecycle, review and verification obligations. The earlier stopped
native cancellation experiment remains stopped; this archive establishes no
runtime cancellation, crash, race or leak reproduction.
