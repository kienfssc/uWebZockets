# Reviewed IOCP cancellation-result candidate

The [archive](iocp-cancel-not-found.tar.gz) preserves reviewed local append
commit `b2afbafa6900d147ea0dea56e33b612b18f278d4`, parent
`29490914cf58b24d7ab32ca5349f9a03a910435f`, tree
`512dbee775106f1a84d14715a0ce4cf85f47dceb`. It includes exact source, the
complete-history Git bundle, independent review and raw verification.

SHA256: `dca4e99a32baa16cc0bae5eceb4f19161360406b2169e0adcff3daf906b99384`
(2,144,633 bytes). The [manifest](manifest.json) records 87 safe regular archive
members, 86 inventory entries and omitted foreign binaries by hash and size.
Retained bytes and decoded source passed credential checks; packed historical
Git objects were not exhaustively decoded. The bundle restores the exact
commit/tree into an empty repository and passes strict fsck.

Both active native cancellation paths now acknowledge only
`CancelIoEx(FALSE)` with `ERROR_NOT_FOUND`. Native success returns before reading
last-error; other failures preserve the existing `Unexpected` error and
diagnostic. Public errors, completion layout and state handling are unchanged.
This follows the [Microsoft CancelIoEx contract](https://learn.microsoft.com/en-us/windows/win32/api/ioapiset/nf-ioapiset-cancelioex).
Acknowledgement does not permit target-storage reuse before its completion.

Independent source review found no actionable findings in this scope. The
extracted-old-policy test fails only the missing-request expectation; final
focused suites pass 30/30 in Debug and ReleaseSafe, including four new named
policy cases. Unchanged healthy suites pass 155 with four existing skips each,
159 total. The initial sandbox-denied run is preserved separately. Windows
compilation passes 8/8 steps; before/after layout and closed-error consumer
assembly is byte-identical. No Windows executable was run.

No native cancellation, fault, race or leak experiment ran. Full H1 retirement
remains open: fresh source review also requires removing worker access to
published completion storage and releasing newly duplicated fds when epoll
registration fails. The maintained refs and all root dependency pins remain
unchanged. The Codespace credential reports `push: false` for both maintained
dependency repositories; publication, protections and adoption remain pending.
