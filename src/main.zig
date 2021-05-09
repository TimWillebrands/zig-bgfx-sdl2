const std = @import("std");

const assert = std.debug.assert;
const meta = std.meta;
const builtin = std.builtin;

usingnamespace @cImport({
    @cInclude("stdio.h");
    @cInclude("string.h");
    @cInclude("unistd.h");
    @cInclude("time.h");
    @cInclude("errno.h");
    @cInclude("stdintfix.h"); // NB: Required as zig is unable to process some macros

    @cInclude("GL/gl.h");
    @cInclude("GL/glx.h");
    @cInclude("GL/glext.h");

    @cInclude("bgfx/c99/bgfx.h");
});

const sdl = @cImport({
    @cInclude("SDL2/SDL.h");
    @cInclude("SDL2/SDL_syswm.h");
});

fn sdlSetWindow(window: *sdl.SDL_Window) !void {
    var wmi: sdl.SDL_SysWMinfo = undefined;
    wmi.version.major = sdl.SDL_MAJOR_VERSION;
    wmi.version.minor = sdl.SDL_MINOR_VERSION;
    wmi.version.patch = sdl.SDL_PATCHLEVEL;
    if (sdl.SDL_GetWindowWMInfo(window, &wmi) == .SDL_FALSE) {
        return error.SDL_FAILED_INIT;
    }

    var pd = std.mem.zeroes(bgfx_platform_data_t);
    if (builtin.os.tag == .linux) {
        pd.ndt = wmi.info.x11.display;
        pd.nwh = meta.cast(*c_void, wmi.info.x11.window);
    }
    if (builtin.os.tag == .freebsd) {
        pd.ndt = wmi.info.x11.display;
        pd.nwh = meta.cast(*c_void, wmi.info.x11.window);
    }
    if (builtin.os.tag == .macos) {
        pd.ndt = NULL;
        pd.nwh = wmi.info.cocoa.window;
    }
    if (builtin.os.tag == .windows) {
        pd.ndt = NULL;
        pd.nwh = wmi.info.win.window;
    }
    //if (builtin.os.tag == .steamlink) {
    //    pd.ndt = wmi.info.vivante.display;
    //    pd.nwh = wmi.info.vivante.window;
    //}
    pd.context = NULL;
    pd.backBuffer = NULL;
    pd.backBufferDS = NULL;
    bgfx_set_platform_data(&pd);
}

pub fn main() !void {
    const out = std.io.getStdOut().writer();
    try out.print("Hello, {s}!\n", .{"world"});
    _ = sdl.SDL_Init(0);
    defer sdl.SDL_Quit();
    const window = sdl.SDL_CreateWindow("bgfx", sdl.SDL_WINDOWPOS_UNDEFINED, sdl.SDL_WINDOWPOS_UNDEFINED, 800, 600, sdl.SDL_WINDOW_SHOWN | sdl.SDL_WINDOW_RESIZABLE).?;
    defer sdl.SDL_DestroyWindow(window);
    try sdlSetWindow(window);

    var in = std.mem.zeroes(bgfx_init_t);
    in.type = bgfx_renderer_type.BGFX_RENDERER_TYPE_COUNT; // Automatically choose a renderer.
    in.resolution.width = 800;
    in.resolution.height = 600;
    in.resolution.reset = BGFX_RESET_VSYNC;
    var success = bgfx_init(&in);
    defer bgfx_shutdown();
    assert(success);

    bgfx_set_debug(BGFX_DEBUG_TEXT);

    bgfx_set_view_clear(0, BGFX_CLEAR_COLOR | BGFX_CLEAR_DEPTH, 0x443355FF, 1.0, 0);
    bgfx_set_view_rect(0, 0, 0, 800, 600);

    var frame_number: u64 = 0;
    gameloop: while (true) {
        var event: sdl.SDL_Event = undefined;
        var should_exit = false;
        while (sdl.SDL_PollEvent(&event) == 1) {
            switch (event.type) {
                sdl.SDL_QUIT => should_exit = true,

                sdl.SDL_WINDOWEVENT => {
                    const wev = &event.window;
                    switch (wev.event) {
                        sdl.SDL_WINDOWEVENT_RESIZED, sdl.SDL_WINDOWEVENT_SIZE_CHANGED => {},

                        sdl.SDL_WINDOWEVENT_CLOSE => should_exit = true,

                        else => {},
                    }
                },

                else => {},
            }
        }
        if (should_exit) break :gameloop;

        bgfx_set_view_rect(0, 0, 0, 800, 600);
        bgfx_touch(0);
        bgfx_dbg_text_clear(0, false);
        bgfx_dbg_text_printf(0, 1, 0x4f, "Frame#:%d", frame_number);
        frame_number = bgfx_frame(false);
    }
}
