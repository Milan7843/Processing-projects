PVector[] a = new PVector[60];

void setup() {
  size(600, 600);
  for (int i = 0; i < a.length; i++) {
    a[i] = new PVector(random(200, 400), random(200, 400));
  }
  frameRate(60);
}

void draw() {
  background(220);
  a[0] = new PVector(mouseX, mouseY);
  //for (int i = 0; i < a.length-1; i++) {
  //  a[i] = a[i+1];
  //}
  for (int i = a.length-1; i > 0; i--) {
    a[i] = a[i-1];
  }
  fill(0);
  for (int i = 0; i < a.length; i++) {
    circle(a[i].x, a[i].y, 20);
  }
}
