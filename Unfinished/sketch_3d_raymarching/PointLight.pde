class PointLight {
  PVector pos;
  float intensity;
  Sphere indicator;
  color c;
  
  PointLight(PVector pos_, float i, color c_) {
    intensity = i;
    pos = pos_;
    c = c_;
    //indicator = new Sphere(pos, 0.2, false);
  }
  
  PointLight(float x, float y, float z, float i, color c_) {
    intensity = i;
    pos = new PVector(x, y, z);
    c = c_;
    //indicator = new Sphere(pos, 0.2, false);
  }
  
}
