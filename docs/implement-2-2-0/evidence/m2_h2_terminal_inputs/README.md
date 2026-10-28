# Reviewed HTTP/2 terminal-input checkpoint

The [archive](reviewed-terminal-inputs.tar.gz) preserves four changed source
paths with preimages, full source inventories, raw command records and logs,
measurement inputs, original errors, independent reviews and the scoped fix.
All 477 members are safe regular files; 476 inventory entries verify.

Archive SHA256:
`454de85dcc1c002259a33a0a36b27deb4e04de09829c98f341e3c886f2559235`
(1640522 bytes). See the [manifest](manifest.json) and
[component report](../../m2_h2_terminal_inputs.md) for scope and limitations.

The readable [patch](terminal-inputs.patch) has SHA256
`c606fa2a9ae47d43480be3d990e07c28ab728e1b1e543757a20b187da4428650`.
It applies to the exact 1029-file [startup baseline](../m2_h2_native_startup/README.md),
`d69d1fb4f318f660ec5163315b1e70824a4a112803ad980bdcda7572b6d2c13f`,
and independently reconstructs final 1029-file source
`aa420a97e62062d78c0d3c2fd2f35df11115ef85b8b7cfe316d3734d592a6fd0`.
Use `git apply --unidiff-zero --check terminal-inputs.patch`, then
`git apply --unidiff-zero terminal-inputs.patch`. Historical contextual patches
and the earlier 485 source evidence remain archived without relabeling.

The final tree passes 190 selected tests in each of Debug and ReleaseSafe,
three-target central and eligible 32-bit compilation, static checks and AST
refresh. Root binds 117 indexed artifacts, 24 compile/run pairs, immediate new
raw-log hashes, binary/input identities and all 93 reviewed libxev override files.
Both original reviewers pass the server-only nesting fix. No tests were rerun
during evidence auditing or packaging.

The optional credit marker preserves native-eight and disabled layouts on all
three 64-bit OS targets; enabled generic width 2 grows by eight bytes. Eligible
32-bit widths 2/4/8 grow by four. CompileLog exit 1 is measurement; private offset
inspection identifies its visibility-only diagnostic copy. The first 32-bit
refactor comparison used the same source twice and remains non-comparative;
the corrected distinct-source pair verifies unchanged measurements.

Most older runtime logs lack individual historical digests. The inventory binds
their publication-time bytes and leaves that limitation explicit. New fix records
include immediate raw-log hashes. Two compound error combinations have source
inspection but no direct execution. Full runtime, sanitizer, live h1spec and native
release/upload acceptance remain open. No Root production source, maintained pin,
stopped experiment or denied socket case changed at this checkpoint.
