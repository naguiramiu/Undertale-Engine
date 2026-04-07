varying vec2 v_vWorldPos; 
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 u_rect_center;
uniform vec2 u_rect_size; 
uniform float u_rect_angle;

void main() 
{
    vec2 rel_pos = v_vWorldPos - u_rect_center;
    float cos_a = cos(-u_rect_angle);
    float sin_a = sin(-u_rect_angle);
    vec2 rotated_pos;
    rotated_pos.x = rel_pos.x * cos_a - rel_pos.y * sin_a;
    rotated_pos.y = rel_pos.x * sin_a + rel_pos.y * cos_a;
    vec2 half_size = u_rect_size * 0.5;
    
    if (abs(rotated_pos.x) < half_size.x && abs(rotated_pos.y) < half_size.y) 
	{
		gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    }
	else 
	{
		discard;
	}
}
