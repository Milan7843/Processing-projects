float rectX = 200;
float rectY = 200;
float cloudX = 100;
float seaHeight = 350;
//RESOLUTIE
int displayHeight = 1080;
int displayWidth = 1920;

int iPX1 = 200;
int iPY1 = 50;
//int iPX2 = 200;
//int iPY2 = 50;
//int iPX3 = 200;
//int iPY3 = 50;
int mult1 = 1;
float cloudDarkener = 0;
float cloudSize = 0.5;
float watR = 0;
float watG = 50;
float watB = 255;
boolean reflectie = false;
int ref = 15;


void setup() {
  size(displayWidth, displayHeight);
}

public void draw() {
  float zonGrootte = 150 + mouseY * 0.2;
  //BACKGROUND
  stroke(255 - mouseY, 255 - mouseY, 255 - mouseY * 0.6);
  fill(255 - mouseY, 255 - mouseY, 255 - mouseY * 0.6);
  rect(0, 0, displayWidth, displayHeight);
  stroke(0);
  if (iPX1 > displayWidth + 50) {
    mult1 = -1;
  }
  if (iPX1 < -50) {
    mult1 = 1;
  }
  cloudDarkener = mouseY * 0.2;
  iPX1 += 1 * mult1;
  //iPX2 += 1;
  //iPX3 += 1;
  
  if(reflectie != true) {
    Zon(zonGrootte);
    stroke(watR, watG, watB);
    fill(watR, watG, watB);
    rect(0, displayHeight - seaHeight, displayWidth, seaHeight);
  } else {
    Weer(zonGrootte);
  }
  Cloud();
  
}

public void Cloud() {
  stroke(200 - cloudDarkener, 200 - cloudDarkener, 200 - cloudDarkener);
  Circle(iPX1, iPY1);
  Circle(iPX1 - 50 * cloudSize, iPY1 + 50 * cloudSize);
  Circle(iPX1 + 50 * cloudSize, iPY1 + 30 * cloudSize);
  Circle(iPX1 + 100 * cloudSize, iPY1 + 50 * cloudSize);
  fill(200 - cloudDarkener, 200 - cloudDarkener, 200 - cloudDarkener);
  rect(iPX1 - 50 * cloudSize, iPY1, 150 * cloudSize, 100 * cloudSize);
  stroke(0);
}

public void Circle(float circleX, float circleY) {
  fill(200 - cloudDarkener, 200 - cloudDarkener, 200 - cloudDarkener);
  ellipse(circleX, circleY, 100 * cloudSize, 100 * cloudSize);
}

public void Zon(float zonGrootte) {
  stroke(255, 255 - mouseY * 0.4, 0);
  fill(255, 255 - mouseY * 0.4, 0);
  ellipse(displayWidth/2, mouseY, zonGrootte, zonGrootte);
}

public void Weer(float zonGrootte) {
  stroke(watR, watG, watB);
  fill(watR, watG, watB);
  rect(0, displayHeight - seaHeight, displayWidth, seaHeight);
  stroke(0);
  Zon(zonGrootte);
  for(int i = 0; i < ref; i++) {
    stroke(watR, watG, watB);
    fill(watR, watG, watB);
    rect(0, displayHeight - seaHeight + i*10, displayWidth, 5);
  }
  rect(0, displayHeight - seaHeight + ref*10, displayWidth, 800);
  stroke(0);
}
