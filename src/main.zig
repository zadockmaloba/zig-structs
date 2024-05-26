const std = @import("std");
const buf_print = std.fmt.bufPrint;

const eShapeType = enum { Undefined, Rectangle, Square, Triangle, Circle };

const Shape = struct {
    type: eShapeType = .Undefined,
    width: u32 = 0,
    height: u32 = 0,
    areaFn: fn (*const @This()) i32 = undefined,

    fn area(self: *const @This()) i32 {
        return self.areaFn(self);
    }

    pub fn format(
        shape: *const @This(),
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        try writer.writeAll("Shape{\n");
        _ = try writer.print("\ttype: {},\n", .{shape.type});
        _ = try writer.print("\twidth: {},\n", .{shape.width});
        _ = try writer.print("\theight: {},\n", .{shape.height});

        try writer.writeAll("}\n");
    }
};

pub fn main() !void {
    const rectangle = Shape{
        .type = .Rectangle,
        .width = 10,
        .height = 10,
    };
    std.debug.print("Hello, World\n", .{});
    //std.json.stringify(rectangle, .{}, std.debug.print);
    std.debug.print("{}", .{rectangle});
}
