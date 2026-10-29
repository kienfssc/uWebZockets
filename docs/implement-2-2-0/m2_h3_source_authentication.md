# M2: HTTP/3 source authentication

The cached `lsquic_qdec_hdl.c` exactly matches maintained lsquic pin
`85bd081c9103c077a7cc98271d09334d0f1043d4`. This closes a source-provenance gap
in the request-streaming implementation plan. HTTP/3 request streaming remains
unimplemented; this checkpoint establishes source identity only.

On 2026-10-29, Root verified the retained
[current-pin archive](evidence/m3_pin_archives/README.md), extracted only its
lsquic bundle and restored its advertised `refs/archive/current-pin` into a
fresh private bare repository under `/tmp`. Bundle verification, offline fetch
and `git fsck --full --strict` all exited zero. Git hooks were disabled and the
subprocess environment allowed only the file transport.

The pinned file has Git blob `c7046698107512a926542dcf46f5a8144b1010c7`,
31,642 bytes and SHA-256
`093dbe960188830e121518bf1f932c8cb7e570214d9dc4adcd699ef1b688940b`.
Its bytes equal the cached file read before and after restoration. The
[evidence package](evidence/m2_h3_source_authentication/README.md) retains the
actual tool, commands, environment, results and extracted source.

Review found that Python optimization could disable the original tool's proof
assertions. The corrected tool uses explicit failures. Five optimized regression
tests reproduce the original gap and pass after the fix; the current source
authentication also passes under CPython 3.14.2 with optimization level 1. The
package retains the original version and raw failing results as history.

No native executable, server, client or test ran. Existing source, dependency
pins and repository refs were unchanged. This does not establish native
Content-Length enforcement, bounded uploads, typed stream errors, second-machine
resolution or any complete milestone gate. The next implementation work remains
the HTTP/3 body adapter, admission and lifecycle composition, followed by actual
declared and undeclared 100000000-byte uploads and the complete M2 matrix.
