float r = 0, g = 0, b = 0;
int maxDrawingPoints = 15000;
float rX, rY, rHeight = 255, sliderWidth = 20, height2 = 20;
PVector[] vector = new PVector[maxDrawingPoints];
float rCircleY = height2, gCircleY = height2, bCircleY = height2;
float gX, gY, gHeight = 255, gWidth;
float bX, bY, bHeight = 255, bWidth;
//percentage
float settingsPanelWidth = 25;
float circleWidth = 30;
//Color number indicator
float indicatorX = 20, indicatorY = rHeight + height2 + 30;
//Brush size box
float sizeX = 0, sizeY = 300, sizeWidth, sizeHeight, sizeSizePart = 3, sizePosPart = 11;
float brushSize = 20;
boolean draw;
//Clear button
float clearX = 20, clearY, clearWidth, clearHeight = 40;
//Connecting drawn dots
float lastX, lastY;
//Color selector
float selectorX = 0, selectorY = 300, selectorWidth, selectorHeight, selectorSizePart = 4, selectorPosPart = 14;
float circleSize = 20;

//exit button
float exitButtonWidth = 60, exitButtonHeight = 40;
//General info
//Colors sliders are always half of the settings panel
//Settings panel height is divided in 30 parts

void setup() {
  frameRate(600);
  //size(600, 600);
  fullScreen();
  clearY = height - 150;
  settingsPanelWidth = width*(0.01*settingsPanelWidth);
  clearWidth = settingsPanelWidth- 40;
  rX = (settingsPanelWidth/8)-(0.5*sliderWidth);
  gX = (settingsPanelWidth/8)*2-(0.5*sliderWidth);
  bX = (settingsPanelWidth/8)*3-(0.5*sliderWidth);
  sizeY = height/30 * sizePosPart;
  sizeHeight = height/30 * sizeSizePart;
  sizeWidth = settingsPanelWidth - sizeX;
  selectorY = height/30 * selectorPosPart;
  selectorHeight = height/30 * selectorSizePart;
  selectorWidth = settingsPanelWidth - sizeX;
  background(255);
  circleSize = settingsPanelWidth/7;
}

void draw() {
  sizeWidth = settingsPanelWidth - sizeX;
  drawing();
  settingsPanel();
  clearButton();
  finalColorPanel();
  if(mouseX <= settingsPanelWidth) {
    draw = false;
  }
  lastX = mouseX;
  lastY = mouseY;
  text(mouseX, 20, 500);
  text(settingsPanelWidth, 20, 550);
  //exit button
  fill(255, 0, 0);
  rect(width - exitButtonWidth, 0, exitButtonWidth, exitButtonHeight);
  
}


void drawing() {
  
}

void clearButton() {
  stroke(2);
  fill(255);
  rect(clearX, clearY, settingsPanelWidth-2*clearX, clearHeight);
  fill(0);
  text("CLEAR", clearX + 20, clearY + 27);
  fill(255);
}

void settingsPanel() {
  fill(210, 210, 255);
  stroke(0);
  strokeWeight(1);
  rect(0,0, settingsPanelWidth, height);
  rect(rX, height2, sliderWidth, rHeight);
  rect(gX, height2, sliderWidth, gHeight);
  rect(bX, height2, sliderWidth, bHeight);
  
  //Colorful sliders
  for (int i = 0; i < 255; i++) {
    stroke(255-i, 0, 0);
    line(rX +1, height2 + i, rX + sliderWidth, height2 + i);
  }
  for (int i = 0; i < 255; i++) {
    stroke(0, 255-i, 0);
    line(gX +1, height2 + i, gX + sliderWidth, height2 + i);
  }
  for (int i = 0; i < 255; i++) {
    stroke(0, 0, 255-i);
    line(bX +1, height2 + i, bX + sliderWidth, height2 + i);
  }
  fill(r, 0, 0);
  ellipse(rX + sliderWidth/2, rCircleY, circleWidth, circleWidth);
  fill(0, g, 0);
  ellipse(gX + sliderWidth/2, gCircleY, circleWidth, circleWidth);
  fill(0, 0, b);
  ellipse(bX + sliderWidth/2, bCircleY, circleWidth, circleWidth);
  fill(0);
  text("R: "+ r, indicatorX, indicatorY);
  text("G: "+ g, indicatorX, indicatorY + 30);
  text("B: "+ b, indicatorX, indicatorY + 60);
  //Brush size
  noFill();
  textSize(20);
  text("Brush: ", indicatorX, sizeY + 0.5*sizeHeight);
  rect(sizeX, sizeY, sizeWidth, sizeHeight);
  fill(r, g, b);
  ellipse(sizeX + 0.75 * settingsPanelWidth, sizeY + 0.5*sizeHeight, brushSize, brushSize);
  //Colors selector
  noFill();
  rect(selectorX, selectorY, selectorWidth, selectorHeight);
  //5 to 3 color circles
  stroke(0);
  fill(50, 50, 50);
  ellipse(selectorX + selectorWidth/6*1, selectorY + selectorHeight/4*1, circleSize, circleSize);
  fill(50, 50, 50);
  ellipse(selectorX + selectorWidth/6*1, selectorY + selectorHeight/4*1, circleSize, circleSize);
}

void finalColorPanel() {
  r = 255-(rCircleY - height2);
  g = 255-(gCircleY - height2);
  b = 255-(bCircleY - height2);
  fill(r, g, b);
  rect(0, height-70, settingsPanelWidth, height-3);
}

void mouseClicked() {
  //R
  if (mouseX <= rX + sliderWidth && mouseX >= rX && mouseY <= height2 + rHeight && mouseY >= height2) {
    rCircleY = mouseY;
  }
  //G
  if (mouseX <= gX + sliderWidth && mouseX >= gX && mouseY <= height2 + gHeight && mouseY >= height2) {
    gCircleY = mouseY;
  }
  //B
  if (mouseX <= bX + sliderWidth && mouseX >= bX && mouseY <= height2 + bHeight && mouseY >= height2) {
    bCircleY = mouseY;
  }
  if (mouseX > settingsPanelWidth) {
    draw = true;
  }
  //close button
  if (mouseX >= width - exitButtonWidth && mouseY <= exitButtonHeight) {
    exit(); 
  }
  
  //CLEAR
  if (mouseX <=clearX + clearWidth && mouseX >= clearX && mouseY <= clearY + clearHeight && mouseY >= clearY) {
    background(255);
  }
}

void mouseDragged() {
  if(mouseX > settingsPanelWidth + 3) {
    draw = true;
  }
  //R
  if (mouseX <= rX + sliderWidth && mouseX >= rX && mouseY <= height2 + rHeight && mouseY >= height2) {
    rCircleY = mouseY;
  }
  //G
  if (mouseX <= gX + sliderWidth && mouseX >= gX && mouseY <= height2 + gHeight && mouseY >= height2) {
    gCircleY = mouseY;
  }
  //B
  if (mouseX <= bX + sliderWidth && mouseX >= bX && mouseY <= height2 + bHeight && mouseY >= height2) {
    bCircleY = mouseY;
  }
}

void mouseMoved() {
  draw = false;
}

void mouseWheel(MouseEvent event) {
  if(brushSize > 0){
    brushSize += -1*event.getCount();
  }
  if (brushSize == 0 && -1*event.getCount() > 0) {
    brushSize += -1*event.getCount();
  }
}
