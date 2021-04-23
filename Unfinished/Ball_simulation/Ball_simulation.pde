PVector[] point = new PVector[10];
boolean[] touching = new boolean[10];

float gravity = 0.1;
float airResistance = 0.01; // amount of speed loss per frame
float speed = 0.5;

boolean info = true;

int currentLines;
boolean[] keys = new boolean[5];
float lineAngle;
float  newX, newY;
float distToB;

boolean tempTouching;

Ball[] b = new Ball[1];
void setup() {
  //new Ball(float x_, float y_, float weight_, float bouncyness_, float diameter_);
  b[0] = new Ball(300, 200, 1.4, 0.1, 100);
  size(600, 600);
  for (int i = 0; i < 10; i++) {
    point[i] = new PVector(0, 0);
  }
  newLine(50, 50, 140, 150);
  newLine(140, 150, 160, 300);
  newLine(160, 300, 460, 350);
  frameRate(60);
}

void draw() {
  background(240);
  b[0].calculate();
  b[0].physics();
  lineDrawing();
  b[0].show();
  if (info) {
    info();
  }
  distToB = 1000;
}

PVector intersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float x = ((x1*y2-y1*x2)*(x3-x4) - (x1-x2)*(x3*y4-y3*x4))/((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
  float y = ((x1*y2-y1*x2)*(y3-y4) - (y1-y2)*(x3*y4-y3*x4))/((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
  return(new PVector(x,y));
}

void info() {
  stroke(0);
  fill(0);
  
  //text(lineAngle + "\n" + distToB + "\n" + newX + "\n" + (dist(b.x, b.y, intsct[0].x, intsct[0].y)) + "\n" + (point[1].y - (point[0].y)) / (point[1].x - (point[0].x)), 150, 350);
  for (int i = 0; i < currentLines; i++) {
    
  } 
}

void lineDrawing() {
  for (int i = 0; i < currentLines; i++) {
    if (touching[i]) {
      stroke(255, 0, 0);
    } else {
      stroke(0);
    }
    line(point[i*2].x, point[i*2].y, point[i*2+1].x, point[i*2+1].y);
  } 
}

void newLine(float x1, float y1, float x2, float y2) {
  point[currentLines*2] = new PVector(x1, y1);
  point[currentLines*2 + 1] = new PVector(x2, y2);
  currentLines++;
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
