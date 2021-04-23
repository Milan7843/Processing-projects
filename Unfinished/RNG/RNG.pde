float random = random(0, 3);
void Setup() {
  size(200, 200);
  //frameRate(1);
}

void draw() {
  //random = random(1, 4);
  background(200);
  textSize(30);
  text((int)random, 50, 50);
}
void mousePressed() {
  random = random(1, 4);
}
