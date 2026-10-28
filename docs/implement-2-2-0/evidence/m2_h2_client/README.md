# Independent HTTP/2 client preparation

The [archive](independent-h2-client-preparation.tar.gz) preserves prepared client
helpers, pure checks, failed runs and source snapshots, the informational-header
budget fix/review, pinned pure wheels with their licenses, source URLs/hashes,
loaded module identities and an offline restoration helper.

SHA256: `38b27b6fb02b69d341629224b0b713e053a1b593f6ed7ec8bfc44257ed86140a`
(134440 bytes). The [manifest](manifest.json) binds 53 regular members and
52 inventory entries; all hashes and credential checks pass.

Verification tools are h2 4.4.1, hpack 4.2.0 and hyperframe 6.1.0. Their complete
42-file source inventory is bound to
`0f85bd19e3af0e20c135b960d3a16361662c2ae32a256cc8df6e7be283cde473`.
The fixed client source is
`07a5201f4cb85be3053b572ae6ffccb7173c263db44483f76bd934b5d6f09d00`.
No installation/build scripts run and no production build dependency is added.
Public API grounding is the [hyper-h2 documentation](https://python-hyper.org/projects/hyper-h2/en/stable/api.html);
exact release metadata and source URLs are retained in client-tooling/packages.json.

The pure protocol pair checks fragmented input, informational/final headers,
padded DATA, trailers and full count/hash of the bounded 100000000-byte generator.
That generator matches the reviewed payload SHA256
`190f6457d88258809df90a042b0226dab5537a1984f708cfd5bb90005835cea2`.
It never contacts uWebZockets or an endpoint. Initial incorrect expected-literal
failures are preserved and excluded from behavioral-red evidence.

Independent review found unbounded informational-header retention. The corrected
helper preflights 16 responses and a 16384-byte aggregate budget before retention.
Actual behavior-red, boundary/unchanged-state regressions and normal follow-up
frames are retained; scoped re-review approves the fix. An intermediate faulty
deepcopy assertion is also preserved with its diagnosis. Final pure checks and
scratch AST refresh pass.

Extract the archive, then run client-tooling/restore_tools.py with a new temporary
destination to restore every pinned package file without network or install hooks.
Use that path as PYTHONPATH and Python -B for prepared helper checks.
Socket/TLS helpers, the process-owning live runner, live uploads and native
activation remain unverified. This checkpoint authorizes no live use and closes
no M2 transport acceptance requirement.
