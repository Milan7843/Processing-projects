import queasycam.*;

PVector cp = new PVector(0, 0, 0);
PVector cr = new PVector(0, 0, 0);
QueasyCam cam;
float sensitivity = 5;
float camSpeed = .03;

PVector oldMousePos = new PVector(0, 0);

char[] inputKeys = {
  'w', // forward
  's', // backward
  'a', // left
  'd', // right
  ' ', // up
  'z', // down
};

/*
char fwdKey = 'w';
char bwdKey = 's';
char lftKey = 'a';
char rgtKey = 'd';
char upKey = ' ';
char dwnKey = 'z';
*/

boolean[] keys = new boolean[6];

Lamp[] lamp = new Lamp[2];

//Plane plane = new Plane(new PVector(0, 0, 0), new PVector(0, -0.5*sqrt(2), 0.5*sqrt(2)), new PVector(1, 1));
//Plane plane = new Plane(new PVector(0, 0, 0), new PVector(1, 0, 0), new PVector(1, 1));

Box box = new Box(new PVector(0, 0, 0), new PVector(1, 1, 1));

void setup() {
  size(800, 600, P3D);
  cam = new QueasyCam(this);
  cam.sensitivity = 0;
  cam.speed = 0;
}

void draw() {
  background(0);
  
  
  fill(255);
  //renderBox(0, 0, 0, 1, 1, 1);
  movement();
  
  box.render();
  /*
  lamp[0] = new Lamp(new PVector(-1, -1, 0), 255, 255, 0);
  lamp[1] = new Lamp(new PVector(1, -1, 0), 0, 0, 255);
  
  loadLamps();
  
  noStroke();
  box(1);
  //text("pos: " + cp + "\nrot: " + cr + "\n", 0, 20);
  */
  //int groundSize = 50;
  //fill(150);
  //noStroke();
  //beginShape();
  ////normal(1, 0, 0);
  //vertex(-groundSize, 0, -groundSize);
  //vertex(groundSize, 0, -groundSize);
  //vertex(groundSize, 0, groundSize);
  //vertex(-groundSize, 0, groundSize);
  //endShape();
  
}

void loadLamps() {
  for (int i = 0; i < lamp.length; i++) {
    lamp[i].loadIndicator();
  }
  for (int i = 0; i < lamp.length; i++) {
    lamp[i].loadLight();
  }
}

/*
void light(PVector pos, float r, float g, float b) {
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  noStroke();
  fill(r, g, b);
  sphere(0.1);
  pointLight(r, g, b, 0, 0, 0);
  translate(0, 0, 2);
  fill(255, 255, 0);
  popMatrix();
}
*/

PVector vectorAverage(PVector[] p) {
  float x, y, z;
  PVector mean = new PVector();
  for(PVector po : p) {
    mean.add(po);
  }
  return mean.div((float)p.length);
}


void movement() {
  if (keys[0]) {
    PVector mvnt = new PVector(cos(cr.y), sin(cr.x), sin(cr.y));
    cp.add(mvnt.normalize().mult(camSpeed));
  }
  if (keys[1]) {
    PVector mvnt = new PVector(cos(cr.y), sin(cr.x), sin(cr.y));
    cp.add(mvnt.normalize().mult(-camSpeed));
  }
  //left
  if (keys[2]) {
    cp.add(new PVector(sin(cr.y)*camSpeed, 0, -cos(cr.y)*camSpeed));
  }
  //right
  if (keys[3]) {
    cp.add(new PVector(-sin(cr.y)*camSpeed, 0, cos(cr.y)*camSpeed));
  } 
  // up
  if (keys[5]) {
    cp.add(new PVector(0, camSpeed, 0));
  }
  // down
  if (keys[4]) {
    cp.add(new PVector(0, -camSpeed, 0));
  }
  if (mousePressed) {
    cr.add(new PVector(mouseY-oldMousePos.y, mouseX-oldMousePos.x).mult(sensitivity*0.001));
    cr.x = constrain(cr.x, -PI/2, PI/2);
  }
  oldMousePos = new PVector(mouseX, mouseY);
  cam.tilt = cr.x;
  cam.pan = cr.y;
  cam.position = cp;
}

void keyPressed() {
  for (int i = 0; i < keys.length; i++) {
    if (key == inputKeys[i]) {
      keys[i] = true;
    }
  }
}

void keyReleased() {
  for (int i = 0; i < keys.length; i++) {
    if (key == inputKeys[i]) {
      keys[i] = false;
    }
  }
}

void renderBox(float x, float y, float z, float sx, float sy, float sz) {
  pushMatrix();
  translate(x - sx/2, y - sy/2, z - sz/2);
  box(sx, sy, sz);
  
  
  popMatrix();
}

//v1 - v2
PVector subtractVectors(PVector v1, PVector v2) {
  PVector toReturn = new PVector(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
  return toReturn;
}
//v1 + v2
PVector addVectors(PVector v1, PVector v2) {
  PVector toReturn = new PVector(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
  return toReturn;
}
