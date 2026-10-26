import shlex, subprocess, os
from pathlib import Path
log=Path('/tmp/uwz-m1d-h2-compile-layout-red.log').read_text()
line=next(x[len('failed command: '):] for x in log.splitlines() if x.startswith('failed command: ') and 'zig test ' in x)
args=shlex.split(line)
args=[x.replace('-Mroot=/workspaces/uWebZockets/src/tests/main.zig','-Mroot=/workspaces/uWebZockets/src/tests/static_sidecar_tests.zig') for x in args if x!='--listen=-']
args += ['--test-filter','static sidecars:']
Path('/tmp/uwz-m1f-sidecar-focused.command.txt').write_text(shlex.join(args)+'\n')
raise SystemExit(subprocess.call(args,env={**os.environ,'ZIG_GLOBAL_CACHE_DIR':'/tmp/uwz-zig-cache'}))
