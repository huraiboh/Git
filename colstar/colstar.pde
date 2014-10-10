Ball[] ball = new Ball[50];

void setup() {
  size(640, 480);
  for (int i=0; i<ball.length; i++) {
    ball[i]=new Ball(i);
  }
}

void draw() {
  background(0);
  for (int i=0; i<ball.length; i++) {
    ball[i].move();
    ball[i].disp();
  }
}

