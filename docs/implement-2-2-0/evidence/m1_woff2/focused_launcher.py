from pathlib import Path
import shlex,subprocess
args=shlex.split(Path('/tmp/uwz-m1f-sidecar-focused.command.txt').read_text())
args=[x.replace('src/tests/static_sidecar_tests.zig','src/tests/framework_tests.zig') for x in args]
args[args.index('--test-filter')+1]='framework: static files parse ranges and map MIME types'
Path('/tmp/uwz-m1-woff2-focused.command.txt').write_text(shlex.join(args)+'\n')
raise SystemExit(subprocess.call(args,cwd='/workspaces/uWebZockets'))
