class Line {
  PVector pos1;
  PVector pos2;
  color clr = color(random(255), random(255), random(255));
  
  Line (float x1, float y1, float z1, float x2, float y2, float z2) {
    pos1 = new PVector(x1, y1, z1);
    pos2 = new PVector(x2, y2, z2);
  }
  
  Line (float x1, float y1, float z1, float x2, float y2, float z2, color c) {
    pos1 = new PVector(x1, y1, z1);
    pos2 = new PVector(x2, y2, z2);
    clr = c;
  }
}
