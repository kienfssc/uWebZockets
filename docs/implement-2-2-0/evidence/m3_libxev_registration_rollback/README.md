# Reviewed epoll registration rollback

The [archive](epoll-registration-rollback.tar.gz) preserves reviewed local append
`c223bd886c6a51d2cd60def39dd9a68d701fea73`, parent
`179f22bc539548e024407b76d4aa39c54342e5b4`, tree
`86c6944f53dc009d7503a9ab0bc873aef3cd7b79`. Exact source, complete-history
bundle, accepted plan, independent review and raw verification are retained.

SHA256: `015830477ecbd886600d814ed474531b8a01e261e622a4d5e68fca0be7c300d1`
(1,835,180 bytes). The [manifest](manifest.json) records 97 safe regular members
and 96 inventory entries. Retained bytes and decoded source passed credential
checks; historical packed objects were not exhaustively decoded. The bundle
restores the exact commit/tree into an empty repository with strict fsck.

All eleven registration paths retain an explicit acquisition record. Failed
ADD takes only a newly acquired duplicate, including fd 0, invalidates its
cache before close and preserves the exact error. Original/cached fds, operation
fd, dup request, callbacks, state and active accounting remain unchanged.
Connect carries the record across WouldBlock. A stack output handles the packed
cache without changing completion layout; unowned paths never read that output.

Independent review found no actionable findings. Extracted-old-policy red fails
the two ownership cases; final focused suites pass 30/30 each, including four
new named cases. Healthy Debug and ReleaseSafe each pass 159 with four existing
skips, 163 total. Linux x64 layout assembly is byte-identical; Windows focused
compilation passes without execution. An evidence-parser failure is retained
separately from the corrected alias-aware comparison of all thirteen values.

Pure tests exercise the actual ownership decision. A failing kernel ADD and
rollback close were not executed or measured. No native fault, cancellation,
interleaving, race or leak probe ran. Immediate connect outcomes, old cache
semantics and general retirement remain outside scope. Maintained publication,
protection confirmation and root adoption remain open; root pins are unchanged.
