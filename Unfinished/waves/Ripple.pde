class Ripple {
  float r;
  float c;
  float speed = 1;
  float lifetime = 0;
  PVector pos;
  
  
  Ripple(PVector p) {
    pos = p;
  }
  
  void update() {
    r += speed;
    stroke(255/2, sin(lifetime) * 255f);
    print(sin(lifetime) + "\n");
    noFill();
    circle(pos.x, pos.y, r);
    lifetime += 0.01;
  }
}
