//Bezier curve
PVector[] point = new PVector[3];
PVector[] weight = new PVector[point.length*2];

int pointsPerLine = 5;
//String art stuffs
boolean stringArt = true;
PVector[][] stringPoints = new PVector[point.length-1][pointsPerLine];

float dragDst;
int dragging = -1;
float frames;

void setup() {
  size(600, 600);
  point[0] = new PVector(200, 200);
  point[1] = new PVector(300, 200);
  point[2] = new PVector(300, 300);
  for (int i = 0; i < point.length-1; i++) {
    for (int e = 0; e < pointsPerLine; e++) {
      stringPoints[i][e] = new PVector(0, 0);
    }
  }
}

void draw() {
  background(200, 255, 200);
  frames++;
  drawPointsAndLines();
}

void drawPointsAndLines() {
  if (stringArt) {
    for (int i = 0; i < point.length-1; i++) {
      for (int e = 0; e < pointsPerLine; e++) {
        stringPoints[i][e].x = lerp(point[i].x, point[i+1].x, (e+1)/(pointsPerLine+1));
        stringPoints[i][e].y = lerp(point[i].y, point[i+1].y, (e+1)/(pointsPerLine+1));
      }
    }
    for (int i = 0; i < point.length-2; i++) {
      for (int e = 0; e < pointsPerLine; e++) {
        line(stringPoints[i][e].x, stringPoints[i][e].y, stringPoints[i+1][e].x, stringPoints[i+1][e].y);
      }
    }
  }
  
  
  for (int i = 0; i < point.length-1; i++) {
    line(point[i].x, point[i].y, point[i+1].x, point[i+1].y);
    for (int e = 0; e < pointsPerLine; e++) {
      //line(lerp(point[i].x, point[i+1].x, e/pointsPerLine), lerp(point[i].y, point[i+1].y, e/pointsPerLine));
    }
  }
  for (int i = 0; i < point.length; i++) {
    //circle(point[i].x, point[i].y, 20);
  }
}

void mousePressed() {
  for (int i = 0; i < point.length; i++) {
    if (dist(point[i].x, point[i].y, mouseX, mouseY) < 20) {
      dragging = i;
    }
  }
}

void mouseDragged() {
  if (dragging != -1) {
    point[dragging] = new PVector(mouseX, mouseY);
  }
}

void mouseReleased() {
  dragging = -1;
}
