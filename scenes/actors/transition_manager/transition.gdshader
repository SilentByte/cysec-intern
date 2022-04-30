shader_type canvas_item;

uniform float transition_delta : hint_range(0.0, 1.0);
uniform sampler2D transition_texture;

void fragment(){
	COLOR = texture(TEXTURE, UV);
	float tt = texture(transition_texture, UV).r;
	COLOR.a *= step(transition_delta, tt);
//	COLOR = tt;
//	COLOR.a = 1.0 - transition_delta;
}
