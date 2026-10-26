# 0008. Bounded request body streaming

- Status: Accepted
- Date: 2026-10-26
- Deciders: transport, HTTP, router, QUIC, and root integrator
- Release: 2.2.0

## Context

Every live transport currently buffers request bodies before dispatch. Its
Content-Length policy applies the buffered ceiling before routing, so a new
handler alone cannot support a 100 MB upload. Response producers and async
response tokens do not provide a request coroutine runtime.

Choose the route-level sink recommended by the milestone plan. Keep framing
and lifecycle validation pure; transport drivers call application sinks and
perform I/O. The full-body APIs remain the default and remain compatible.
M1 must finish before this decision's transport implementation starts.

## Compatibility implementation gate, 2026-10-26

The initial shared Request/helper surface below is under revision before any
integration. A [compiler proof](../implement-2-2-0/evidence/m2_compatibility/README.md)
shows that adding BodyNotBuffered to an existing inferred helper error set
breaks unchanged buffered consumers. Keep the accepted route-level ownership,
flow-control, terminal, and capacity design, while preserving legacy helper
source compatibility through a separately reviewed streaming-aware surface.
Do not implement the initial helper guards as written or weaken the distinct
refusal semantics. The revised request/middleware/clone contract must be
accepted and pass the old consumer probes before implementation lands.

## Public contract

Add ServerConfig.stream_request_bodies, default false. Enabling it reserves
bounded startup storage; registration cannot resize a running slab.
route_body returns BodyStreamingDisabled when the feature was not enabled.
It borrows an immutable BodyRoute whose lifetime covers the App:

```zig
pub const BodyReadiness = enum { ready, paused };
pub const BodyProgress = struct { consumed: usize, readiness: BodyReadiness };
pub const BodyBinding = struct {
    context: *anyopaque,
    readiness: BodyReadiness = .ready,
};
pub const BodyLimits = struct { max_body_bytes: u64, max_active: u16 };
pub const BodyBeginFn = *const fn (*anyopaque, *Request, BodyControl) anyerror!BodyBinding;
pub const BodyChunkFn = *const fn (*anyopaque, []const u8) anyerror!BodyProgress;
pub const BodyEndFn = *const fn (*anyopaque, *Request, *Response) anyerror!void;
pub const BodyCancelFn = *const fn (*anyopaque, BodyCancelReason) void;
pub const BodySink = struct {
    context: *anyopaque,
    begin: BodyBeginFn,
    chunk: BodyChunkFn,
    end: BodyEndFn,
    cancel: BodyCancelFn,
};
pub const BodyRoute = struct { sink: BodySink, limits: BodyLimits };
pub const BodyCancelReason = enum {
    cancelled, peer_closed, reset, invalid_body, body_too_large,
    timeout, shutdown, source_failure, sink_failure,
};
pub const BodyControlError = error{
    BodyControlExpired, BodyCallbackActive, BodyNotPaused, BodyDeliveryFailed,
};
```

The caller supplies per-request state through begin's returned context. The
library never allocates it. max_active is a required positive admission bound
per route, per worker; existing connection/stream slots also bound concurrency.
Store counters within the existing router-record capacity. Refuse admission
before begin when its quota is full, with 503. A declared or observed logical
body above max_body_bytes receives 413 before accepting the offending bytes.
A zero logical limit permits only an empty body. Invalid registration limits
return InvalidBodyLimits. Check counters and logical arithmetic for overflow.

## Admission and terminal ownership

Validate framing and finish initial headers before choosing buffered or
streaming policy. Preserve existing early-data, method, QUERY, upgrade, and
routing rules. Buffered routes retain their existing ceiling and complete-body
middleware timing. For an enabled streaming route:

1. Pin headers and captures; set Request.body_mode to streaming.
2. Run middleware once with headers and an empty body.
3. Check declared length, physical ingress, admission, and metadata capacity.
4. Preserve middleware response metadata, reserve admission, and call begin.
5. After successful admission, send any required 100 Continue and deliver data.

A successful begin establishes exactly one end or cancel. A failed begin owns
its partial-resource rollback; no context was accepted and no cancel follows.
Release its admission reservation. Defer cancellation during begin until its
return; a successful binding returned after cancellation still receives cancel.

Each chunk slice is borrowed only during the callback. The sink consumes or
copies its accepted prefix. ready requires consumed equal to the offered
length; a partial prefix must return paused. Reject over-consumption and
zero-progress ready results. paused stops delivery until explicit resume,
including a pause after consuming the final byte. Do not spin-poll the sink.

Call end only after exact framing/length agreement, validated trailers, no
queued data, and readiness. Invalidate control generations before terminal
notification and release admission once after it returns. End follows normal
synchronous response rules: complete its fresh Response or arm an existing
response producer. It does not acquire an AsyncResponse token. End owns its
cleanup even on error; its error aborts output without a second cancel.

Cancel reasons distinguish application cancellation, peer close/reset, invalid
body, limit, timeout, shutdown, source failure, and sink failure. Reset/shutdown
during a callback records cancellation and defers notification and slot/context
release until the callback unwinds. Never release or recycle callback storage
under an active callback. Forbid event-loop reentry and App destruction there.

## Control and request lifetime

BodyControl is copyable, generation checked, and confined to the owning loop.
Its public operations are resume(control: BodyControl) BodyControlError!void
and cancel(control: BodyControl) BodyControlError!void. Both execute inline:
they may synchronously invoke terminal callbacks and release caller-owned sink
state before returning. Callers must not access per-request context after either
call without an independently valid lifetime. Copy needed values before calling.

BodyControlExpired covers inactive/stale generations; BodyCallbackActive refuses
reentrant use during begin/chunk, and BodyNotPaused refuses an unpaused resume.
Those validation errors change no state. BodyDeliveryFailed means resumed
delivery or end failed and the owner performed its terminal failure path; it
does not return the old context to the caller. Cancel does not use the latter
two errors. Resume retries retained input before arming reads and can deliver
pending end with no remaining bytes. Cancel abandons the upload through its
owner, invoking cancel before returning. Generation validation precedes callback
validation, so controls used from a terminal callback are already expired.

The App and backing storage must outlive every control use, matching the
existing async-token boundary. Header slices and route captures remain pinned
through deferred end and subsequent response lifetime. Move HTTP/2's shared
overflow captures to per-stream ownership before admitting streaming requests.
Request pointers and header-array views are borrowed for each callback only;
retain individual pinned byte slices or caller-owned metadata copies instead.

Add Request.body_mode with buffered as the default. In streaming mode body,
text(), and bytes() are empty; fallible JSON, JSON validation, form, and full-body
multipart helpers return BodyNotBuffered before parsing. Query helpers remain
available. Clone copies available metadata and preserves the mode, without
capturing future input. Validate and discard trailers on every transport; they
never merge into initial headers and end has no trailer view.

## Middleware and early responses

Retain up to the current 2048-byte pending-header capacity across middleware
and end; never retain the stack Response pointer. HTTP/1 reserves persistent
header storage only when streaming is enabled. HTTP/2 and HTTP/3 may reuse
their idle response-header storage, copying metadata into the fresh Response
before encoding overwrites it. Preflight capacity before begin, including
configurations smaller than 2048; refuse overflow without truncation.

Before the body completes, middleware can append headers or send a bounded
fixed final response. Stream/file starts return BodyNotComplete before mutation.
JSON/SSE starts inherit the canonical chunked-start guard. Preserve the
nonfallible writable_stream signature; its first write reaches that guard.

Early HTTP/1 rejection closes after final output drains. HTTP/3 stops reads
independently of response writes. HTTP/2 emits NO_ERROR reset only after every
final frame is accepted into ordered output. A high-level end call with pending
DATA is insufficient: retain explicit retry state, or abort on output failure.
Never queue reset ahead of the final response bytes.

## HTTP/1 and TLS

Add a header-ready admission boundary before buffered body policy. Extract one
pure incremental decoder for fixed-length/chunked framing; return consumed
offsets and body/end/error events without invoking sinks. Reuse that decoder
in the buffered collector to preserve framing strictness.

Pin the initial prefix and reuse its physical tail as bounded ingress. For
L=max_request_line_size, H=max_header_size, and B=max_body_size, the existing
request stride is S=align_up(L+H+B+1024,16). With parsed request-line length q
including CRLF and header content length k, header_end=q+k+4, q<=L, k<=H.
Compute R=S-header_end with checked arithmetic. Normal validated configurations
give R>=B+1020; defaults give S=41,984 and worst-prefix R=17,404. Persistent
middleware metadata is separate and does not reduce R.

Admission requires no ingress for an absent/known-empty body, R>=1 for positive
Content-Length, and R>=3 for chunked framing, including an empty chunked entity.
An unusable low-level storage configuration returns BodyIngressUnavailable and
503 before begin/100 Continue, then closes after output. Never grow storage.

For streaming chunked input, line_content_limit=min(H,R-2), excluding CRLF,
applies to each chunk-size/extension line and trailer field line. A chunk payload
can exceed R and is delivered in pieces. Trailer content is the sum of field-line
content lengths plus 2*(field_count-1), bounded by H; field count is at most 64,
matching existing trailers independently of initial max_header_count. Empty
trailers consume two bytes. Validate incrementally without retaining the whole
section. This per-line bound is new for streaming mode; buffered line/status
behavior is preserved. Malformed/overlong framing and trailer bounds fail with
400 and close; logical route limits use 413; initial-line/header limits retain
431. Error output is best-effort if transport writes have already failed.

Keep logical counters separate from buffer offsets. Preserve following pipeline
bytes and suspend dispatch through upload/response ownership. Cap enabled-path
socket reads and SSL_read at min(8192,free_ingress), even before admission, so
no unretained stack-buffer suffix can remain after a pause. A full retained
window pauses reads; it is not by itself a body-limit error.

Pause socket reads and TLS plaintext extraction while preserving BIO contents.
Resume consumes retained plaintext first. An upload pause retains idle-timeout
coverage; do not inherit dispatch_suspended's current timer cancellation.

## HTTP/2 storage and credit

Continue parsing connection frames while a sink is paused. Queue unaccepted
DATA in connection-owned 1024-byte blocks with per-stream head/tail indices
and a free list. Do not allocate a complete receive window per stream.

Hold DATA credit, including consumed head prefixes, until each occupied block
is completely reclaimed. Refund padding immediately because it uses no retained
payload storage. The required pool payload bound is:

```text
round_up(65535 + max_streams * 1023, 1024)
```

At eight streams this is 73,728 bytes, plus 432 planned bytes for three u16
metadata fields per block, before owner state/alignment. Only the partial tail
of each queued stream adds unaccounted fragmentation; consumed head bytes stay
uncredited. At most 1023 consumed bytes per queued stream remain held this way.
Allocate this pool only when streaming is enabled; measure both enabled and
disabled layouts on Linux, macOS, and Windows.

The pool is independent of max_h2_body_size/body_stride, which retains its
positive buffered request/response role. Streaming bypasses complete-body
ceilings after admission and never requires a 1024-byte or 65,535-byte stride.
Validate the enabled pool at startup. A low-level session with missing/undersized
storage returns BodyIngressUnavailable/503 before begin rather than accepting
and later overflowing on its first legal DATA frame.

Keep checked pending connection/stream WINDOW_UPDATE counters. Validate before
output and update actual receive windows only after the whole frame is accepted.
WouldBlock preserves the intent without granting credit. Reset reclaims queued
storage, restores connection credit once, and drops obsolete stream intents.

Control frames and outbound responses continue during a pause. Exhausting the
shared connection receive window can block all inbound DATA; unconditional
sibling upload progress is not promised. This follows
[RFC 9113 flow control](https://www.rfc-editor.org/rfc/rfc9113.html#section-5.2.2).

## HTTP/3 and informational headers

Move buffered body-cap policy after routing while retaining structural header
validation. Reuse a bounded ingress window and pause only that stream with
wantread(0). Trailer decoding must not overwrite initial overflow-header arrays.
max_h3_body_size supplies this reusable window; one byte suffices, independently
of the logical route limit. Normal configured engines already require positive
capacity. A malformed low-level zero-window streaming fixture refuses before
begin with BodyIngressUnavailable/503; preserve the buffered zero-window probe.

Pinned lsquic supports successive IETF header blocks after the previous block
is sent; a pending block can refuse another. Implement private bounded interim
paths: HTTP/1's literal, HTTP/2 status-100 HEADERS without END_STREAM, and HTTP/3
status 100 without write shutdown and with retry state. Do not consume final
pending metadata or mark final headers sent. Admit before 100 Continue; do not
wait for content to decide whether to send it. Source inspection is provisional
until real-client validation, following
[RFC 9110 Expect](https://www.rfc-editor.org/rfc/rfc9110.html#section-10.1.1).

## Implementation and acceptance

Implement serial slices: common types/storage/router admission, HTTP/1/TLS,
HTTP/2, HTTP/3, the transport matrix, then incremental multipart. Keep the body
decoder and lifecycle/progress invariants common; adapters own I/O and storage.
Do not introduce a generic continuation framework.

Prove 100,000,000 logical bytes on every claimed transport using bounded input
and exact byte/hash checks. Cover split framing, chunk CRLF/extensions, trailers,
100 Continue, metadata retention, limits/admission, pause/resume at EOF, errors,
resets/shutdown, callback cancellation, stale tokens, and no library allocation
after startup. Preserve existing buffered suites. Record exact source, capacities,
commands, raw results, sanitizer/target/package gates, h1spec/HTTP2 regressions,
real HTTP/3 clients, fuzzing, and independent review.

Multipart follows the stable sink: a pure event parser with the plan's boundary
and metadata bounds, boundary.len + 4 carry, and an optional explicit-Io file
adapter. Retain the full-body API; verify every boundary split, 100 MB input,
backpressure/errors, fuzzing, and a deterministic same-input comparison.

## Design review

Fresh-context review found two actionable omissions: control calls could release
sink state synchronously without an explicit caller lifetime rule, and physical
ingress/framing limits were deferred. The concrete operations/errors, inline
terminal semantics, capacity formulas, limits, and refusal outcomes above resolve
both. Bounded re-review found no remaining actionable contract issue. The root
integrator accepts the design; runtime and client evidence remain implementation
requirements, including the provisional HTTP/3 informational-header path.
