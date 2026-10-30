# Combined HTTP/2 acceptance contract evidence

This checkpoint contains pure catalogue/model preparation. It executes no server,
fixture, build, socket or TLS operation. Actual combined40 remains open.

The archive is `combined-contract.tar.gz`, SHA256
`61d0640aabfd67528e61d394395694498174c2895a8beec74b47b49e715351b1` (1368413 bytes).
It contains 87 safe regular members; `inventory.json` covers the other 86 members
with byte counts and SHA256 values. The separate manifest records exact current
source and retained-input identities. The Python executable is identified, not
bundled.

`source/` contains the six current catalogue/model/test/notes files. `reference/`
preserves 40 textual source inputs. `history/` retains the first-review model,
its final results, and earlier source-reference copies. `evidence/` contains
requirements, architecture/barrier handoffs, implementation report, initial and
fix reviews, source audits and exact raw results. Initial behavioral RED text is
in the report; the fix round also has three separate actual RED/GREEN JSON pairs.

All three current scripts passed normally and with Python `-O`, using pinned
Python3.14.2 with `-B -S`. They cover 40 IDs/67 body records, selection/defaults,
pre/post transitions, separate hashes, family evidence, bounded arithmetic,
inherited read caps, buffered/async responses and producer binding observations.
Authored proof checks use explicit raises. AST/inert-import checks cover all five
Python files. Independent source/specification and quality review passed after
three P2 preservation fixes. Root independently verified archive safety,
complete inventory, all six current sources and the 40 textual reference inputs.

To inspect/replay from the repository root with the recorded interpreter:

```sh
contract_dir=$(mktemp -d)
tar -xzf docs/implement-2-2-0/evidence/m2_h2_combined_contract/combined-contract.tar.gz -C "$contract_dir"
/home/codespace/.python/current/bin/python3 -B -S "$contract_dir/source/test_catalogue.py"
/home/codespace/.python/current/bin/python3 -B -S "$contract_dir/source/test_model.py"
/home/codespace/.python/current/bin/python3 -B -S "$contract_dir/source/test_structure.py"
```

The retained six-command evidence also runs each script with `-O`. No third-party
package is needed for these pure checks. Actual formatter/log bounds, startup
serialization, combined fixture/client, fresh builds, runtime closure and the
two-child 40-case execution remain required. This archive does not satisfy broad
native/platform/fuzz/package gates or complete M2.
