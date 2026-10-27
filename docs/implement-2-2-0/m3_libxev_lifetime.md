# M3 libxev UDP and bounded cancellation review

Status: local candidate verified and archived, 2026-10-27. Maintained-fork
publication, protection confirmation and root adoption remain open.

An ordinary upload-preparation UDP startup/immediate-shutdown test exposed peer
decoding before checking a cancelled receive result. The existing source left
the sockaddr undefined on error. The test exited 134 at the current pin; that
failure and its source binding are preserved without rerunning the old case.
The local peer fix checks the original result first in all three receive
wrappers and supplies a defined IPv4 `0.0.0.0:0` error peer. Successful decoding,
callback signatures, original errors and layouts remain unchanged.

Source review later corrected the new kqueue fixture: epoll abandons the target
callback, whereas kqueue queues and delivers its cancelled result. The original
peer commit and mistaken test/review contract remain historical evidence; a
separate test-only append corrects the expectation. Foreign compilation is
recorded without claiming native kqueue execution.

Another source audit found that queued epoll cancellation could start after the
target had already disarmed. The bounded followup checks private dead state
before target fd access: dead non-timers return existing NotFound, while dead
timers retain successful acknowledgement. It changes no public error tags,
layout, queue phase or active-count ownership. This is a source argument with
pure actual-decision tests and unchanged healthy suites, not an executed race
or crash reproduction. Target storage and its operation tag remain retained
without repurposing through cancellation acknowledgement.

The [review package](evidence/m3_libxev_udp/README.md) preserves the three local
append commits, a verified complete-history bundle, exact sources and contracts,
raw failures and successful checks, and bounded independent reviews. Final
candidate `7b7b1f14518d9504b15590d123ec494b8fadb2e3` has tree
`0ae835a79eaea49f8ff086e64d777152c454b928`, descended from current maintained
pin `c49f6dfb83038c146232472c063e4b2681d098d8`.

The peer candidate passes the required and healthy UDP cases, 2/2 on asserted
epoll and io_uring, and 14/14 focused application cases. The final fork candidate
passes 149 tests with four existing skips in both Debug and ReleaseSafe. The
helper filter passes 28/28 including two named pure tests. Callback/layout
consumer and foreign UDP compilation checks pass. Independent bounded reviews
found no remaining findings within these scopes.

All root dependency pins remain unchanged. Before publishing, the maintainer
must confirm the protected integration ancestry and required fork protections;
the Codespace credential could not read those protections. Adoption then needs
all four zon views, ledger, documentation and required project gates together.
The archive is supplied for manual review and is not a local build overlay.

This verified candidate does not settle registered duplicate-descriptor cleanup,
generic adding/deleting/thread-pool cancellation, foreign IPv6 peer storage,
or connection physical-close and slot-reuse ownership. A separate
[registered duplicate cleanup draft](evidence/m3_libxev_dup_cleanup/README.md)
preserves the original source-only snapshot. The later
[reviewed follow-up](evidence/m3_libxev_dup_verified/README.md) verifies that exact
unchanged tree and saves local append commit
`29490914cf58b24d7ab32ca5349f9a03a910435f`, parent `7b7b1f14518d9504b15590d123ec494b8fadb2e3`.
Fresh independent source review finds no actionable issues within its restricted
registered non-worker contract. Its actual-decision filters pass 28/28 each;
the healthy suites pass 151/155 with four existing skips in Debug and ReleaseSafe.
Every source hash is unchanged. A complete-history bundle restores and verifies
the exact commit/tree in an empty repository with strict fsck.

This is not a maintained publication, adopted pin or runtime leak/race claim.
The [reviewed IOCP follow-up](evidence/m3_libxev_iocp_cancel/README.md) saves local
append commit `b2afbafa6900d147ea0dea56e33b612b18f278d4` without adopting it.
Both native cancellation paths acknowledge FALSE with ERROR_NOT_FOUND while
preserving all other errors and public layouts. Pure policy suites pass 30/30;
unchanged healthy suites pass 155/159 with four existing skips in each mode.
Windows compilation passes 8/8 steps and before/after ABI consumer assembly
is identical; no Windows execution is claimed. Independent bounded review
finds no actionable issues, and its complete-history bundle restores and
passes strict fsck.

R3 still requires explicit io_uring ExpirationInProgress handling. Fresh source
review additionally identifies worker completion-storage reads after MPSC
publication and missing rollback after a newly duplicated fd fails epoll ADD.
The [reviewed worker-publication correction](evidence/m3_libxev_worker_publication/README.md)
saves local append `179f22bc539548e024407b76d4aa39c54342e5b4`. Both workers now
capture metadata before publication and stop accessing completion storage
afterward. Independent review finds no actionable findings; unchanged healthy
suites pass 155/159 with four existing skips each, and Darwin/FreeBSD UDP graphs
compile without execution. Its bundle restores the exact commit/tree and passes
strict fsck. Captured-loop safety relies on R2 joining workers before loop deinit.

The [reviewed registration rollback](evidence/m3_libxev_registration_rollback/README.md)
saves local append `c223bd886c6a51d2cd60def39dd9a68d701fea73`. All eleven ADD
paths retain acquisition ownership; failure invalidates and closes only a new
duplicate, preserving exact errors and existing state/callback accounting.
Independent review finds no actionable findings. Four named ownership cases
and discovery checks pass 30/30 each mode; healthy suites pass 159/163 with
four existing skips each. Linux x64 layout assembly is identical, and Windows
focused compilation passes. The bundle restores the exact commit/tree with
strict fsck. The actual failing kernel branch remains source-proved.

The [fresh V6 design review](evidence/m2_h1_retirement_v6/README.md) finds a
separate FreeBSD liveness gap: worker close publication has no wakeup after the
last timer/scheduler ends, so shutdown can wait indefinitely. Existing bounded
candidate approvals do not prove that combined claim. The broad proposal stays
unaccepted; a separate community-BSD activation guard is the stated default
pending implementation and review. No native fault or interleaving experiment
is needed for these source and pure-policy checks. Full H1 physical-close,
generic adding/deleting/worker behavior and M3 provenance acceptance remain open.

The later [normal HTTP/3 refusal check](evidence/m2_h3_refusal_live/README.md)
uses an immutable export of the reviewed three-commit candidate as a scoped
test override. Aioquic verifies a complete 503, healthy sibling and connection
reuse; the owned io_uring server drains and exits zero. Candidate bytes and all
four root pin views stay unchanged. This adds no duplicate-cleanup acceptance,
native fault/cancellation experiment, maintained publication or full gate claim.
