# Multipart parser preparation evidence

The archive preserves P1 parser v1, its test-only v2 extension, and verification v3 plus dictionary v4. The outer manifest binds 254 safe regular members, 253 checksum entries, 174 original evidence files, 39 verification command/output pairs, and 29 source freezes. Each author's frozen imports remain separate; they are not claimed to form one combined root tree.

Archive SHA256: `b1c12f9169235b59aa6bb2f5c0134f2c494d295606b3d7c562eb8e28c7009c48` (207,714 bytes). Root independently checked all members, hashes, paths, and inventory. The archive contains README, HANDOFF, and REPRODUCE records, exact source and command bindings, raw failures, and successful outputs.

Results include 22 focused parser tests in Debug/ReleaseSafe, 100,999 native Smith runs, 10,000 external LLVM runs, six-target object/export/coverage and smoke graphs, and the fixed-block 100,000,000 logical entity-byte proof. The standalone comparison records equal payload/metadata hashes for both parsers and raw timings. It establishes no official throughput threshold or quiet-host result.

The first dictionary syntax failure and its correction remain preserved. External Clang/ASan linkage and Zig ReleaseSafe/coverage do not establish ASan instrumentation of Zig loads and stores. Large generated binaries, objects, evolved corpora, and the 100 MB fixture are omitted with hashes and reproduction notes. The fixture digest is explicitly derived from its frozen formula, rather than read from a retained original file.

This is preparation evidence. Root canonical verification, part-sink adapter evidence, actual request transport integration, and independent review records are separate. The pure proof establishes no live 100 MB HTTP upload.
