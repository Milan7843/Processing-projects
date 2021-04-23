boolean followMouse = false;
boolean resizeToCanvas = false;
float spedTimeScale = -1000;

float totalSeconds;

float h; //0-12
float hw = 5; //Hour hand width
float m; //0-60
float mw = 3; //Minute hand width
float s; //0-60
float sw = 3; //Second hand width

PVector pos = new PVector(300, 300);
float radius = 275;

float timeScale = 1;

float smallStripeLength = 20;
float smallStripeWidth = 2;
float largeStripeLength = 40;
float largeStripeWidth = 4;

void setup() {
  size(600, 600);
  frameRate(60);
  totalSeconds = random(60*60*12);
}

void draw() {
  noStroke();
  background(240);
  if (followMouse){
    pos = new PVector(mouseX, mouseY);
  }
  if (resizeToCanvas) {
    radius = min(mouseX, width-mouseX, min(mouseY, height-mouseY));
  }
  
  fill(80);
  //Drawing back circle
  circle(pos.x, pos.y, radius*2);
  drawIndicators();
  drawHands();
  setTime();
}

void setTime() {
  totalSeconds += (1 * timeScale)/60;
  h = (totalSeconds/3600)%60;
  m = (totalSeconds/60)%60;
  s = totalSeconds%60;
}

void drawHands() {
  //Hours
  stroke(255);
  strokeWeight(hw);  
  line(pos.x, pos.y, pos.x + cos(h/6*PI - 0.5*PI)*(radius-5), pos.y + sin(h/6*PI - 0.5*PI)*(radius-5));
  //Minutes
  stroke(255);
  strokeWeight(mw);  
  line(pos.x, pos.y, pos.x + cos(m/30*PI - 0.5*PI)*(radius-5), pos.y + sin(m/30*PI - 0.5*PI)*(radius-5));
  //Seconds
  stroke(255, 0, 0);
  strokeWeight(sw);  
  line(pos.x, pos.y, pos.x + cos(s/30*PI - 0.5*PI)*(radius-5), pos.y + sin(s/30*PI - 0.5*PI)*(radius-5));
}

void drawIndicators() {
  stroke(255);
  //Drawing large indicators for hours
  strokeWeight(largeStripeWidth);
  for (float i = 0; i < 12; i++) {
    line(pos.x + cos(i/6*PI)*(radius-largeStripeLength), pos.y + sin(i/6*PI)*(radius-largeStripeLength), pos.x + cos(i/6*PI)*radius, pos.y + sin(i/6*PI)*radius);
  }
  //Drawing small indicators for minutes
  strokeWeight(smallStripeWidth);
  for (float i = 0; i < 60; i++) {
    line(pos.x + cos(i/30*PI)*(radius-smallStripeLength), pos.y + sin(i/30*PI)*(radius-smallStripeLength), pos.x + cos(i/30*PI)*radius, pos.y + sin(i/30*PI)*radius);
  }
}

void mousePressed () {
  timeScale = spedTimeScale;
}

void mouseReleased () {
  timeScale = 1;
}
