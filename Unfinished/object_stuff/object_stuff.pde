PVector gravity = new PVector(0, 0.02);

Object[] objects = {
  new Ball(new PVector(300, 300), 50)
};

float groundLevel = 590;

void setup() {
  size(600,600);
}

void draw() {
  background(200);
  objects[0].update();
  objects[0].show();
}

/*
void mousePressed() {
  for (Object obj : objects) {
    if (obj.pointOn(mouseX, mouseY)) {
      obj.setHolding(true);
    }
  }
}
*/
