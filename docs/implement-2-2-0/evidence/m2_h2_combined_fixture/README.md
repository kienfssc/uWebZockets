# Combined HTTP/2 fixture evidence

The reviewed fixture has 67 persistent body records, two application slots,
three 8192-byte producer scratches and one 8192-byte file scratch. It uses the
unchanged candidate and libxev override authenticated by the retained receipts.
This checkpoint compiles the fixture; it does not execute a native case.

Archive: `combined-fixture.tar.gz`, SHA256
`c731e84571477286905ed9116fe8f3e6d820d492e6696fb3382947def8cb38c9`, 1601430 bytes. It contains 412 safe regular text members; `inventory.json`
records the sizes and SHA256 values of the other 411 members. No compiled
binary, cache, private key or Python executable is included.

- `source/fixture/`: 25 current frozen source, proof, preparation and binding files.
- `source/tools/`: 4 guarded replacement recorders/checkers.
- `reference/`: 11 retained family sources and the 6-file reviewed model.
- `builds/`:exact source snapshots, compiler commands/environment/maps,
  stdout/stderr and statuses for 8 failed, intermediate and final attempts.
- `proofs/`:actual metrics/helper RED-GREEN diagnostics, focused check outcomes,
  and separate compileLog observations. The diagnostic exit 1 is intentional.
- `history/`:preserved defective helpers, source-generation tools, early logs
  and the capacity-recovery snapshot.
- `evidence/`:requirements, full implementation report, source/fix reviews,
  source maps and independent Root audits.

The final `Fix1Final2` Debug and ReleaseSafe receipts both report exit 0 on the
same 25-file fixture, 1031-file candidate, 93-file override and 12 original direct
inputs. Compiler environments contain only `LC_ALL=C.UTF-8`; streams are empty.
Debug artifact SHA256:
`37557e3932bc04d8d98b7ddccc1ed6479a555c5df9a562ea287ac9ea1405019c`.
ReleaseSafe artifact SHA256:
`3004debe07208fe508aa293141251213aad33c5eee6a086660efd18288780e76`.
Neither artifact was executed. Earlier successful snapshots are labeled
intermediate; failed compilations retain their exact diagnostics.

The corrected compileLog proof computes body 462/output 553/prefix 51 bytes,
overhead 1452 and retained 39162, within 768/1024/64/2048/62144 respectively.
It exercises the actual formatter on the reviewed schedule bounds. Independent
literal comparisons cover 67 default body schemas and 4 metrics/aggregation states.
Root matched those literals to the unchanged model and verified final inputs,
artifacts, archive safety, complete inventory and reviewed source identities.

Ten focused Python runs passed: five covering scripts, each normal and `-O`,
using pinned Python 3.14.2 with `-B -S`. Formatting also passed. The recorder-only
second fix checks 9 current helpers under empty/foreign argv with rejecting doubles;
it did not rerun the unchanged successful compiler work. The exact commands and
raw standard streams/statuses are retained, including 8 behavioral REDs for the
historical recorders. The initial metrics RED source was not separately frozen;
its diagnostic and command are retained, while final proof source is frozen.
The new recorders' operational paths were tested with doubles, not invoked as
new compiler/check-recording runs. Recorded absolute paths describe this Codespace.

Source/specification and quality review passed after both fix rounds. Combined
client integration, startup serialization/grants, runtime closure, a fresh idle
child plus main 39-case native execution, broader gates and production adoption
remain required. This preparation does not complete M2.
