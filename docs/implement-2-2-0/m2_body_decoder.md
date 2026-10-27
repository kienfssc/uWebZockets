# M2 HTTP/1 head and body decoder

Status: pure decoder implemented and verified, 2026-10-27. This is a
pure parser checkpoint, not a working request-streaming transport or M2 closure.

The HTTP/1 parser now exposes a header-only admission checkpoint and shares
strict body framing with a pure BodyDecoder. Header parsing provisionally
retains valid u64 wire lengths. Buffered fallback commits the legacy policy,
including its earliest machine-width failure checkpoint, even when a later
structural error prevented a ready head. Configured Content-Length body limits
retain their original ordering after field, Host and Transfer-Encoding checks.

The existing consume signature, fourteen HttpParser fields, layouts, scalar
state, compaction, request views and pipelining behavior remain unchanged.
Buffered collection projects its existing fields through a stack decoder and
preserves its old line policy and exact scan accounting. It introduces no full
Request copy, persistent parser growth, connection-slab addition, allocation,
callback, clock or I/O. Request and OwnedRequest are unchanged.

The separate streaming decoder has explicit logical/header/line bounds,
validated discarded trailers, payload acknowledgement and prefix reclamation.
It retains offsets rather than input pointers. Those facilities still need
the real transport's admission, capped reads, pause/resume, metadata lifetime
and terminal ownership handling.

## Compatibility proof and correction

Preparation compares per-call consumption, all parser fields, views, scan work,
compaction and pipeline tails against an immutable baseline parser. Four
differential groups pass on native and actual x86 Linux32 binaries; all fourteen
field offsets/layouts match across six target selections. The historical
baseline oracle and source hashes are retained separately from production.

Independent review found that bounded ingress does not bound lifetime delimiter
work. The new streaming decoder's usize diagnostic counter could overflow.
Eight accounting sites now use saturating streaming addition, while buffered
projection keeps the original exact arithmetic. Pure tests seed only that
diagnostic near its maximum, then process actual legal framing; no multi-GB
request is claimed. Failing-first native/32-bit results and corrected 21-case
focused and four-group differential runs are retained. Bounded re-review found
no remaining production findings.

Root applies the exact reviewed v2 production patch and composes the four
central support/test imports with the already committed multipart slices.
The first full build catches a focused-test integration mistake: a relative
test_support import belongs to two modules. The test now uses the repository's
named test_support module. That one-line correction changes no production
source or test assertion; its initial failed build remains preserved.

## Canonical verification

The integrated native and C-sanitizer suites each pass 851/851 tests and 22/22
build steps. The default ReleaseSafe build passes 47/47 steps; ReleaseSafe test
compilation, Windows GNU and macOS ARM64 compilation each pass 20/20. The
downstream consumer passes 16/16, and the owned local h1spec server passes all
33 cases before recorded cleanup. Whole Smith requests 100K and records 304,615
runs, 3/3 tests and 19/19 steps. Six-target OSS-Fuzz object and deterministic
smoke graphs each pass 14/14. All 263 frozen source files remain unchanged
throughout the final matrix. Formatting, conventions, version, documentation,
whitespace checks and AST-only graph refresh pass.
Cross-target compilation does not establish native foreign execution; decoder
Linux32 proof does not establish full 32-bit App support. C/C++ instrumentation
plus Zig ReleaseSafe does not establish ASan instrumentation of Zig loads/stores.

The [evidence package](evidence/m2_body_decoder/README.md) preserves the
original preparation, source-bound failures and successful integration results.
Actual H1/TLS streaming, router admission, H2/H3 adapters, real bounded 100 MB
uploads and the final combined M2 gates remain open.
