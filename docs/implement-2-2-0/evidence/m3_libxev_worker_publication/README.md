# Reviewed worker-publication candidate

The [archive](worker-publication.tar.gz) preserves reviewed local append
`179f22bc539548e024407b76d4aa39c54342e5b4`, parent
`b2afbafa6900d147ea0dea56e33b612b18f278d4`, tree
`afb88b35febd1d2e0de8d2802d1f3e2f8adceb38`. Exact source, complete-history
bundle, architecture contract, independent review and raw checks are retained.

SHA256: `86e97dba74aaa8b352612e7ce452e93d2980bae3d44ba54ecfa4b091e4161465`
(1,835,135 bytes). The [manifest](manifest.json) records 59 safe regular members
and 58 inventory entries. Retained bytes and decoded source passed credential
checks; packed historical objects were not exhaustively decoded. The bundle
restores its exact commit/tree into an empty repository with strict fsck.

The epoll and kqueue workers capture loop metadata before publishing a
completion. After publication they use only the captured loop, allowing the
consumer to release completion storage before the worker returns. Result writes
still precede publication. Wakeup failures now emit scoped warnings; wakeup
ordering and retry behavior remain unchanged. The captured loop must outlive
workers: the separately reviewed R2 contract joins the pool before loop deinit.

Independent review found no actionable findings in the two-function diff.
Unchanged healthy suites pass 155 cases with four existing skips in each of
Debug and ReleaseSafe, 159 total. Darwin and FreeBSD UDP graphs compile; no
foreign executable ran. No state, API, layout, allocation or test was added.

These checks do not reproduce a race. No new native fault, cancellation,
interleaving or leak experiment ran. Archived R3 V5 inputs remain conditional
proposals. Failed-registration rollback, H1 retirement, maintained publication,
protection confirmation and root adoption remain open. Root pins are unchanged.
