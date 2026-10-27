# Integrated timer overflow correction

The [archive](timer-overflow-integrated.tar.gz) preserves the exact root source
delta, baseline/final files, central behavioral red/green, independent review
and raw root checks. SHA256:
`3e2cc0fb58e160bc287cdd40a62421ca85d6595ac37913162f8b9403187b714e`
(59,801 bytes). The [manifest](manifest.json) binds 51 safe regular members
and 50 inventory entries. All retained bytes passed credential-value and
GitHub-token pattern checks.

`Wheel.next_event` now scans every overflow entry for the earliest migration
boundary. Advancing directly to an earlier deadline no longer misses that timer
when a later entry heads the list. Storage, callbacks, counts, allocation and
I/O are unchanged; the decision costs linear time in overflow entries.

The new regression lives in the central suite. It fails against the actual
root baseline, then passes 1/1 in Debug and ReleaseSafe; the six existing pure
wheel cases also pass in both modes. Independent re-review resolves test
placement and historical red-source attribution findings with no new findings.
The [original archive](../m6_timer_audit/README.md) remains byte-identical; the
followup distinguishes its passing first-probe hash from the actual failing
single-leap source and raw record.

Whole-root formatting, conventions, version, documentation, dependency and
whitespace checks pass. Native and sanitizer suites each pass 852/852;
ReleaseSafe compilation passes 20/20 steps and default build 47/47. All 263
recorded source identities remain stable. The unchanged Nix-rendered sanitizer
environment and provenance are retained. All four dependency views remain at
their existing pins; no local libxev override was used.

No new native clock, fault, cancellation, race or leak experiment ran. The new
test uses scalar deadlines and caller-owned memory. This establishes no measured
wall-clock or performance improvement, response-token semantic change, or full
C6 acceptance.
