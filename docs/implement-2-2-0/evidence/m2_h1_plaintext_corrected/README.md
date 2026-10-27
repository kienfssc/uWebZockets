# Corrected plaintext client evidence

All 21 ordinary cases pass against the unchanged reviewed combined source and
ReleaseSafe server binary. The [archive](corrected-plaintext-client.tar.gz)
preserves the exact client preimage/diff, independent correction review,
runtime fixtures and raw records, source/input/binary bindings, lifecycle
results, and three passing unchanged healthy TLS echo tests.

SHA256: `7e1472279d4fd739a1da26a0f389b52aedf830b755e4d25363f65dbbcb1de1d1`
(140694 bytes). The [manifest](manifest.json) binds 20 safe regular members and
19 inventory entries. Credential-pattern and available named credential-value
checks pass. Executables are omitted with their identities retained.

The original 33-byte rejected payload/trailer sequence receives a complete 413
before the recorded connection reset. A separate size-line-only case receives
413 and clean EOF with no payload sent. Both accept zero bytes, cancel once and
release quota for a real max32 retry. Failed begin produces clean pre-header
EOF and releases quota for a real same-route retry. Exact 413/503 assertions
remain mandatory for declared-size and quota refusals.

Both successful upload framings transfer exactly 100000000 bytes with SHA256
`190f6457d88258809df90a042b0226dab5537a1984f708cfd5bb90005835cea2`.
Real-file, pause/resume, pipeline, middleware and terminal checks also pass.
The owned server exits 0, is reaped without forced termination and records
post-deinit drain. Runner exit is 0; all 1023 source and recorded compiler,
client, binary, library and 93 override inputs remain unchanged.

Use the server source/profile and compile record in the
[implementation checkpoint](../m2_h1_plaintext/README.md); this archive changes
only verification. The original 18/20 failure result remains preserved there.
Producer metadata and remaining lifecycle/transport cases are still open.
Legacy TLS echo success does not activate TLS uploads or complete M2.
