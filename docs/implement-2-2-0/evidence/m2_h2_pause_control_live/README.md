# Owned HTTP/2 pause and public-control evidence

The [archive](pause-control-live.tar.gz) preserves all fixture revisions, retained
compile failures and successful receipts, input inventories, independent initial
and fix reviews, actual pure codec guard checks, Root audit/authorization, exact
executed command, raw result/server log/public certificate and result audit.
All 113 members are safe regular files; 112 inventory entries verify.
No private key or compiled executable is included.

Archive SHA-256: `14497888b6ee1c677660082ecb7c4341e2d555882fee3c940c27df4a64b74e86` (1234656 bytes).
See the [manifest](manifest.json) and [component report](../../m2_h2_pause_control_live.md).

The single Linux ReleaseSafe TLS1.3/h2 run passes partial_pause, final_pause,
begin_pause_empty, control_rules and shutdown_idle. Five accepted requests each
have1/1/0 begin/end/cancel; aggregate5/5/0, zero failed/errors/active. Forty-two
callback refusals and ten terminal refusals match the exact public errors.
All five persistent records match after deinit;41 responses end normally.
Owned SIGTERM exits0/reaps/no force or retry; private key removed.

The partial pause holds accepted7 through queuedDATA/EOF, then resumes12289
bytes with SHA`f84149bf46313d9f7da734e3d53f88b2d01a2c01c38bf422063c507b237915f4`.
Both partial barriers require no finalHEADERS/end. Final-byte pause resumes32
without more upload data; begin-paused emptyEOF has no chunks before/after resume.
Ordinary ready/stale/callback/terminal control validation is distinct from native
cancellation schedules or active cancellation, which this run does not exercise.

Candidate source remains1031-file
`fc69e66f18d404aff19a0b018b81dd35c02ec2a46ed8f38670eb926c794f72de` from the
[native checkpoint](../m2_h2_native_tcp/README.md), with unchanged c223 override,
bindings/libraries and [pinned client](../m2_h2_client/README.md). The
[core proof](../m2_h2_core_live/README.md) remains separate. Exact compiler argv
and source/input/binary hashes are in `evidence/*v3*.json`; exact runtime argv
and environment are in `evidence/fix1/stage-b-authorization.json`. That record
authorizes the completed run, not arbitrary future runs.

Initial source review finds an early-final-HEADERS observation gap; the retained
fix adds an actual shared pure guard and real-codec checks. No old live failure
or original behavioral red is claimed. Both scoped re-reviews pass; unchanged
Debug/ReleaseSafe binaries are rehashed, not rebuilt. Only ReleaseSafe is run.
Subset support is source-checked; only the full selected set ran. The unused
copied100M hash constant is a recorded minor for later fixture cleanup.

Remaining5b/5c, full combined H2, H3, multipart transport, genuine earlydata,
physical-lifetime/full-quality/platform/compliance, maintained publication,
production adoption and M2 remain open. Fixed-capacity evidence is not an RSS/
leak/native safety proof. Unread future resets and exceptional cleanup are
outside this run. Stopped experiments and denied socket cases remain stopped.
