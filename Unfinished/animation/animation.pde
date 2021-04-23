import queasycam.*;

float freecamSpeed = 0.6;
float freecamSensitivity = 0.3;
float freecamDistanceFromPlane = 15;
boolean invertPitch = false;

//Camera
QueasyCam cam;
PVector cp = new PVector(0, -100, 0); // Camera position
PVector cpold = new PVector(0, 0, 0);
PVector cr = new PVector(0, 0, 0); // Camera rotation
PVector crold = new PVector(0, 0, 0);

//Input
char[] inputKeys = {'w', 's', 'd', 'a', 'z', ' ', 't', 'g', 'f', 'h', 'y', 'n', 'u', 'j', 'i', 'k', 'o', 'l', 'q', 'e'};
boolean paused;
char toggleFreecam = 'x';
char toggleInfo = 'c';
char pause = 'p';
boolean[] keys = new boolean[20];

PVector oldMousePos = new PVector(0, 0);

void setup() {
  //size(1400, 1000, P3D);
  fullScreen(P3D);
  cam = new QueasyCam(this);
  cam.sensitivity = 0;
  cam.speed = 0;
}

void draw() {
  cpold = cp;
  crold = cr;
  PVector mousePos = new PVector(-1*mouseY-height/2, -1*(mouseX-width/2));
  freecam(mousePos);
  float size = 100;
  translate(-size/2, -size/2, -size/2);
  box(size);
  sphere(56);
  oldMousePos = mousePos;
}

void freecam(PVector mPos) {
  if (keys[0]) {
    PVector mvnt = new PVector(cos(cr.y), sin(cr.x), sin(cr.y));
    cp.add(multiplyVectorWithFloat(mvnt.normalize(), freecamSpeed));
  }
  if (keys[1]) {
    PVector mvnt = new PVector(cos(cr.y), sin(cr.x), sin(cr.y));
    cp.add(multiplyVectorWithFloat(mvnt.normalize(), -freecamSpeed));
  }
  if (keys[3]) {
    cp.add(new PVector(sin(cr.y)*freecamSpeed, 0, -cos(cr.y)*freecamSpeed));
  }
  if (keys[2]) {
    cp.add(new PVector(-sin(cr.y)*freecamSpeed, 0, cos(cr.y)*freecamSpeed));
  } 
  if (keys[5]) {
    cp.add(new PVector(0, -freecamSpeed, 0));
  } 
  if (keys[4]) {
    cp.add(new PVector(0, freecamSpeed, 0));
  }
  if (mousePressed) {
    cr.add(subtractVectors(oldMousePos, mPos).mult(freecamSensitivity*0.01));
    cr.x = constrain(cr.x, -PI/2, PI/2);
  }
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

PVector multiplyVectorWithFloat(PVector v1, float f) {
  return(new PVector(v1.x*f, v1.y*f, v1.z*f));
}
