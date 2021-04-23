  //grid
float lineSpace = 10;
float xOffset = 0, yOffset = 0;
float nLinesL, nLinesR, nLinesU, nLinesD;
float space = 30;
//controls
boolean dragging = false, draggingPoint = false;
int oldMouseY, oldMouseX;
float radius = 10;
//coordinates
float pointSize = 10;
int nPoints = 0;
float textSize = 20;
float xTextOffset = 10, yTextOffset = 5;
float ax = 5, ay = 3, aw = 2;
float bx = 7, by = 2, bw = 4;
float cx = -3, cy = -3, cw = 9;
float zx, zy, zw;
float realAX, realAY;
float realBX, realBY;
float realCX, realCY;
float decimalPlaces = 3;

void setup() {
  fullScreen();
  decimalPlaces = pow(10, decimalPlaces);
  realAX = width/2+xOffset + ax*space;
  realBX = width/2+xOffset + bx*space;
  realCX = width/2+xOffset + cx*space;
  realAY = (height/2-yOffset) - ay*space;
  realBY = (height/2-yOffset) - by*space;
  realCY = (height/2-yOffset) - cy*space;
}

void draw() {
  if (dragging) {
    xOffset += (mouseX-oldMouseX);
    yOffset -= (mouseY-oldMouseY);
    realAX += (mouseX-oldMouseX);
    realBX += (mouseX-oldMouseX);
    realCX += (mouseX-oldMouseX);
    realAY += (mouseY-oldMouseY);
    realBY += (mouseY-oldMouseY);
    realCY += (mouseY-oldMouseY);
  }
  background(230);
  grid();
  
  println("dp "+draggingPoint);
  println("ay "+ay);
  println("mouseX "+mouseX);
  
  
  //assigning points
  a();
  b();
  c();
  calculate();
  oldMouseY = mouseY;
  oldMouseX = mouseX;
  //dragging = false;
  results();
  
}

void calculate() {
  ax = (realAX - (width/2+xOffset))/space;
  bx = (realBX - (width/2+xOffset))/space;
  cx = (realCX - (width/2+xOffset))/space;
  ay = -(realAY - (height/2-yOffset))/space;
  by = -(realBY - (height/2-yOffset))/space;
  cy = -(realCY - (height/2-yOffset))/space;
  zx = (aw/zw)*ax+(bw/zw)*bx+(cw/zw)*cx;
  zy = (aw/zw)*ay+(bw/zw)*by+(cw/zw)*cy;
  zw = aw + bw + cw;
}

void grid() {
  //middle line
  strokeWeight(2);
  line(0, height/2-yOffset, width, height/2-yOffset);
  line(width/2+xOffset, 0, width/2+xOffset, height);
  //making borders and calculating the amount of lines
  nLinesR = (width/2-xOffset)/space;
  nLinesL = (width/2+xOffset)/space;
  nLinesU = (height/2-yOffset)/space;
  nLinesD = (height - (height/2-yOffset))/space;
  //other lines
  strokeWeight(0.5);
  //vertical
  //right
  for (int i = 0; i <= nLinesR; i++) {
    line(width/2+xOffset + i*space, 0, width/2+xOffset + i*space, height);
  }
  //left
  for (int i = 0; i <= nLinesL; i++) {
    line(width/2+xOffset - i*space, 0, width/2+xOffset - i*space, height);
  }
  //horizontal
  //up
  for (int i = 0; i <= nLinesU; i++) {
    line(0, (height/2-yOffset) - i*space, width, (height/2-yOffset) - i*space);
  }
  //down
  for (int i = 0; i <= nLinesD; i++) {
    line(0, (height/2-yOffset) + i*space, width, (height/2-yOffset) + i*space);
  }
  //smaller lines
  strokeWeight(2);
  //right
  for (int i = 0; i <= nLinesR; i++) {
    line(width/2+xOffset + i*5*space, (height/2-yOffset) - 10, width/2+xOffset + i*5*space, (height/2-yOffset) + 10);
  }
  //left
  for (int i = 0; i <= nLinesL; i++) {
    line(width/2+xOffset - i*5*space, (height/2-yOffset) - 10, width/2+xOffset - i*5*space, (height/2-yOffset) + 10);
  }
  //horizontal
  //up
  for (int i = 0; i <= nLinesU; i++) {
    line(width/2+xOffset - 10, (height/2-yOffset) - i*5*space, width/2+xOffset + 10, (height/2-yOffset) - i*5*space);
  }
  //down
  for (int i = 0; i <= nLinesD; i++) {
    line(width/2+xOffset - 10, (height/2-yOffset) + i*5*space, width/2+xOffset + 10, (height/2-yOffset) + i*5*space);
  }
}


void mouseDragged() {
  if (dist(mouseX, mouseY, realAX, realAY) < radius) {
    realAX = mouseX;
    realAY = mouseY;
    draggingPoint = true;
  }
  else if (dist(mouseX, mouseY, realBX, realBY) < radius) {
    realBX = mouseX;
    realBY = mouseY;
    draggingPoint = true;
  }
  else if (dist(mouseX, mouseY, realCX, realCY) < radius) {
    realCX = mouseX;
    realCY = mouseY;
    draggingPoint = true;
  }
  else {
    dragging = true;
    //realAX = width/2+xOffset + ax*space;
    //realBX = width/2+xOffset + bx*space;
    //realCX = width/2+xOffset + cx*space;
    //realAY = (height/2-yOffset) - ay*space;
    //realBY = (height/2-yOffset) - by*space;
    //realCY = (height/2-yOffset) - cy*space;
  }
}

void mouseWheel(MouseEvent event) {
  if (dist(mouseX, mouseY, realAX, realAY) < pointSize) {
    aw -= event.getCount();
  }
  else if (dist(mouseX, mouseY, realBX, realBY) < pointSize) {
    bw -= event.getCount();
  }
  else if (dist(mouseX, mouseY, realCX, realCY) < pointSize) {
    cw -= event.getCount();
  }
  else {
    space -= event.getCount();
    realAX = width/2+xOffset + ax*space;
    realBX = width/2+xOffset + bx*space;
    realCX = width/2+xOffset + cx*space;
    realAY = (height/2-yOffset) - ay*space;
    realBY = (height/2-yOffset) - by*space;
    realCY = (height/2-yOffset) - cy*space;
  }
}

void results() {
  fill(0);
  circle(width/2+xOffset + zx*space, height/2-yOffset - zy*space, pointSize);
  textSize(textSize + 10);
  zx *= decimalPlaces;
  zx = round(zx);
  zx /= decimalPlaces;
  zy *= decimalPlaces;
  zy = round(zy);
  zy /= decimalPlaces;
  text("Z", width/2+xOffset + zx*space + xTextOffset, height/2-yOffset - zy*space + pointSize - yTextOffset);
  strokeWeight(2);
  fill(200);
  rect(20, height-200, 380, 180);
  fill(0);
  ax *= decimalPlaces;
  ax = round(ax);
  ax /= decimalPlaces;
  ay *= decimalPlaces;
  ay = round(ay);
  ay /= decimalPlaces;
  text("A(" + ax + "; " + ay + ", " + (int)aw + ")", 30, height-160);
  bx *= decimalPlaces;
  bx = round(bx);
  bx /= decimalPlaces;
  by *= decimalPlaces;
  by = round(by);
  by /= decimalPlaces;
  text("B(" + bx + "; " + by + ", " + (int)bw + ")", 30, height-120);
  cx *= decimalPlaces;
  cx = round(cx);
  cx /= decimalPlaces;
  cy *= decimalPlaces;
  cy = round(cy);
  cy /= decimalPlaces;
  text("C(" + cx + "; " + cy + ", " + (int)cw + ")", 30, height-80);
  text("Z(" + zx + "; " + zy + ", " + zw + ")", 30, height-40);
}

void mouseReleased() {
  dragging = false;
}

//coordinates
void a() {
  fill(0);
  circle(realAX, realAY, pointSize);
  textSize(textSize);
  text("A", realAX + xTextOffset, realAY + pointSize - yTextOffset);
}
void b() {
  fill(0);
  circle(realBX, realBY, pointSize);
  textSize(textSize);
  text("B", realBX + xTextOffset, realBY + pointSize - yTextOffset);
}
void c() {
  fill(0);
  circle(realCX, realCY, pointSize);
  textSize(textSize);
  text("C", realCX + xTextOffset, realCY + pointSize - yTextOffset);
}
