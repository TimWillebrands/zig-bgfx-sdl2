const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("game", "src/main.zig");
    exe.addIncludeDir("src");
    
    exe.linkSystemLibrary("c");

    exe.linkLibC();
    exe.linkSystemLibrary("c++");
    exe.linkSystemLibrary("X11");
    exe.linkSystemLibrary("SDL2");
    exe.linkSystemLibrary("GL");

    comptime const cxx_options = [_][]const u8{
        "-fno-strict-aliasing",
        "-fno-exceptions",
        "-fno-rtti",
        "-ffast-math",
    };
    // Define to enable some debug prints in BGFX
    //exe.defineCMacro("BGFX_CONFIG_DEBUG=1");

    // bx
    comptime const bx = "submodules/bx/";
    exe.addIncludeDir(bx ++ "include/");
    exe.addIncludeDir(bx ++ "3rdparty/");
    exe.addCSourceFile(bx ++ "src/amalgamated.cpp", &cxx_options);

    // bimg
    comptime const bimg = "submodules/bimg/";
    exe.addIncludeDir(bimg ++ "include/");
    exe.addIncludeDir(bimg ++ "3rdparty/");
    exe.addIncludeDir(bimg ++ "3rdparty/astc-codec/");
    exe.addIncludeDir(bimg ++ "3rdparty/astc-codec/include/");
    exe.addCSourceFile(bimg ++ "src/image.cpp", &cxx_options);
    exe.addCSourceFile(bimg ++ "src/image_gnf.cpp", &cxx_options);
    // FIXME: Glob?
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/astc_file.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/codec.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/endpoint_codec.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/footprint.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/integer_sequence_codec.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/intermediate_astc_block.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/logical_astc_block.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/partition.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/physical_astc_block.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/quantization.cc", &cxx_options);
    exe.addCSourceFile(bimg ++ "3rdparty/astc-codec/src/decoder/weight_infill.cc", &cxx_options);

    // bgfx
    comptime const bgfx = "submodules/bgfx/";
    exe.addIncludeDir(bgfx ++ "include/");
    exe.addIncludeDir(bgfx ++ "3rdparty/");
    exe.addIncludeDir(bgfx ++ "3rdparty/dxsdk/include/");
    exe.addIncludeDir(bgfx ++ "3rdparty/khronos/");
    exe.addIncludeDir(bgfx ++ "src/");
    exe.addCSourceFile(bgfx ++ "src/amalgamated.cpp", &cxx_options);

    // exe.setTarget(builtin.Arch.x86_64, .windows, .msvc);
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);


    

    const git_sub_cmd = [_][]const u8{ "git", "submodule", "update", "--init", "--recursive" };
    const fetch_subs = b.addSystemCommand(&git_sub_cmd);
    const fetch_step = b.step("fetch", "Fetch submodules");
    fetch_step.dependOn(&fetch_subs.step);
}
