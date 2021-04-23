class Plane {
  float px, py, pz, plx, plz;
  PVector a_ = new PVector(px, py, pz);
  //PVector[] a = {new PVector(0, 0, 0), new PVector(2, 0, 0), new PVector(0, 2, 0), new PVector(0, 0, 2)};
  PVector[] a = new PVector[8];
  PVector[] screenLoc = new PVector[4];
  
  Plane(float x_, float y_, float z_, float lx_, float lz_) {
    px = x_;
    py = y_;
    pz = z_;
    plx = lx_;
    plz = lz_;
    a = toPlane(a_, plx, plz);
  }
  void render() {
    screenLoc = calculatePoints(4, a, true);
    for (int i = 1; i < 4; i++) {
      line(screenLoc[0].x, screenLoc[0].y, screenLoc[i].x, screenLoc[i].y);
    }
    fillShape(screenLoc, 0, 3, 255);
  }
  
  PVector[] toPlane(PVector start, float lx, float lz) {
    PVector[] vectors = new PVector[8];
    for (int i = 0; i < 8; i++) {
      vectors[i] = new PVector();
    }
    vectors[0] = start;
    vectors[1] = new PVector(lx + start.x, 0 + start.y, 0 + start.z);
    vectors[2] = new PVector(lx + start.x, 0 + start.y, lz + start.z);
    vectors[3] = new PVector(0 + start.x, 0 + start.y, lz + start.z);
    return vectors;
  }
}
