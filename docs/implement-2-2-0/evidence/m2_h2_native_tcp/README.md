# Reviewed native HTTP/2 composition

The [archive](reviewed-native-tcp.tar.gz) contains seven changed source paths,
preimages, inventories, raw command/log/input/binary identities, intermediate
corrections, pin proposal/adversarial review, independent source reviews and the
three-callsite cause fix. All 631 members are safe regular files;
630 publication inventory entries verify.

Archive SHA256:
`dc09271562dfa29551256ed6bf4a28da3ce913e9bbf71cbfde60c266b68131a6`
(1311378 bytes). See the [manifest](manifest.json) and
[component report](../../m2_h2_native_tcp.md).

The [patch](native-tcp.patch), SHA256
`cc698e1d29c6c239eba3dbaeba9d2797623c1e72cddccbf03e866ae156a79124`,
applies to the exact1029-file [admission baseline](../m2_h2_native_admission/README.md)
`9e4ccd66b9b4c888b97d2d8d39c7f25d700e6d3fe0302ddcf257bb789829d116`
and independently reconstructs final1031-file source
`fc69e66f18d404aff19a0b018b81dd35c02ec2a46ed8f38670eb926c794f72de`.
Use `git apply --unidiff-zero --check native-tcp.patch`, followed by
`git apply --unidiff-zero native-tcp.patch`.

Initial8f2 source passes193 selected results per mode across26 compile/run pairs.
Finalfc69 passes79 covering results per mode across8 pairs, with fresh3OS central
semantic/static/AST checks. Old eligible32 compilation and3OS layout measurements
retain8f2 identity; the final exact3-callsite diff changes no storage declarations.
CompileLog exit1 is measurement. Auditing and packaging ran no tests or compilers.

Root binds source/log/binary/input identities, all93 libxev override files and
full reconstruction. Pure helper red compiles0/run1; historical red and green
now reconstruct all1031 files exactly. The original audit's missing-source limit
and the later exact completion record are both retained. Shared caches were valid;
one Root-requested pure-check interruption and its fresh rerun remain explicit.

Both reviewers accept the source-failure fix; no native reset-output fault was
injected. Owned live H2/TLS, physical lifecycle, full native/sanitizer/h1spec,
genuine early data and complete M2 acceptance remain open. Root production source
and maintained pins are unchanged. Stopped native experiments remain stopped.
