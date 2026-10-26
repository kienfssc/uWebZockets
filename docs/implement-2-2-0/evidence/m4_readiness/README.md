# WebTransport readiness evidence

The [archive](readiness.tar.gz) preserves unchanged source snapshots, Git blob
and SHA bindings, published-fork permissions, fixed draft/client references,
old-gate observations, and individual command results. The
[manifest](manifest.json) records its outer hash and scope. Extract into a new
directory and verify its inner SHA256SUMS before inspection.

Independent review validates all 106 inner checksums, 24 root-source bindings,
six lsquic source bindings, and the distinction between source/helper evidence
and actual live results. No new build or live CONNECT/SETTINGS probe ran.
The old qlog corroborates only recognized QUIC datagram-parameter absence;
it does not establish draft-16 negotiation or an immediate CONNECT refusal.
