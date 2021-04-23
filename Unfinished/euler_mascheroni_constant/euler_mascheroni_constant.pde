double total = 0;
int perFrame = 10000;
float n = 1;
boolean paused = false;


void setup() {
  size(600, 600);
  frameRate(10);
}


void draw() {
  background(0);
  if (!paused) {
    for (int i = 0; i < perFrame; i++) {
      total += 1/n;
      n++;
    }
  }
  
  
  if (keyPressed) {
    if (key == 'w') {
      perFrame++;
    }
    else if (key == 's') {
      perFrame--;
    }
    else if (key == 'p') {
      paused = !paused;
    }
  }
  
  text("n: " + n + "\ntotal: " + (total - log(n)) + "\nper frame: " + perFrame, 50, 50);
}
