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
    
  }
  
  void update() {
    if (getInt("framesBetweenDispenses") == 0) {
      dispenseParticle();
    }
    else if (frame % getInt("framesBetweenDispenses") == 0) {
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
      float angle = random(getDual("angle").x, getDual("angle").y);
      angle = radians(angle);
      float force = random(getDual("force").x, getDual("force").y);
      particles.add(new Particle(pos.x, pos.y, cos(angle)*force, sin(angle)*force, 1, getFloat("drag"), random(getDual("size").x, getDual("size").y), color(random(getDual("minr").x, getDual("minr").y), 
      random(getDual("ming").x, getDual("ming").y), random(getDual("minb").x, getDual("minb").y)), getInt("particleLifetime"), getBool("fade"), getInt("fadeFrame")));
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
