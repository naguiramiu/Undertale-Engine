//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour;
	
	gl_FragColor.a *= texture2D( gm_BaseTexture, v_vTexcoord ).a;
	if (gl_FragColor.a == 0.0)
	{
		discard;	
	}
}
