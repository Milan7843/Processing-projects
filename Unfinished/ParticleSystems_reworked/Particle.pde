class Particle {
  PVector pos;
  PVector vel;
  color colour = color(0);
  float weight;
  float drag;
  float size;
  float totalLifeTime;
  float lifeTime;
  
  //Fading
  boolean fade;
  int fadeFrame;
  
  Particle(float x, float y, float vx, float vy, float w, float d, float s, color c, float totLifeTime, boolean fadeEnabled, int fadeAfterFrame) {
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    colour = c;
    weight = w;
    size = s;
    drag = d;
    totalLifeTime = totLifeTime;
    
    fade = fadeEnabled;
    fadeFrame = fadeAfterFrame;
  }
  
  void update() {
    updateVel();
    updatePos();
    render();
    lifeTime++;
  }
  
  void updateVel() {
    vel.y += getFloat("gravity")*weight*0.01;
    vel.y -= drag*vel.y;
    vel.x -= drag*vel.x;
  }
  
  void updatePos() {
    pos.add(vel);
    //Hitting the ground
    if (getBool("groundcoll")) {
      if (pos.y > groundY ) {
        pos.y = groundY;
        vel.y = -vel.y*random(0.4, 1);
        vel.x = 0.5*vel.x;
      }
    }
  }
  
  void render() {
    noStroke();
    fill(colour, (fade) ? map(lifeTime, fadeFrame, totalLifeTime, 255, 0) : 255);
    circle(pos.x, pos.y, size);
  }
  
  float getLifeTimeLeft() {
    return totalLifeTime-lifeTime;
  }
}
