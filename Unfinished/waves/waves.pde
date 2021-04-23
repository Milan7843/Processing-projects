Source source1 = new Source();

void setup() {
  size(600, 600);
}

void draw() {
  //background(255/2.0);
  
  source1.update();
  loadPixels();
  color c = pixels[mouseX + mouseY*width];
  fill(c);
  rect(0, 0, 10, 10);
}
