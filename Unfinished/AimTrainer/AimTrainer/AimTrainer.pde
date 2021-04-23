//Target variables
float x,y,d,radius = 150, distance, change = 1;
float t, t2, target;
float timer = 15;
int score = 0;
boolean new1 = true, make = true;
float x1, y1;
float r=255,g=0,b=0;
float rX, rY, rHeight = 255, sliderWidth = 20, height2 = 20;
float rCircleY = 240, gCircleY = 134, bCircleY = height2;
float gX, gY, gHeight = 255, gWidth;
float bX, bY, bHeight = 255, bWidth;
//Percentage
float settingsPanelWidth = 15;
float circleWidth = 30;
//stop button
float stopX = 20, stopY, stopWidth, stopHeight = 40;
float startX = 20, startY, startWidth, startHeight = 40;
float offset = radius/2;
float pause = 0;
float sliderTextOffset = 25;
float size, time;
boolean start = false;
boolean rgb = false;
float i1 = 0, i2 = 0, i3 = 0, i4 = 0, startSize = 200;
float startTimer;
//Stats
float cps = 15, misses = 0, totalClicks = 0, accuracy = 0, totalFrames = 0;
float realSize;
//R = Timer
//G = Size
//B = ??

void setup() {
  //size(600,600);
  fullScreen();
  frameRate(60);
  stopY = height - 150;
  startY = height - 200;
  settingsPanelWidth = width*(0.01*settingsPanelWidth);
  stopWidth = settingsPanelWidth- 40;
  startWidth = settingsPanelWidth- 40;
  rX = (settingsPanelWidth/4)-(0.5*sliderWidth);
  gX = (settingsPanelWidth/4)*2-(0.5*sliderWidth);
  bX = (settingsPanelWidth/4)*3-(0.5*sliderWidth);
  background(255);
  time = timer;
}
void draw() {
  if (rgb) {
    background(r,g,b);
  }
  else {
    background(255);
  }
  totalFrames++;
  t += pause;
  t2++;
  if (pause == 1) {
    cps = totalClicks/(totalFrames/60);
  }
  //Timer
  if (pause == 0) {
    time = timer;
  }
  if (t >= frameRate+1) {
    if (make) {
      time -= pause;
    }
    t=0;
  }
  
  //Start timer
  if (start) {
    fill(0);
    stroke(0);
    startTimer++;
    if (startTimer<=60) {
      i1++;
      textSize(startSize + i1);
      text("3", (width-settingsPanelWidth)/2, height/2 + .5*(i1+startSize));
    }
    if (startTimer>=60 && startTimer<=120) {
      i2++;
      textSize(startSize + i2);
      text("2", (width-settingsPanelWidth)/2, height/2 + 0.5*(i2+startSize));
    }
    if (startTimer>=120 && startTimer<=180) {
      i3++;
      textSize(startSize + i3);
      text("1", (width-settingsPanelWidth)/2, height/2 + 0.5*(i3+startSize));
    }
    if (startTimer>=180 && startTimer<=240) {
      i4++;
      textSize(startSize + i4);
      text("START", (width-settingsPanelWidth)/2 - 150, height/2 + 0.5*(i4+startSize));
    }
    if (startTimer >= 240) {
      startNow();
      startTimer = 0;
      start = false;
    }
  }
  
  //Making a new target
  if (new1 && make && pause == 1) {
    x=random(settingsPanelWidth+offset, width-offset);
    y=random(offset, height-offset);
    realSize = radius - score*change;
  }
  if (time <= 0) {
    end();
  }
  new1 = false;
  textSize(50);
  if (rgb) {
    fill(255-r, 255-g, 255-b);
  }
  else {
    fill(0);
  }
  text((int)time, settingsPanelWidth+20, 50);
  if (make) {
    //noStroke();
    strokeWeight(2);
    ellipse(x, y, realSize, realSize);
    if (!rgb) {
      fill(0);
    }
    if (score <10) {
      text(score, width-50, 50);
    } else {
      text(score, width-70, 50);
    }
  }
  //Final score indicator
  if (!make && !start) {
    if (!rgb) {
      fill(0);
      stroke(0);
    }
    textSize(150);
    text(score, width/2-100, height/2);
    textSize(50);
    text("CPS: " + cps , width/2-100, height/2+50);
    text("Misses: " + misses , width/2-100, height/2+110);
    text("Total Clicks: " + totalClicks , width/2-100, height/2+170);
    text("Accuracy: " + accuracy + "%" , width/2-100, height/2+230);
  }
  
  if (t2<=255) {
    g++;
  }
  if (t2>=255 && t2<=510) {
    r--;
  }
  if (t2>=510 && t2<=765) {
    b++;
  }
  if (t2>=765 && t2<=1020) {
    g--;
  }
  if (t2>=1020 && t2<=1275) {
    r++;
  }
  if (t2>=1275 && t2<=1530) {
    b--;;
  }
  if (t2>1530) {
    t2=0;
  }
  settingsPanel();
  stopButton();
  startButton();
  background();
  text(mouseY, 20, 500);
  accuracy = (misses-totalClicks)/totalClicks*-100;
}

void background() {
  if (t2<=255) {
    g++;
  }
  if (t2>=255 && t2<=510) {
    r--;
  }
  if (t2>=510 && t2<=765) {
    b++;
  }
  if (t2>=765 && t2<=1020) {
    g--;
  }
  if (t2>=1020 && t2<=1275) {
    r++;
  }
  if (t2>=1275 && t2<=1530) {
    b--;;
  }
  if (t2>1530) {
    t2=0;
  }
}

void settingsPanel() {
  fill(210, 210, 255);
  stroke(0);
  strokeWeight(1);
  rect(0,0, settingsPanelWidth, height);
  fill(255);
  rect(rX, height2, sliderWidth, rHeight);
  rect(gX, height2, sliderWidth, gHeight);
  rect(bX, height2, sliderWidth, bHeight);
  
  fill(255);
  ellipse(rX + sliderWidth/2, rCircleY, circleWidth, circleWidth);
  fill(255);
  ellipse(gX + sliderWidth/2, gCircleY, circleWidth, circleWidth);
  fill(255);
  ellipse(bX + sliderWidth/2, bCircleY, circleWidth, circleWidth);
    //text("T"\n"i"\n"m"\n"e"\n"r", rX-sliderTextOffset, rY);
  textSize(15);
  text("T\nI\nM\nE\nR", rX-sliderTextOffset, rY+50);
  text("S\nT\nA\nR\nT\n\nS\nI\nZ\nE", gX-sliderTextOffset, gY+50);
  //text("T\nI\nM\nE\nR", rX-sliderTextOffset, rY+50);
  
  //Actual slider numbers
  text((int)timer, rX, 255+height2+30);
  text((int)radius, gX, 255+height2+30);
  
  //Stats
  //text("cps: " + cps, 20, height/2);
}

void stopButton() {
  stroke(2);
  fill(255);
  rect(stopX, stopY, settingsPanelWidth-2*stopX, stopHeight);
  fill(0);
  textSize(20);
  text("stop", stopX + 20, stopY + 27);
  fill(255);
}

void startButton() {
  stroke(2);
  fill(255);
  rect(startX, startY, settingsPanelWidth-2*startX, startHeight);
  fill(0);
  textSize(20);
  text("start", startX + 20, startY + 27);
  fill(255);
}

void mouseDragged() {
  x1=mouseX;
  y1=mouseY;
  
  //Sliders
  if (mouseX <= rX + sliderWidth && mouseX >= rX && mouseY <= height2 + rHeight && mouseY >= height2) {
    timer = (255-(rCircleY - height2))*0.4+1;
    rCircleY = mouseY;
  }
  //G
  if (mouseX <= gX + sliderWidth && mouseX >= gX && mouseY <= height2 + gHeight && mouseY >= height2) {
    radius = (255-(gCircleY - height2))+10;
    gCircleY = mouseY;
  }
  //B
  if (mouseX <= bX + sliderWidth && mouseX >= bX && mouseY <= height2 + bHeight && mouseY >= height2) {
    bCircleY = mouseY;
  }
}

void mousePressed() {
  x1=mouseX;
  y1=mouseY;
  distance = sqrt(sq(x1-x)+sq(y1-y));
  if (distance <= radius/2) {
    new1 = true;
    distance = radius + 1;
    score++;
  }
  else if (pause == 1 && mouseX >= settingsPanelWidth) {
    misses++;
  }
  if (mouseX <= rX + sliderWidth && mouseX >= rX && mouseY <= height2 + rHeight && mouseY >= height2) {
    timer = (255-(rCircleY - height2))*0.4+1;
    rCircleY = mouseY;
  }
  //G
  if (mouseX <= gX + sliderWidth && mouseX >= gX && mouseY <= height2 + gHeight && mouseY >= height2) {
    radius = (255-(gCircleY - height2))+10;
    gCircleY = mouseY;
  }
  //B
  if (mouseX <= bX + sliderWidth && mouseX >= bX && mouseY <= height2 + bHeight && mouseY >= height2) {
    bCircleY = mouseY;
  }
  //stop
  if (mouseX <=stopX + stopWidth && mouseX >= stopX && mouseY <= stopY + stopHeight && mouseY >= stopY) {
    pause = 0;
    t = 0;
    score = 0;
    cps = 0;
  }
  if (mouseX <= settingsPanelWidth) {
    if (pause == 1) {
      make = false;
    }
    pause = 0;
    t = 0;
    cps = 0;
  }
  //start
  if (mouseX <=startX + startWidth && mouseX >= startX && mouseY <= startY + startHeight && mouseY >= startY) {
    starter();
  }
  if (mouseX > settingsPanelWidth && pause == 1) {
    totalClicks++;
  }
  if (mouseX > settingsPanelWidth && pause == 0) {
    //starter();
  }
}

void end() {
  make = false;
  pause = 0;
  t = 0;
  cps = 0;
}

void starter() {
  start = true;
}

void startNow() {
  cps = 0;
  pause = 1;
  time = timer;
  score = 0;
  new1 = true;
  misses = 0;
  totalClicks = 0;
  make = true;
}

void keyPressed() {
  if (key == 'r') {
    if (rgb) {
      rgb = false;
    }
    else {
      rgb = true;
    }
  }
}
