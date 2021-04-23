class Box {
  PVector pos;
  PVector size;
  color clr = color(random(255), random(255), random(255));
  
  Box (float x, float y, float z, float xl, float yl, float zl) {
    pos = new PVector(x, y, z);
    size = new PVector(xl, yl, zl);
  }
}
