float rectX = 200;
float rectY = 200;

void setup() {
  size(500, 500);
}

void draw() {
  float zonGrootte = 150 + mouseY * 0.15;
  background(255 - mouseY * 0.6);
  fill(255, 255 - mouseY * 0.4, 0);
  ellipse(250, mouseY, zonGrootte, zonGrootte);
  fill(0, 50, 255);
  rect(0,300, 500, 200);
}
