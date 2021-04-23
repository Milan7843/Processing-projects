float playerSize = 150;
float lastMouseX;
float lastMouseY;
float diffFrame;
float diffSec;
float diffX;
float diffY;
float timer;
int maxSpeed;
float avSpeed;
float totalDistance = 0;
int totalFrames;
float diffFrameN;
float backR = 100;
float backG = 100;
float backB = 255;
int p = 1;

//PAUSEBUTTON
float pauseBLength = 100;
float pauseBHeight = 100;
float pauseY = 50;
float pauseX = 1920 - (pauseBLength + 10);
//float pauseX = 500;
float pressedTimer = 60;

void setup() {
  fullScreen();
  frameRate(60);
}

void draw() {
  pressedTimer += 1;
  if (mousePressed && mouseY > pauseY && mouseY < pauseY + pauseBHeight && mouseX > pauseX && mouseX < pauseX + pauseBLength){ 

  }
  int updateTime = (int)frameRate/6;
  background(backR, backG, backB);
  timer += 1;
  totalFrames += 1 * p;
  diffX = lastMouseX - mouseX * p;
  diffY = lastMouseY - mouseY * p;
  diffFrameN = (int)sqrt(pow(diffX, 2) + pow(diffY, 2));
  
  //CALCULATIONS
  //diffFrame = (int)sqrt(pow(diffX, 2) + pow(diffY, 2));
  //diffSec = diffFrame * frameRate;
  fill(0 + diffFrameN * 3, 0, 200 - diffFrameN * 3);
  if (timer >= updateTime) {
    diffFrame = (int)sqrt(pow(diffX, 2) + pow(diffY, 2));
    diffSec = diffFrame * frameRate;
    timer = 0;
  }
  if (p == 1) {
    rect(mouseX - 0.5 * playerSize, mouseY - 0.5 * playerSize, playerSize, playerSize);
  }
  
  if (diffFrame > maxSpeed) {
    maxSpeed = (int)diffFrame * p;
  }
  totalDistance += diffFrame * p;
  avSpeed = totalDistance / totalFrames;
  
  //BUTTONS (work in progress)
  //Button(300, 300, 100, 100, "PAUSE", 27);
  
  
  
  //TEXT
  textSize(32);
  fill(0);
  String diffTextFrame = Float.toString(diffFrame);
  String diffSecText = Float.toString(diffSec);
  text("Mouse speed: " + diffTextFrame + " Pixels/frame", 5, height - 10);
  text("Mouse speed: " + diffSecText + " Pixels/sec", 5, height - 45);
  text("Max mouse speed: " + maxSpeed + " Pixels/frame", 5, height - 80);
  text("Average mouse speed: " + avSpeed + " Pixels/frame", 5, height - 115);
  text("Total traveled distance: " + totalDistance + " Pixels", 5, height - 150);
  text("FPS: " + frameRate, width - 200, 30);
  
  //GRAPH
  fill(255);
  rect(10, 10, 300, 300);
  stroke(0);
  line(10, 160, 310, 160);
  line(160, 10, 160, 310);
  fill(0 + diffFrameN * 3, 0, 200 - diffFrameN * 3);
  rect(145 - diffX, 145 - diffY, 30, 30);
  rect(width - 100, height - 100, 200, 200);

  lastMouseX = mouseX  * p;
  lastMouseY = mouseY  * p;
}

public void Button(float x, float y, float BWidth, float BHeight, String text, float size) {
  int pressedTimer = 0;
  pressedTimer += 1;
  if(mouseY > y && mouseY < y + BHeight && mouseX > x && mouseX < x + BWidth){ 
    fill(backR + 30, backG + 30, backB + 30);
    if (p == 1 && pressedTimer > 60){
      p = 0;
      pressedTimer = 0;
    } else if (pressedTimer > 60){
      p = 1;
      pressedTimer = 0;
    }
  } else {
    fill(backR, backG, backB);
  }
  rect(x, y, BWidth, BHeight);
  fill(0);
  textSize(size);
  text(text, x + BWidth/10, y + BHeight/2);
}
