# M2: HTTP/2 output client credit and work limits

The bounded observer now tracks request-send refunds separately from response
receive credit. It checks complete raw WINDOW_UPDATE frames against known debt,
matches the pinned codec's ordered events, and preserves late refunds after a
stream closes or its response record retires. Explicit output stages enforce
derived byte, frame and response-count limits.

The [source and evidence](evidence/m2_h2_output_client_core/README.md) contain
11 reviewed client files, pinned codecs, exact inputs, test results and review
history. Recorded pure suites pass 10 client-core, nine receive-credit and
13 observer tests. Two selected client-core tests pass under Python optimization;
Root independently ran the frozen 10-test suite and checked all 65 recorded
source, codec and interpreter inputs. All 10 Python modules parse and import
without output.

Independent review found that an incoming reset must close both directions
before subsequent refunds are classified. The fix preserves debt and correctly
accepts codec-suppressed events after closure. Its actual codec regression covers
refunds in the same read and after retirement. A separate test exercises the
strict stage through the real observer with both ledgers and source-shaped
SETTINGS bytes. These are protocol-byte checks without sockets or a native server.

This completes the client component's preparation. Actual driver action pairing,
fixture and runner integration, native validation of the five output cases, and
the combined 40-case matrix remain required. The 65-byte request-flow cap and
stage budgets apply to the five output cases; the combined matrix still needs
its own derived limits. M2 remains open with 35 native H2 case IDs proved.
Full quality/platform gates and production adoption remain open.
