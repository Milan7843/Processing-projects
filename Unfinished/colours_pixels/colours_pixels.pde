PVector colour = new PVector(66, 150, 245);

color[] clrs = {
  color(colour.x, 0, 0),
  color(0, colour.y, 0),
  color(0, 0, colour.z)  
};

int c = 0;

void setup() {
  size(600, 600);
  for (int i = 0; i < width; i++) {
    stroke(clrs[c]);
    line(i, 0, i, height);
    if (i % 1 == 0) c++;
    if (c >= 3) {
      c = 0;
    }
  }
}
