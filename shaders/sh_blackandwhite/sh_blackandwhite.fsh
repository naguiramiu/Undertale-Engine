varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord );
	
	float luminosity = gl_FragColor.r + gl_FragColor.g + gl_FragColor.b;
		
	if ((luminosity / 3.0) > 0.5) 
		gl_FragColor = vec4(1.0,1.0,1.0,gl_FragColor.a);
	else 
		gl_FragColor = vec4(0.0,0.0,0.0,gl_FragColor.a);
}