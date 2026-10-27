# TLS capacity contract evidence

The [archive](tls-capacity-contract.tar.gz) preserves the source-backed plan,
independent crypto review, Root's pre-flight rulings, exact ADR before/after
text and pinned-source hashes. No implementation, build, runtime or native
probe result is represented by this design checkpoint.

SHA256: `b07d2c5cf02b62d15197aae153823f090ea7cab3d197c7a50503533695caf36c`
(18392 bytes). The [manifest](manifest.json) binds nine safe regular members
and eight inventory entries.

The decision separates readiness and ciphertext byte count from the unchanged
HTTP plaintext cap, using the existing bounded BIO. Its reservation requires
one inbound BIO writer, one active receive and stable BIO lifetime through
retirement. The report's concrete implementation review and runtime gates
remain mandatory. It does not activate TLS request streaming or adopt a pin.
