//==============================================================================
// Sine Wave Fragment Shader
//==============================================================================
#ifdef GL_ES
precision mediump float;
#endif
//==============================================================================
const float twoPi = 3.14159 * 2.;
//==============================================================================
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
//==============================================================================
const vec3 color = vec3(.0, .9, .7);
const float intensity = 4.1;
//==============================================================================
float band(vec2 pos, float amplitude, float frequency)
{
	float wave = ((1.0 - (cos(twoPi * 2.0 * pos.x + time))) * 0.5) * (amplitude * (sin(twoPi * frequency/3. * pos.x + time* 1.5) + sin(twoPi * frequency * pos.x + time * 1.3)) / 4.);
	float colourScaling = 0.001;
	float minValue = 0.001;
	float maxValue = 4.0;
	float wavePosition = clamp(abs(wave - pos.y + .5), 0.001, 2.) ; // cosine - pixel ycoord (0 < wavePosition < 1)
	float light = clamp(amplitude * frequency * colourScaling, minValue, maxValue) / wavePosition; // this worked on zero division. this was a hack
	return light * intensity;
}
//==============================================================================
void main(void)
{
	vec2 pos = (gl_FragCoord.xy / resolution.xy);
	float spectrum;
	spectrum += band(pos, .9, 1.);

	gl_FragColor = vec4(color * spectrum, 1.0);
}
//==============================================================================
