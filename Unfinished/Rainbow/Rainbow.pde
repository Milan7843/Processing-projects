float r = 255, g = 0, b = 0, x;
float frames;
void setup() {
 size(600, 600);
 frameRate(600);
}

void draw() {
  frames++;
  fill(0);
  rect(0, 0, width, height/3);
  textSize(50);
  fill(255);
  text(frames, 50, 100);
  stroke(r, g, b);
  if (g <= 255) {
    g+=2;
  }
  if (g >= 255) {
    r-=2;
  }
  if (r <= 0) {
    b+=2;
  }
  if (b >= 255) {
    g-=2;
  }
  if (g<=255 && b>=255) {
    g-=2;
  }
  line(x, 0, x, height);
  x+= 0.2;
}
