# Reviewed HTTP/2 reset-writer correction

The [archive](h2-reset-writer-correction.tar.gz) preserves two source replacements
over the [v5 checkpoint](../m2_h2_refusal/README.md), exact preimages, behavioral
red/green, raw verification and independent review. Its SCOPE.md describes
reconstruction; the earlier archives remain unchanged.

SHA256: `c0516e3f4050ec0fde472c2a058202ba2c8b659c6626303b7b0bfbd0fb53b04b`
(95,532 bytes). The [manifest](manifest.json) records 64 safe regular members,
63 inventory entries and omitted derived binaries by hash/size. Retained bytes
passed environment-credential and GitHub-token pattern checks.

Final response HEADERS can succeed before reset emission clears the stream and
then fails. Checking only the cleared response flag let the old catch retry
and hide `OutputTooSmall`. Recovery now requires the original stream to remain
active in the same slot with an unstarted response; other errors propagate.
The actual bounded memory-writer regression fails against v5 and passes after
the correction, checking exactly one reset-write attempt.

Independent re-review resolves P2 with no new actionable findings. Focused
suites pass 15/15 and unchanged HTTP/2 suites pass 69/69 in both modes. Native
and Linux32 executables run seven wire cases each. The initial Linux32 sandbox
SIGSYS is retained separately; normal-OS execution passes on the identical
binary. Formatting, conventions and version checks pass without weakening.

This remains an isolated component. Its synthetic memory writer is not a native
kernel-error probe. No v6 live-client check, combined production integration or
full upload gate ran. No public interface, layout or persistent state changed.
