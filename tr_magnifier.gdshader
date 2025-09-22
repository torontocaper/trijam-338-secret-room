shader_type canvas_item;

/* Godot 4.5+: declare the screen sampler */
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

/* Lens params */
uniform float zoom = 2.0;

/* Set from script each frame */
uniform vec2 lens_center_uv = vec2(0.5, 0.5);    // screen UV [0..1]
uniform vec2 screen_size    = vec2(1152.0, 648.0);

/* Your 200px circle with ~13px frame */
uniform float outer_radius_px = 100.0;           // 200/2
uniform float frame_thickness_px = 13.0;

void fragment() {
    // 1) Always draw the frame texture so your ring is visible
    vec4 frame_col = texture(TEXTURE, UV);
    COLOR = frame_col;

    // 2) If inside the inner circle, overwrite with magnified screen
    float inner_radius_px = outer_radius_px - frame_thickness_px;

    vec2 frag_px   = SCREEN_UV * screen_size;
    vec2 center_px = lens_center_uv * screen_size;
    float d = distance(frag_px, center_px);

    if (d <= inner_radius_px) {
        vec2 dir       = frag_px - center_px;
        vec2 sample_px = center_px + dir / zoom;
        vec3 mag_rgb   = texture(SCREEN_TEXTURE, sample_px / screen_size).rgb;
        COLOR = vec4(mag_rgb, 1.0);  // overwrite inner area (opaque lens)
    }
}
