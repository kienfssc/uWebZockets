# Reviewed registered-duplicate cleanup

The [archive](reviewed-duplicate-cleanup.tar.gz) preserves independently reviewed
local commit `29490914cf58b24d7ab32ca5349f9a03a910435f`, its exact source, complete
reachable-history Git bundle, review and raw verification. Its tree is
`e13b3948e95075cd1245b25a872fa714045ba95e`, identical to the
[original source-only candidate](../m3_libxev_dup_cleanup/README.md).

SHA256: `bb0e7bdcd70be2a1749fc94878afab52511e57d6255771b64296f62be03af05b`
(1,740,669 bytes). Packaging verified 27 safe regular members and 26 inventory
entries. The [manifest](manifest.json) binds all retained files. Outer bytes and
decoded source contain no matching environment credentials or GitHub token
patterns; packed historical Git objects were not exhaustively decoded.

Fresh independent source review found no actionable issues within the retained
registered, non-worker duplicate contract. Both decision filters pass 28 cases
in Debug and ReleaseSafe, including the two named actual-decision cases and
existing declaration/discovery checks. Each healthy suite passes 151 cases with
four existing skips, 155 total. Every source hash remains unchanged throughout.
Formatting and whitespace checks pass.

The complete-history bundle verifies and restores the exact commit/tree into
an empty repository with strict fsck. This is a local review candidate saved
through the root feature branch. No maintained ref or root pin changes.

No new native fault, cancellation, race or leak experiment ran. The earlier
stopped experiment stays stopped. These results do not establish full transport
lifetime safety or generic adding/deleting/thread-pool cancellation. The R3
review also found a separate IOCP error-mapping prerequisite; this epoll change
does not resolve it. Maintained publication and complete integration remain open.
