# M2: coherent H1 implementation baseline

Status: isolated mechanical composition verified and independently reviewed,
2026-10-27. Actual H1 upload delivery remains open.

The [checkpoint](evidence/m2_h1_baseline/README.md) combines prepared router/App
and cold-owner storage, typed loop callbacks, the confirmed platform guard,
pure H1 admission, final H2 refusal v6 and final H3 refusal v7. It starts from
Root production source 3cc8f81 and preserves the later multipart, timer, fuzz
and package-consumer work. Earlier component snapshots cannot replace Root
wholesale. The saved authority map and per-file merge ledger identify the
source of every changed path.

TCP explicitly combines the guarded owner entries with the H2 header selector.
Current central tests retain the timer regression and all prior imports, adding
each component import once. Verification facades remain test inputs. All four
dependency views and root exports retain their original bytes.

Measured default slabs are 684,177,024 bytes on Linux, 684,095,104 on macOS and
684,676,736 on Windows. Each grows by exactly 16,384 bytes relative to Root:
R2 adds 8 bytes and H2 another 8 bytes per connection across 1,024 slots. The
three exact assertions now record those measured values; capacities and
thresholds are unchanged. The platform guard itself adds no layout growth.

The complete unfiltered centralized graph compiles in ReleaseSafe. Each mode,
Debug and ReleaseSafe, passes 134 selected pure/component cases, five buffered
decoder cases, 17 App cases, 69 unchanged H2 cases and 35 unchanged QUIC cases:
520 executed cases in total. Compiled binary hashes and source/input stability
bind each run. Formatting, conventions, version and AST graph update pass.
Initial compile failures remain preserved: the replay graph lacked direct
zslay access, followed by the outdated exact layout assertion. The graph repair
changes no source/build dependency configuration.

Independent composition review found no actionable findings, including its
structural lens. It verified all 1,020 frozen files, 989 untouched Root inputs,
protected paths and the 93-file immutable local libxev override. Production
dependency pins remain unchanged. This foundation supplies no full Root test,
sanitizer, native foreign runtime or live interoperability result.

The next isolated slice prepares cold H1 head association, delivery pinning and
pending-payload accounting. Resolver binding, actual H1 body delivery, retirement,
physical close and TLS hooks still require implementation and review. Public
transport integration and all original milestone gates remain required.
