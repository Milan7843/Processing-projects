int t = 0;
int ms = 0;
int s = 0;
int m = 0;
int h = 0;
float speed = 1;

void setup() {
  size(600, 600);
}

void draw() {
  speed = sq(mouseX / 10);
  background(255);
  t += 1000/frameRate * speed;
  ms = t % 1000;
  s = floor(t / 1000) % 60;
  m = floor(t / 1000) / 60 % 60;
  h = floor(t / 1000) / 3600 % 24;
  fill(0);
  textSize(100);
  text(h + ":" + m + ":" +s + "." +ms, 10, 300);
}
