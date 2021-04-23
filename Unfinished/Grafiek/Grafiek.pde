int xOffset = 50;
int yOffset = 0;
int lines = 50;
float x = 0;
float y;
float scale = 60;
void setup() {
  size(600, 600);
  //translate(50, 50);
  frameRate(600);
}

void draw() {
  //background(204);
  translate(xOffset, height/2 + yOffset);
  Grafiek1();
  Checker();
}


void Grafiek1() {
  //x-as
  for(int i = 0; i <= (int)((width-xOffset)/lines); i++) {
    strokeWeight(0.5);
    textSize(15);
    
    //text(i, 50, 50);
    text(i*lines, i*lines + 2, 30);
    line(i*lines, -height/2 + yOffset, i*lines, height/2 + yOffset);
  }
  for(int i = 0; i <= height/lines; i++) {
    strokeWeight(0.5);
    textSize(15);
    text(-(i*lines-height/2), xOffset-90, i*lines-height/2 + 5);
    line(0, i*lines-height/2, width, i*lines-height/2);
  }
  strokeWeight(3);
  line(0,-width/2, 0,width/2);
  line(0,0, width,0);
}

void Checker() {
  x+=1;
  if(x >= width) {
    x = -1*xOffset;
  }
  strokeWeight(1);
  //line(x, -height/2, x, height/2);
  //FPS counter
  //text((int)frameRate, width-80, -(height/2)+15);
  
  //Calculations
  x /= scale;
  y = sin(x);
  float y2 = cos(x);
  x *= scale;
  dot1(x, y*scale);
  dot1(x, y2*scale);
}

void dot1(float x1, float y1) {
  ellipse(x1, y1, 1, 1);
}
