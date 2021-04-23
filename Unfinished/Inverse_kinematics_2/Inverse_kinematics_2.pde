PVector start = new PVector(300, 50);
PVector target = new PVector();
boolean targetIsMouse = true;
PVector p1 = new PVector(), p2 = new PVector();
float r1 = 150, r2 = 230;
boolean drawGizmoLines = true;
//9:40, 40%

//Gizmo stuff
float a;
float h;
float d;
PVector pMid = new PVector();

void setup() {
  size(600, 600);
}

void draw() {
  background(230);
  strokeWeight(1);
  noFill();
  if (targetIsMouse) {
    target = new PVector(mouseX, mouseY);
  }
  
  calculatePositions();
  
  
  if (drawGizmoLines) {
    stroke(0, 0, 255);
    //line(start.x, start.y, target.x, target.y);
    circle(start.x, start.y, r1*2);
    circle(target.x, target.y, r2*2);
    stroke(255, 0, 0);
    line(start.x, start.y, pMid.x, pMid.y);
    stroke(0, 255, 0);
    line(target.x, target.y, pMid.x, pMid.y);
  }
  stroke(0);
  strokeWeight(2);
  line(start.x, start.y, p1.x, p1.y);
  line(target.x, target.y, p1.x, p1.y);
  
  line(start.x, start.y, p2.x, p2.y);
  line(target.x, target.y, p2.x, p2.y);
}

void calculatePositions() {
  d = sqrt(sq(target.x-start.x) + sq(target.y-start.y));
  if (d > r1 + r2) {
    p1 = (target.copy().sub(start)).normalize().mult(r1).add(target);
    p2 = (target.copy().sub(start)).normalize().mult(r1);
  }
  else {
    a = (sq(r1) - sq(r2) + sq(d)) / (2*d);
    h = sqrt(sq(r1) - sq(a));
    PVector norm = new PVector(target.x-start.x, target.y-start.y).normalize();
    pMid = norm.mult(a).add(start);
    p1.x = pMid.x + h * (target.y-start.y) / d;
    p1.y = pMid.y - h * (target.x-start.x) / d;
    p2.x = pMid.x - h * (target.y-start.y) / d;
    p2.y = pMid.y + h * (target.x-start.x) / d;
  }
}
