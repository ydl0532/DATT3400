float t;

void setup() {
  size(800, 800);
  background(0);
  smooth(200);
}

void draw() {
  noStroke();
  fill(0, 50);
  rect(0, 0, width, height);
  translate(width / 2, height / 2);
  float p = sin(frameCount * 0.01) * 5.05;
  for (int j = 0; j < 8; j++) {
    rotate(TWO_PI * (j * 0.125));
    for (int i = 0; i < 800; i++) {
      float x = 100 * sin(p * t / 2) / pow(sin(t), 2);
      float y = 100 * cos(t) * pow(cos(p * t), 4);
      fill(255, 40);
      ellipse(x, y, 3, 3);
      t += 0.004 ;
      if (t >= 2) {
        t = -2;
      }
    }
  }
}
