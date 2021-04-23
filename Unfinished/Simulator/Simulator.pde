int ballAmount = 1;
float gravity = 9.81/60;
float throwStrength = 10;
//Ball:
//x, y, size, weight, bounce
//weight in kilogrammes
//bounce in percentage

Ball[] b = new Ball[ballAmount];
void setup() {
  fullScreen();
  frameRate(60);
  b[0] = new Ball(300, 300, 100, 10, 100);
}

void draw() {
  background(3, 173, 252);
  for (int i = 0; i < ballAmount; i++) {
    b[i].update();
    b[i].show();
  }
  
}

void mouseDragged() {
  for (int i = 0; i < ballAmount; i++) {
    b[i].mousedrag();
  }
  
}
void mouseReleased() {
  for (int i = 0; i < ballAmount; i++) {
    b[i].stoppedholding();
  }
  
}
