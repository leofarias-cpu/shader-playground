shader_type canvas_item;

uniform vec3 color: source_color;
uniform float radius: hint_range(0, 0.5) = 0.2;
uniform float softness: hint_range(0, 0.5) = 0.01;
uniform float border_width: hint_range(0, 0.5) = 0.2;
uniform vec3 border_color: source_color;

uniform float breathing_strenght: hint_range(0, 0.2) = 0.1;
uniform float breathing_frequency: hint_range(0, 10, 0.05) = 1.0;

void fragment() {
	float oscilation = 
		sin(TIME + UV.x * 10.0 + UV.y * 6.0) * breathing_strenght;

	float distancia = distance(vec2(0.5, 0.5), UV) + oscilation;
	float outside_radius = radius + border_width;
	
	float inner_mask = smoothstep(radius, radius - softness, distancia);
	float outer_mask = smoothstep(outside_radius, outside_radius - softness, distancia);
	float ring_mask = outer_mask - inner_mask;
	
	vec3 final_color = ring_mask * border_color + inner_mask * color;
	COLOR = vec4(final_color, outer_mask);
}
