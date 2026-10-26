#!/bin/sh
set -u
worktree=/home/codespace/.codex/worktrees/05f7/uWebZockets
evidence=/tmp/uwz-m1-file-protocols
mkdir -p "$evidence/http3"
test "$(cat "$evidence/build.exit.txt")" = 0 || exit 2
test "$(git -C "$worktree" rev-parse HEAD)" = ee4bf1c9180533cd429c75ed427d8766f467e17d || exit 2
git -C "$worktree" diff --exit-code > "$evidence/http3_source_diff.txt" || exit 2
date -u +%Y-%m-%dT%H:%M:%SZ > "$evidence/http3_start.txt"
sha256sum "$worktree/zig-out/bin/http3_server" "$worktree/scripts/http3_compliance/run.sh" "$worktree/scripts/http3_compliance/expectations.json" > "$evidence/http3_inputs.sha256"
export HTTP3_ARTIFACT_DIR="$evidence/http3"
export HTTP3_SERVER_BIN="$worktree/zig-out/bin/http3_server"
/home/codespace/.nix-profile/bin/nix --extra-experimental-features 'nix-command flakes' develop --no-update-lock-file . -c /home/codespace/.nix-profile/bin/nix --extra-experimental-features 'nix-command flakes' develop --no-update-lock-file path:./scripts/http3_compliance -c bash scripts/http3_compliance/run.sh > "$evidence/http3_shell.log" 2>&1
result=$?
printf '%s\n' "$result" > "$evidence/http3.exit.txt"
date -u +%Y-%m-%dT%H:%M:%SZ > "$evidence/http3_finish.txt"
exit "$result"
