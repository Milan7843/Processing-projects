class Cube {
  float px, py, pz, pl;
  PVector a_ = new PVector(px, py, pz);
  PVector[] a = new PVector[8];
  PVector[] screenLoc = new PVector[8];
  int[] mainPoints = {0, 2, 5, 7};
  int[] auxPoints = {1,3,4, 1,3,6, 1,4,6, 3,4,6};
  Cube(float x_, float y_, float z_, float l_) {
    px = x_;
    py = y_;
    pz = z_;
    pl = l_;
    a_ = new PVector(px, py, pz);
    a = toCube(a_, pl);
  }
  
  
  
  void render() {
    screenLoc = calculatePoints(8, a, true);
    for (int i = 0; i < 7; i++) {
      //line(screenLoc[0].x, screenLoc[i].y, screenLoc[i+1].x, screenLoc[i+1].y);
    }
    for (int m = 0; m < 4; m++) {
      for (int a = 0; a < 3; a++) {
        screenLocLine(mainPoints[m], auxPoints[a+m*3]);
      }
    }
    //screenLocLine(2, 4);
    /*
    0-1,3,4
    2-1,3,6
    5-1,4,6
    7-3,4,6
    */
  }
  
  void screenLocLine(int i1, int i2) {
    line(screenLoc[i1].x, screenLoc[i1].y, screenLoc[i2].x, screenLoc[i2].y);
  }
  
  void move(PVector mvmnt) {
    a_ = new PVector(a_.x+mvmnt.x, a_.y+mvmnt.y, a_.z+mvmnt.z);
    a = toCube(a_, pl);
  }
  
  PVector[] toCube(PVector start, float l) {
    PVector[] vectors = new PVector[8];
    for (int i = 0; i < 8; i++) {
      vectors[i] = new PVector();
    }
    vectors[0] = start;
    vectors[1] = new PVector(l + start.x, 0 + start.y, 0 + start.z);
    vectors[2] = new PVector(l + start.x, 0 + start.y, -l + start.z);
    vectors[3] = new PVector(0 + start.x, 0 + start.y, -l + start.z);
    vectors[4] = new PVector(0 + start.x, -l + start.y, 0 + start.z);
    vectors[5] = new PVector(l + start.x, -l + start.y, 0 + start.z);
    vectors[6] = new PVector(l + start.x, -l + start.y, -l + start.z);
    vectors[7] = new PVector(0 + start.x, -l + start.y, -l + start.z);
    return vectors;
  }
}
