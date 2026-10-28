# Core owned HTTP/2 request-streaming evidence

The [archive](core-live.tar.gz) preserves the reviewed fixture and bounded client,
original v2 and fix-round-1 sources, exact build/input inventories, retained codec
red/green, both independent reviews, Root identity audit and precise authorization,
executed command, raw run result/server log/public certificate and result audit.
All 79 members are safe regular files; 78 inventory entries verify.
No private key or compiled executable is included.

Archive SHA-256: `7f67b9addf3c8d015bf14a875d9a9d973d688c44cef7c3e99fd4c4a29f270879` (652288 bytes).
See the [manifest](manifest.json) and [component report](../../m2_h2_core_live.md).

All five selected cases pass in one owned Linux ReleaseSafe run over TLS1.3/h2:
buffered compatibility, ordinary async response, declared and undeclared actual
100000000-byte uploads, and normal idle shutdown. Each upload has matching
independent client/server SHA-256
`190f6457d88258809df90a042b0226dab5537a1984f708cfd5bb90005835cea2`,
begin/end/cancel1/1/0 and maximum offered span8192. The owned child exits0 and is
reaped, no forced cleanup or retry occurs, and the private key is removed.

Candidate source is the exact1031-file
`fc69e66f18d404aff19a0b018b81dd35c02ec2a46ed8f38670eb926c794f72de` from the
[native composition checkpoint](../m2_h2_native_tcp/README.md); that checkpoint
supplies the cumulative source patch and reconstruction evidence. Use the pinned
[client tooling](../m2_h2_client/README.md), reviewed c223 override, C bindings
and static-library inputs whose complete identities are retained in this archive.
The prior source is unchanged; the core package adds test-only files. The exact
compiler argv, executable identities, runner argv/environment and absolute input
paths are in `evidence/*final*.json` and `evidence/fix1/stage-b-authorization.json`.
Source identity must be re-established before any new execution; archived
authorization describes this completed run, not arbitrary future runs.

Debug and ReleaseSafe compile successfully; only ReleaseSafe is run. Offline
checks establish codec and helper behavior; the live run separately establishes
the listed five cases. Raw reset detection covers bytes observed, not future
unread resets. Source/capacity bounds are not RSS, leak or native safety evidence.

All 35 further planned cases remain open, including pause/credit/limits/quota,
metadata/control, producer/file/pressure/reuse, cancellation/error/disconnect,
active shutdown and the combined matrix. H3, multipart transport, genuine early
data, full quality/platform gates, maintained publication, production adoption
and complete M2 remain open. Stopped experiments were not resumed.
