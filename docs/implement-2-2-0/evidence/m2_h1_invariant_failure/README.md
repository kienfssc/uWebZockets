# Typed H1 retirement invariant checkpoint

The [archive](typed-retirement-invariant.tar.gz) preserves the one-file overlay,
preimage, actual observer harness, raw checks, full three-target LLVM IR,
scoped latch proof and independent review. Apply it over the
[retirement-policy checkpoint](../m2_h1_retirement_policy/README.md).

SHA256: `41a5c76494cd710bfc75c09194de746f82558b8466369e7ed23908d6b26fb5bc`
(7,758,168 bytes). The [manifest](manifest.json) binds 61 safe regular members
and 60 inventory entries. Retained bytes passed credential-value and GitHub
token-pattern checks. Derived executables are omitted with their hashes.

Frozen source digest:
`81f8bc248df272e5e5750b63745db0478d17091e9ad6ef1a291dc89ce92a6108`.
Exactly two added lines provide the payloadless retirement_inactive failure
case and fixed diagnostic. All other 1,019 inputs remain unchanged.

All 14 assigned checks pass. Three unchanged classifier/payload cases pass in
Debug and ReleaseSafe. Native/macOS/Windows observer code generation and central
semantic compilation pass. Independent review matches all three complete IR
hashes and verifies the actual bound-fence store before the new panic call.
No panic path is executed; no substitute observer is used.

This adds no native callback wiring, expiry mapping, lifecycle timing or upload
result. The retained source audit and next-unit contract identify the initial
close operation borrow, one-shot cancellation, inline IOCP job callback, real
cleanup and resume dependencies. Those are implementation requirements, not
runtime evidence. Root source, pins and maintained refs remain unchanged.
