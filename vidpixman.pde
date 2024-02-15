import processing.video.*;

Capture vid;
Ball[] balls = new Ball[10000];
PImage img;

void setup() {
  size(400, 400);
  vid = new Capture(this, 400, 400);
  vid.start();
  noStroke();
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  if (vid.available()) {
    vid.read();
  }
  vid.loadPixels();
  background(50, 70);
  for (Ball b : balls) {
    b.update();
    b.show();
  }
}

class Ball {
  float x, y, vel;

  Ball() {
    x = random(10, 390);
    y = 390;
    vel = random(1, 5);
  }

  void update() {
    y += random(-1, 1) - vel;
    x += random(-1, 1);
    if (y < 0) {
      x = random(10, 390);
      y = 390;
      vel = random(1, 5);
    }
  }

  void show() {
    color cov = vid.get(int(x), int(y));
    float g = (red(cov) + green(cov) + blue(cov)) / 3;
    fill(g, 1.5 * alpha(cov));
    circle(x, y, random(5, 10));
  }
}
