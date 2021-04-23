Color c = new Color();
float w = 1;
void setup() {
  size(600, 200);
  for (float x = 0; x < width; x += w) {
    if (w == 1) {
      stroke(c.getColor(x/(float)width));
      line(x, 0, x, height);
    }
    else {
      noStroke();
      fill(c.getColor(x/(float)width));
      rect(x, 0, w, height);
    }
  }
}
