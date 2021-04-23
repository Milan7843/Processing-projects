class Particle {
  PVector pos;
  PVector vel;
  float w;
  float c;
  boolean interactWithWalls = true;
  boolean interactWithGround = true;
  float r = 15;
  
  
  Particle(float sx, float sy, float svx, float svy, float weight) {
    pos = new PVector(sx, sy);
    vel = new PVector(svx, svy);
    w = weight;
    c = color(255);
  }
  
  void render() {
    noStroke();
    fill(c);
    circle(pos.x, pos.y, r*2);
  }
  
  void updatepos() {
    pos.add(new PVector(vel.x*timeScale, vel.y*timeScale));
  }
  
  void checkParticleCollision() {
    for (Particle p : particles) {
      if (p.pos != pos) {
        if (dist(p.pos.x, p.pos.y, pos.x, pos.y) - 2*r < 0) {
          PVector normal = new PVector((pos.x-p.pos.x)/2+random(-0.01, 0.01), (pos.y-p.pos.y)/2+random(-0.01, 0.01));
          vel = new PVector(normal.x, normal.y);
        }
      }
    }
  }
  
  void grav() {
    vel.y += 0.981*w;
    if (interactWithGround) {
      if (pos.y + r > groundY) {
        pos.y = groundY-r;
        vel.y = -vel.y*bounciness;
        print(pos.y+r + " " + groundY + "\n");
        if (vel.y > 0 && vel.y < 0.01) {
          //vel.y = 0;
        }
      }
    }
  }
}
