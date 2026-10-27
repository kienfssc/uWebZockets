# Plaintext producer and lifecycle proof

All 26 ordinary cases pass against the reviewed combined HTTP/1 source. The
[archive](plaintext-lifecycle-proof.tar.gz) retains complete public fixtures,
preimages/diffs, the producer assertion finding and scoped fix review, actual
compiler/runtime records, input bindings and independent live-evidence review.

SHA256: `d6ccb9393c5dc64f4336bd47c4ba951223c74ad6d2fbeaccbad92a6a1f8b439d`
(479540 bytes). The [manifest](manifest.json) binds 57 safe regular members and
56 inventory entries. Credential-pattern and available named credential-value
checks pass. Derived executables are omitted with their identities retained.

The approved 21 cases remain, including both exact 100000000-byte uploads,
real-file ordering and strict error/quota checks. Five additional cases prove:

- Independent producer context and retained metadata survive upload cleanup
  and binding reuse. An actual post-reuse snapshot shows unfinished output at
  2686976 bytes; subsequent callbacks finish 16777313 bytes, with 12 metadata
  checks over 12 producer calls and 11 calls after the end callback.
- Three distinct routes hold successful bindings simultaneously, then resume
  through their real indexed controls and complete with matching hashes.
- Ordinary peer disconnect cancels once with peer_closed and permits reuse.
- End callback error aborts output without a second cancel and permits reuse.
- Owned shutdown during a seven-byte upload cancels once with shutdown,
  drains/deinitializes and exits 0. Its post-deinit snapshot reads independent
  counters, not expired controls or request storage.

Runner exit is 0. Child PID 203632 exits 0, is reaped without forced termination
and emits its drain marker. All 1023 source inputs, 93 override files and
recorded fixtures/compiler/libraries/binary inputs remain unchanged. Independent
source, scoped fix and actual evidence reviews approve this ordinary slice.

The fixture producer uses fixed single-use server-lifetime storage; no abort
reclamation hook is claimed. TLS/framed uploads, multipart transport, platform,
maintained adoption and full final gates remain open. This does not complete M2
or change Root production source/pins. Earlier failures remain in their
[original checkpoint](../m2_h1_plaintext/README.md).
