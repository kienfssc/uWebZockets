# Immutable first-slice verification

Source: `fa7449e80334cef360cb32ec61e051d255c37249`, in a separate clean managed
worktree. Library compiler: Zig 0.16.0. Lock-file SHA-256:
`94223deed9f5d74b7bd5e630a4491e9dc2ccb9ffcdfaceedff0afbf822149431`.

The frozen-lock Nix shell was built successfully and its compiler-version
guard passed. The [sanitizer gate](sanitizer.log) exits 0 with 663/663 tests and
22/22 successful steps. ASan/UBSan/leak settings remain unchanged; the command
is recorded in [sanitizer.command.txt](sanitizer.command.txt). This source
predates the transport matrix, negotiation helper, and 100 KiB socket tests.

The [native ReleaseSafe default build](build.log) exits 0 with 47/47 steps,
including h1spec and http3_server. Its command was:

```sh
ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache \
  /tmp/zig-x86_64-linux-0.16.0/zig build -Doptimize=ReleaseSafe -j2 \
  --cache-dir /tmp/uwz-frozen-m1a-cache --summary all
```

The maintained h1spec fork at
`999ba9e8f318b1c0ebbff1278b98bc5833f1af18`, driven by Deno 2.9.4, passes 33/33
tests with exit 0 against that ReleaseSafe server on localhost:8000. The
runner used the exact CI command from the pinned submodule:

```sh
deno run --allow-net=127.0.0.1:8000 http_test.ts 127.0.0.1 8000
```

[The compressed raw runner output](h1spec_runner.log.gz) preserves upstream
formatting verbatim; [server output](h1spec_server.log) and
[Deno version](deno_version.txt) are retained separately. Runner output SHA-256
after decompression:
`5685c7b29746af937b05b9869b04700c66730e5cc4943741c744331cc225fc90`.
Compressed-file SHA-256:
`e962c13a1916b40d3ea3142eee8803dafaa1f83a85c0302aec0ee61455c72130`.
The runner owned its server PID and terminated/joined it on exit.

ReleaseSafe test compilation and Windows compilation remain live, sequential
steps in the same Nix-shell job. HTTP/3 cross-implementation, current-source
sanitizer/target checks, and the later milestone gates remain open.
