//
//  draw a 10 Print style maze
//
//  inspiration: https://10print.org/
//

void line(
  vec2 inFragCoord,
  vec2 fromPoint,
  vec2 toPoint,
  float strokeThickness,
  vec4 strokeColor,
  inout vec4 outFragColor)
{
  float a = distance(fromPoint, inFragCoord);
  float b = distance(toPoint, inFragCoord);
  float c = distance(fromPoint, toPoint);

  // points outside the line segment
  if (a >= c || b >= c) { return; }

  float p = (a + b + c) * 0.5;

  float dist = 2.0 / c * sqrt(p * (p - a) * (p - b) * (p - c));

  if (dist < strokeThickness)
  {
    outFragColor = mix(outFragColor, strokeColor, 1.0 / max(1.0, dist*3.0));
  }
}

void mazeTile(
  vec2 inFragCoord,
  vec2 tileCoord,
  float tileSize,
  bool flip,
  float strokeThickness,
  vec4 strokeColor,
  inout vec4 outFragColor)
{
  vec2 from = tileCoord;
  vec2 to = vec2(tileCoord) + vec2(tileSize);
  
  if (flip) {
    from = vec2(tileCoord.x + tileSize, tileCoord.y);
    to = vec2(tileCoord.x, tileCoord.y + tileSize);
  }

  line(
    inFragCoord,
    from,
    to,
    strokeThickness,
    strokeColor,
    outFragColor);
}

// https://en.wikipedia.org/wiki/Linear_congruential_generator
int rand(int prev) {
  return (75 * prev + 74) % ((2 << 16) + 1);
}

int nthRand(int seed, int n)
{
  int result = seed;
  for (int i = 0; i < n; i++) {
    result = rand(result);
  }
  return result;
}

void mainImage( out vec4 outFragColor, in vec2 inFragCoord )
{
  float tileSize = 20.0;
  float strokeThickness = 3.0;
  vec4 strokeColor = vec4(1, 1, 1, 1);


  // tile coordinate space
  int x = int(inFragCoord.x / tileSize);
  int y = int(inFragCoord.y / tileSize);
  int width = int(iResolution.x / tileSize);
  int tileIndex = y * width + x;
  vec2 tileCoord = vec2(x, y) * tileSize;

  int randValue = nthRand(int(iTime / 1.0), tileIndex);
  bool flip = randValue % 2 == 0;

  mazeTile(
    inFragCoord,
    tileCoord,
    tileSize,
    flip,
    strokeThickness,
    strokeColor,
    outFragColor
  );
}
