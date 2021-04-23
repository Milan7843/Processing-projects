class ParticleSystem {
  PVector pos;
  
  
  /* OLDER VARIABLES
  int framesBetweenDispense;
  int amountPerDispense;
  float minForce, maxForce;
  int particleLifeTime;
  float minAngle, maxAngle;
  float minColour = 50;
  
  float minSize, maxSize;
  
  //Fading
  boolean fade;
  float fadeFrame;
  */
  
  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  ParticleSystem(int x, int y, int f, int a, float mnForce, float mxForce, int lifeTime, float mnAngle, float mxAngle, float mnSize, float mxSize, boolean fadeEnabled, float fadeAfterFrame, float drag) {
    pos = new PVector(x, y);
    intData[0] = f;
    intData[1] = a;
    intData[2] = lifeTime;
    floatData[0] = fadeAfterFrame;
    dualFloatData[0].x = mnForce;
    dualFloatData[0].y = mxForce;
    dualFloatData[1].x = mnAngle;
    dualFloatData[1].y = mxAngle;
    dualFloatData[2].x = mnSize;
    dualFloatData[2].y = mxSize;
    booleanData[0] = fadeEnabled;
    floatData[2] = drag;
  }
  
  void update() {
    if (intData[0] == 0) {
      dispenseParticle();
    }
    else if (frame % intData[0] == 0) {
      dispenseParticle();
    }
    //Updating particles
    for (int i = particles.size() - 1; i >= 0; i--) {
      particles.get(i).update();
      if (particles.get(i).getLifeTimeLeft() < 0) {
        particles.remove(i);
      }
    }
  }
  
  void dispenseParticle() {
    for (int i = 0; i < intData[1]; i++) {
      float angle = random(dualFloatData[1].x, dualFloatData[1].y);
      angle = radians(angle);
      float force = random(dualFloatData[0].x, dualFloatData[0].y);
      particles.add(new Particle(pos.x, pos.y, cos(angle)*force, sin(angle)*force, 1, floatData[2], random(dualFloatData[2].x, dualFloatData[2].y), color(random(dualFloatData[3].x, dualFloatData[3].y), 
      random(dualFloatData[4].x, dualFloatData[4].y), random(dualFloatData[5].x, dualFloatData[5].y)), intData[2], booleanData[0], floatData[0]));
    }
  }
  
  
  /*
  Particle[] particle;
  boolean[] slotTaken;
  int maxParticles;
  
  ParticleSystem(int x, int y, int maxPart, int f, int a) {
    pos = new PVector(x, y);
    intData[0] = f;
    intData[1] = a;
    slotFree = new boolean[maxPart];
  }
  
  void update() {
    if (intData[0] != 0) {
      dispenseParticle();
    }
    else if (frame % intData[0] == 0) {
      dispenseParticle();
    }
    else {
      for (int i = 0; i < maxParticles; i++) {
        
      }
    }
  }
  
  void dispenseParticle() {
    particle[giveSlot()] = new Particle();
  }
  
  int giveSlot() {
    int leastIndex;
    int leastLifetime;
    for (int i = 0; i < maxParticles; i++) {
      if (!slotTaken[i]) {
        return i;
        //break;
      }
    }
    //Array is full
    print("Particle system max amount filled up, ");
    for (int i = 0; i < maxParticles; i++) {
      if (particle[i].getLifeTimeLeft) {
        
      }
    }
  }
  */
}
