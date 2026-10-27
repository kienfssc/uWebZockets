# Integrated multipart utility verification

This checkpoint verifies the standalone P1 incremental multipart utility on
`feat/implement-2-2-0`, based on commit
`8da20c2e1c397124d5e8f4b136690326f84aac0e`.
It does not establish live request streaming, the separate part-sink adapter,
or closure of M2.

The evidence archive retains exact argv, source hashes, raw outputs, statuses,
source patch and the sanitizer setup failure followed by its configured rerun.
The frozen matrix used identical production and test bytes throughout; a
subsequent README-only correction records six fuzz targets instead of five.
The preparation archive remains a separate artifact with its own scope.

Native and C-sanitizer suites each pass 811/811 tests. The default build passes
47/47 steps; Windows GNU and macOS ARM64 compile graphs each pass 20/20;
the public consumer passes 16/16, and the clean package-path build passes.
MSan smoke passes 16/16; h1spec passes 33/33 against the owned server, followed
by recorded server cleanup. Whole Smith requested 100K and recorded 204,495
runs; the object and smoke fuzz graphs each pass 14/14 steps.

These results do not establish execution on foreign targets, Zig ASan/MSan
instrumentation, hosted OSS-Fuzz enrollment, or a live 100 MB upload. The
standalone 100 MB proof and comparison are in the preparation archive.

The [archive](multipart-p1-integrated.tar.gz) contains 103 safe regular members and
102 inventory entries, checked by root after packaging. Its SHA256 is
`836e08f1cd4bef9169468ad9a96e8570f14c971c0727bb14d5b5b2aa8e11e4c4` (126321 bytes). The
[manifest](manifest.json) binds every retained file and canonical outcome.
Build caches and generated binaries are excluded. A credential scan found no
matching environment credentials or GitHub token patterns.

Independent integration review found one stale five-target description; the
README correction passed bounded re-review with no remaining actionable
findings. The archive also retains the initial documentation check that ran
before this evidence README existed, followed by the successful complete
documentation check.
