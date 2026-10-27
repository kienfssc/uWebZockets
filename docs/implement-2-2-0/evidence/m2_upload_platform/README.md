# Request-streaming platform guard V2 checkpoint

The [archive](request-streaming-platform-v2.tar.gz) preserves the reviewed
11-file overlay, exact preimages, source audits, commands, raw outcomes,
versioned V1/V2 evidence, independent review and the eligible-runtime H1
implementation contract. It also preserves the baseline-authority map for
later composition with current Root.

SHA256: `a2f5be864ee153ef881d3973d5e0be7a69e1ae13ebfc72726d486a2dd5548dad`
(1,389,082 bytes). The [manifest](manifest.json) binds 336 safe regular members
and 335 inventory entries. Derived executable/IR outputs omitted from the
archive are identified by size and hash. Retained bytes passed credential-value
and GitHub-token pattern checks.

Linux App tests pass 17/17 in Debug and ReleaseSafe, with no skips. Final V2
Windows/macOS App graphs compile without execution. The actual FreeBSD target
proves setup refusal at compile/comptime and compiles the complete App graph;
this uses two documented annotations in temporary generated C bindings. Raw and
adjusted bindings, the original sys/time.h, their exact delta and the
hash-identical 159-source proof snapshot are retained. No native BSD runtime or
worker-wakeup result is claimed. Failed harness/translation attempts and the
expected pure red/builder refusal remain distinct from successful checks.

Independent review found no actionable findings in this bounded activation
unit. Final eligible-target compile records bind all frozen V2 sources.
The user explicitly confirmed gating streaming on community BSD. The
eligible-retirement contract accepts only a subsequent implementation plan;
the historical unrestricted V6 liveness claim remains rejected.

This is an isolated successor, not a combined production build. Its prepared
tree predates Root's timer fix; later assembly must retain current Root
multipart, timer, fuzz and consumer inputs. The test-only libxev override is
local candidate `c223bd886c6a51d2cd60def39dd9a68d701fea73`, tree
`86c6944f53dc009d7503a9ab0bc873aef3cd7b79`. Root pins and maintained refs remain
unchanged. H1 delivery, physical close, TLS review and combined gates remain.
