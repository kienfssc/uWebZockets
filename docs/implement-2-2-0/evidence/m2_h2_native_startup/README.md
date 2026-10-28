# Reviewed HTTP/2 startup checkpoint

The [archive](reviewed-startup-storage.tar.gz) preserves five-file source/preimage
snapshots, full inventories, patches, available raw records, compiler/input/binary
identities, measurement sources and independent spec/quality/structural review.
It contains205 safe regular members and204 inventory entries, all hashes verified.

Archive SHA256:
`0d876de2207d8cc75c1324dbebd6b083a1c7131c6b43a17db04c984866b86697`
(832036 bytes). See the [manifest](manifest.json) and
[component report](../../m2_h2_native_startup.md) for exact scope.

The readable [patch](startup-storage.patch) has SHA256
`6bfe3d1853a0bff77ad10525b50839e806fe15fa30094cc37e2915a1f611ac3d`.
It applies to exact1029-file baseline
`1d53c6704d8f31c333052998a85a293834276f386b4239fdbf44556496a5342e`
and independently reconstructs final1029-file source
`d69d1fb4f318f660ec5163315b1e70824a4a112803ad980bdcda7572b6d2c13f`.
Use `git apply --unidiff-zero --check startup-storage.patch`, then
`git apply --unidiff-zero startup-storage.patch`. The original contextual patch
is also archived.

140 selected tests pass per Debug/ReleaseSafe mode; three-target central and
eligible32 compilation, static checks and AST refresh pass. Offset diagnostics
identify their own210dbcc1 source, differing only in private-function visibility;
public frozen-candidate totals cross-check them. CompileLog exit1 is measurement.

The interrupted first compile is invalid; the original red compile's missing raw
record remains explicit. Later fully bound red compilation/runtime0/1 preserves
the genuine capacity assertion failure. Source d69 and its final checks did not
change during that evidence correction. Root independently binds51 records,
52 unique inputs and16 compile/run pairs and verifies exact reconstruction.

Native body callbacks remain gated. TCP composition, live H2/TLS delivery,
production adoption and final M2 acceptance remain open. No maintained refs/pins
or Root production code changed, and stopped experiments/socket cases were not
retried.
