#!/bin/sh
set -u
expected_commit=$1
evidence=/tmp/uwz-m1c-verification
mkdir -p "$evidence"
git rev-parse HEAD > "$evidence/source_commit.txt"
test "$(cat "$evidence/source_commit.txt")" = "$expected_commit" || exit 2
git diff --exit-code > "$evidence/source_diff.txt" || exit 2
zig version > "$evidence/zig_version.txt" || exit 2
test "$(cat "$evidence/zig_version.txt")" = 0.16.0 || exit 2
sha256sum flake.lock > "$evidence/flake_lock.sha256"
export ZIG_GLOBAL_CACHE_DIR=/tmp/uwz-zig-cache
status=0
run_gate() {
    gate_name=$1
    shift
    printf '%s\n' "$*" > "$evidence/$gate_name.command.txt"
    "$@" > "$evidence/$gate_name.log" 2>&1
    gate_status=$?
    printf '%s\n' "$gate_status" > "$evidence/$gate_name.exit.txt"
    printf '%s exit %s\n' "$gate_name" "$gate_status"
    if [ "$gate_status" -ne 0 ]; then status=1; fi
}
run_gate sanitizer zig build test -Dsanitize=true -Doptimize=ReleaseSafe -j2 --cache-dir /tmp/uwz-frozen-m1a-cache --summary all
run_gate release_safe zig build test-compile -Doptimize=ReleaseSafe -j2 --cache-dir /tmp/uwz-frozen-m1a-cache --summary all
run_gate windows zig build test-compile -Dtarget=x86_64-windows-gnu -Doptimize=ReleaseSafe -j2 --cache-dir /tmp/uwz-frozen-m1a-cache --summary all
run_gate macos_arm64 zig build test-compile -Dtarget=aarch64-macos -Doptimize=ReleaseSafe -j2 --cache-dir /tmp/uwz-frozen-m1a-cache --summary all
printf '%s\n' "$status" > "$evidence/matrix.exit.txt"
exit "$status"
