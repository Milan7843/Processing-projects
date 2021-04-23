int radius = 200;
float x, y;

void setup() {
  size(600, 600);
}

void draw() {
  background(200, 200, 255);
  ellipse(300, 300, 2*radius, 2*radius);
  text(mouseX, 50, 50);
  line(300, 300, mouseX, mouseY);
  x = x+1;
  if(x > width) {
    x = 0;
  }
  if(mouseY > 300) {
    y = sqrt(sq(radius) - sq(x-300)) + 300;
  }
  else {
    y = 300-sqrt(sq(radius) - sq(x-300));
  }
  line(300, 300, x, 300);
  line(x, 0, x, height);
  line(300, 300, x, y);
}
