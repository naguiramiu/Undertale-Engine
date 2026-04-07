varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_texel_size; 
uniform vec4 u_outline_color;

void main()
{
    vec4 base_color = texture2D(gm_BaseTexture, v_vTexcoord);
    float alpha = base_color.a + texture2D(gm_BaseTexture, v_vTexcoord + vec2(u_texel_size.x, 0.0)).a + texture2D(gm_BaseTexture, v_vTexcoord - vec2(u_texel_size.x, 0.0)).a + texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, u_texel_size.y)).a + texture2D(gm_BaseTexture, v_vTexcoord - vec2(0.0, u_texel_size.y)).a;
	
	gl_FragColor = ((base_color.a < 0.1 && alpha > 0.1) ? u_outline_color : v_vColour * base_color);
}
