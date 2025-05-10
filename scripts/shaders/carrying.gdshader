shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform vec4 color: source_color = vec4(1.0);
uniform float intensity: hint_range(0.0, 1.0, 0.1) = 0;
void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	tex.rgb = mix(tex.rgb, color.rgb, intensity);

	COLOR = tex;

	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
