# Registered duplicate cleanup review source

The [archive](registered-dup-cleanup.tar.gz) is a source-only followup on reviewed
local libxev candidate `7b7b1f14518d9504b15590d123ec494b8fadb2e3`. Its uncommitted
candidate tree is `e13b3948e95075cd1245b25a872fa714045ba95e`. No compiler or
unit/native tests have run; independent review is pending due account usage
limits. Formatting and whitespace checks pass only. It changes no root pin.

The actual private decision distinguishes registered duplicate ownership from
queued/dead/worker states, includes accept/recv/send and fd 0, then stops once,
invalidates the cache, closes the saved duplicate and follows existing ACK.
Two declared pure tests exercise that actual decision; they remain unexecuted.
The source audit and typed contract define excluded cases and lifetime bounds.
Base-candidate healthy results do not verify this delta. No native cancellation,
leak, fault, race or crash experiment was added or run.

Archive SHA256:
`aba4301dc865c5a69bc01040a7802e6b4bf21899c4b1208eaa0ead93639cb8bb` (179532 bytes).
Root checked 8 safe regular outer members, 7 inventory entries and
41 decoded source files. The [manifest](manifest.json) binds all retained
artifacts. Outer and decoded source scans found no matching environment
credentials or GitHub token patterns. The complete base-history bundle is in
[the preceding review package](../m3_libxev_udp/README.md).

Review the exact patch and source contract before permitting the two pure tests,
unchanged healthy suites, a local append commit or maintained publication.
Generic adding/deleting/thread-pool cancellation and complete H1 physical-close
proof remain outside this source correction.
