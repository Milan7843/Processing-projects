class Ball extends Object {
  PVector com = new PVector(); // Center of mass
  PVector pos = new PVector();
  PVector vel = new PVector();
  float s = 10;
  float m = 1;
  boolean holding;
  PVector holdingPos;
  
  
  Ball (PVector _pos, float diameter) {
    pos = _pos;
    s = diameter;
  }
  
  void update() {
    if (!holding) {
      PVector f = new PVector();
      f.add(gravity.copy().mult(m));
      vel.add(f);
      pos.add(vel);
    }
    else {
      
    }
  }
  
  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    circle(0, 0, s);
    popMatrix();
  }
  
  void setHolding(boolean newValue, float hx, float hy) {
    holding = newValue;
    holdingPos = new PVector(hx-pos.x, hy-pos.y);
  }
  
  void setHolding(boolean newValue) {
    holding = newValue;
  }
  
  boolean pointOn(float px, float py) {
    return (sqrt(sq(px-pos.x) + sq(py-pos.y)) < s/2);
  }
}
