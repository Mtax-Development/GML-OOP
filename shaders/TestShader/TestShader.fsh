varying vec2 v_vTexcoord;
varying vec4 v_vColor;

uniform float testFloat;
uniform int testInt;
uniform mat4 testMat4;
uniform sampler2D testSampler2D;

void main()
{
	vec2 samplerParse = vec2((v_vColor * texture2D(testSampler2D, v_vTexcoord)).xy);
	
	float alpha = 1.0;
	
	if ((testMat4[0][0] == 1.0) && (testMat4[1][0] == 0.0) && (testMat4[2][0] == 0.0)
	&& (testMat4[3][0] == 0.0) && (testMat4[0][1] == 0.0) && (testMat4[1][1] == 1.0)
	&& (testMat4[2][1] == 0.0) && (testMat4[3][1] == 0.0) && (testMat4[0][2] == 0.0)
	&& (testMat4[1][2] == 0.0) && (testMat4[2][2] == 1.0) && (testMat4[3][2] == 0.0)
	&& (testMat4[0][3] == 0.0) && (testMat4[1][3] == 0.0) && (testMat4[2][3] == 0.0)
	&& (testMat4[3][3] == 1.0))
	{
		alpha = 0.3;
	}
	
	vec4 v_vColor = vec4(testFloat, (0.1 * float(testInt)), (v_vColor.b - samplerParse.x), alpha);
    gl_FragColor = (v_vColor * texture2D(gm_BaseTexture, v_vTexcoord));
}

