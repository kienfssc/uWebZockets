# M2 common-contract verification

The [checkpoint report](../../m2_common_contract.md) records new typed metadata
and body-control primitives with unchanged buffered Request/OwnedRequest.
The archive contains exact integrated source/patch, frozen draft artifacts,
compiler consumers/layout probes, final canary correction, full combined gate
logs/commands/statuses and root review record. Its portable SHA256SUMS inventory
covers every other regular member; the manifest binds actual source files.

Final native and sanitizer suites each pass 781/781; production/examples build,
ReleaseSafe, Windows GNU, macOS arm64, actual package consumer and clean manifest
package gates pass. All eight source hashes match before and after the run.
The index includes new files before the clean package archive; source remains
frozen. The run uses a dirty cdd7ff7 base plus exact archived source hashes,
not a claim that tests ran on a later clean commit.

Independent source/evidence review found no actionable findings. Canonical
formatting exposed an illegal test-hook declaration; a meaningful untagged-union
parser canary replaced it. The negative parser probe intentionally fails, while
all eight helper tests pass; naming gates are unchanged. Historical setup/naming
diagnostics remain labeled, including original quoted-alias source and inventory.

These results establish common types and lifecycle only. Admission, framing,
real upload transports, global allocation and performance evidence remain open.
Foreign compilation/layout measurements do not establish native foreign runtime.
