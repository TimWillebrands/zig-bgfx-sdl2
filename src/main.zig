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
    // @cInclude("bgfx/platform.h");
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

// COPIED FROM https://bedroomcoders.co.uk/using-bgfx-from-c/

const PosColorVertex = packed struct {
    x: f32,
    y: f32,
    z: f32,
    abgr: c_uint
};

const cubeVertices = [_]PosColorVertex
{
    {-.x=1.0; .y= 1.0; .z=1.0; .abge=0xff000000; },
    { .x=1.0; .y= 1.0; .z=1.0; .abge=0xff0000ff; },
    {-.x=1.0; .y=-1.0; .z=1.0; .abge=0xff00ff00; },
    { .x=1.0; .y=-1.0; .z=1.0; .abge=0xff00ffff; },
    {-.x=1.0; .y= 1.0; .z=1.0; .abge=0xffff0000; },
    { .x=1.0; .y= 1.0; .z=1.0; .abge=0xffff00ff; },
    {-.x=1.0; .y=-1.0; .z=1.0; .abge=0xffffff00; },
    { .x=1.0; .y=-1.0; .z=1.0; .abge=0xffffffff; },
};

const cubeTriList = [_]c_uint
{
    0, 1, 2,
    1, 3, 2,
    4, 6, 5,
    5, 6, 7,
    0, 2, 4,
    4, 2, 6,
    1, 5, 3,
    5, 7, 3,
    0, 4, 1,
    4, 5, 1,
    2, 3, 6,
    6, 3, 7,
};

// export fn loadShader(FILENAME:char *)
// {
//     const char* shaderPath = "???";
//     //dx11/  dx9/   essl/  glsl/  metal/ pssl/  spirv/
//     bgfx_shader_handle_t invalid = BGFX_INVALID_HANDLE;
    
//     switch(bgfx_get_renderer_type()) {
//         case BGFX_RENDERER_TYPE_NOOP:
//         case BGFX_RENDERER_TYPE_DIRECT3D9:     shaderPath = "shaders/dx9/";   break;
//         case BGFX_RENDERER_TYPE_DIRECT3D11:
//         case BGFX_RENDERER_TYPE_DIRECT3D12:    shaderPath = "shaders/dx11/";  break;
//         case BGFX_RENDERER_TYPE_GNM:           shaderPath = "shaders/pssl/";  break;
//         case BGFX_RENDERER_TYPE_METAL:         shaderPath = "shaders/metal/"; break;
//         case BGFX_RENDERER_TYPE_OPENGL:        shaderPath = "shaders/glsl/";  break;
//         case BGFX_RENDERER_TYPE_OPENGLES:      shaderPath = "shaders/essl/";  break;
//         case BGFX_RENDERER_TYPE_VULKAN:        shaderPath = "shaders/spirv/"; break;
//         case BGFX_RENDERER_TYPE_NVN:
//         case BGFX_RENDERER_TYPE_WEBGPU:
//         case BGFX_RENDERER_TYPE_COUNT:         return invalid; // count included to keep compiler warnings happy
//     }
//     size_t shaderLen = strlen(shaderPath);
//     size_t fileLen = strlen(FILENAME);
//     char *filePath = (char *)malloc(shaderLen + fileLen + 1);
//     memcpy(filePath, shaderPath, shaderLen);
//     memcpy(&filePath[shaderLen], FILENAME, fileLen);
//     filePath[shaderLen+fileLen] = 0;    // properly null terminate
//     FILE *file = fopen(filePath, "rb");
    
//     if (!file) {
//         return invalid;
//     }
    
//     fseek(file, 0, SEEK_END);
//     long fileSize = ftell(file);
//     fseek(file, 0, SEEK_SET);
//     const bgfx_memory_t *mem = bgfx_alloc(fileSize + 1);
//     fread(mem->data, 1, fileSize, file);
//     mem->data[mem->size - 1] = '\0';
//     fclose(file);
//     return bgfx_create_shader(mem);
// }


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

    const pcvDecl = bgfx_vertex_decl;
    // pcvDecl.begin()
    //     .add(bgfx::Attrib::Position, 3, bgfx::AttribType::Float)
    //     .add(bgfx::Attrib::Color0, 4, bgfx::AttribType::Uint8, true)
    // .end();
    // bgfx::VertexBufferHandle vbh = bgfx::createVertexBuffer(bgfx::makeRef(cubeVertices, sizeof(cubeVertices)), pcvDecl);
    // bgfx::IndexBufferHandle ibh = bgfx::createIndexBuffer(bgfx::makeRef(cubeTriList, sizeof(cubeTriList)));

    // unsigned int counter = 0;

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
