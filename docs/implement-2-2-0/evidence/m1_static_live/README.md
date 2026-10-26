# Saved-revision static correctness evidence

The [archive](live_correctness.tar.gz) retains unchanged raw output from the
successful fc0587a loopback gate and its original outer driver/report/hash
inventory. The [manifest](manifest.json) records the full source identity,
portable archive hash, exact claims, and limits. Extract into a new directory
and run `sha256sum -c SHA256SUMS.portable`; the original absolute-path inventory
is preserved under outer/.

Independent review checks all 738 original inventory entries and independently
streams/decompresses all five 100 MiB body archives, comparing every byte with
the fixed sparse fixture. Four curl protocol matrices and the aioquic
large/sibling/reuse connection pass. Every numeric gate/command/server status
is zero, timeouts/forced kills are false, and the source stays clean.

The public test certificate is retained. Private keys lived outside artifacts
and their temporary runtime directory was removed. Closed-test qlogs retain
ordinary protocol metadata. This establishes correctness for the recorded
configuration, with no throughput, official-profile, global-allocation,
non-Linux-runtime, or release-completion claim.
