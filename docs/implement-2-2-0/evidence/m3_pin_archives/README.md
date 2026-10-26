# Current dependency-pin recovery archives

Prepared 2026-10-26 for M3/C13. This preserves the current pins; it is not a
final-release, second-machine, runtime, or WebTransport-completion claim.
No repository source, pin, cache, upstream, or remote ref was changed.

The [archive](current_pins.tar.gz) contains five complete reachable-history Git
bundles, captured source policy/manifests, exact commands and terminal statuses,
public ref/API observations, license texts, verification logs, and reconstruction
scripts. The [manifest](manifest.json) binds every pin, tree, bundle, license,
source context, and artifact hash. Original source context was captured from
uWebZockets commit `40931267a61cde32c7d3b4ad2e5ce98098ee7102`.

| Source | Current pin | Reachable commits | Bundle bytes |
| --- | --- | ---: | ---: |
| libxev | `c49f6dfb83038c146232472c063e4b2681d098d8` | 601 | 1438084 |
| lsquic | `85bd081c9103c077a7cc98271d09334d0f1043d4` | 630 | 9365023 |
| h1spec | `999ba9e8f318b1c0ebbff1278b98bc5833f1af18` | 22 | 591254 |
| lshpack | `fda48e02491d865cce00612be8cc10c2622b8e55` | 113 | 2515653 |
| lsqpack | `91567706c41c0d97ab8dc576873ecd472d7869fa` | 523 | 1315018 |

## Verification

Each exact pin was fetched read-only without a depth limit into a new bare
repository under /tmp. Each source reports `--is-shallow-repository=false`.
Every bundle verifies in an initially empty repository, so it has no external
commit prerequisite. A local bundle fetch restores the identical commit, tree,
and reachable commit count; `git fsck --full --strict` succeeds before and after
restoration. Current maintained integration refs resolve to the recorded pins.

The working-tree reconstruction additionally checks out all five root sources,
initializes both lsquic submodules from local bundles, verifies the exact child
commits, and asserts clean tracked files. Git's empty-repository warnings from
submodule cloning are retained: the bundles advertise archive refs rather than a
default branch, and the subsequent explicit full-commit fetch/checkouts succeed.
No network URL is used during reconstruction. This remains one physical host.
No native compiler, test, sanitizer, or protocol gate was run by this slice.

## Reproduce from the retained artifact

Use a new directory and the supplied outer SHA-256, then inspect the manifest:

```sh
sha256sum current_pins.tar.gz
mkdir unpacked
cd unpacked
tar -xzf ../current_pins.tar.gz
sha256sum -c SHA256SUMS
python3 restore_sources.py /tmp/uwz-current-pins-restored-UNIQUE
```

`restore_sources.py` accepts a destination that does not exist. It uses Git and
Python only as recovery tooling, never as a library build requirement. All fetch
arguments during reconstruction point at the adjacent local bundles. The
retained `verification.log`, `source_reconstruction.log`, and `raw/*.json`
show the executed commands and individual exits. Fetches and public API queries
have UTC timestamps. `git_version`, `curl_version`, and `python_version` records
identify the actual tools. Bundle SHA-256 values identify retained bytes; Git
commit/tree IDs identify source regardless of a future bundle's pack encoding.

## Exact child and license boundaries

The lsquic pin records QPACK `91567706c41c0d97ab8dc576873ecd472d7869fa`,
matching the root build. It records HPACK
`cf0f70dd10b352194c97448eb5d00b4aa484f531`, while the root builds
`fda48e02491d865cce00612be8cc10c2622b8e55`. Both HPACK commits are retained in
the HPACK bundle. The reconstruction preserves this difference; it does not
apply the unpublished LSQ-003 candidate. Neither codec tree has nested gitlinks,
and the two HPACK revisions have identical retained LICENSE text.

MIT texts are preserved from libxev, lsquic, ls-hpack, and ls-qpack; lsquic's
additional Chrome component license is preserved separately. The pinned h1spec
tree and its exact upstream ancestor have six files, no license file, and no
matching license/copyright/grant statement. The 22-commit reachable history has
no matching license-text changes. GitHub's pinned-ref license endpoints each
return HTTP 404; upstream repository metadata returns HTTP 200 with license:null.
These are source/API facts, not a legal conclusion. Captured root notices say
MIT, but this archive does not substantiate that attribution. Proposed correction:
"License unverified: the pinned h1spec source contains no license notice;
maintainer confirmation required." No license grant is invented.

## Open requirements and restoration

The live lsquic mirror `413ca7c1acb443b0f9f7aa28611ca723c6738844` differs from
upstream `02b10a9e620bc235e40baa8dd0b2d9f32ff96cab`; the other two captured
mirrors match upstream. This is a point-in-time read, not a branch-protection
or security-sync acceptance. Existing write-access/publication blockers,
reviewed HPACK alignment, and WebTransport work remain open. Current-pin
archives must be refreshed when final reviewed pins change.

Before accepting the v2.2.0 release merge/tag, the build/vendor maintainer must
complete authorized reviewed mirror/pin publication, prove protection and exact
mirror equality, refresh archives, and preserve final gates. The repository
maintainer must substantiate h1spec permission/license attribution or resolve its
notice/inclusion. Verification must resolve the pins and retained archives from
an independent machine and run the required native runtime/platform/compliance
jobs. A second local checkout does not satisfy that requirement. These dated
criteria do not mark M3 or C13 complete.

The archive contains published source history and public metadata. No local
credentials, authentication headers, private-key files, or environment dumps were
collected. This is not an exhaustive secret scan of historical third-party blobs.

Archive SHA-256: `d7fad900595499141777bb3f6fcdd8999f1a8e8917a1704432a1afc329a7a6c5`.
