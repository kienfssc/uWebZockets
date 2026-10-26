#!/bin/bash
set -u
evidence=/tmp/uwz-m1c-h1spec
worktree=/home/codespace/.codex/worktrees/05f7/uWebZockets
suite=/workspaces/uWebZockets/vendor/h1spec
mkdir -p "$evidence"
result=2
server_pid=
finish() {
    trap - EXIT
    if [[ -n "$server_pid" ]]; then
        # The harness owns this exact process; its main has no signal handler.
        kill -TERM "$server_pid" 2>/dev/null
        kill_result=$?
        wait "$server_pid"
        server_result=$?
        printf '%s\n' "$server_result" > "$evidence/server.exit.txt"
        printf '%s\n' "$kill_result" > "$evidence/termination_signal.exit.txt"
        if [[ "$result" == 0 && ( "$kill_result" != 0 || "$server_result" != 143 ) ]]; then result=1; fi
    fi
    printf '%s\n' "$result" > "$evidence/gate.exit.txt"
    exit "$result"
}
trap finish EXIT
test "$(cat "$evidence/build.exit.txt")" = 0 || exit 2
git -C "$worktree" rev-parse HEAD > "$evidence/source_commit.txt"
test "$(cat "$evidence/source_commit.txt")" = 9ac0566f1af87f50eebe56be6bd605f1adc671f3 || exit 2
git -C "$worktree" diff --exit-code > "$evidence/source_diff.txt" || exit 2
test -e "$suite/.git" || exit 2
test "$(git -C "$suite" rev-parse --show-toplevel)" = "$suite" || exit 2
git -C "$suite" rev-parse HEAD > "$evidence/h1spec_commit.txt"
test "$(cat "$evidence/h1spec_commit.txt")" = 999ba9e8f318b1c0ebbff1278b98bc5833f1af18 || exit 2
/tmp/uwz-deno-2.9.4/deno --version > "$evidence/deno_version.txt" || exit 2
ss -H -ltn 'sport = :8000' > "$evidence/listener_before.txt" || exit 2
test ! -s "$evidence/listener_before.txt" || exit 2
"$worktree/zig-out/bin/h1spec" > "$evidence/server.log" 2>&1 &
server_pid=$!
printf '%s\n' "$server_pid" > "$evidence/server.pid"
ready=false
for ((attempt=0; attempt<100; attempt++)); do
    kill -0 "$server_pid" 2>/dev/null || exit 2
    ss -H -ltnp 'sport = :8000' > "$evidence/listener_running.txt" || exit 2
    if rg -q -F "pid=$server_pid," "$evidence/listener_running.txt"; then ready=true; break; fi
    sleep 0.1
done
test "$ready" = true || exit 2
cd "$suite" || exit 2
printf '%s\n' '/tmp/uwz-deno-2.9.4/deno run --allow-net=127.0.0.1:8000 http_test.ts 127.0.0.1 8000' > "$evidence/runner.command.txt"
/tmp/uwz-deno-2.9.4/deno run --allow-net=127.0.0.1:8000 http_test.ts 127.0.0.1 8000 > "$evidence/runner.log" 2>&1
result=$?
printf '%s\n' "$result" > "$evidence/runner.exit.txt"
if rg -q 'panic:|reached unreachable|response error:' "$evidence/server.log"; then result=1; fi
exit "$result"
