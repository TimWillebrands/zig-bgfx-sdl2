
/// Init attachment.
/// @param[in] _handle Render target texture handle.
/// @param[in] _access Access. See `Access::Enum`.
/// @param[in] _layer Cubemap side or depth layer/slice.
/// @param[in] _mip Mip level.
/// @param[in] _resolve Resolve flags. See: `BGFX_RESOLVE_*`
fn bgfx_attachment_init(bgfx_attachment_t* _this, bgfx_texture_handle_t _handle, bgfx_access_t _access, uint16_t _layer, uint16_t _mip, uint8_t _resolve); = enum {};

/// Decode attribute.
/// @param[in] _attrib Attribute semantics. See: `bgfx::Attrib`
/// @param[out] _num Number of elements.
/// @param[out] _type Element type.
/// @param[out] _normalized Attribute is normalized.
/// @param[out] _asInt Attribute is packed as int.
fn bgfx_vertex_layout_decode(const bgfx_vertex_layout_t* _this, bgfx_attrib_t _attrib, uint8_t * _num, bgfx_attrib_type_t * _type, bool * _normalized, bool * _asInt); = enum {};

/// End VertexLayout.
fn bgfx_vertex_layout_end(bgfx_vertex_layout_t* _this); = enum {};

/// Pack vertex attribute into vertex stream format.
/// @param[in] _input Value to be packed into vertex stream.
/// @param[in] _inputNormalized `true` if input value is already normalized.
/// @param[in] _attr Attribute to pack.
/// @param[in] _layout Vertex stream layout.
/// @param[in] _data Destination vertex stream where data will be packed.
/// @param[in] _index Vertex index that will be modified.
fn bgfx_vertex_pack(const float _input[4], bool _inputNormalized, bgfx_attrib_t _attr, const bgfx_vertex_layout_t * _layout, void* _data, uint32_t _index); = enum {};

/// Unpack vertex attribute from vertex stream format.
/// @param[out] _output Result of unpacking.
/// @param[in] _attr Attribute to unpack.
/// @param[in] _layout Vertex stream layout.
/// @param[in] _data Source vertex stream from where data will be unpacked.
/// @param[in] _index Vertex index that will be unpacked.
fn bgfx_vertex_unpack(float _output[4], bgfx_attrib_t _attr, const bgfx_vertex_layout_t * _layout, const void* _data, uint32_t _index); = enum {};

/// Converts vertex stream data from one vertex stream format to another.
/// @param[in] _dstLayout Destination vertex stream layout.
/// @param[in] _dstData Destination vertex stream.
/// @param[in] _srcLayout Source vertex stream layout.
/// @param[in] _srcData Source vertex stream data.
/// @param[in] _num Number of vertices to convert from source to destination.
fn bgfx_vertex_convert(const bgfx_vertex_layout_t * _dstLayout, void* _dstData, const bgfx_vertex_layout_t * _srcLayout, const void* _srcData, uint32_t _num); = enum {};

/// Sort indices.
/// @param[in] _sort Sort order, see `TopologySort::Enum`.
/// @param[out] _dst Destination index buffer.
/// @param[in] _dstSize Destination index buffer in bytes. It must be
///  large enough to contain output indices. If destination size is
///  insufficient index buffer will be truncated.
/// @param[in] _dir Direction (vector must be normalized).
/// @param[in] _pos Position.
/// @param[in] _vertices Pointer to first vertex represented as
///  float x, y, z. Must contain at least number of vertices
///  referencende by index buffer.
/// @param[in] _stride Vertex stride.
/// @param[in] _indices Source indices.
/// @param[in] _numIndices Number of input indices.
/// @param[in] _index32 Set to `true` if input indices are 32-bit.
fn bgfx_topology_sort_tri_list(bgfx_topology_sort_t _sort, void* _dst, uint32_t _dstSize, const float _dir[3], const float _pos[3], const void* _vertices, uint32_t _stride, const void* _indices, uint32_t _numIndices, bool _index32); = enum {};

/// Returns name of renderer.
/// @param[in] _type Renderer backend type. See: `bgfx::RendererType`
/// @returns Name of renderer.
fn bgfx_init_ctor(bgfx_init_t* _init); = enum {};

/// Shutdown bgfx library.
fn bgfx_shutdown(void); = enum {};

/// Reset graphic settings and back-buffer size.
/// @attention This call doesn't actually change window size, it just
///   resizes back-buffer. Windowing code has to change window size.
/// @param[in] _width Back-buffer width.
/// @param[in] _height Back-buffer height.
/// @param[in] _flags See: `BGFX_RESET_*` for more info.
///    - `BGFX_RESET_NONE` - No reset flags.
///    - `BGFX_RESET_FULLSCREEN` - Not supported yet.
///    - `BGFX_RESET_MSAA_X[2/4/8/16]` - Enable 2, 4, 8 or 16 x MSAA.
///    - `BGFX_RESET_VSYNC` - Enable V-Sync.
///    - `BGFX_RESET_MAXANISOTROPY` - Turn on/off max anisotropy.
///    - `BGFX_RESET_CAPTURE` - Begin screen capture.
///    - `BGFX_RESET_FLUSH_AFTER_RENDER` - Flush rendering after submitting to GPU.
///    - `BGFX_RESET_FLIP_AFTER_RENDER` - This flag  specifies where flip
///      occurs. Default behaviour is that flip occurs before rendering new
///      frame. This flag only has effect when `BGFX_CONFIG_MULTITHREADED=0`.
///    - `BGFX_RESET_SRGB_BACKBUFFER` - Enable sRGB backbuffer.
/// @param[in] _format Texture format. See: `TextureFormat::Enum`.
fn bgfx_reset(uint32_t _width, uint32_t _height, uint32_t _flags, bgfx_texture_format_t _format); = enum {};

/// Set debug flags.
/// @param[in] _debug Available flags:
///    - `BGFX_DEBUG_IFH` - Infinitely fast hardware. When this flag is set
///      all rendering calls will be skipped. This is useful when profiling
///      to quickly assess potential bottlenecks between CPU and GPU.
///    - `BGFX_DEBUG_PROFILER` - Enable profiler.
///    - `BGFX_DEBUG_STATS` - Display internal statistics.
///    - `BGFX_DEBUG_TEXT` - Display debug text.
///    - `BGFX_DEBUG_WIREFRAME` - Wireframe rendering. All rendering
///      primitives will be rendered as lines.
fn bgfx_set_debug(uint32_t _debug); = enum {};

/// Clear internal debug text buffer.
/// @param[in] _attr Background color.
/// @param[in] _small Default 8x16 or 8x8 font.
fn bgfx_dbg_text_clear(uint8_t _attr, bool _small); = enum {};

/// Print formatted data to internal debug text character-buffer (VGA-compatible text mode).
/// @param[in] _x Position x from the left corner of the window.
/// @param[in] _y Position y from the top corner of the window.
/// @param[in] _attr Color palette. Where top 4-bits represent index of background, and bottom
///  4-bits represent foreground color from standard VGA text palette (ANSI escape codes).
/// @param[in] _format `printf` style format.
/// @param[in]
fn bgfx_dbg_text_printf(uint16_t _x, uint16_t _y, uint8_t _attr, const char* _format, ... ); = enum {};

/// Print formatted data from variable argument list to internal debug text character-buffer (VGA-compatible text mode).
/// @param[in] _x Position x from the left corner of the window.
/// @param[in] _y Position y from the top corner of the window.
/// @param[in] _attr Color palette. Where top 4-bits represent index of background, and bottom
///  4-bits represent foreground color from standard VGA text palette (ANSI escape codes).
/// @param[in] _format `printf` style format.
/// @param[in] _argList Variable arguments list for format string.
fn bgfx_dbg_text_vprintf(uint16_t _x, uint16_t _y, uint8_t _attr, const char* _format, va_list _argList); = enum {};

/// Draw image into internal debug text buffer.
/// @param[in] _x Position x from the left corner of the window.
/// @param[in] _y Position y from the top corner of the window.
/// @param[in] _width Image width.
/// @param[in] _height Image height.
/// @param[in] _data Raw image data (character/attribute raw encoding).
/// @param[in] _pitch Image pitch in bytes.
fn bgfx_dbg_text_image(uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height, const void* _data, uint16_t _pitch); = enum {};

/// Set static index buffer debug name.
/// @param[in] _handle Static index buffer handle.
/// @param[in] _name Static index buffer name.
/// @param[in] _len Static index buffer name length (if length is INT32_MAX, it's expected
///  that _name is zero terminated string.
fn bgfx_set_index_buffer_name(bgfx_index_buffer_handle_t _handle, const char* _name, int32_t _len); = enum {};

/// Destroy static index buffer.
/// @param[in] _handle Static index buffer handle.
fn bgfx_destroy_index_buffer(bgfx_index_buffer_handle_t _handle); = enum {};

/// Destroy vertex layout.
/// @param[in] _layoutHandle Vertex layout handle.
fn bgfx_destroy_vertex_layout(bgfx_vertex_layout_handle_t _layoutHandle); = enum {};

/// Set static vertex buffer debug name.
/// @param[in] _handle Static vertex buffer handle.
/// @param[in] _name Static vertex buffer name.
/// @param[in] _len Static vertex buffer name length (if length is INT32_MAX, it's expected
///  that _name is zero terminated string.
fn bgfx_set_vertex_buffer_name(bgfx_vertex_buffer_handle_t _handle, const char* _name, int32_t _len); = enum {};

/// Destroy static vertex buffer.
/// @param[in] _handle Static vertex buffer handle.
fn bgfx_destroy_vertex_buffer(bgfx_vertex_buffer_handle_t _handle); = enum {};

/// Update dynamic index buffer.
/// @param[in] _handle Dynamic index buffer handle.
/// @param[in] _startIndex Start index.
/// @param[in] _mem Index buffer data.
fn bgfx_update_dynamic_index_buffer(bgfx_dynamic_index_buffer_handle_t _handle, uint32_t _startIndex, const bgfx_memory_t* _mem); = enum {};

/// Destroy dynamic index buffer.
/// @param[in] _handle Dynamic index buffer handle.
fn bgfx_destroy_dynamic_index_buffer(bgfx_dynamic_index_buffer_handle_t _handle); = enum {};

/// Update dynamic vertex buffer.
/// @param[in] _handle Dynamic vertex buffer handle.
/// @param[in] _startVertex Start vertex.
/// @param[in] _mem Vertex buffer data.
fn bgfx_update_dynamic_vertex_buffer(bgfx_dynamic_vertex_buffer_handle_t _handle, uint32_t _startVertex, const bgfx_memory_t* _mem); = enum {};

/// Destroy dynamic vertex buffer.
/// @param[in] _handle Dynamic vertex buffer handle.
fn bgfx_destroy_dynamic_vertex_buffer(bgfx_dynamic_vertex_buffer_handle_t _handle); = enum {};

/// Allocate transient index buffer.
/// @remarks
///   Only 16-bit index buffer is supported.
/// @param[out] _tib TransientIndexBuffer structure is filled and is valid
///  for the duration of frame, and it can be reused for multiple draw
///  calls.
/// @param[in] _num Number of indices to allocate.
fn bgfx_alloc_transient_index_buffer(bgfx_transient_index_buffer_t* _tib, uint32_t _num); = enum {};

/// Allocate transient vertex buffer.
/// @param[out] _tvb TransientVertexBuffer structure is filled and is valid
///  for the duration of frame, and it can be reused for multiple draw
///  calls.
/// @param[in] _num Number of vertices to allocate.
/// @param[in] _layout Vertex layout.
fn bgfx_alloc_transient_vertex_buffer(bgfx_transient_vertex_buffer_t* _tvb, uint32_t _num, const bgfx_vertex_layout_t * _layout); = enum {};

/// Allocate instance data buffer.
/// @param[out] _idb InstanceDataBuffer structure is filled and is valid
///  for duration of frame, and it can be reused for multiple draw
///  calls.
/// @param[in] _num Number of instances.
/// @param[in] _stride Instance stride. Must be multiple of 16.
fn bgfx_alloc_instance_data_buffer(bgfx_instance_data_buffer_t* _idb, uint32_t _num, uint16_t _stride); = enum {};

/// Destroy draw indirect buffer.
/// @param[in] _handle Indirect buffer handle.
fn bgfx_destroy_indirect_buffer(bgfx_indirect_buffer_handle_t _handle); = enum {};

/// Set shader debug name.
/// @param[in] _handle Shader handle.
/// @param[in] _name Shader name.
/// @param[in] _len Shader name length (if length is INT32_MAX, it's expected
///  that _name is zero terminated string).
fn bgfx_set_shader_name(bgfx_shader_handle_t _handle, const char* _name, int32_t _len); = enum {};

/// Destroy shader.
/// @remark Once a shader program is created with _handle,
///   it is safe to destroy that shader.
/// @param[in] _handle Shader handle.
fn bgfx_destroy_shader(bgfx_shader_handle_t _handle); = enum {};

/// Destroy program.
/// @param[in] _handle Program handle.
fn bgfx_destroy_program(bgfx_program_handle_t _handle); = enum {};

/// Calculate amount of memory required for texture.
/// @param[out] _info Resulting texture info structure. See: `TextureInfo`.
/// @param[in] _width Width.
/// @param[in] _height Height.
/// @param[in] _depth Depth dimension of volume texture.
/// @param[in] _cubeMap Indicates that texture contains cubemap.
/// @param[in] _hasMips Indicates that texture contains full mip-map chain.
/// @param[in] _numLayers Number of layers in texture array.
/// @param[in] _format Texture format. See: `TextureFormat::Enum`.
fn bgfx_calc_texture_size(bgfx_texture_info_t * _info, uint16_t _width, uint16_t _height, uint16_t _depth, bool _cubeMap, bool _hasMips, uint16_t _numLayers, bgfx_texture_format_t _format); = enum {};

/// Update 2D texture.
/// @attention It's valid to update only mutable texture. See `bgfx::createTexture2D` for more info.
/// @param[in] _handle Texture handle.
/// @param[in] _layer Layer in texture array.
/// @param[in] _mip Mip level.
/// @param[in] _x X offset in texture.
/// @param[in] _y Y offset in texture.
/// @param[in] _width Width of texture block.
/// @param[in] _height Height of texture block.
/// @param[in] _mem Texture update data.
/// @param[in] _pitch Pitch of input image (bytes). When _pitch is set to
///  UINT16_MAX, it will be calculated internally based on _width.
fn bgfx_update_texture_2d(bgfx_texture_handle_t _handle, uint16_t _layer, uint8_t _mip, uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height, const bgfx_memory_t* _mem, uint16_t _pitch); = enum {};

/// Update 3D texture.
/// @attention It's valid to update only mutable texture. See `bgfx::createTexture3D` for more info.
/// @param[in] _handle Texture handle.
/// @param[in] _mip Mip level.
/// @param[in] _x X offset in texture.
/// @param[in] _y Y offset in texture.
/// @param[in] _z Z offset in texture.
/// @param[in] _width Width of texture block.
/// @param[in] _height Height of texture block.
/// @param[in] _depth Depth of texture block.
/// @param[in] _mem Texture update data.
fn bgfx_update_texture_3d(bgfx_texture_handle_t _handle, uint8_t _mip, uint16_t _x, uint16_t _y, uint16_t _z, uint16_t _width, uint16_t _height, uint16_t _depth, const bgfx_memory_t* _mem); = enum {};

/// Update Cube texture.
/// @attention It's valid to update only mutable texture. See `bgfx::createTextureCube` for more info.
/// @param[in] _handle Texture handle.
/// @param[in] _layer Layer in texture array.
/// @param[in] _side Cubemap side `BGFX_CUBE_MAP_<POSITIVE or NEGATIVE>_<X, Y or Z>`,
///    where 0 is +X, 1 is -X, 2 is +Y, 3 is -Y, 4 is +Z, and 5 is -Z.
///                   +----------+
///                   |-z       2|
///                   | ^  +y    |
///                   | |        |    Unfolded cube:
///                   | +---->+x |
///        +----------+----------+----------+----------+
///        |+y       1|+y       4|+y       0|+y       5|
///        | ^  -x    | ^  +z    | ^  +x    | ^  -z    |
///        | |        | |        | |        | |        |
///        | +---->+z | +---->+x | +---->-z | +---->-x |
///        +----------+----------+----------+----------+
///                   |+z       3|
///                   | ^  -y    |
///                   | |        |
///                   | +---->+x |
///                   +----------+
/// @param[in] _mip Mip level.
/// @param[in] _x X offset in texture.
/// @param[in] _y Y offset in texture.
/// @param[in] _width Width of texture block.
/// @param[in] _height Height of texture block.
/// @param[in] _mem Texture update data.
/// @param[in] _pitch Pitch of input image (bytes). When _pitch is set to
///  UINT16_MAX, it will be calculated internally based on _width.
fn bgfx_update_texture_cube(bgfx_texture_handle_t _handle, uint16_t _layer, uint8_t _side, uint8_t _mip, uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height, const bgfx_memory_t* _mem, uint16_t _pitch); = enum {};

/// Set texture debug name.
/// @param[in] _handle Texture handle.
/// @param[in] _name Texture name.
/// @param[in] _len Texture name length (if length is INT32_MAX, it's expected
///  that _name is zero terminated string.
fn bgfx_set_texture_name(bgfx_texture_handle_t _handle, const char* _name, int32_t _len); = enum {};

/// Returns texture direct access pointer.
/// @attention Availability depends on: `BGFX_CAPS_TEXTURE_DIRECT_ACCESS`. This feature
///   is available on GPUs that have unified memory architecture (UMA) support.
/// @param[in] _handle Texture handle.
/// @returns Pointer to texture memory. If returned pointer is `NULL` direct access
///  is not available for this texture. If pointer is `UINTPTR_MAX` sentinel value
///  it means texture is pending creation. Pointer returned can be cached and it
///  will be valid until texture is destroyed.
fn  bgfx_get_direct_access_ptr(bgfx_texture_handle_t _handle); = enum {};

/// Destroy texture.
/// @param[in] _handle Texture handle.
fn bgfx_destroy_texture(bgfx_texture_handle_t _handle); = enum {};

/// Set frame buffer debug name.
/// @param[in] _handle Frame buffer handle.
/// @param[in] _name Frame buffer name.
/// @param[in] _len Frame buffer name length (if length is INT32_MAX, it's expected
///  that _name is zero terminated string.
fn bgfx_set_frame_buffer_name(bgfx_frame_buffer_handle_t _handle, const char* _name, int32_t _len); = enum {};

/// Destroy frame buffer.
/// @param[in] _handle Frame buffer handle.
fn bgfx_destroy_frame_buffer(bgfx_frame_buffer_handle_t _handle); = enum {};

/// Retrieve uniform info.
/// @param[in] _handle Handle to uniform object.
/// @param[out] _info Uniform info.
fn bgfx_get_uniform_info(bgfx_uniform_handle_t _handle, bgfx_uniform_info_t * _info); = enum {};

/// Destroy shader uniform parameter.
/// @param[in] _handle Handle to uniform object.
fn bgfx_destroy_uniform(bgfx_uniform_handle_t _handle); = enum {};

/// Destroy occlusion query.
/// @param[in] _handle Handle to occlusion query object.
fn bgfx_destroy_occlusion_query(bgfx_occlusion_query_handle_t _handle); = enum {};

/// Set palette color value.
/// @param[in] _index Index into palette.
/// @param[in] _rgba RGBA floating point values.
fn bgfx_set_palette_color(uint8_t _index, const float _rgba[4]); = enum {};

/// Set palette color value.
/// @param[in] _index Index into palette.
/// @param[in] _rgba Packed 32-bit RGBA value.
fn bgfx_set_palette_color_rgba8(uint8_t _index, uint32_t _rgba); = enum {};

/// Set view name.
/// @remarks
///   This is debug only feature.
///   In graphics debugger view name will appear as:
///       "nnnc <view name>"
///        ^  ^ ^
///        |  +--- compute (C)
///        +------ view id
/// @param[in] _id View id.
/// @param[in] _name View name.
fn bgfx_set_view_name(bgfx_view_id_t _id, const char* _name); = enum {};

/// Set view rectangle. Draw primitive outside view will be clipped.
/// @param[in] _id View id.
/// @param[in] _x Position x from the left corner of the window.
/// @param[in] _y Position y from the top corner of the window.
/// @param[in] _width Width of view port region.
/// @param[in] _height Height of view port region.
fn bgfx_set_view_rect(bgfx_view_id_t _id, uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height); = enum {};

/// Set view rectangle. Draw primitive outside view will be clipped.
/// @param[in] _id View id.
/// @param[in] _x Position x from the left corner of the window.
/// @param[in] _y Position y from the top corner of the window.
/// @param[in] _ratio Width and height will be set in respect to back-buffer size.
///  See: `BackbufferRatio::Enum`.
fn bgfx_set_view_rect_ratio(bgfx_view_id_t _id, uint16_t _x, uint16_t _y, bgfx_backbuffer_ratio_t _ratio); = enum {};

/// Set view scissor. Draw primitive outside view will be clipped. When
/// _x, _y, _width and _height are set to 0, scissor will be disabled.
/// @param[in] _id View id.
/// @param[in] _x Position x from the left corner of the window.
/// @param[in] _y Position y from the top corner of the window.
/// @param[in] _width Width of view scissor region.
/// @param[in] _height Height of view scissor region.
fn bgfx_set_view_scissor(bgfx_view_id_t _id, uint16_t _x, uint16_t _y, uint16_t _width, uint16_t _height); = enum {};

/// Set view clear flags.
/// @param[in] _id View id.
/// @param[in] _flags Clear flags. Use `BGFX_CLEAR_NONE` to remove any clear
///  operation. See: `BGFX_CLEAR_*`.
/// @param[in] _rgba Color clear value.
/// @param[in] _depth Depth clear value.
/// @param[in] _stencil Stencil clear value.
fn bgfx_set_view_clear(bgfx_view_id_t _id, uint16_t _flags, uint32_t _rgba, float _depth, uint8_t _stencil); = enum {};

/// Set view clear flags with different clear color for each
/// frame buffer texture. Must use `bgfx::setPaletteColor` to setup clear color
/// palette.
/// @param[in] _id View id.
/// @param[in] _flags Clear flags. Use `BGFX_CLEAR_NONE` to remove any clear
///  operation. See: `BGFX_CLEAR_*`.
/// @param[in] _depth Depth clear value.
/// @param[in] _stencil Stencil clear value.
/// @param[in] _c0 Palette index for frame buffer attachment 0.
/// @param[in] _c1 Palette index for frame buffer attachment 1.
/// @param[in] _c2 Palette index for frame buffer attachment 2.
/// @param[in] _c3 Palette index for frame buffer attachment 3.
/// @param[in] _c4 Palette index for frame buffer attachment 4.
/// @param[in] _c5 Palette index for frame buffer attachment 5.
/// @param[in] _c6 Palette index for frame buffer attachment 6.
/// @param[in] _c7 Palette index for frame buffer attachment 7.
fn bgfx_set_view_clear_mrt(bgfx_view_id_t _id, uint16_t _flags, float _depth, uint8_t _stencil, uint8_t _c0, uint8_t _c1, uint8_t _c2, uint8_t _c3, uint8_t _c4, uint8_t _c5, uint8_t _c6, uint8_t _c7); = enum {};

/// Set view sorting mode.
/// @remarks
///   View mode must be set prior calling `bgfx::submit` for the view.
/// @param[in] _id View id.
/// @param[in] _mode View sort mode. See `ViewMode::Enum`.
fn bgfx_set_view_mode(bgfx_view_id_t _id, bgfx_view_mode_t _mode); = enum {};

/// Set view frame buffer.
/// @remarks
///   Not persistent after `bgfx::reset` call.
/// @param[in] _id View id.
/// @param[in] _handle Frame buffer handle. Passing `BGFX_INVALID_HANDLE` as
///  frame buffer handle will draw primitives from this view into
///  default back buffer.
fn bgfx_set_view_frame_buffer(bgfx_view_id_t _id, bgfx_frame_buffer_handle_t _handle); = enum {};

/// Set view view and projection matrices, all draw primitives in this
/// view will use these matrices.
/// @param[in] _id View id.
/// @param[in] _view View matrix.
/// @param[in] _proj Projection matrix.
fn bgfx_set_view_transform(bgfx_view_id_t _id, const void* _view, const void* _proj); = enum {};

/// Post submit view reordering.
/// @param[in] _id First view id.
/// @param[in] _num Number of views to remap.
/// @param[in] _order View remap id table. Passing `NULL` will reset view ids
///  to default state.
fn bgfx_set_view_order(bgfx_view_id_t _id, uint16_t _num, const bgfx_view_id_t* _order); = enum {};

/// Reset all view settings to default.
/// @param[in] _id
fn bgfx_reset_view(bgfx_view_id_t _id); = enum {};

/// End submitting draw calls from thread.
/// @param[in] _encoder Encoder.
fn bgfx_encoder_end(bgfx_encoder_t* _encoder); = enum {};

/// Sets a debug marker. This allows you to group graphics calls together for easy browsing in
/// graphics debugging tools.
/// @param[in] _marker Marker string.
fn bgfx_encoder_set_marker(bgfx_encoder_t* _this, const char* _marker); = enum {};

/// Set render states for draw primitive.
/// @remarks
///   1. To setup more complex states use:
///      `BGFX_STATE_ALPHA_REF(_ref)`,
///      `BGFX_STATE_POINT_SIZE(_size)`,
///      `BGFX_STATE_BLEND_FUNC(_src, _dst)`,
///      `BGFX_STATE_BLEND_FUNC_SEPARATE(_srcRGB, _dstRGB, _srcA, _dstA)`,
///      `BGFX_STATE_BLEND_EQUATION(_equation)`,
///      `BGFX_STATE_BLEND_EQUATION_SEPARATE(_equationRGB, _equationA)`
///   2. `BGFX_STATE_BLEND_EQUATION_ADD` is set when no other blend
///      equation is specified.
/// @param[in] _state State flags. Default state for primitive type is
///    triangles. See: `BGFX_STATE_DEFAULT`.
///    - `BGFX_STATE_DEPTH_TEST_*` - Depth test function.
///    - `BGFX_STATE_BLEND_*` - See remark 1 about BGFX_STATE_BLEND_FUNC.
///    - `BGFX_STATE_BLEND_EQUATION_*` - See remark 2.
///    - `BGFX_STATE_CULL_*` - Backface culling mode.
///    - `BGFX_STATE_WRITE_*` - Enable R, G, B, A or Z write.
///    - `BGFX_STATE_MSAA` - Enable hardware multisample antialiasing.
///    - `BGFX_STATE_PT_[TRISTRIP/LINES/POINTS]` - Primitive type.
/// @param[in] _rgba Sets blend factor used by `BGFX_STATE_BLEND_FACTOR` and
///    `BGFX_STATE_BLEND_INV_FACTOR` blend modes.
fn bgfx_encoder_set_state(bgfx_encoder_t* _this, uint64_t _state, uint32_t _rgba); = enum {};

/// Set condition for rendering.
/// @param[in] _handle Occlusion query handle.
/// @param[in] _visible Render if occlusion query is visible.
fn bgfx_encoder_set_condition(bgfx_encoder_t* _this, bgfx_occlusion_query_handle_t _handle, bool _visible); = enum {};

/// Set stencil test state.
/// @param[in] _fstencil Front stencil state.
/// @param[in] _bstencil Back stencil state. If back is set to `BGFX_STENCIL_NONE`
///  _fstencil is applied to both front and back facing primitives.
fn bgfx_encoder_set_stencil(bgfx_encoder_t* _this, uint32_t _fstencil, uint32_t _bstencil); = enum {};

/// Set scissor from cache for draw primitive.
/// @remark
///   To scissor for all primitives in view see `bgfx::setViewScissor`.
/// @param[in] _cache Index in scissor cache.
fn bgfx_encoder_set_scissor_cached(bgfx_encoder_t* _this, uint16_t _cache); = enum {};

///  Set model matrix from matrix cache for draw primitive.
/// @param[in] _cache Index in matrix cache.
/// @param[in] _num Number of matrices from cache.
fn bgfx_encoder_set_transform_cached(bgfx_encoder_t* _this, uint32_t _cache, uint16_t _num); = enum {};

/// Set shader uniform parameter for draw primitive.
/// @param[in] _handle Uniform.
/// @param[in] _value Pointer to uniform data.
/// @param[in] _num Number of elements. Passing `UINT16_MAX` will
///  use the _num passed on uniform creation.
fn bgfx_encoder_set_uniform(bgfx_encoder_t* _this, bgfx_uniform_handle_t _handle, const void* _value, uint16_t _num); = enum {};

/// Set index buffer for draw primitive.
/// @param[in] _handle Index buffer.
/// @param[in] _firstIndex First index to render.
/// @param[in] _numIndices Number of indices to render.
fn bgfx_encoder_set_index_buffer(bgfx_encoder_t* _this, bgfx_index_buffer_handle_t _handle, uint32_t _firstIndex, uint32_t _numIndices); = enum {};

/// Set index buffer for draw primitive.
/// @param[in] _handle Dynamic index buffer.
/// @param[in] _firstIndex First index to render.
/// @param[in] _numIndices Number of indices to render.
fn bgfx_encoder_set_dynamic_index_buffer(bgfx_encoder_t* _this, bgfx_dynamic_index_buffer_handle_t _handle, uint32_t _firstIndex, uint32_t _numIndices); = enum {};

/// Set index buffer for draw primitive.
/// @param[in] _tib Transient index buffer.
/// @param[in] _firstIndex First index to render.
/// @param[in] _numIndices Number of indices to render.
fn bgfx_encoder_set_transient_index_buffer(bgfx_encoder_t* _this, const bgfx_transient_index_buffer_t* _tib, uint32_t _firstIndex, uint32_t _numIndices); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _handle Vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
fn bgfx_encoder_set_vertex_buffer(bgfx_encoder_t* _this, uint8_t _stream, bgfx_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _numVertices); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _handle Vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
/// @param[in] _layoutHandle Vertex layout for aliasing vertex buffer. If invalid
///  handle is used, vertex layout used for creation
///  of vertex buffer will be used.
fn bgfx_encoder_set_vertex_buffer_with_layout(bgfx_encoder_t* _this, uint8_t _stream, bgfx_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _numVertices, bgfx_vertex_layout_handle_t _layoutHandle); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _handle Dynamic vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
fn bgfx_encoder_set_dynamic_vertex_buffer(bgfx_encoder_t* _this, uint8_t _stream, bgfx_dynamic_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _numVertices); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _handle Dynamic vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
fn bgfx_encoder_set_dynamic_vertex_buffer_with_layout(bgfx_encoder_t* _this, uint8_t _stream, bgfx_dynamic_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _numVertices, bgfx_vertex_layout_handle_t _layoutHandle); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _tvb Transient vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
fn bgfx_encoder_set_transient_vertex_buffer(bgfx_encoder_t* _this, uint8_t _stream, const bgfx_transient_vertex_buffer_t* _tvb, uint32_t _startVertex, uint32_t _numVertices); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _tvb Transient vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
/// @param[in] _layoutHandle Vertex layout for aliasing vertex buffer. If invalid
///  handle is used, vertex layout used for creation
///  of vertex buffer will be used.
fn bgfx_encoder_set_transient_vertex_buffer_with_layout(bgfx_encoder_t* _this, uint8_t _stream, const bgfx_transient_vertex_buffer_t* _tvb, uint32_t _startVertex, uint32_t _numVertices, bgfx_vertex_layout_handle_t _layoutHandle); = enum {};

/// Set number of vertices for auto generated vertices use in conjuction
/// with gl_VertexID.
/// @attention Availability depends on: `BGFX_CAPS_VERTEX_ID`.
/// @param[in] _numVertices Number of vertices.
fn bgfx_encoder_set_vertex_count(bgfx_encoder_t* _this, uint32_t _numVertices); = enum {};

/// Set instance data buffer for draw primitive.
/// @param[in] _idb Transient instance data buffer.
/// @param[in] _start First instance data.
/// @param[in] _num Number of data instances.
fn bgfx_encoder_set_instance_data_buffer(bgfx_encoder_t* _this, const bgfx_instance_data_buffer_t* _idb, uint32_t _start, uint32_t _num); = enum {};

/// Set instance data buffer for draw primitive.
/// @param[in] _handle Vertex buffer.
/// @param[in] _startVertex First instance data.
/// @param[in] _num Number of data instances.
///  Set instance data buffer for draw primitive.
fn bgfx_encoder_set_instance_data_from_vertex_buffer(bgfx_encoder_t* _this, bgfx_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _num); = enum {};

/// Set instance data buffer for draw primitive.
/// @param[in] _handle Dynamic vertex buffer.
/// @param[in] _startVertex First instance data.
/// @param[in] _num Number of data instances.
fn bgfx_encoder_set_instance_data_from_dynamic_vertex_buffer(bgfx_encoder_t* _this, bgfx_dynamic_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _num); = enum {};

/// Set number of instances for auto generated instances use in conjuction
/// with gl_InstanceID.
/// @attention Availability depends on: `BGFX_CAPS_VERTEX_ID`.
/// @param[in] _numInstances
fn bgfx_encoder_set_instance_count(bgfx_encoder_t* _this, uint32_t _numInstances); = enum {};

/// Set texture stage for draw primitive.
/// @param[in] _stage Texture unit.
/// @param[in] _sampler Program sampler.
/// @param[in] _handle Texture handle.
/// @param[in] _flags Texture sampling mode. Default value UINT32_MAX uses
///    texture sampling settings from the texture.
///    - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
///      mode.
///    - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
///      sampling.
fn bgfx_encoder_set_texture(bgfx_encoder_t* _this, uint8_t _stage, bgfx_uniform_handle_t _sampler, bgfx_texture_handle_t _handle, uint32_t _flags); = enum {};

/// Submit an empty primitive for rendering. Uniforms and draw state
/// will be applied but no geometry will be submitted. Useful in cases
/// when no other draw/compute primitive is submitted to view, but it's
/// desired to execute clear view.
/// @remark
///   These empty draw calls will sort before ordinary draw calls.
/// @param[in] _id View id.
fn bgfx_encoder_touch(bgfx_encoder_t* _this, bgfx_view_id_t _id); = enum {};

/// Submit primitive for rendering.
/// @param[in] _id View id.
/// @param[in] _program Program.
/// @param[in] _depth Depth for sorting.
/// @param[in] _flags Discard or preserve states. See `BGFX_DISCARD_*`.
fn bgfx_encoder_submit(bgfx_encoder_t* _this, bgfx_view_id_t _id, bgfx_program_handle_t _program, uint32_t _depth, uint8_t _flags); = enum {};

/// Submit primitive with occlusion query for rendering.
/// @param[in] _id View id.
/// @param[in] _program Program.
/// @param[in] _occlusionQuery Occlusion query.
/// @param[in] _depth Depth for sorting.
/// @param[in] _flags Discard or preserve states. See `BGFX_DISCARD_*`.
fn bgfx_encoder_submit_occlusion_query(bgfx_encoder_t* _this, bgfx_view_id_t _id, bgfx_program_handle_t _program, bgfx_occlusion_query_handle_t _occlusionQuery, uint32_t _depth, uint8_t _flags); = enum {};

/// Submit primitive for rendering with index and instance data info from
/// indirect buffer.
/// @param[in] _id View id.
/// @param[in] _program Program.
/// @param[in] _indirectHandle Indirect buffer.
/// @param[in] _start First element in indirect buffer.
/// @param[in] _num Number of dispatches.
/// @param[in] _depth Depth for sorting.
/// @param[in] _flags Discard or preserve states. See `BGFX_DISCARD_*`.
fn bgfx_encoder_submit_indirect(bgfx_encoder_t* _this, bgfx_view_id_t _id, bgfx_program_handle_t _program, bgfx_indirect_buffer_handle_t _indirectHandle, uint16_t _start, uint16_t _num, uint32_t _depth, uint8_t _flags); = enum {};

/// Set compute index buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Index buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_encoder_set_compute_index_buffer(bgfx_encoder_t* _this, uint8_t _stage, bgfx_index_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute vertex buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Vertex buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_encoder_set_compute_vertex_buffer(bgfx_encoder_t* _this, uint8_t _stage, bgfx_vertex_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute dynamic index buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Dynamic index buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_encoder_set_compute_dynamic_index_buffer(bgfx_encoder_t* _this, uint8_t _stage, bgfx_dynamic_index_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute dynamic vertex buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Dynamic vertex buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_encoder_set_compute_dynamic_vertex_buffer(bgfx_encoder_t* _this, uint8_t _stage, bgfx_dynamic_vertex_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute indirect buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Indirect buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_encoder_set_compute_indirect_buffer(bgfx_encoder_t* _this, uint8_t _stage, bgfx_indirect_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute image from texture.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Texture handle.
/// @param[in] _mip Mip level.
/// @param[in] _access Image access. See `Access::Enum`.
/// @param[in] _format Texture format. See: `TextureFormat::Enum`.
fn bgfx_encoder_set_image(bgfx_encoder_t* _this, uint8_t _stage, bgfx_texture_handle_t _handle, uint8_t _mip, bgfx_access_t _access, bgfx_texture_format_t _format); = enum {};

/// Dispatch compute.
/// @param[in] _id View id.
/// @param[in] _program Compute program.
/// @param[in] _numX Number of groups X.
/// @param[in] _numY Number of groups Y.
/// @param[in] _numZ Number of groups Z.
/// @param[in] _flags Discard or preserve states. See `BGFX_DISCARD_*`.
fn bgfx_encoder_dispatch(bgfx_encoder_t* _this, bgfx_view_id_t _id, bgfx_program_handle_t _program, uint32_t _numX, uint32_t _numY, uint32_t _numZ, uint8_t _flags); = enum {};

/// Dispatch compute indirect.
/// @param[in] _id View id.
/// @param[in] _program Compute program.
/// @param[in] _indirectHandle Indirect buffer.
/// @param[in] _start First element in indirect buffer.
/// @param[in] _num Number of dispatches.
/// @param[in] _flags Discard or preserve states. See `BGFX_DISCARD_*`.
fn bgfx_encoder_dispatch_indirect(bgfx_encoder_t* _this, bgfx_view_id_t _id, bgfx_program_handle_t _program, bgfx_indirect_buffer_handle_t _indirectHandle, uint16_t _start, uint16_t _num, uint8_t _flags); = enum {};

/// Discard previously set state for draw or compute call.
/// @param[in] _flags Discard or preserve states. See `BGFX_DISCARD_*`.
fn bgfx_encoder_discard(bgfx_encoder_t* _this, uint8_t _flags); = enum {};

/// Blit 2D texture region between two 2D textures.
/// @attention Destination texture must be created with `BGFX_TEXTURE_BLIT_DST` flag.
/// @attention Availability depends on: `BGFX_CAPS_TEXTURE_BLIT`.
/// @param[in] _id View id.
/// @param[in] _dst Destination texture handle.
/// @param[in] _dstMip Destination texture mip level.
/// @param[in] _dstX Destination texture X position.
/// @param[in] _dstY Destination texture Y position.
/// @param[in] _dstZ If texture is 2D this argument should be 0. If destination texture is cube
///  this argument represents destination texture cube face. For 3D texture this argument
///  represents destination texture Z position.
/// @param[in] _src Source texture handle.
/// @param[in] _srcMip Source texture mip level.
/// @param[in] _srcX Source texture X position.
/// @param[in] _srcY Source texture Y position.
/// @param[in] _srcZ If texture is 2D this argument should be 0. If source texture is cube
///  this argument represents source texture cube face. For 3D texture this argument
///  represents source texture Z position.
/// @param[in] _width Width of region.
/// @param[in] _height Height of region.
/// @param[in] _depth If texture is 3D this argument represents depth of region, otherwise it's
///  unused.
fn bgfx_encoder_blit(bgfx_encoder_t* _this, bgfx_view_id_t _id, bgfx_texture_handle_t _dst, uint8_t _dstMip, uint16_t _dstX, uint16_t _dstY, uint16_t _dstZ, bgfx_texture_handle_t _src, uint8_t _srcMip, uint16_t _srcX, uint16_t _srcY, uint16_t _srcZ, uint16_t _width, uint16_t _height, uint16_t _depth); = enum {};

/// Request screen shot of window back buffer.
/// @remarks
///   `bgfx::CallbackI::screenShot` must be implemented.
/// @attention Frame buffer handle must be created with OS' target native window handle.
/// @param[in] _handle Frame buffer handle. If handle is `BGFX_INVALID_HANDLE` request will be
///  made for main window back buffer.
/// @param[in] _filePath Will be passed to `bgfx::CallbackI::screenShot` callback.
fn bgfx_request_screen_shot(bgfx_frame_buffer_handle_t _handle, const char* _filePath); = enum {};

/// Set platform data.
/// @warning Must be called before `bgfx::init`.
/// @param[in] _data Platform data.
fn bgfx_set_platform_data(const bgfx_platform_data_t * _data); = enum {};

/// Sets a debug marker. This allows you to group graphics calls together for easy browsing in
/// graphics debugging tools.
/// @param[in] _marker Marker string.
fn bgfx_set_marker(const char* _marker); = enum {};

/// Set render states for draw primitive.
/// @remarks
///   1. To setup more complex states use:
///      `BGFX_STATE_ALPHA_REF(_ref)`,
///      `BGFX_STATE_POINT_SIZE(_size)`,
///      `BGFX_STATE_BLEND_FUNC(_src, _dst)`,
///      `BGFX_STATE_BLEND_FUNC_SEPARATE(_srcRGB, _dstRGB, _srcA, _dstA)`,
///      `BGFX_STATE_BLEND_EQUATION(_equation)`,
///      `BGFX_STATE_BLEND_EQUATION_SEPARATE(_equationRGB, _equationA)`
///   2. `BGFX_STATE_BLEND_EQUATION_ADD` is set when no other blend
///      equation is specified.
/// @param[in] _state State flags. Default state for primitive type is
///    triangles. See: `BGFX_STATE_DEFAULT`.
///    - `BGFX_STATE_DEPTH_TEST_*` - Depth test function.
///    - `BGFX_STATE_BLEND_*` - See remark 1 about BGFX_STATE_BLEND_FUNC.
///    - `BGFX_STATE_BLEND_EQUATION_*` - See remark 2.
///    - `BGFX_STATE_CULL_*` - Backface culling mode.
///    - `BGFX_STATE_WRITE_*` - Enable R, G, B, A or Z write.
///    - `BGFX_STATE_MSAA` - Enable hardware multisample antialiasing.
///    - `BGFX_STATE_PT_[TRISTRIP/LINES/POINTS]` - Primitive type.
/// @param[in] _rgba Sets blend factor used by `BGFX_STATE_BLEND_FACTOR` and
///    `BGFX_STATE_BLEND_INV_FACTOR` blend modes.
fn bgfx_set_state(uint64_t _state, uint32_t _rgba); = enum {};

/// Set condition for rendering.
/// @param[in] _handle Occlusion query handle.
/// @param[in] _visible Render if occlusion query is visible.
fn bgfx_set_condition(bgfx_occlusion_query_handle_t _handle, bool _visible); = enum {};

/// Set stencil test state.
/// @param[in] _fstencil Front stencil state.
/// @param[in] _bstencil Back stencil state. If back is set to `BGFX_STENCIL_NONE`
///  _fstencil is applied to both front and back facing primitives.
fn bgfx_set_stencil(uint32_t _fstencil, uint32_t _bstencil); = enum {};

/// Set scissor from cache for draw primitive.
/// @remark
///   To scissor for all primitives in view see `bgfx::setViewScissor`.
/// @param[in] _cache Index in scissor cache.
fn bgfx_set_scissor_cached(uint16_t _cache); = enum {};

///  Set model matrix from matrix cache for draw primitive.
/// @param[in] _cache Index in matrix cache.
/// @param[in] _num Number of matrices from cache.
fn bgfx_set_transform_cached(uint32_t _cache, uint16_t _num); = enum {};

/// Set shader uniform parameter for draw primitive.
/// @param[in] _handle Uniform.
/// @param[in] _value Pointer to uniform data.
/// @param[in] _num Number of elements. Passing `UINT16_MAX` will
///  use the _num passed on uniform creation.
fn bgfx_set_uniform(bgfx_uniform_handle_t _handle, const void* _value, uint16_t _num); = enum {};

/// Set index buffer for draw primitive.
/// @param[in] _handle Index buffer.
/// @param[in] _firstIndex First index to render.
/// @param[in] _numIndices Number of indices to render.
fn bgfx_set_index_buffer(bgfx_index_buffer_handle_t _handle, uint32_t _firstIndex, uint32_t _numIndices); = enum {};

/// Set index buffer for draw primitive.
/// @param[in] _handle Dynamic index buffer.
/// @param[in] _firstIndex First index to render.
/// @param[in] _numIndices Number of indices to render.
fn bgfx_set_dynamic_index_buffer(bgfx_dynamic_index_buffer_handle_t _handle, uint32_t _firstIndex, uint32_t _numIndices); = enum {};

/// Set index buffer for draw primitive.
/// @param[in] _tib Transient index buffer.
/// @param[in] _firstIndex First index to render.
/// @param[in] _numIndices Number of indices to render.
fn bgfx_set_transient_index_buffer(const bgfx_transient_index_buffer_t* _tib, uint32_t _firstIndex, uint32_t _numIndices); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _handle Vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
fn bgfx_set_vertex_buffer(uint8_t _stream, bgfx_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _numVertices); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _handle Vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
/// @param[in] _layoutHandle Vertex layout for aliasing vertex buffer. If invalid
///  handle is used, vertex layout used for creation
///  of vertex buffer will be used.
fn bgfx_set_vertex_buffer_with_layout(uint8_t _stream, bgfx_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _numVertices, bgfx_vertex_layout_handle_t _layoutHandle); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _handle Dynamic vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
fn bgfx_set_dynamic_vertex_buffer(uint8_t _stream, bgfx_dynamic_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _numVertices); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _handle Dynamic vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
/// @param[in] _layoutHandle Vertex layout for aliasing vertex buffer. If invalid
///  handle is used, vertex layout used for creation
///  of vertex buffer will be used.
fn bgfx_set_dynamic_vertex_buffer_with_layout(uint8_t _stream, bgfx_dynamic_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _numVertices, bgfx_vertex_layout_handle_t _layoutHandle); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _tvb Transient vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
fn bgfx_set_transient_vertex_buffer(uint8_t _stream, const bgfx_transient_vertex_buffer_t* _tvb, uint32_t _startVertex, uint32_t _numVertices); = enum {};

/// Set vertex buffer for draw primitive.
/// @param[in] _stream Vertex stream.
/// @param[in] _tvb Transient vertex buffer.
/// @param[in] _startVertex First vertex to render.
/// @param[in] _numVertices Number of vertices to render.
/// @param[in] _layoutHandle Vertex layout for aliasing vertex buffer. If invalid
///  handle is used, vertex layout used for creation
///  of vertex buffer will be used.
fn bgfx_set_transient_vertex_buffer_with_layout(uint8_t _stream, const bgfx_transient_vertex_buffer_t* _tvb, uint32_t _startVertex, uint32_t _numVertices, bgfx_vertex_layout_handle_t _layoutHandle); = enum {};

/// Set number of vertices for auto generated vertices use in conjuction
/// with gl_VertexID.
/// @attention Availability depends on: `BGFX_CAPS_VERTEX_ID`.
/// @param[in] _numVertices Number of vertices.
fn bgfx_set_vertex_count(uint32_t _numVertices); = enum {};

/// Set instance data buffer for draw primitive.
/// @param[in] _idb Transient instance data buffer.
/// @param[in] _start First instance data.
/// @param[in] _num Number of data instances.
fn bgfx_set_instance_data_buffer(const bgfx_instance_data_buffer_t* _idb, uint32_t _start, uint32_t _num); = enum {};

/// Set instance data buffer for draw primitive.
/// @param[in] _handle Vertex buffer.
/// @param[in] _startVertex First instance data.
/// @param[in] _num Number of data instances.
///  Set instance data buffer for draw primitive.
fn bgfx_set_instance_data_from_vertex_buffer(bgfx_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _num); = enum {};

/// Set instance data buffer for draw primitive.
/// @param[in] _handle Dynamic vertex buffer.
/// @param[in] _startVertex First instance data.
/// @param[in] _num Number of data instances.
fn bgfx_set_instance_data_from_dynamic_vertex_buffer(bgfx_dynamic_vertex_buffer_handle_t _handle, uint32_t _startVertex, uint32_t _num); = enum {};

/// Set number of instances for auto generated instances use in conjuction
/// with gl_InstanceID.
/// @attention Availability depends on: `BGFX_CAPS_VERTEX_ID`.
/// @param[in] _numInstances
fn bgfx_set_instance_count(uint32_t _numInstances); = enum {};

/// Set texture stage for draw primitive.
/// @param[in] _stage Texture unit.
/// @param[in] _sampler Program sampler.
/// @param[in] _handle Texture handle.
/// @param[in] _flags Texture sampling mode. Default value UINT32_MAX uses
///    texture sampling settings from the texture.
///    - `BGFX_SAMPLER_[U/V/W]_[MIRROR/CLAMP]` - Mirror or clamp to edge wrap
///      mode.
///    - `BGFX_SAMPLER_[MIN/MAG/MIP]_[POINT/ANISOTROPIC]` - Point or anisotropic
///      sampling.
fn bgfx_set_texture(uint8_t _stage, bgfx_uniform_handle_t _sampler, bgfx_texture_handle_t _handle, uint32_t _flags); = enum {};

/// Submit an empty primitive for rendering. Uniforms and draw state
/// will be applied but no geometry will be submitted.
/// @remark
///   These empty draw calls will sort before ordinary draw calls.
/// @param[in] _id View id.
fn bgfx_touch(bgfx_view_id_t _id); = enum {};

/// Submit primitive for rendering.
/// @param[in] _id View id.
/// @param[in] _program Program.
/// @param[in] _depth Depth for sorting.
/// @param[in] _flags Which states to discard for next draw. See BGFX_DISCARD_
fn bgfx_submit(bgfx_view_id_t _id, bgfx_program_handle_t _program, uint32_t _depth, uint8_t _flags); = enum {};

/// Submit primitive with occlusion query for rendering.
/// @param[in] _id View id.
/// @param[in] _program Program.
/// @param[in] _occlusionQuery Occlusion query.
/// @param[in] _depth Depth for sorting.
/// @param[in] _flags Which states to discard for next draw. See BGFX_DISCARD_
fn bgfx_submit_occlusion_query(bgfx_view_id_t _id, bgfx_program_handle_t _program, bgfx_occlusion_query_handle_t _occlusionQuery, uint32_t _depth, uint8_t _flags); = enum {};

/// Submit primitive for rendering with index and instance data info from
/// indirect buffer.
/// @param[in] _id View id.
/// @param[in] _program Program.
/// @param[in] _indirectHandle Indirect buffer.
/// @param[in] _start First element in indirect buffer.
/// @param[in] _num Number of dispatches.
/// @param[in] _depth Depth for sorting.
/// @param[in] _flags Which states to discard for next draw. See BGFX_DISCARD_
fn bgfx_submit_indirect(bgfx_view_id_t _id, bgfx_program_handle_t _program, bgfx_indirect_buffer_handle_t _indirectHandle, uint16_t _start, uint16_t _num, uint32_t _depth, uint8_t _flags); = enum {};

/// Set compute index buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Index buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_set_compute_index_buffer(uint8_t _stage, bgfx_index_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute vertex buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Vertex buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_set_compute_vertex_buffer(uint8_t _stage, bgfx_vertex_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute dynamic index buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Dynamic index buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_set_compute_dynamic_index_buffer(uint8_t _stage, bgfx_dynamic_index_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute dynamic vertex buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Dynamic vertex buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_set_compute_dynamic_vertex_buffer(uint8_t _stage, bgfx_dynamic_vertex_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute indirect buffer.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Indirect buffer handle.
/// @param[in] _access Buffer access. See `Access::Enum`.
fn bgfx_set_compute_indirect_buffer(uint8_t _stage, bgfx_indirect_buffer_handle_t _handle, bgfx_access_t _access); = enum {};

/// Set compute image from texture.
/// @param[in] _stage Compute stage.
/// @param[in] _handle Texture handle.
/// @param[in] _mip Mip level.
/// @param[in] _access Image access. See `Access::Enum`.
/// @param[in] _format Texture format. See: `TextureFormat::Enum`.
fn bgfx_set_image(uint8_t _stage, bgfx_texture_handle_t _handle, uint8_t _mip, bgfx_access_t _access, bgfx_texture_format_t _format); = enum {};

/// Dispatch compute.
/// @param[in] _id View id.
/// @param[in] _program Compute program.
/// @param[in] _numX Number of groups X.
/// @param[in] _numY Number of groups Y.
/// @param[in] _numZ Number of groups Z.
/// @param[in] _flags Discard or preserve states. See `BGFX_DISCARD_*`.
fn bgfx_dispatch(bgfx_view_id_t _id, bgfx_program_handle_t _program, uint32_t _numX, uint32_t _numY, uint32_t _numZ, uint8_t _flags); = enum {};

/// Dispatch compute indirect.
/// @param[in] _id View id.
/// @param[in] _program Compute program.
/// @param[in] _indirectHandle Indirect buffer.
/// @param[in] _start First element in indirect buffer.
/// @param[in] _num Number of dispatches.
/// @param[in] _flags Discard or preserve states. See `BGFX_DISCARD_*`.
fn bgfx_dispatch_indirect(bgfx_view_id_t _id, bgfx_program_handle_t _program, bgfx_indirect_buffer_handle_t _indirectHandle, uint16_t _start, uint16_t _num, uint8_t _flags); = enum {};

/// Discard previously set state for draw or compute call.
/// @param[in] _flags Draw/compute states to discard.
fn bgfx_discard(uint8_t _flags); = enum {};

/// Blit 2D texture region between two 2D textures.
/// @attention Destination texture must be created with `BGFX_TEXTURE_BLIT_DST` flag.
/// @attention Availability depends on: `BGFX_CAPS_TEXTURE_BLIT`.
/// @param[in] _id View id.
/// @param[in] _dst Destination texture handle.
/// @param[in] _dstMip Destination texture mip level.
/// @param[in] _dstX Destination texture X position.
/// @param[in] _dstY Destination texture Y position.
/// @param[in] _dstZ If texture is 2D this argument should be 0. If destination texture is cube
///  this argument represents destination texture cube face. For 3D texture this argument
///  represents destination texture Z position.
/// @param[in] _src Source texture handle.
/// @param[in] _srcMip Source texture mip level.
/// @param[in] _srcX Source texture X position.
/// @param[in] _srcY Source texture Y position.
/// @param[in] _srcZ If texture is 2D this argument should be 0. If source texture is cube
///  this argument represents source texture cube face. For 3D texture this argument
///  represents source texture Z position.
/// @param[in] _width Width of region.
/// @param[in] _height Height of region.
/// @param[in] _depth If texture is 3D this argument represents depth of region, otherwise it's
///  unused.
fn bgfx_blit(bgfx_view_id_t _id, bgfx_texture_handle_t _dst, uint8_t _dstMip, uint16_t _dstX, uint16_t _dstY, uint16_t _dstZ, bgfx_texture_handle_t _src, uint8_t _srcMip, uint16_t _srcX, uint16_t _srcY, uint16_t _srcZ, uint16_t _width, uint16_t _height, uint16_t _depth); = enum {};
