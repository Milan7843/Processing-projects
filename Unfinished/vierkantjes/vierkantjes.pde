int xnum;
int ynum;
float num = 0;
float frames = 0;
float w;
float xOffset = 0;
//When fullscreen is enabled only the l counts
boolean fullScreen = true;
//When l = width and fullScreen = true the picture will be the sharpest
float l = 1920/8;
float u = 0;
float x,y;
float r = 255, g = 0, b = 0, lastH, newH, cc = 50;
boolean strokeEnabled = false;
int totalBlocks = 0;
boolean make;

PVector[] val = new PVector[90000];

void setup() {
  size(600, 600);
  //fullScreen();
  frameRate(6000);
  
  if (fullScreen) {
    w = width/l;
  }
  cc = w*255/(height/6);
  background(0);
}

void draw() {
  w = 20;
  xnum = (int)(width/w);
  ynum = (int)(height/w);
  fill(0);
  rect(100, 100, 100, 100);
  fill(255);
  text(frameRate, 150, 150);
  frames++;
  //newPoint();
  //u = (mouseY)/100;
  
  x = (1*w)*floor((0.01*w)*width/xnum * random(0, xnum));
  y = (1*w)*floor((0.01*w)*height/ynum * random(0, ynum));
  //val[totalBlocks] = new PVector(x, y);
  for (int i = 0; i <= totalBlocks-1; i++) {
    if (val[i] == val[totalBlocks]) {
      make = false;
    }
  }
  if (frames >= u && make) {
    newPoint();
    frames = 0;
    
    val[totalBlocks] = new PVector(x, y);
    totalBlocks++;
  }
  make = true;
  
  println(totalBlocks);
}

void mouseClicked() {

}


void newPoint() {
  if (!strokeEnabled) {
    noStroke();
  }
  fill(r, g, b);
  rect(x, y, w, w);
  num++;
  
}
