PVector[] point = new PVector[10];
PVector[] anb = new PVector[5];
PVector[] intsct = new PVector[2];
int currentLines;
float ballDiam = 100;
float intx, inty;
PVector b = new PVector(300, 300);
float dx, dy, dr, D;
boolean[] keys = new boolean[5];
float angle;
float speed = 2;
float lineAngle;
float  newX, newY;
float distToB;
boolean info = true;
void setup() {
  size(600, 600);
  for (int i = 0; i < 10; i++) {
    point[i] = new PVector(0, 0);
  }
  for (int i = 0; i < 5; i++) {
    anb[i] = new PVector(0, 0);
  }
  for (int i = 0; i < 2; i++) {
    intsct[i] = new PVector(0, 0);
  }
  newLine(50, 50, 140, 150);
  newLine(140, 150, 160, 300);
}

void draw() {
  background(240);
  movement();  
  lineChecking();
  lineDrawing();
  ballDrawing();
  if (info) {
    circle(intsct[0].x, intsct[0].y, 10);
    circle(intsct[1].x, intsct[1].y, 10);
    text(lineAngle + "\n" + distToB + "\n" + newX + "\n" + (dist(b.x, b.y, intsct[0].x, intsct[0].y)) + "\n" + (point[1].y - (point[0].y)) / (point[1].x - (point[0].x)), 150, 350);
  }
  distToB = 1000;
}

PVector intersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float x = ((x1*y2-y1*x2)*(x3-x4) - (x1-x2)*(x3*y4-y3*x4))/((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
  float y = ((x1*y2-y1*x2)*(y3-y4) - (y1-y2)*(x3*y4-y3*x4))/((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
  return(new PVector(x,y));
}

void lineDrawing() {
  for (int i = 0; i < currentLines; i++) {
    line(point[i*2].x, point[i*2].y, point[i*2+1].x, point[i*2+1].y);
  } 
}

void ballDrawing() {
  noFill();
  if (distToB <= ballDiam/2) {
    stroke(255, 0, 0);
  } else {
    stroke(0);
  }
  circle(b.x, b.y, ballDiam);
  if (info) {
    float len = 100;
    line(b.x+len, b.y, b.x-len, b.y);
    line(b.x, b.y-len, b.x, b.y+len);
  }
}


void lineChecking() {
  for (int i = 0; i < currentLines; i++) {
    lineAngle = atan((point[i*2+1].y - (point[i*2].y)) / (point[i*2+1].x - (point[i*2].x)));
    lineAngle = degrees(lineAngle);
    //intsct[0].x = intersect(point[currentLines/2].x, point[currentLines/2].y, point[currentLines/2+1].x, point[currentLines/2+1].y, b.x, b.y, b.x, b.y-100).x;
    //intsct[0].y = intersect(point[currentLines/2].x, point[currentLines/2].y, point[currentLines/2+1].x, point[currentLines/2+1].y, b.x, b.y, b.x, b.y-100).y;
    float tempx, tempy;
    newX = b.x + cos(radians(lineAngle) + PI/2) * 200;
    newY = b.y + sin(radians(lineAngle) + PI/2) * 200;
    tempx = intersect(b.x, b.y, newX, newY, point[i*2].x, point[i*2].y, point[i*2+1].x, point[i*2+1].y).x;
    tempy = intersect(b.x, b.y, newX, newY, point[i*2].x, point[i*2].y, point[i*2+1].x, point[i*2+1].y).y;
    if ((dist(b.x, b.y, tempx, tempy)) < distToB) {
      if ((dist(b.x, b.y, point[i*2].x, point[i*2].y)) < ballDiam/2 || (dist(b.x, b.y, point[i*2+1].x, point[i*2+1].y)) < ballDiam/2) {
        distToB = (dist(b.x, b.y, tempx, tempy));
      }
      else if (tempx < point[i*2].x && tempx > point[i*2+1].x) {
        distToB = (dist(b.x, b.y, tempx, tempy));
      }
      else if (tempx > point[i*2].x && tempx < point[i*2+1].x) {
        distToB = (dist(b.x, b.y, tempx, tempy));
      }
    }
    circle(tempx, tempy, 10);
    
    if (info) {
      line(b.x, b.y, newX, newY);
      circle(tempx, tempy, 10);
    }
  }
}
float dis() {
  //y = ax + b
  for (int i = 0; i < currentLines; i++) {
    float dx = point[i*2+1].x - point[i*2].x;
    float dy = point[i*2+1].y - point[i*2].y;
    float dr = sqrt(sq(dx) + sq(dy));
    float D = (point[i*2].x * point[i*2+1].y) - (point[i*2+1].x * point[i*2].y);
    float intx = sq(ballDiam/2) * sq(dr) - sq(D);
    intsct[0].x = ((D * dy) + sig(dy)*dx * sqrt(sq(ballDiam/2) * sq(dr) - sq(D)))/sq(dr);
    intsct[0].y = ((-D * dx) + abs(dy) * sqrt(sq(ballDiam/2) * sq(dr) - sq(D)))/sq(dr);
    
    
  }
  float dist = 10;
  
  return(dist);
}

void newLine(float x1, float y1, float x2, float y2) {
  point[currentLines*2] = new PVector(x1, y1);
  point[currentLines*2 + 1] = new PVector(x2, y2);
  currentLines++;
}

float sig(float x) {
  if (x < 0) {
    return(-1);
  }
  else {
    return(1);
  }
  
}

void keyPressed()
{
  if (key=='a') {
    keys[0]=true;
  } if (key=='d') {
    keys[1]=true;
  } if (key == 'w') {
    keys[2]=true;
  } if (key == 's') {
    keys[3]=true;
  } if (key == 'r') {
    keys[4]=true;
  }    
}

void keyReleased()
 {
   if (key=='a') {
     keys[0]=false;
   } if (key=='d') {
     keys[1]=false;
   } if (key == 'w') {
     keys[2]=false;
   } if (key == 's') {
     keys[3]=false;
   } if (key == 'r') {
     keys[4]=false;
   }
} 

void movement() {
  if (keys[0]) {
    b.x -= speed;
  }
  if (keys[1]) {
    b.x += speed;
  }
  if (keys[2]) {
    b.y -= speed;
  }
  if (keys[3]) {
    b.y += speed;
  }
}
