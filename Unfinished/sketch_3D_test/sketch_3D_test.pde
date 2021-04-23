float camSpeed = 0.03;
boolean freeCam; //not implemented


PVector camPos = new PVector(0, -4, 4); //Camera position
PVector cr = new PVector(0, 0, 0); //Camera rotation in Radians
PVector cn = new PVector(0, 0, 0);
//PVector e = new PVector(480, 270, 3); //Display's surface position
PVector e = new PVector(480, 270, 6); //Display's surface position //FOV depends on Z component of this vector
PVector r = new PVector(9.6, 5.4, 100); //Recording surface size
float l_ = 20;

Cube[] cube = new Cube[1];
Plane[] plane = new Plane[0];

//Not to change
boolean forward, back , right, left, up, down;
PVector oldMousePos = new PVector(0, 0);


void setup() {
  size(960, 540);
  cube[0] = new Cube(0, 0, 0, 2);
  //plane[0] = new Plane(0, 0, 0, 4, 4);
}

void draw() {
  background(200);
  PVector mousePos = new PVector(mouseY-height/2, -1*(mouseX-width/2));
  movement(mousePos);
  //Calculating the normal of the camera
  cn = new PVector(sin(cr.y), -tan(cr.x), cos(cr.y)).normalize();
  
  PVector lookDirVector = new PVector(cos(cr.x), sin(cr.y));
  //print(lookDirVector + " || " + cr + "\n");
  
  renderObjects();
  //circle(width/2, height/2, 10);
  orientationIndicator();
  
  oldMousePos = mousePos;
  //PVector crClone = cr.copy();
  //print(new PVector(cos(crClone.x), sin(crClone.y)).normalize() + "\n");
  
  cube[0].move(new PVector(0, 0, 0.004));
}

void fillShape(PVector[] coords, int beginIndex, int endIndex, color colour) {
  fill(colour);
  beginShape();
  for (int i = beginIndex; i < endIndex+1; i++) {
    vertex(coords[i].x, coords[i].y);
  }
  endShape();
  noFill();
}

void renderObjects() {
  for (int i = 0; i < cube.length; i++) {
    cube[i].render();
  }
  for (int i = 0; i < plane.length; i++) {
    plane[i].render();
  }
}

PVector[] calculatePoints(int vertexAmount, PVector[] a, boolean drawPoints) {
  PVector[] points = new PVector[vertexAmount];
  for (int i = 0; i < vertexAmount; i++) {
    
    PVector s = new PVector(sin(cr.x), sin(cr.y), sin(cr.z));
    PVector c = new PVector(cos(cr.x), cos(cr.y), cos(cr.z));
    float x = a[i].x - camPos.x;
    float y = a[i].y - camPos.y;
    float z = a[i].z - camPos.z;
    
    //n * (a-p) =
    // > 0 -> past plane
    // 0 -> on plane
    // < 0 -> behind plane
    boolean aft = false;
    //float aft = cn.dot(new PVector(x, y, z));
    if (cn.dot(new PVector(a[i].x - camPos.x*2, a[i].y - camPos.y*2, a[i].z - camPos.z*2)) > 0) {
      //Point is definitely off-screen
      PVector nw = subtractVectors(camPos, new PVector(x*2, y*2, z*2));
      x = -a[i].x + camPos.x;
      y = -a[i].y + camPos.y;
      z = -a[i].z + camPos.z;
      aft = true;
      //aft = cn;
      points[i] = new PVector(0, 0);
    }
    else {    
      PVector d = new PVector();
      PVector b = new PVector();
      d.x = c.y * (s.z*y + c.z*x) - s.y*z;
      d.y = s.x * (c.y*z + s.y*(s.z*y + c.z*x)) + c.x * (c.z*y - s.z * x);
      d.z = c.x * (c.y*z + s.y*(s.z*y + c.z*x)) - s.x * (c.z*y - s.z * x);
      //b.x = (d.x * s.x) / (d.z * r.x) * r.z;
      //b.y = (d.y * s.y) / (d.z * r.y) * r.z;
      b.x = e.z/d.z*d.x + e.x;
      b.y = e.z/d.z*d.y + e.y;
      
      circle((b.x-480)*40+480, (b.y-270)*40+270, 5);
      //print(b.x + " || " + b.y + "\n");
      //print(d.x + " || " + d.y + "\n");
      if (aft) {
        stroke(255, 0, 0);
      }
      else {
        stroke(0, 255, 0);
      }
      text(i + " " + aft, (b.x-480)*40+480, (b.y-270)*40+270);
      stroke(0);
      points[i] = new PVector((b.x-480)*40+480, (b.y-270)*40+270);
    }
    
  }
  return points;
}

void orientationIndicator() {
  float scale = 0.5;
  PVector mp = addVectors(camPos, multiplyVectorWithFloat(cn, 2));
  strokeWeight(2);
  //X
  PVector[] xarray = {mp, new PVector(mp.x+scale, mp.y, mp.z)};
  PVector[] xPoints = calculatePoints(2, xarray, false);
  stroke(255, 0, 0);
  line(xPoints[0].x, xPoints[0].y, xPoints[1].x, xPoints[1].y);
  //Y
  PVector[] yarray = {mp, new PVector(mp.x, mp.y+scale, mp.z)};
  PVector[] yPoints = calculatePoints(2, yarray, false);
  stroke(0, 255, 0);
  line(yPoints[0].x, yPoints[0].y, yPoints[1].x, yPoints[1].y);
  //Z
  PVector[] zarray = {mp, new PVector(mp.x, mp.y, mp.z+scale)};
  PVector[] zPoints = calculatePoints(2, zarray, false);
  stroke(0, 0, 255);
  line(zPoints[0].x, zPoints[0].y, zPoints[1].x, zPoints[1].y);
  stroke(0);
  strokeWeight(1);
}

void movement(PVector mPos) {
  if (forward) {
    PVector mvnt = new PVector(-sin(cr.y), sin(cr.x), -cos(cr.y));
    camPos.add(multiplyVectorWithFloat(mvnt.normalize(), camSpeed));
  }
  if (back) {
    PVector mvnt = new PVector(-sin(cr.y), sin(cr.x), -cos(cr.y));
    camPos.add(multiplyVectorWithFloat(mvnt.normalize(), -camSpeed));
  }
  if (left) {
    camPos.add(new PVector(cos(cr.y)*camSpeed, 0, -sin(cr.y)*camSpeed));
  }
  if (right) {
    camPos.add(new PVector(-cos(cr.y)*camSpeed, 0, sin(cr.y)*camSpeed));
  } 
  if (up) {
    camPos.add(new PVector(0, camSpeed, 0));
  } 
  if (down) {
    camPos.add(new PVector(0, -camSpeed, 0));
  } 
  if (mousePressed) {
    cr.add(subtractVectors(oldMousePos, mPos).mult(0.02));
  }
}

PVector multiplyVectorWithFloat(PVector v1, float f) {
  return(new PVector(v1.x*f, v1.y*f, v1.z*f));
}

PVector addVectors(PVector v1, PVector v2) {
  PVector toReturn = new PVector(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
  return toReturn;
}

//v1 - v2
PVector subtractVectors(PVector v1, PVector v2) {
  PVector toReturn = new PVector(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
  return toReturn;
}

void keyPressed() {
  if (key == 'w') {
    forward = true;
  }
  if (key == 'a') {
    left = true;
  }
  if (key == 's') {
    back = true;
  }
  if (key == 'd') {
    right = true;
  }
  if (key == ' ') {
    up = true;
  }
  if (key == 'z') {
    down = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    forward = false;
  }
  if (key == 'a') {
    left = false;
  }
  if (key == 's') {
    back = false;
  }
  if (key == 'd') {
    right = false;
  }
  if (key == ' ') {
    up = false;
  }
  if (key == 'z') {
    down = false;
  }
}

//https://www.researchgate.net/profile/Chandra_Sekhar_Gatla/publication/41322677/figure/fig1/AS:648954270216192@1531734163239/A-pinhole-camera-projecting-an-object-onto-the-image-plane.png
