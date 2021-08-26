//
//  draws some circles
//

vec4 red = vec4(1, 0, 0, 1);
vec4 green = vec4(0, 1, 0, 1);
vec4 blue = vec4(0, 0, 1, 1);


void circle(
  vec2 inFragCoord,
  vec2 center,
  float radius,
  float strokeThickness,
  vec4 strokeColor,
  inout vec4 outFragColor)
{
  float dist = distance(inFragCoord, center);

  if (dist > radius || dist < radius - strokeThickness) {
    return;
  }

  outFragColor = strokeColor;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  float aspectRatio = iResolution.x / iResolution.y;
  vec2 frag = fragCoord / iResolution.y;

  circle(frag,
    vec2(0.3 * aspectRatio, 0.5),
    0.3 * mod(iTime, 1.0),
    0.02,
    red,
    fragColor);

  circle(frag,
    vec2(0.5 * aspectRatio, mix(0.1, 0.9, abs(sin(iTime)))),
    0.3,
    0.02,
    green,
    fragColor);

  circle(frag,
    vec2(0.7 * aspectRatio, 0.5),
    0.3,
    0.02,
    blue,
    fragColor);
}
