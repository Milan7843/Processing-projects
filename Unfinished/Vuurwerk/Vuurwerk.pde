//Firework firework = new Firework();
Firework firework = new Firework(1000);
void setup() {
  fullScreen();
  frameRate(1);
  
}

void draw() {
  background(15,0,40);
  
  firework.update();
  firework.show();
}
