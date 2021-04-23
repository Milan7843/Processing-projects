class Sphere {
  PVector pos;
  float radius;
  color clr = color(random(255), random(255), random(255));
  boolean reflective;
  
  
  Sphere (float x, float y, float z, float r, boolean ref) {
    pos = new PVector(x, y, z);
    radius = r;
    reflective = ref;
  }
  
  Sphere (PVector pos_, float r, boolean ref) {
    pos = new PVector(pos_.x, pos_.y, pos_.z);
    radius = r;
    reflective = ref;
  }
  Sphere (PVector pos_, float r, color c) {
    pos = new PVector(pos_.x, pos_.y, pos_.z);
    radius = r;
    clr = c;
  }
  Sphere (float x, float y, float z, float r, color c) {
    pos = new PVector(x, y, z);
    radius = r;
    clr = c;
  }
}
