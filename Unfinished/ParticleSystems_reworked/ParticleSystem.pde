class ParticleSystem {
  PVector pos;
  
  float framePause;
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
    
    findSetting("framesBetweenDispenses").intValue = f;
    findSetting("particlesPerDispense").intValue = a;
    findSetting("particleLifetime").intValue = lifeTime;
    findSetting("fadeFrame").floatValue = fadeAfterFrame;
    findSetting("drag").floatValue = drag;
    findSetting("force").dualValue.x = mnForce;
    findSetting("force").dualValue.y = mxForce;
    findSetting("angle").dualValue.x = mnAngle;
    findSetting("angle").dualValue.y = mxAngle;
    findSetting("size").dualValue.x = mnSize;
    findSetting("size").dualValue.y = mxSize;
    findSetting("fade").boolValue = fadeEnabled;
    framePause = (int)getRandomDual("framesBetweenDispenses");
  }
  
  void update() {
    if (framePause == 0) {
      dispenseParticle();
    }
    else if (frame % framePause == 0) {
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
    for (int i = 0; i < getInt("particlesPerDispense"); i++) {
      float angle = getRandomDual("angle");
      angle = radians(angle);
      float force = getRandomDual("force");
      particles.add(new Particle(pos.x, pos.y, cos(angle)*force, sin(angle)*force, 1, getFloat("drag"), getRandomDual("size"), color(getRandomDual("minr"), 
      getRandomDual("ming"), getRandomDual("minb")), getRandomDual("particleLifetime"), getBool("fade"), getInt("fadeFrame")));
    }
    framePause = (int)getRandomDual("framesBetweenDispenses");
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
