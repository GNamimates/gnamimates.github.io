shader_type spatial;
render_mode unshaded;

uniform vec4 highlight : hint_color;

void fragment() {
	ALBEDO = highlight.rgb;
	ALPHA = highlight.a;
}