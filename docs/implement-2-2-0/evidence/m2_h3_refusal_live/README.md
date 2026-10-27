# Owned HTTP/3 refusal evidence

The [archive](h3-refusal-live.tar.gz) supplements the
[isolated H3 checkpoint](../m2_h3_refusal/README.md) with an executable server,
aioquic client, raw events/output and complete source bindings. The production
H3 source bytes remain unchanged.

SHA256: `22a0f6816b1684cf55f618cd602aeb21f7a5169716451f34b663a22989ac4afc`
(34,275 bytes). Packaging verified 17 safe regular members and 16 inventory
entries. The [manifest](manifest.json) binds every file. A byte scan found no
matching environment credential values or GitHub token patterns.

The run explicitly overrides libxev with reviewed local commit
`7b7b1f14518d9504b15590d123ec494b8fadb2e3`, exported from its immutable tree.
Its complete-history bundle lives in the [M3 review package](../m3_libxev_udp/README.md).
All 89 exported files are hashed; the staged unreviewed duplicate-cleanup
candidate is excluded. This is test-only. All four root dependency views remain
unchanged; no maintained ref or source pin was updated.

Aioquic 1.3.0 sends valid upload headers declaring 100,000,000 bytes with no DATA
or sending-side FIN. It receives STOP_SENDING with H3_NO_ERROR (256), a complete
empty 503, a healthy concurrent 200 sibling and a later healthy 200 on the same
QUIC connection. The io_uring server records zero sink effects or retained
quota and two healthy middleware/handler invocations. Client and server exit
zero; normal server shutdown drains and the owned process is reaped.

The retained trace contains application events rather than transport qlog.
This proves normal refusal, sibling progress and connection reuse, not a
successful 100 MB upload, performance result, full compliance gate or final M2
acceptance. Independent review, maintained dependency adoption and combined
integration remain required. The earlier stopped native experiment stays stopped.
