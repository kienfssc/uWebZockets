# Maintained-libxev review candidate

The [review archive](libxev-maintainer-review.tar.gz) preserves three local append
commits based on authoritative pin
`c49f6dfb83038c146232472c063e4b2681d098d8`:

1. `1b6c8ee4521e8073c066ef1265730d54a9b70a98`: deterministic error peers before
   UDP sockaddr decoding.
2. `c546997cfb1bb30babdd467aaf86a2437d9d57da`: correct the new kqueue test's
   callback expectation; retain the original mistaken contract as history.
3. `7b7b1f14518d9504b15590d123ec494b8fadb2e3`: the bounded private dead-target
   epoll cancellation decision, including completed-timer compatibility.

The final tree is `0ae835a79eaea49f8ff086e64d777152c454b928`. The complete-history
bundle inside the archive verifies and preserves every candidate and parent.
This is a review artifact. No candidate was published to the maintained
integration branch or adopted by the normal build; all four root dependency
views retain their existing pin.

Archive SHA256:
`5c4d533191b3f635548718f736b0e8e8a950515ecd57da2613ad00ea0c8e8d22` (42650211 bytes).
Root independently verified all 289 safe regular members and 287 inventory
entries against the [package manifest](package-manifest.json), plus the archive
hash/size. The [validation record](root-validation.json) records a credential
scan with no matching environment values or GitHub token patterns. Packed
third-party history was not exhaustively decoded for a secret scan.

The artifact includes exact sources, contracts and bounded reviews, the original
ordinary application startup/shutdown exit 134, and a self-contained companion
for the peer-fix reruns: 2/2 UDP cases on asserted epoll and io_uring, plus 14/14
focused application cases. The old failure was not rerun. Final healthy fork
suites pass 149 tests with four existing skips in Debug and ReleaseSafe; the
pure-helper filter passes two named tests plus existing discovery tests, 28/28.
Four callback/layout consumers and three foreign UDP test compilations pass.

No targeted native cancellation, race, crash or leak experiment was run. The
source-level dead-target argument is narrower than generic cancellation. Active
registered duplicate cleanup, adding/deleting/thread-pool cancellation, foreign
native execution, foreign IPv6 peer capacity and H1 physical-close proof remain
separate. Root M2 transport integration must not infer those results from this
package. Maintainer protection/ancestry confirmation and reviewed publication
are required before any pin update.
