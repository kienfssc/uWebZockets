# HTTP/2 output fixture: compilation and pure preparation

[output-fixture.tar.gz](output-fixture.tar.gz) preserves 150 safe regular text
members, including a 149-entry byte/SHA256 inventory. Its SHA256 is
`f1ff8cbf8e47b17e3c4d1a3337295b8141fe0a05f745d82d3c7ab205134349a1`
(709853 bytes). [manifest.json](manifest.json) records source identities,
actual build receipts, review scope and remaining work.

- `source/fixture/`: the five current reviewed fixture and preparation files.
- `source/client/`: the 12 current reviewed client files, with 37 function-based
  checks; the six runtime modules retain the previous client-core identities.
- `source/codecs/` and `provenance/`: 42 pinned pure Python codec files and their
  retained package, license and download metadata.
- `history/`: the failed first compile snapshot, successful builds with unknown
  ambient environment, controlled build snapshot and earlier client tests.
- `builds/`: complete actual compiler receipts and stdout/stderr. Binaries and
  compiler caches are excluded.
- `evidence/`: task requirements, reports, review returns, diffs, Root identity
  audits, actual check results and raw preparation-check logs. The edit-diagnostic
  text is explicitly reconstructed; compiler and check logs are original.

The controlled Debug binary hashes to
`57b1fabd6ea6a66ce92e065dbc4a336810ddd38e88cece3bf1a63de17267fe3d`;
ReleaseSafe hashes to
`d1a8a2c0e7e86d1cf4add784a4f1c48d85afde15cbebe783d7766f3ab88fa543`.
Both compiler exits were zero, with empty stdout/stderr and the explicit complete
environment `{"LC_ALL":"C.UTF-8"}`. Receipts retain all 1031 candidate source
and 93 override file identities, 12 unchanged non-fixture direct inputs and the
five-file actual compilation snapshot. The earlier compiler failure is retained
as a failure; any partial compiler artifact is not a successful build proof.

Current `profile.zig`, `output.zig`, `file_observer.zig` and `prepare.py` match
the controlled build snapshot byte for byte. Current `test_prepare.py` differs
from the historical test in that snapshot. No native compilation is attributed
to the changed test. Root's current frozen four-check result and optimized
37-check client result are preserved separately. Historical check failures show
the unguarded import and inherited-environment defects; rejecting doubles prevent
filesystem creation and compiler execution during those checks.

The existing [client-core checkpoint](../m2_h2_output_client_core/README.md)
remains immutable history. This archive supplies its current function-based
checks without changing the six runtime algorithms. Source and preparation
reviews pass. No fixture binary, constructor, native test, socket, transfer file
or certificate was executed or created in this preparation task. No native
returned-error behavior is inferred from Python doubles. Native H2 coverage
remains 35 case IDs; five output cases, the actual combined matrix, full
quality/platform gates and adoption remain open.
