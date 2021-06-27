const std = @import("std");
const fs = std.fs;
const File = std.fs.File;

const CommentBuffer = struct {
    buf: [2048]u8 = undefined,
    cursor: u64 = 0,
};

pub fn codegen(self: *std.build.Step) !void {

    // READ-FILE: https://zigforum.org/t/read-file-or-buffer-by-line/317/4
    var currentDir  = std.fs.cwd();
    var file        = try currentDir.openFile("submodules/bgfx/include/bgfx/c99/bgfx.h", .{});
    defer file.close();
    var buf_reader  = std.io.bufferedReader(file.reader());
    var in_stream   = buf_reader.reader();
    var readBuffer: [1024]u8 = undefined;

    var commentBuffer = CommentBuffer{};

    var wFile = try currentDir.createFile("lib/bgfx.zig", .{});

    var isReadingComment:bool = false;

    while (try in_stream.readUntilDelimiterOrEof(&readBuffer, '\n')) |line| {
        if(startsWith(line, "/**") and !startsWith(line, "/**/")) {

            // Leeg de buffer;
            for(commentBuffer.buf) |*char,i|{
                char.* = 0;
            }

            // Reset de cursor
            commentBuffer.cursor = 0;

            isReadingComment = true;
        }

        if(isReadingComment == true){
            const skip = 3; // Hoeveel char's we negeren

            if(line.len > skip){
                const readLenght    = line.len - skip;              // Hoeveel van de lengte van de gelezen lijn we interesant vinden
                const commentStr    = "\n/// ";                     // Waarmee we een comment-lijn prefixen
                const bufSliceStart = commentBuffer.cursor + commentStr.len; // Waar in de buffer we beginnnen met schrijven van de lijn-info
                const bufSliceEnd   = bufSliceStart + readLenght;   // Waar in de buffer we stoppen met schrijven
                const totalLength   = commentStr.len + (bufSliceEnd - bufSliceStart) ;

                for(commentStr) |char, i| {
                    commentBuffer.buf[commentBuffer.cursor+i] = char;
                }

                for(commentBuffer.buf[bufSliceStart..bufSliceEnd]) |*char, i| {
                    char.* = line[i+skip];
                }

                // std.debug.print("STUFF {s}", .{commentBuffer.buf[bufSliceStart..(bufSliceEnd+10)]});

                commentBuffer.cursor += totalLength;
            }
        }

        if(startsWith(line, " */")) {
            isReadingComment = false;
        }

        if(find(line, "BGFX_C_API void")) |index| {
            var writeEnumError = try writeVoidFunction(wFile, line, commentBuffer);
        }
    }

    defer wFile.close();
}

fn startsWith(self: []u8, search:[]const u8) bool {
    if(self.len < search.len) return false; 

    var slice = self[0..search.len];
    return std.mem.eql(u8, slice, search);
}

fn find(self: []u8, search:[]const u8) ?u16 {

    var index:u16 = 0;

    while(search.len + index < self.len){
        const asd = self[index..(search.len + index)];
        const eq = std.mem.eql(u8, asd, search);
        if(eq){
            return index;
        }

        index += 1;
    }

    return null;
}

fn writeVoidFunction(file: File, line: []u8, comBuffer: ?CommentBuffer) !void {
    // Schrijf commentaar naar file wanneer dit aanwezig is
    if(comBuffer) |commentBuffer|{
        var b = try file.write(commentBuffer.buf[0..commentBuffer.cursor]);
        b = try file.write("\n");
    }

    const functionName = line[16..];
    

    var a = try file.write("fn ");
    a = try file.write(functionName);
    a = try file.write(" = enum {};\n");
}