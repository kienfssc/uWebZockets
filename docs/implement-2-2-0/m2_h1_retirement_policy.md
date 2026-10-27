# M2: pure H1 retirement and close policy

Status: isolated Stage A policy verified and independently reviewed,
2026-10-27. Native callback wiring and actual close remain open.

The [checkpoint](evidence/m2_h1_retirement_policy/README.md) adds pure transitions
over existing retirement phases. An idle request starts the first boundary;
pending requests coalesce. Expiry requests a fresh second boundary, then writes
idle before returning tail eligibility. Idle expiry returns RetirementInactive
without mutation. A late request after idle creates a new obligation.

The one-shot close claim takes six explicit connection facts without defaults.
It checks initialized storage, failure fence, close intent, native target/ACK
flags and every existing owner gate. Invalid inputs leave state unchanged.
A valid close intent discards queued resume work while ownership pins defer
the claim; it consumes close intent only after all gates pass. It never clears
ownership flags, releases admission or performs native I/O. The existing drain
predicate shares the canonical owner checks and retains its semantics.

Eleven new tests first fail on the missing API, then pass against the actual
implementation. These are declaration reds, not a fabricated native failure.
Focused tests pass 11/11, whole App tests 31/31 and admission tests 7/7 in Debug
and ReleaseSafe. Centralized Linux/macOS/Windows graphs compile without linking
or execution. Formatting, conventions, version and isolated AST update pass.

Actual compiler proofs retain all 25 stored fields, sizes, alignments and
offsets on every target. The owner struct, reset/deinit tail and prior 20 App
tests are byte-identical to the predecessor. This slice adds no stored state
or slab growth; its close snapshot remains a caller-owned value.

Independent review finds no actionable findings. Retirement completion-state
checks are preserved and source-reviewed; inert fixtures do not synthesize
active completions. The final ReleaseSafe App execution arrived after review
and Root separately verified its 31/31 result and stable source/input/binary
bindings. The archive records that timing explicitly.

Caller-supplied facts establish policy rather than native quiescence. The next
implementation must wire real target/ACK/timer tails, preserve two fresh timer
stages, integrate terminal/admission cleanup, and make physical close/release
the final safe action. Unexpected RetirementInactive also needs truthful typed
failure-fence handling. Real delivery, TLS and all full integration gates remain
required. Root production source, pins and maintained refs remain unchanged.
