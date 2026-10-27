# Plaintext H1 implementation recovery

The [archive](h1-plaintext-checkpoint.tar.gz) preserves the reviewed App and
transport components, combined overlay, preimages, fixtures, actual tests and
partial live results. The [slice report](../../m2_h1_plaintext.md) records the
18 passing and two unresolved initial client cases.

SHA256: `9e86b7188a0ad5ba0bc5e8f7f2596e97b500509b6f0ae378e2272db11173c175`
(3444303 bytes). The [manifest](manifest.json) binds 322 safe regular members
and 321 inventory entries. Retained bytes passed GitHub token-pattern and
available named credential-value checks. Derived executables are omitted;
their build identities are retained.

Apply `evidence/combined/snapshot/src/` over the immutable
[typed retirement baseline](../m2_h1_invariant_failure/README.md).
The combined manifest binds all 1023 source inputs. Five existing-file
preimages and the three new source files make the eight-path change reviewable.
The App and transport source snapshots and complete patches remain separately
available inside the archive.

Both exact 100000000-byte upload cases and real-file ordering passed. This
archive retains the over-limit reset and failed-begin EOF as failures, plus the
evidence-wrapper bytecode assertion and its explicit recovery. It excludes
the subsequent uncompiled fixture extensions and client corrections.
It is a recovery checkpoint, not production adoption or M2 completion.
