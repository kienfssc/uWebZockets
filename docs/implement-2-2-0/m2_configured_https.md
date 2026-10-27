# Configured single-App HTTPS construction

Two additive public constructors preserve the builder's full ServerConfig for
HTTPS: App.init_https_configured and Server.preset(...).build_https(...).
The existing init_https remains compatible. The reviewed isolated component
and a composed live single-App server both pass their scoped checks.

The [recovery archive](evidence/m2_configured_https/README.md) contains the four
actual changed files, complete preimages, patch, source manifests, public
consumer/example link evidence and independent API and crypto approvals.
Configured slab construction and TLS context loading are transactional: a
certificate/key error releases the App's storage. Loop/head/failure binding
still occurs at its existing lifecycle boundary.

## Verification

The final candidate passes 2/2 focused and 11/11 unchanged healthy Debug cases,
plus 13/13 ReleaseSafe cases. Full centralized semantic compilation passes
Linux, macOS and Windows. The actual candidate public consumer and six existing
examples link. Formatting, conventions, version and AST graph checks pass.
Tests verify carving, deferred binding, key consistency and caller-slab cleanup;
they do not claim BoringSSL allocator instrumentation.

The first PEM test run faulted because by-value !App assertions required a
multi-megabyte test stack. The preserved static diagnosis led to a test-only
!void helper; the faulting binary was never rerun. The corrected ordinary tests
pass. Original backend-expectation failures also remain: the sandbox selected
epoll and the unchanged test correctly rejected an io_uring expectation. Final
epoll runs retain the same assertions. Transient generated PEM files from the
interrupted test were removed from the source inventory, with exact hashes and
digest reconciliation retained; no key material is archived.

Root composed the four reviewed paths over the TLS shutdown successor without
other source edits. That source passes 35/35 selected tests in each build mode,
three-target centralized semantic compilation and static checks. The
[live single-App TLS matrix](m2_tls_live.md) passes all 37 cases, including both
exact 100000000-byte framings and normal owned shutdown.

The constructor source digest is
`f6f6e7d62a5b33c33f5c466f225b6476778094582759efc63482913e08ed9458`.
The composed source digest is
`89dce088f5684c9173c45c572e785e7ff9c57991eb152ec76c46a58db481479d`.
No Root production adoption, dependency pin, C ABI, mTLS, HTTP/3 or release
completion follows from these results.
