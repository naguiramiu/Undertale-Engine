varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying float v_vWorldY;
uniform float u_y_limit;

void main() {
    if (v_vWorldY < u_y_limit) {
        discard; 
    }
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
}
