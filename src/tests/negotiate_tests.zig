const std = @import("std");
const negotiate = @import("test_support").negotiate;

const EncodingCase = struct {
    header: ?[]const u8,
    available: negotiate.EncodingAvailability = .{ .identity = true, .gzip = true, .br = true },
    expected: ?negotiate.Encoding,
};

const QualityCase = struct {
    value: []const u8,
    expected: ?u16,
};

test "negotiate: qvalue permits an empty fractional part" {
    const accept = negotiate.parse("text/plain;q=0., application/json;q=1.");
    try std.testing.expectEqual(@as(usize, 2), accept.count);
    try std.testing.expectEqual(@as(u16, 0), negotiate.score(accept, "text/plain"));
    try std.testing.expectEqual(@as(u16, 1000), negotiate.score(accept, "application/json"));
}

test "negotiate: qvalue limits the fractional part to three digits" {
    const accept = negotiate.parse("text/plain;q=1.0000, application/json;q=1.000");
    try std.testing.expectEqual(@as(usize, 1), accept.count);
    try std.testing.expectEqual(@as(u16, 0), negotiate.score(accept, "text/plain"));
    try std.testing.expectEqual(@as(u16, 1000), negotiate.score(accept, "application/json"));
}

test "negotiate: content coding selection preserves weights and explicit refusals" {
    const cases = [_]EncodingCase{
        .{ .header = null, .expected = .identity },
        .{ .header = "", .expected = .identity },
        .{ .header = " \t, ,", .expected = .identity },
        .{ .header = "gzip", .expected = .gzip },
        .{ .header = "br, gzip", .expected = .br },
        .{ .header = "gzip;q=0", .expected = .identity },
        .{ .header = "*;q=0", .expected = null },
        .{ .header = "*;q=0, gzip;q=1", .expected = .gzip },
        .{ .header = "*;q=1, gzip;q=0", .expected = .br },
        .{ .header = "*;q=0, identity;q=0.7", .expected = .identity },
        .{ .header = "identity;q=0, *;q=0.7", .expected = .br },
        .{ .header = "br;q=0.5, gzip;q=0.8, identity;q=0.1", .expected = .gzip },
        .{ .header = "br;q=0.5, gzip;q=0.8", .expected = .identity },
        .{ .header = "br;q=0, gzip;q=0, identity;q=0", .expected = null },
        .{ .header = " GZIP ; Q=1. , Br;q=0.999, IDENTITY;q=0.1", .expected = .gzip },
        .{ .header = "gzip;q=0.001, identity;q=0", .expected = .gzip },
        .{ .header = "gzip;q=0., identity;q=0", .expected = null },
        .{ .header = "zstd, unknown", .expected = .identity },
    };
    for (cases) |case| {
        try std.testing.expectEqual(case.expected, negotiate.select_encoding(case.header, case.available));
    }
}

test "negotiate: content coding selection only considers available representations" {
    const cases = [_]EncodingCase{
        .{ .header = null, .available = .{ .identity = false, .br = true }, .expected = .br },
        .{ .header = "", .available = .{ .identity = false, .br = true }, .expected = null },
        .{ .header = "br, gzip", .available = .{ .gzip = true }, .expected = .gzip },
        .{ .header = "br;q=1, gzip;q=0.5, identity;q=0.1", .available = .{ .gzip = true }, .expected = .gzip },
        .{ .header = "br, gzip", .available = .{}, .expected = .identity },
        .{ .header = "*", .available = .{ .identity = false }, .expected = null },
        .{ .header = "gzip;q=0, identity;q=0", .available = .{ .gzip = true }, .expected = null },
    };
    for (cases) |case| {
        try std.testing.expectEqual(case.expected, negotiate.select_encoding(case.header, case.available));
    }
}

test "negotiate: duplicate coding refusals cannot be undone" {
    const cases = [_]EncodingCase{
        .{ .header = "gzip;q=0, gzip;q=1", .expected = .identity },
        .{ .header = "gzip;q=1, GZIP;q=0", .expected = .identity },
        .{ .header = "gzip;q=1, gzip;q=0.2, identity;q=0.5", .expected = .identity },
        .{ .header = "*;q=0, *;q=1", .expected = null },
        .{ .header = "identity;q=0, identity;q=1", .expected = null },
    };
    for (cases) |case| {
        try std.testing.expectEqual(case.expected, negotiate.select_encoding(case.header, case.available));
    }
}

test "negotiate: coding refusals beyond media entry capacity are honored" {
    const header = ("unknown, " ** 20) ++ "gzip;q=0, br;q=0, identity;q=0, *;q=1";
    try std.testing.expectEqual(@as(?negotiate.Encoding, null), negotiate.select_encoding(
        header,
        .{ .gzip = true, .br = true },
    ));
}

test "negotiate: malformed known coding weights fail closed" {
    const headers = [_][]const u8{
        "gzip;q=1.0000", "gzip;q=.5", "gzip;q=01",    "gzip;q=1.001",
        "gzip;q=0.1234", "gzip;q=-1", "gzip;q=NaN",   "gzip;q=\"1\"",
        "gzip;q=1;q=1",  "gzip;q",    "gzip;level=1", "gzip;q=1;",
    };
    for (headers) |header| {
        var buffer: [128]u8 = undefined;
        const field = try std.fmt.bufPrint(&buffer, "{s}, *;q=1, identity;q=0", .{header});
        try std.testing.expectEqual(@as(?negotiate.Encoding, null), negotiate.select_encoding(
            field,
            .{ .identity = false, .gzip = true },
        ));
    }
}

test "negotiate: shared qvalue parser follows the complete RFC grammar" {
    const cases = [_]QualityCase{
        .{ .value = "0", .expected = 0 },
        .{ .value = "0.", .expected = 0 },
        .{ .value = "0.0", .expected = 0 },
        .{ .value = "0.001", .expected = 1 },
        .{ .value = "0.999", .expected = 999 },
        .{ .value = "1", .expected = 1000 },
        .{ .value = "1.", .expected = 1000 },
        .{ .value = "1.0", .expected = 1000 },
        .{ .value = "1.000", .expected = 1000 },
        .{ .value = ".5", .expected = null },
        .{ .value = "01", .expected = null },
        .{ .value = "1.001", .expected = null },
        .{ .value = "1.0000", .expected = null },
        .{ .value = "0.1234", .expected = null },
        .{ .value = "-1", .expected = null },
        .{ .value = "NaN", .expected = null },
        .{ .value = "\"1\"", .expected = null },
    };
    for (cases) |case| {
        var buffer: [64]u8 = undefined;
        const field = try std.fmt.bufPrint(&buffer, "text/plain;q={s}", .{case.value});
        const accept = negotiate.parse(field);
        if (case.expected) |quality| {
            try std.testing.expectEqual(@as(usize, 1), accept.count);
            try std.testing.expectEqual(quality, negotiate.score(accept, "text/plain"));
            continue;
        }
        try std.testing.expectEqual(@as(usize, 0), accept.count);
    }
}
