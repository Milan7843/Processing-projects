float f(float x) {
  float y = x*x*x*x;
  return y;
}


float minDst = 5;
float scale = 400;
PVector pan = new PVector(300, 300);
float panSens = 1;
PVector screenSpaceX = new PVector(50, 750);
PVector screenSpaceY = new PVector(50, 550);
PVector spaceX = new PVector(0, 0);
PVector spaceY = new PVector(0, 0);
float dx = 0.001;

int precision = 200; //Amount of line segments

PVector lastMousePos = new PVector(0, 0);

void setup() {
  size(800, 600);
}

void draw() {
  background(200);
  if (mousePressed && mouseButton == LEFT) {
    pan.add(new PVector(mouseX-lastMousePos.x, mouseY-lastMousePos.y));
  }
  spaceX = new PVector(screenToSpaceX(screenSpaceX.x), screenToSpaceX(screenSpaceX.y));
  spaceY = new PVector(screenToSpaceY(screenSpaceY.x), screenToSpaceY(screenSpaceY.y));
  noStroke();
  rect(screenSpaceX.x, screenSpaceY.x, screenSpaceX.y-screenSpaceX.x, screenSpaceY.y-screenSpaceY.x);
  renderGrid();
  drawFunction();
  drawDerivative();
  print(scale + "\n");
  float x = screenToSpaceX(mouseX);
  stroke(150);
  if (mouseX > screenSpaceX.x && mouseX < screenSpaceX.y) {
    line(mouseX, screenSpaceY.x, mouseX, screenSpaceY.y);
  }
  float dy = f(x+dx)-f(x);
  float dyStep = f(x+dx*2)-f(x+dx);
  noStroke();
  textSize(25);
  fill(255, 0, 0);
  text(f(x), 15, height - 20);
  circle(mouseX, spaceToScreenY(f(x)), 10);
  fill(0, 0, 255);
  text(dy/dx, 200, height - 20);
  circle(mouseX, spaceToScreenY(dy/dx), 10);
  fill(0, 255, 0);
  text((dyStep-dy)/dx/dx, 400, height - 20);
  circle(mouseX, spaceToScreenY((dyStep-dy)/dx/dx), 10);
  lastMousePos = new PVector(mouseX, mouseY);
  stroke(0);
  fill(255);
}

void renderGrid() {
  stroke(0);
  float lineDst = 0.001*scale;
  while (lineDst < minDst) {
    lineDst *= 10;
  }
  strokeWeight(1);
  stroke(map(lineDst, minDst, minDst*10, 255, 100));
  drawGrid(lineDst);
  stroke(50);
  strokeWeight(1);
  drawGrid(lineDst*10);
  stroke(0);
  drawLine(4, 4, 7, -3);
  circle(spaceToScreenX(0), spaceToScreenY(0), 6);
  circle(spaceToScreenX(1), spaceToScreenY(1), 6);
  strokeWeight(2);
  if (pan.x+screenSpaceX.x > screenSpaceX.x && pan.x+screenSpaceX.x < screenSpaceX.y) {
    line(pan.x+screenSpaceX.x, screenSpaceY.x, pan.x+screenSpaceX.x, screenSpaceY.y);
  }
  if (pan.y+screenSpaceY.x > screenSpaceY.x && pan.y+screenSpaceY.x < screenSpaceY.y) {
    line(screenSpaceX.x, pan.y+screenSpaceY.x, screenSpaceX.y, pan.y+screenSpaceY.x);
  }
}

void drawLine(float x1, float y1, float x2, float y2) {
  PVector p1 = spaceToScreen(new PVector(x1, y1));
  PVector p2 = spaceToScreen(new PVector(x2, y2));
  //Case 1: line is fully in screen
  //if (p1.x >= screenSpaceX.x && p1.x <= screenSpaceX.y && p1.y >= screenSpaceY.x && p1.y <= screenSpaceY.y && p2.x >= screenSpaceX.x && p2.x <= screenSpaceX.y && p2.y >= screenSpaceY.x && p2.y <= screenSpaceY.y) {
    line(p1.x, p1.y, p2.x, p2.y);
  //}
}

void drawFunction() {
  stroke(255, 0, 0);
  float segmentLength = (spaceX.y - spaceX.x)/precision;
  for (int i = 0; i < precision; i++) {
    float x = i*segmentLength+spaceX.x;
    drawLine(x, f(x), x+segmentLength, f(x+segmentLength));
  }
}

void drawDerivative() {
  float segmentLength = (spaceX.y - spaceX.x)/precision;
  for (int i = 0; i < precision; i++) {
    float x = i*segmentLength+spaceX.x;
    float dy = f(x+dx)-f(x);
    float dyStep = f(x+dx*2)-f(x+dx);
    float dyStepSeg = (f(x+segmentLength+dx*2)-f(x+segmentLength+dx));
    float dySeg = (f(x+segmentLength+dx)-f(x+segmentLength));
    stroke(0, 0, 255);
    drawLine(x, dy/dx, x+segmentLength, dySeg/dx);
    stroke(0, 255, 0);
    drawLine(x, (dyStep-dy)/dx/dx, x+segmentLength, (dyStepSeg-dySeg)/dx/dx);
  }
}

PVector clampLine(PVector p1, PVector p2) {
  if (p1.x < screenSpaceX.x) {
    //p1.x = 
  }
  return null;
}

void drawGrid(float lineDst) {
  PVector panMod = new PVector(pan.x%lineDst, pan.y%lineDst);
  if (panMod.x < 0) panMod.x+=lineDst;
  if (panMod.y < 0) panMod.y+=lineDst;
  
  //Vertical lines
  int i = 0;
  while (i*lineDst + screenSpaceX.x + panMod.x < screenSpaceX.y) {
    line(i*lineDst + screenSpaceX.x + panMod.x, screenSpaceY.x, i*lineDst + screenSpaceX.x + panMod.x, screenSpaceY.y);
    i++;
  }
  
  //Horizontal lines
  i = 0;
  while (i*lineDst + screenSpaceX.x + panMod.y < screenSpaceY.y) {
    line(screenSpaceX.x, i*lineDst + screenSpaceX.x + panMod.y, screenSpaceX.y, i*lineDst + screenSpaceX.x + panMod.y);
    i++;
  }
}

PVector spaceToScreen(PVector spaceCoord) {
  return new PVector(spaceCoord.x*scale+pan.x+screenSpaceX.x, -spaceCoord.y*scale+pan.y+screenSpaceY.x);
}

float spaceToScreenX(float spaceCoord) {
  return spaceCoord*scale+pan.x+screenSpaceX.x;
}

float spaceToScreenY(float spaceCoord) {
  return -spaceCoord*scale+pan.y+screenSpaceY.x;
}

PVector screenToSpace(PVector screenCoord) {
  return new PVector((screenCoord.x-screenSpaceX.x-pan.x)/scale, -(screenCoord.y-screenSpaceY.x-pan.y)/scale);
}

float screenToSpaceX(float screenCoord) {
  return (screenCoord-screenSpaceX.x-pan.x)/scale;
}

float screenToSpaceY(float screenCoord) {
  return -(screenCoord-screenSpaceX.x-pan.x)/scale;
}
void mouseWheel(MouseEvent event) {
  scale -= event.getCount()*0.1*scale;
  scale = constrain(scale, 20, 100000);
}
