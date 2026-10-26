# M1: opt-in static sidecars

Status: implemented and independently reviewed, 2026-10-26. Native proof
passes; live delivery and final-source gates remain open.

`Options.precompressed` defaults to false. When enabled, static serving opens
the confined regular source, probes fresh gzip/Brotli sidecars, and negotiates
all Accept-Encoding fields. It closes every unselected descriptor. Missing,
stale, nonregular, symlink, and overlong candidates are unavailable; permission
and unexpected I/O failures propagate. There is no new filename component cap.

Selection precedes conditionals and ranges. Original-path MIME is preserved;
coding-specific ETags, selected descriptor mtime, and encoded size govern
validators, Last-Modified, Content-Length, and encoded-byte ranges. Negotiable
identity and encoded responses include Vary, including 304. Encoded 304 retains
Content-Encoding. A 406 has no file body; 416 reports the selected total and
Vary with an empty error body and no misleading Content-Encoding.

The existing send_file/stream_file ownership and bounded legacy fallback stay
in place. No queue, body, route-buffer, or header-entry capacity grows. No hot
allocator or lock is added. Six public test-only declarations reuse the
existing static wire fixture rather than duplicate it.

## Filesystem boundary

Pinned Zig 0.16 pathname stat panics on a filesystem component ENAMETOOLONG.
A valid source name can trigger this after appending a sidecar suffix. A Linux
metadata-only O_PATH open maps the error correctly through the supplied Io;
its descriptor is statted and closed before the ordinary readable open. Only
regular candidates proceed. The readable descriptor's stat remains authoritative
and metadata descriptors never enter FileSource. Other platforms retain their
existing stat path. The narrow profile exception, removal condition, and
operator-controlled namespace assumption are recorded in
[ADR 0010](../adr/0010-bounded-file-streaming.md#asset-filesystem-boundary).
The preflight does not guarantee progress against hostile entry replacement.

## Evidence and review

The [raw evidence](evidence/m1_static_sidecars/manifest.json) retains the absent
API and runtime-selection REDs, the long-name panic, an independent stdlib
reproduction, workaround probes, commands, exact source hashes, and GREEN logs.
Focused cases pass 22/22; reduced Linux probes pass 3/3. The canonical native
suite passes 752/752 tests and 22/22 build steps, exit 0. Existing deliberate
fault warnings remain in the log.

Tests cover selection/quality/refusal across all fields, defaults, freshness,
confinement, symlinks, nonregular files, long leaves, metadata-descriptor cleanup,
readable-fd freshness, selected validators, HEAD, 304, ranges/If-Range, 406/416,
and fault cleanup. Gzip/Brotli fixtures independently decode to the expected
35-byte identity body; that development-only check adds no build dependency.
Injected H3 cases and fixture decoding do not establish live client delivery.

Independent source, ownership, filesystem, metadata, negotiation, and structural
review found no actionable source issues. Root recorded the requested workaround
retirement criterion. Formatting, conventions, release/docs checks, and graph
refresh pass. Final-source sanitizers/platform/package/fuzz/protocol gates,
large plaintext/live-H3 downloads, actual client decoding, and static-profile
evidence remain M1 acceptance work.


## Static profile MIME closure

Official static-profile assets include regular.woff2 and bold.woff2. The final
pure MIME polish maps that extension to the registered `font/woff2` type,
following [IANA](https://www.iana.org/assignments/media-types/font/woff2) and
[RFC 8081](https://www.rfc-editor.org/rfc/rfc8081.html#section-4.4.6). Two assertions
extend the existing MIME case, including uppercase extension handling. The
[retained RED/GREEN](evidence/m1_woff2/manifest.json) reproduces the generic
fallback, then passes 1/1 focused and 752/752 combined native tests, 22/22 steps.
Independent review finds no issue. Formatting, conventions, release/docs,
dependency checks, and graph refresh pass. This adds no transport or allocation
behavior and is not an official static-profile activation claim.
