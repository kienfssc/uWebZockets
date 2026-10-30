# Pure HTTP/2 output observer checkpoint

`output-observer.tar.gz` contains69 regular UTF-8 files: six reviewed observer/
contract files,42 pinned codec source/metadata/license files, provenance, original
and fixed review evidence, source history and `inventory.json`. The
[manifest](manifest.json) binds archive and source hashes. Archive SHA-256:
`775cda492e8fde8850ac954f8e131bcc8be1caf534c0e121fb97d4a8e9bc3145`.

The observer hashes/counts exact responses online and retains zero large-response
payload bytes. Frozen expected responses are16777313 producer bytes,
24593 selected file bytes and17 early-final bytes. Padded DATA hashes logical
bytes; flow-controlled length remains available for the future independent ledger.
Small JSON responses remain bounded below4096 bytes. Manual credit invokes no
automatic acknowledgement. Raw parser limits and terminal/reset policies remain.

The normal frozen observer suite passes13 tests. The fix's selected optimized
suite passes3 tests. Root's independent frozen run passes13 tests. Prior contract
and observer runs, behavioral mutation failures, test-input corrections and the
review-found closed-stream reset regression remain in `evidence/task-5d1-report.md`.
The archived initial review requests changes; the scoped fix review passes.
Producer-size tests use inert event doubles plus serialized frames; separate real
codec tests cover split/padded data and closed/half-open refusal behavior.

To inspect or repeat the pure observer checks from the repository root, using
Python3.14.2 as recorded:

```sh
observer_artifact=/tmp/uwz-output-observer-20261030
mkdir "$observer_artifact"
tar -xzf docs/implement-2-2-0/evidence/m2_h2_output_observer/output-observer.tar.gz -C "$observer_artifact"
PYTHONPATH="$observer_artifact/source/client" python3 -B -S "$observer_artifact/source/observer/test_wire.py"
```

No package installation, network access, native server or socket is needed.
The42 codec files match digest
`0f85bd19e3af0e20c135b960d3a16361662c2ae32a256cc8df6e7be283cde473`.
Their retained wheel provenance and license metadata are included.

This checkpoint proves pure client behavior. It does not execute the five output
cases or close M2. The manifest lists remaining ledger, budget, fixture, runner,
native, combined-matrix, quality/platform and adoption requirements. The archived
budget/credit/file-I/O notes are source decisions for that remaining work.
