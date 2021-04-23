class Plane {
  PVector pos;
  PVector n;
  float h;
  float a, b, c, d, s;
  color[] clr = {color(random(255), random(255), random(255)), color(random(255), random(255), random(255))};
  boolean reflective;
  boolean isGround;
  
  PVector[] points = new PVector[4];
  //(x1, y1, z1) and a plane a * x + b * y + c * z + d = 0
  
  Plane (float x, float y, float z, float nx, float ny, float nz, float h_, float s_, boolean reflective_, boolean groundplane) {
    pos = new PVector(x, y, z);
    n = new PVector(nx, ny, nz).normalize();
    h = h_;
    s = s_;
    reflective = reflective_;
    points[0] = new PVector(pos.x - s/2, pos.y - s/2, z);
    /*
    points[1] = new PVector(n.z, n.y, -n.x).add(pos);
    points[3] = new PVector(n.x, -n.z, n.y).add(pos);
    points[2] = new PVector(n.z, n.x, n.y).add(pos);
    */
    points[1] = new PVector(pos.x + s/2, pos.y - s/2, z);
    points[2] = new PVector(pos.x + s/2, pos.y + s/2, z);
    points[3] = new PVector(pos.x - s/2, pos.y + s/2, z);
    print("\n");
    //print(points);
    isGround = groundplane;
  }
  
  
  /*
  Plane (float x, float y, float z, float a_, float b_, float c_, float d_) {
    pos = new PVector(x, y, z);
    a = a_;
    b = b_;
    c = c_;
    d = d_;
  }
  */
}
