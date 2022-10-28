shader_type canvas_item;

uniform vec3 color = vec3(0.8125f,0.88671875f,0.99609375f);
uniform int octaves = 4;

float rand(vec2 coord)
{
	return fract(sin(dot(coord, vec2(58,78)) * 1000.0f) * 1000.0f);
}

float noise(vec2 coord)
{
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i);
	float b = rand(i + vec2(1.0f, 0.0f));
	float c = rand(i + vec2(0.0f, 1.0f));
	float d = rand(i + vec2(1.0f, 1.0f));
	
	vec2 cubic = f * f * (3.0f - 2.0f * f);
	
	return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0f - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coord)
{
	float value = 0.0f;
	float scale = 0.5f;
	
	for (int i  = 0; i < octaves; i++)
	{
		value += noise(coord) * scale;
		coord *= 2.0f;
		scale *= 0.5f;
	}
	return value;
}

void fragment()
{
	vec2 coord = UV * 20.0f;
	
	vec2 motion = vec2(fbm(coord + vec2(TIME * -0.17f, TIME * 0.17f)));
	
	float final = fbm(coord + motion);
	
	COLOR = vec4(color, final);
}