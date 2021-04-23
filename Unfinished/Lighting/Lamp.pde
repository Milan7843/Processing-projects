class Lamp {
  PVector pos;
  float r, g, b;
  
  Lamp(PVector pos_, float r_, float g_, float b_) {
    r = r_;
    g = g_;
    b = b_;
    pos = pos_;
  }
  
  void loadIndicator() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    noStroke();
    fill(r, g, b);
    sphere(0.1);
    popMatrix();
  }
  
  void loadLight() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    pointLight(r, g, b, 0, 0, 0);
    popMatrix();
  }
  
}
