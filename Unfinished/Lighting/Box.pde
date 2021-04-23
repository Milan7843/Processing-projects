class Box {
  PVector pos;
  PVector s;
  Plane[] sides = new Plane[6];
  PVector[] planeNormals = {
    new PVector(0, 1, 0),  //  Bottom
    new PVector(0, 0, 1),  //  Side facing pos Z
    new PVector(0, 0, -1), //  Side facing neg Z
    new PVector(1, 0, 0),  //  Side facing pos X
    new PVector(-1, 0, 0), //  Side facing neg X
    new PVector(0, -1, 0), //  Top
  };
  
  //https://www.researchgate.net/profile/Sibi_Ss/publication/336769307/figure/download/fig1/AS:817410131099648@1571897170254/Cube-vertex-and-edge-indices.ppm (right Z-)
  
  /*
  PVector[] v = {
    new PVector(0, 0, 0),
    new PVector(0, 0, -s.z),
    new PVector(s.x, 0, -s.z),
    new PVector(s.x, 0, 0),
    new PVector(0, s.y, 0),
    new PVector(0, s.y, -s.z),
    new PVector(s.x, s.y, -s.z),
    new PVector(s.x, s.y, 0),
  };
  */
  PVector[] v = {
    new PVector(0, 0, 0),
    new PVector(0, 0, -1),
    new PVector(1, 0, -1),
    new PVector(1, 0, 0),
    new PVector(0, -1, 0),
    new PVector(0, -1, -1),
    new PVector(1, -1, -1),
    new PVector(1, -1, 0),
  };
  
  
  Box(PVector pos_, PVector size) {
    pos = pos_;
    s = size;
    calculateSize();
    calculatePlanes();
  }
  
  void calculateSize() {
    for (int i = 0; i < v.length; i++) {
      v[i] = new PVector(v[i].x*s.x, v[i].y*s.y, v[i].z*s.z);
    }
  }
  
  void calculatePlanes() {
    /*
    sides[0] = new Plane(new PVector(0, -1, 0), planeNormals[0], new PVector(1, 1)); //Bottom
    sides[1] = new Plane(new PVector(0, -1, 0), planeNormals[1], new PVector(1, 1)); //Side facing pos Z
    sides[2] = new Plane(new PVector(0, 0, 0), planeNormals[2], new PVector(1, 1)); //Side facing neg Z
    sides[3] = new Plane(new PVector(0, -1, 0), planeNormals[3], new PVector(1, 1)); //Side facing pos X
    sides[4] = new Plane(new PVector(0, 0, 0), planeNormals[4], new PVector(1, 1)); //Side facing neg X
    sides[5] = new Plane(new PVector(0, 0, 0), planeNormals[5], new PVector(1, 1)); //Top
    */
    sides[0] = new Plane(v[0], v[1], v[2], v[3], planeNormals[0]); //Bottom
    sides[1] = new Plane(v[0], v[3], v[7], v[4], planeNormals[1]); //Side facing pos Z
    sides[2] = new Plane(v[1], v[2], v[6], v[5], planeNormals[2]); //Side facing neg Z
    sides[3] = new Plane(v[2], v[3], v[7], v[6], planeNormals[3]); //Side facing pos X
    sides[4] = new Plane(v[0], v[1], v[5], v[4], planeNormals[4]); //Side facing neg X
    sides[5] = new Plane(v[4], v[5], v[6], v[7], planeNormals[5]); //Top
    
    
  }
  
  void render() {
    for(Plane p : sides) {
      p.render();
      p.showNormal();
    }
  }
}
