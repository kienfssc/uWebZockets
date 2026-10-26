const std = @import("std");

fn regular_leaf(dir: std.Io.Dir, leaf: []const u8) !bool {
    const metadata = try dir.openFile(std.testing.io, leaf, .{ .path_only = true, .follow_symlinks = false, .allow_directory = true });
    defer metadata.close(std.testing.io);
    return (try metadata.stat(std.testing.io)).kind == .file;
}

test "path-only preflight reports overlong leaf as returned error" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    const leaf: [255]u8 = @splat('x');
    const file = try tmp.dir.createFile(std.testing.io, &leaf, .{});
    file.close(std.testing.io);
    var sidecar: [258]u8 = undefined;
    @memcpy(sidecar[0..255], &leaf);
    @memcpy(sidecar[255..], ".gz");
    try std.testing.expectError(error.NameTooLong, regular_leaf(tmp.dir, &sidecar));
}

test "path-only preflight rejects stable FIFO without readable open" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    const rc = std.os.linux.mknodat(tmp.dir.handle, "fifo", std.os.linux.S.IFIFO | 0o600, 0);
    if (std.os.linux.errno(rc) != .SUCCESS) return error.FifoCreationFailed;
    try std.testing.expect(!try regular_leaf(tmp.dir, "fifo"));
}

test "path-only preflight closes before readable regular open and rejects links" {
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    const created = try tmp.dir.createFile(std.testing.io, "regular", .{});
    try created.writePositionalAll(std.testing.io, "bytes", 0);
    created.close(std.testing.io);
    try std.testing.expect(try regular_leaf(tmp.dir, "regular"));
    const readable = try tmp.dir.openFile(std.testing.io, "regular", .{ .follow_symlinks = false });
    defer readable.close(std.testing.io);
    var bytes: [5]u8 = undefined;
    try std.testing.expectEqual(bytes.len, try readable.readPositionalAll(std.testing.io, &bytes, 0));
    try std.testing.expectEqualStrings("bytes", &bytes);
    try tmp.dir.symLink(std.testing.io, "regular", "link", .{});
    try std.testing.expect(!try regular_leaf(tmp.dir, "link"));
}
