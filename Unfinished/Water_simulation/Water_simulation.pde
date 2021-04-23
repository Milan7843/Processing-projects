ArrayList<Water> water = new ArrayList<Water>();

int brushSize = 10;

color backgroundColour = color(255);

void setup() {
  size(800, 800);
}

void draw() {
  background(backgroundColour);
  stroke(0);
  line(200, 600, 500, 700);
  loadPixels();
  if (mousePressed) {
    for (int y = -brushSize; y < brushSize; y++) {
      for (int x = -brushSize; x < brushSize; x++) {
        if (!pixelOccupied(x + mouseX, y + mouseY)) water.add(new Water(x + mouseX, y + mouseY));
      }
    }
  }
  for (Water w : water) {
    w.update();
    w.show();
  }
  
  print(water.size() + "\n");
}

boolean pixelOccupied(int x, int y) {
  int index = x + y * width;
  return (get(x, y) != backgroundColour);
}
