# HTTP/2 output client core: pure preparation

`output-client-core.tar.gz` contains 79 regular UTF-8 files, including 11 reviewed
client/contract files, 42 pinned codec source/metadata/license files, provenance,
original and fixed review evidence, test history and `inventory.json`.
The [manifest](manifest.json) binds archive and source identities. Archive SHA-256:
`a8cd51e1d94cb3a8271bac006d15be81a86c47da0f9c4161b3e639b3aedd748a`.

The component keeps request-send debt and response-receive windows separate.
Raw refunds apply once and are checked against exact remaining debt. Ordered
codec events preserve duplicate occurrences and respect full closure at each
frame's position. Incoming reset closes both directions while preserving debt.
Strict output stages bound decrypted reads, frame types/counts and auxiliary
responses; final collection carries known debt without assuming quiescence.
The bounded hash-only observer and legacy default behavior are retained.

Recorded normal suites pass 10 client-core, nine receive-credit and 13 observer
tests. Two selected final client-core tests pass with `-O`; Root independently
ran the frozen 10-test suite. All 10 Python modules parse/import without output.
Root checked 65 actual inputs: 11 owned and 11 frozen files, 42 codec files and
the Python executable. The original reset-lifecycle failure, fix, actual codec
evidence and independent reviews remain in the archive. Test reports distinguish
codec behavior, source-shaped SETTINGS serialization and inert caller data.

To inspect or repeat the pure suites from the repository root, using the
recorded Python 3.14.2:

```sh
client_artifact=/tmp/uwz-output-client-core-20261030
mkdir "$client_artifact"
tar -xzf docs/implement-2-2-0/evidence/m2_h2_output_client_core/output-client-core.tar.gz -C "$client_artifact"
PYTHONPATH="$client_artifact/source/client" python3 -B -S "$client_artifact/source/observer/test_client_core.py"
PYTHONPATH="$client_artifact/source/client" python3 -B -S "$client_artifact/source/observer/test_response_credit.py"
PYTHONPATH="$client_artifact/source/client" python3 -B -S "$client_artifact/source/observer/test_wire.py"
```

No installation, network access, server or socket is needed. The pinned codec
source digest is `0f85bd19e3af0e20c135b960d3a16361662c2ae32a256cc8df6e7be283cde473`.

This artifact does not prove that a future driver pairs its actual public calls
with ledger actions correctly. It does not run the five native output cases or
the combined matrix. The manifest retains those requirements and full gates/
adoption. File-I/O notes are requirements for the future fixture, not executed
file-transfer evidence. The earlier observer checkpoint remains immutable.
