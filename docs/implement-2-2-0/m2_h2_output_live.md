# M2: HTTP/2 native output proof

All five remaining output cases passed one ordinary Debug run against the
unchanged streaming candidate. One owned fixture served five fresh TLS1.3/h2
connections, 70 responses and 50,356,549 primary-response bytes. Independent
evidence review approved the recorded attempt.

| Case | Observed result |
| --- | --- |
| Held window | 16,777,313 bytes; exact zero/8,192-byte barriers and final hash; 10 pending returns |
| Ready output | 16,777,313 bytes and exact hash; zero pending returns |
| Producer reuse | 16,777,313 bytes; binding index 0 reused at generation 3→4; zero metadata errors |
| File | 24,593 bytes from offset 37; exact hash and Content-Length; one transport close |
| Early final | 17 bytes through grants of 8 and 9; no 100; END before NO_ERROR reset |

The three producers each completed 2,049 successful writes and one terminal.
File observations remained unchanged through App deinitialization, including
the single close. Four reads occurred in this run; read counts and pending counts
are observations. The final 32 body records and metrics matched the post-deinit
log: seven body middleware visits, six begins/ends, 192 accepted bytes, zero
cancels/failures/errors and 63 buffered middleware visits.

The [evidence archive](evidence/m2_h2_output_live/README.md) contains the original
result, server log, exact authorization/command completion, runtime manifest,
public certificate and independent audits. Root independently recomputed pattern
hashes, checked recorded headers and prefixes, compared live/post-deinit records
and outputs, and rehashed all 2,413 inputs and ten source/tool trees. The child
and owned listener were absent after exit zero and reaping; the private key and
transfer file were removed. No forced cleanup or retry occurred.

TLS identity and raw END/reset ordering were checked by successful execution
through the unchanged authenticated client and observer. The terminal booleans
alone are not a separate reconstruction of those checks.

This adds five proved case IDs to the previous 35, giving 40 IDs across
checkpoints. An actual combined 40-case run remains required. ReleaseSafe was
compiled but was not executed in this attempt. Exact-current returned-error
runtime evidence, full quality/platform/fuzz/package gates and adoption remain
open; M2 is not complete.
