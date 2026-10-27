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
Fresh R3 review finds a separate IOCP error-mapping prerequisite and requires
explicit handling of io_uring ExpirationInProgress. Full H1 physical-close,
generic adding/deleting/worker behavior and M3 provenance acceptance remain open.

The later [normal HTTP/3 refusal check](evidence/m2_h3_refusal_live/README.md)
uses an immutable export of the reviewed three-commit candidate as a scoped
test override. Aioquic verifies a complete 503, healthy sibling and connection
reuse; the owned io_uring server drains and exits zero. Candidate bytes and all
four root pin views stay unchanged. This adds no duplicate-cleanup acceptance,
native fault/cancellation experiment, maintained publication or full gate claim.
