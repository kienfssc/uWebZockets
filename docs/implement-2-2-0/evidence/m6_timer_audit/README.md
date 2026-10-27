# Timer and host audit evidence

The [archive](m6-timer-audit.tar.gz) binds source snapshots, exact commands and raw
outputs for the C6 audit and pure overflow correction, plus a fresh C1 host
observation. It contains 41 safe regular members and 40 inventory entries,
checked by root after packaging. SHA256:
`124890cef3b6265a7edaa517c3c4410dbe7fe83674fafb230877b4862cd217e4` (113959 bytes).
The [manifest](manifest.json) binds every retained file.

Existing pure wheel tests pass 6/6. A first probe that advances near the deadline
passes; the single-leap regression then fails at its actual callback-count
assertion. The isolated next-event correction passes all seven cases in Debug
and ReleaseSafe. Source hashes and a patch preserve both versions. Independent
review and production integration remain pending; the root timer implementation
is unchanged. No native clock/cancel/race/crash experiment was run.

The source audit records that repeated sleep replaces the parked callback but
does not expire the current response token. Native parked-H2 reset and the
plan's token semantics remain open. The host metadata establishes no designated
quiet host, benchmark sample or performance result. A credential scan found no
matching environment values or GitHub token patterns in retained file bytes.
