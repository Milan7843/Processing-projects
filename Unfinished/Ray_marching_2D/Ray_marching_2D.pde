Box[] box = new Box[1];
boolean done;
PVector dir;

void setup() {
  size(600, 600);
  box[0] = new Box(150, 150, 100, 100);
  noFill();
}

void draw() {
  background(200);
  
  PVector mouse = new PVector(mouseX, mouseY);
  dir = new PVector(sin(atan2(mouse.x - 50, mouse.y - 50)), cos(atan2(mouse.x - 50, mouse.y - 50)));  
  
  for(int i = 0; i < box.length; i++) {
    rect(box[i].x, box[i].y, box[i].l, box[i].h);
  }
  
  float e = 0;
  PVector currentEndPoint = new PVector(50,50);
  //while (!done) { 
  for(int i = 0; i < 15; i++) {
    float distance = dstToBox(currentEndPoint, box[0])*2;
    //PVector newPoint = currentEndPoint.add(dir.mult(distance));
    circle(currentEndPoint.x, currentEndPoint.y, distance);
    currentEndPoint = new PVector(currentEndPoint.x + distance * dir.x/2, currentEndPoint.y + distance * dir.y/2);
    println(dir);
    
    circle(currentEndPoint.x, currentEndPoint.y, 10);
    if (dstToBox(new PVector(currentEndPoint.x, currentEndPoint.y), box[0])*2 < 0.1) {
      done = true;
    }
    e++;
  }
  done = false;
}

float dstToBox(PVector point, Box box) {
  float dx = max(box.x - point.x, 0, point.x - box.x-box.l);
  float dy = max(box.y - point.y, 0, point.y - box.y-box.h);
  return sqrt(dx*dx + dy*dy);
}
