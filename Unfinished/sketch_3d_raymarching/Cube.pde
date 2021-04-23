class Cube {
  PVector pos;
  float size;
  color clr = color(random(255), random(255), random(255));
  color[] clrs = new color[6];
  PVector[] points = new PVector[6];
  
  PVector midPoint = new PVector(0, 0, 0.5f);
  
  boolean[] reflect = {
    true,
    false,
    false,
    false,
    false,
    false
  };
  
  PVector[] normal = {
    new PVector( 1, 0, 0),  //pos x
    new PVector(-1, 0, 0),  //neg x
    new PVector( 0, 1, 0),  //pos y
    new PVector( 0,-1, 0),  //neg y
    new PVector( 0, 0, 1),  //top
    new PVector( 0, 0,-1)   //bottom
  };
  
  Cube (float x, float y, float z, float s, boolean ref) {
    reflect[0] = ref;
    for (int i = 0; i < 6; i++) {
      clrs[i] = color(random(255), random(255), random(255));
    }
    midPoint.add(x, y, z);
    
    /*
    on spawn:
    forward = pos x
    left = pos y
    up = pos z
    Indices:
    0: towards pos x
    1: towards neg x
    2: towards pos y
    3: towards neg y
    4: top
    5: bottom
    */
    pos = new PVector(x, y, z);
    size = s/2;
    
    
    points[0] = new PVector(size/2 + pos.x, 0 + pos.y, 0 + pos.z);
    points[1] = new PVector(-size/2 + pos.x, 0 + pos.y, 0 + pos.z);
    points[2] = new PVector(0 + pos.x, size/2 + pos.y, 0 + pos.z);
    points[3] = new PVector(0 + pos.x, -size/2 + pos.y, 0 + pos.z);
    points[4] = new PVector(0 + pos.x, 0 + pos.y, size/2 + pos.z);
    points[5] = new PVector(0 + pos.x, 0 + pos.y, -size/2 + pos.z);
  }
}
