shader_type canvas_item;
uniform vec4 color : source_color = vec4(1,1,1,1);
uniform float frequency = 0.5f;
uniform float speed = 1.0f;
varying vec2 pos;

void vertex() {
	// Called for every vertex the material is visible on.
	pos = VERTEX;
}

void fragment() {
	// Called for every pixel the material is visible on.
	float wave = sin(pos.x * frequency - TIME * speed) * 0.5 + 0.5;
	float dashed = step(0.5, wave);
	
	if (dashed >= 0.5) {
		COLOR = color;
	}
	else {
		COLOR = vec4(1,1,1,0);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
