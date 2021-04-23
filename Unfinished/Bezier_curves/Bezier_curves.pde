//Linear, quadratic and higher-order Bézier curves
//Linear: 2 points
//Quadratic: 3 points
//Higher-order: 4 or more points

//2 coords = 1 point
//3 coords = 3 points
//4 coords = 6 points
//5 coords = 10 points


float t; //Float between 0 and 1 to show progress
float timeScale = 0.4;
int steps = 100;

float lineOpacity = 100;
int pAmount = 6;
PVector[] P = new PVector[pAmount]; //P = static points
//int qAmount = AddNumbersUnder(pAmount);
//PVector[] Q = new PVector[qAmount]; //Q = intermediate points
color[] colors = {color(131, 235, 52, lineOpacity), color(52, 86, 235, lineOpacity), color(255, 0, 230, lineOpacity), color(255, 234, 0, lineOpacity), color(255, 140, 0, lineOpacity)};
color pColor = color(100, 255);
boolean dragging = false;
int pointDragging;
PVector[] B = new PVector[steps];
boolean automaticT;
boolean line = true;
PVector[] buttons = new PVector[2];

BezierCurves bezier = new BezierCurves();

void setup() {
  size(600, 600);
  P[0] = new PVector(100, 200);
  P[1] = new PVector(200, 200);
  P[2] = new PVector(500, 300);
  P[3] = new PVector(300, 500);
  P[4] = new PVector(500, 500);
  P[5] = new PVector(550, 550);
  for (int i = 0; i < buttons.length; i++) {
    buttons[i] = new PVector(50 + i * 60, 50);
  }
  //CalculateLine();
  //DrawPoints();
}

void draw() {
  background(255);
  DrawPoints();
  DrawSpecificPoints(bezier.calculateCurve(P, 50, true));
  //CalculatePoints();
  if (!automaticT) {
    t = mouseX - 10;
    t /= 580;
  }
  else {
    //t += 1/(float)steps;
    t += 0.01*timeScale;
    if (t >= 1) {
      t = 0;
    }
  }
  
  
  
  if (t < 0) {
    t = 0;
  }
  else if (t > 1) {
    t = 1;
  }
  Buttons();
  if (line) {
    //CalculateLine();
  }
}

/*
void CalculatePoints() {
  int layerAmount = pAmount-1;
  int index = 0;
  int qAmountOnLayer = pAmount-1;
  for (int i = 0; i < layerAmount; i++) {
    for (int e = 0; e < qAmountOnLayer; e++) {
      if (qAmountOnLayer == pAmount-1) {
        Q[index] = VectorIntermediate(P[index], P[index+1], t);
      }
      else {
        Q[index] = VectorIntermediate(Q[index - qAmountOnLayer - 1], Q[index - qAmountOnLayer], t);
      }
      if (qAmountOnLayer == 1) {
        fill(255, 0, 0);
        stroke(255, 0, 0);
      }
      else {
        fill(colors[pAmount-1-qAmountOnLayer]);
        stroke(colors[pAmount-1-qAmountOnLayer]);
      }
      if (e > 0) {
        line(Q[index].x, Q[index].y, Q[index-1].x, Q[index-1].y);
      }
      
      circle(Q[index].x, Q[index].y, 10);
      index++;
    }
    qAmountOnLayer--;
  }
}
*/

void DrawSpecificPoints(PVector[] points) {
  fill(pColor);
  stroke(pColor);
  for (int i = 0; i < points.length; i++) {
    circle(points[i].x, points[i].y, 4);
    if (i < points.length-1) {
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
    }
  }
}

void DrawPoints() {
  fill(pColor);
  stroke(pColor);
  for (int i = 0; i < pAmount; i++) {
    circle(P[i].x, P[i].y, 10);
    if (i < pAmount-1) {
      line(P[i].x, P[i].y,P[i+1].x, P[i+1].y);
    }
  }
}

void Buttons() {
  for (int i = 0; i < buttons.length; i++) {
    fill(0);
    if (i == 0) {
      text("Auto time", buttons[i].x - 30, buttons[i].y - 25);
    }
    else if (i == 1) {
      text("Line", buttons[i].x - 10, buttons[i].y - 25);
    }
    
    if (automaticT && i == 0) {
      fill(116, 227, 36);
    }
    else if (line && i == 1) {
      fill(116, 227, 36);
    }
    else {
      noFill();
    }
    stroke(0);
    circle(buttons[i].x, buttons[i].y, 40);
  }
}


PVector VectorIntermediate(PVector start, PVector end, float _t) {
  PVector intermediateVector = new PVector();
  intermediateVector.x = end.x * _t + start.x * (1-_t);
  intermediateVector.y = end.y * _t + start.y * (1-_t);
  return intermediateVector;
}

int AddNumbersUnder(int x) {
  int num = 0;
  for (int i = 0; i < x; i++) {
    num += i;
  }
  return num;
}

/*
void CalculateLine() {
  for (int v = 0; v < steps; v++) {
    int layerAmount = pAmount-1;
    int index = 0;
    int qAmountOnLayer = pAmount-1;
    for (int i = 0; i < layerAmount; i++) {
      for (int e = 0; e < qAmountOnLayer; e++) {
        if (qAmountOnLayer == pAmount-1) {
          Q[index] = VectorIntermediate(P[index], P[index+1], v/(float)steps);
        }
        else {
          Q[index] = VectorIntermediate(Q[index - qAmountOnLayer - 1], Q[index - qAmountOnLayer], v/(float)steps);
        }
        B[v] = Q[index];
        
        index++;
      }
      qAmountOnLayer--;
    }
  }
  for (int v = 0; v < t*steps; v++) {
    //circle(B[v].x, B[v].y, 5);
    if (v != 0) {
      strokeWeight(2);
      line(B[v].x, B[v].y, B[v-1].x, B[v-1].y);
    }
    print(v  +"\n");
  }
}
*/

void mouseDragged() {
  for (int i = 0; i < pAmount; i++) {
    if (dist(mouseX, mouseY, P[i].x, P[i].y) < 20) {
      dragging = true;
      pointDragging = i;
    }
  }
  if (dragging) {
    P[pointDragging] = new PVector(mouseX, mouseY);
  }
}

void mousePressed() {
  for (int i = 0; i < buttons.length; i++) {
    if (dist(mouseX, mouseY, buttons[i].x, buttons[i].y) < 20) {
      if (i == 0) {
        automaticT = !automaticT;
      }
      else if (i == 1) {
        line = !line;
      }
    }
  }
}

void mouseReleased() {
  dragging = false;
}
