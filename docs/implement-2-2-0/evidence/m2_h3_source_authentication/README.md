# HTTP/3 pinned-source authentication evidence

Date: 2026-10-29. Scope: offline identity of one cached lsquic source file.
See the [checkpoint report](../../m2_h3_source_authentication.md).

`source_authentication.tar.gz` contains nine regular files: the current
`authenticate_qdec.py` tool and its regression test, the original tool/result/source
under `qdec-provenance-v1/`, the current result/source under `qdec-provenance-v2/`,
the raw `fix-report.md`, and an eight-entry `inventory.json`. The
[manifest](manifest.json) binds this archive, the original dependency archive,
the bundle, the commit/tree/blob and the source digest. The raw result retains
all nine Git commands, exit statuses, stdout and stderr, including the harmless
initial-branch hint and the full source returned by `git show`.

The current tool was invoked as:

```sh
PYTHONOPTIMIZE=1 python3 -B -S -O .superpowers/sdd/m2_h3_streaming_plan/authenticate_qdec.py
```

It uses the retained
[`current_pins.tar.gz`](../m3_pin_archives/current_pins.tar.gz), whose SHA-256 is
`d7fad900595499141777bb3f6fcdd8999f1a8e8917a1704432a1afc329a7a6c5`.
Only `bundles/lsquic.bundle` is extracted. Its SHA-256 is
`cbe304c04e2157bbbb5c2eed2e81e9440809391fe4d4dc8c9df051e8325a7d58`.
The tool uses fresh temporary Git storage and compares the pinned file with
the existing package cache before and after. Its recorded absolute paths locate
the original run; reproduction in another checkout requires adjusting those
paths and choosing a fresh output directory. The complete dependency archive
already provides a portable restoration tool and instructions.

Review exposed a false-PASS risk in the original assertion-based tool when
Python optimization is enabled. The current tool uses explicit failures and
records the interpreter and optimization level. Under optimization, the five
regression tests first had three failures and two errors; the changed-cache
case printed a false `PASS`. All five pass after the fix. The original version
and raw results remain as history; v2 is the current proof.

Bundle verification, offline fetch and full strict Git fsck passed in the actual
v2 run under CPython 3.14.2, optimization level 1. Archive
readback checked all nine members against their original bytes. No network,
native execution, existing repository ref update, dependency change or source
edit occurred. The retained source is upstream dependency evidence, not a local
patch or build input. Its [MIT notice](../../../../licenses/vendor/lsquic_license.txt)
is retained in the repository. HTTP/3 upload, lifecycle, platform, compliance and release
requirements remain open.
