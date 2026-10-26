import ast
import ctypes
import gzip
import hashlib
import importlib.util
import io
import json
import tempfile
from contextlib import ExitStack
from pathlib import Path

from aioquic.h3.events import DataReceived, HeadersReceived

path = Path('/tmp/uwz-m1-static-interop/tests/static_interop/probe.py')
print('Staged probe SHA-256:', hashlib.sha256(path.read_bytes()).hexdigest())
spec = importlib.util.spec_from_file_location('static_probe', path)
probe = importlib.util.module_from_spec(spec)
spec.loader.exec_module(probe)
assert not any(isinstance(node, ast.ClassDef) for node in ast.walk(ast.parse(path.read_text())))
print('Staged harness: zero custom classes')


def rejected(action, name):
    try:
        action()
    except RuntimeError:
        print(name + ': rejected')
        return
    raise AssertionError(name + ' was accepted')


with tempfile.TemporaryDirectory(prefix='uwz-static-offline-') as temporary, ExitStack() as files:
    directory = Path(temporary)
    trace = io.StringIO()
    state = {'requests': {}, 'trace': trace}

    def response(label, content=b'hello'):
        source = directory / (label + '.source')
        source.write_bytes(content)
        body = directory / (label + '.body')
        result = probe.ResponseState(source=files.enter_context(source.open('rb')), output=files.enter_context(body.open('wb')), body_path=body, headers=[], bytes=0, max_event_bytes=0, done=False, proof={})
        state['requests'][0] = result
        return result

    success = response('success', b'x' * 65537)
    probe.h3_consume(state, HeadersReceived(headers=[(b':status', b'200'), (b'content-length', b'65537')], stream_id=0, stream_ended=False))
    probe.h3_consume(state, DataReceived(data=b'x' * 65537, stream_id=0, stream_ended=True))
    assert success['proof']['bytes'] == 65537
    assert success['proof']['max_event_bytes'] == 65537
    assert success['done']
    assert probe.CHUNK_SIZE == 8192
    print('Actual staged consume: legal 65537-byte event accepted via 8192-byte slices; exact END_STREAM')
    response('corrupt')
    rejected(lambda: probe.h3_consume(state, DataReceived(data=b'wrong', stream_id=0, stream_ended=False)), 'Aioquic corrupt data')
    response('premature')
    rejected(lambda: probe.h3_consume(state, DataReceived(data=b'he', stream_id=0, stream_ended=True)), 'Aioquic premature END_STREAM')
    duplicate = response('duplicate')
    duplicate['headers'] = [(b':status', b'200'), (b'content-length', b'5'), (b'content-length', b'5')]
    rejected(lambda: probe.h3_consume(state, DataReceived(data=b'hello', stream_id=0, stream_ended=True)), 'Aioquic duplicate Content-Length')
    records = [json.loads(line) for line in trace.getvalue().splitlines()]
    assert records[0]['event'] == 'headers' and records[1]['data_bytes'] == 65537
    print('Application event trace: valid JSONL, labeled separately from transport qlog')
    manifest = probe.fixtures(directory / 'files')
    proof = probe.compare_files(directory / 'files/large.bin', directory / 'files/large.bin')
    assert proof['bytes'] == 104857600
    assert proof['sha256'] == manifest['files']['large.bin']['sha256']
    print('Sparse fixture:', json.dumps({'logical_bytes': manifest['large_size'], 'allocated_bytes': manifest['large_allocated_file_bytes'], 'sha256': proof['sha256']}))
    assert gzip.decompress((directory / 'files/asset.txt.gz').read_bytes()) == probe.SMALL_BODY
    print('Gzip fixture: exact 1376-byte decoded body')
    decoder = ctypes.CDLL('/nix/store/1wb1ajhk6aqf0chbfpm3qadwhn187dn0-brotli-1.1.0-lib/lib/libbrotlidec.so.1.1.0')
    decoder.BrotliDecoderDecompress.argtypes = [ctypes.c_size_t, ctypes.c_void_p, ctypes.POINTER(ctypes.c_size_t), ctypes.c_void_p]
    decoder.BrotliDecoderDecompress.restype = ctypes.c_int
    output = ctypes.create_string_buffer(4096)
    length = ctypes.c_size_t(len(output))
    assert decoder.BrotliDecoderDecompress(len(probe.SMALL_BR), probe.SMALL_BR, ctypes.byref(length), output) == 1
    assert output.raw[:length.value] == probe.SMALL_BODY
    print('Brotli fixture: exact 47 encoded -> 1376 decoded bytes')
    corrupt = directory / 'corrupt.body'
    corrupt.write_bytes(b'corrupt')
    rejected(lambda: probe.compare_files(corrupt, directory / 'files/asset.txt'), 'File comparison corrupt body')
    truncated = directory / 'truncated.body'
    truncated.write_bytes(probe.SMALL_BODY[:-1])
    rejected(lambda: probe.compare_files(truncated, directory / 'files/asset.txt'), 'File comparison truncated body')
    archive = probe.archive_body(directory / 'files/large.bin')
    assert archive['uncompressed']['bytes'] == 104857600
    print('Archived large body:', json.dumps(archive))
