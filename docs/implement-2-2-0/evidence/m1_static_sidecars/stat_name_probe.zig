const std = @import("std");
test "stdlib stat reports overlong leaf" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    const leaf: [255]u8 = @splat('x');
    const file = try tmp.dir.createFile(std.testing.io, &leaf, .{});
    file.close(std.testing.io);
    var sidecar: [258]u8 = undefined;
    @memcpy(sidecar[0..255], &leaf);
    @memcpy(sidecar[255..], ".gz");
    try std.testing.expectError(error.NameTooLong, tmp.dir.statFile(std.testing.io, &sidecar, .{ .follow_symlinks = false }));
}
