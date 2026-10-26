from pathlib import Path
import ast, ctypes, gzip, hashlib, re
source=Path('/workspaces/uWebZockets/src/tests/static_sidecar_tests.zig').read_text()
def literal(name):
    value=re.search(r'const '+name+r' = ("[^\n]*");', source).group(1)
    return ast.literal_eval(value).encode('latin1')
identity=literal('identity'); encoded_gzip=literal('gzip'); encoded_br=literal('brotli')
assert gzip.decompress(encoded_gzip)==identity
large_gzip=encoded_gzip[:3]+b'\x04'+encoded_gzip[4:10]+b'\x40\x00UW\x3c\x00'+b'0'*60+encoded_gzip[10:]
assert gzip.decompress(large_gzip)==identity
lib=ctypes.CDLL('libbrotlidec.so.1')
decode=lib.BrotliDecoderDecompress
decode.argtypes=[ctypes.c_size_t,ctypes.c_void_p,ctypes.POINTER(ctypes.c_size_t),ctypes.c_void_p]
output=ctypes.create_string_buffer(256); size=ctypes.c_size_t(256)
assert decode(len(encoded_br),encoded_br,ctypes.byref(size),output)==1
assert output.raw[:size.value]==identity
print('Development-only fixture validation; no new build/runtime dependency.')
print('decoded bytes',len(identity),'sha256',hashlib.sha256(identity).hexdigest())
for name,data in [('gzip',encoded_gzip),('br',encoded_br),('gzip_extra',large_gzip)]:
    print(name,'encoded bytes',len(data),'sha256',hashlib.sha256(data).hexdigest())
print('All three valid encoded fixtures decode to the identity fixture.')
