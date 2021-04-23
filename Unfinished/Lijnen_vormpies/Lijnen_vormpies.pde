int n = 100;
int side = 15;
PVector[] p = new PVector[n];
float circleSize = 300;
PVector in = new PVector(300, 300);
float[] dir = new float[2];

void setup() {
  size(600, 600);
  for (int i = 0; i < n; i++) {
    p[i] = new PVector(0, 0);
  } 
}

void draw() {
  background(230);
  for (int i = 0; i < n; i++) {
    p[i].x = in.x + cos(2*PI/n*i) * circleSize;
    p[i].y = in.y + sin(2*PI/n*i) * circleSize;
    fill(0);
    circle(p[i].x, p[i].y, 2);
  }
  connectingLines();
  side = mouseX/10;
  if (mouseY/10 < 50) {
    n = mouseY/10;
    if (side >= n) side = n-1;
  }
  println("side " + side);
  println("n " + n);
  
}

void connectingLines() {
  for (int i = 0; i < n; i++) {
    for (int m = 0; m < side; m++) {
      if (i-m >= 0) line(p[i].x, p[i].y, p[i-m].x, p[i-m].y);
      else line(p[i].x, p[i].y, p[n+(i-m)].x, p[n+(i-m)].y);
    }
  }
}
