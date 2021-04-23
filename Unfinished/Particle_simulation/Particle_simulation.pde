ArrayList<Particle> particles = new ArrayList<Particle>();
float bounciness = 0.5; //0-1
float timeScale = 1;

float wallStartX, wallEndX;
float groundY = 550;

int frames;
int framesBetweenSpawns = 1;

void setup() {
  size(800, 600);
  
}

void draw() {
  background(200);
  if (frames%(int)(framesBetweenSpawns/timeScale) == 0) {
    particles.add(new Particle(width/2+random(-0.1, 0.1), 15+random(-0.1, 0.1), 0, 0, 1));
  }
  for (Particle p : particles) {
    p.grav();
  }
  for (Particle p : particles) {
    p.checkParticleCollision();
  }
  for (Particle p : particles) {
    p.updatepos();
  }
  for (Particle p : particles) {
    p.render();
  }
  frames++;
}
