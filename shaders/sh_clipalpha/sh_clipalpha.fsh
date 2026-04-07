varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vScreenPos;

uniform sampler2D u_alphaTex;

void main() 
{
    vec4 base_color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    float mask_alpha = texture2D(u_alphaTex, v_vScreenPos).a;
    base_color.a *= mask_alpha;
    gl_FragColor = base_color;
}
