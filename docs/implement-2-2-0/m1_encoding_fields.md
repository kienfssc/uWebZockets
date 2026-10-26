# M1: complete-field content-coding negotiation

Status: implemented and independently reviewed, 2026-10-26.

negotiate.select_encoding_headers accepts the existing fetch.HeadersView and
EncodingAvailability. It scans every matching primary and overflow field,
preserves absent versus present-empty semantics, and shares scalar accumulation
and final choice with select_encoding. Existing single-field behavior,
minimum duplicate weights, malformed-known refusals, wildcard precedence,
identity defaults, and tie order remain unchanged. No field joining, entry
capacity, allocation, I/O, lock, or retained borrowed slice is introduced.

The [actual API-absence RED](evidence/m1_encoding_fields/encoding-red.log.gz)
fails before the new entry point exists; no deliberately broken adapter was
added. Focused GREEN passes 14 tests, including six all-field groups. The
isolated full native suite passes 719/719 and 22/22 steps, exit 0. Its initial
translation-cache sandbox failure remains separate; unchanged source/flags
pass under escalation after the first invocation terminates.

Smith and LLVM query coverage now compare first-comma whole-entry splits over
all eight availability masks and preserve refusals in primary/extra orders.
The bounded query smoke passes. These results do not claim a new 100K fuzz
campaign or complete OSS-Fuzz matrix; final M1 gates remain required.

The downstream package compiles the named public function signature in
ReleaseSafe: 16/16 steps, exit 0. Formatting, conventions, release metadata,
graph refresh, and diff checks pass. Independent review verifies the four-file
patch and hashes and finds no actionable issues. The
[source record](evidence/m1_encoding_fields/source_manifest.json) binds exact
commands, sessions, files, and the additional consumer check.

Static sidecar integration follows under [ADR 0010](../adr/0010-bounded-file-streaming.md).
Use Request.headers() rather than get_unique_header when invoking this helper;
duplicate encoding fields must not become indistinguishable from absence.
