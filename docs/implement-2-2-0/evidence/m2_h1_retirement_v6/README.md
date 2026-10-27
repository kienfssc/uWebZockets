# H1 retirement V6 source-review checkpoint

The [archive](retirement-v6-source-review.tar.gz) preserves V3 through V6
proposals, the head/admission seam, exact source inputs and fresh V6 review.
These are proposals and review snapshots, not a combined build or implemented
physical-close algorithm. Earlier archives remain unchanged.

SHA256: `60214fe6735bcbc7e0a2084882df6b9d9e7d466034a504da3ab4ee9cf431bd6e`
(153,577 bytes). The [manifest](manifest.json) binds 24 safe regular members
and 23 inventory entries. All retained bytes passed credential-value and
GitHub-token pattern checks. Backend input is local reviewed candidate
`c223bd886c6a51d2cd60def39dd9a68d701fea73`; root pins remain unchanged.

Fresh-context review found P1: FreeBSD worker close can publish after the
completion-queue poll without waking kqueue. When retirement timers have ended
and shutdown has stopped the scheduler, kevent can block indefinitely. The
descriptor closes, but its callback cannot release the slot. V6 therefore does
not establish its broad finite-close claim. The reviewer ran no builds, tests,
native probes or mutations.

Root surfaced a scope choice and is proceeding with explicit streaming setup
refusal on community BSD as the default. That guard requires its own concrete
implementation and review; restoration requires working worker wakeups and
native validation. This does not alter the existing buffered path. The typed
loop-adapter slice can proceed independently. No fourth full retirement review
or lifetime activation is implied by this checkpoint.
