int am = 15;
float rot = 0;

void setup() {
  size(600, 600);
  background(230, 230, 255);
}

void draw() {
  
  for (int i = 0; i < am; i++) {
    Square();
  }
  rot += 1;
}

void Square(){
  fill(255);
  rect(200, 200, 20, 20);
  rotate(PI/rot);
}
