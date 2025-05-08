shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
		vec4 tex = texture(TEXTURE, UV);
		tex.rgb = vec3(tex.r, tex.g, tex.b)/5.0;
		COLOR = tex;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
