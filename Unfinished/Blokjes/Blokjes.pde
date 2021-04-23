float num = 0;
float frames = 0;
float w = 5;
float xOffset = 0;
//When fullscreen is enabled only the l counts
boolean fullScreen = true;
//When l = width and fullScreen = true the picture will be the sharpest
float l = 1920/16;
float u = 0;
float x,y;
float r = 255, g = 0, b = 0, lastH, newH, cc = 50;
boolean strokeEnabled = false;

void setup() {
  //size(600, 600);
  fullScreen();
  frameRate(6000);
  if (fullScreen) {
    w = width/l;
  }
  cc = w*255/(height/6);
  background(0);
}

void draw() {
  
  fill(0);
  rect(100, 100, 350, 100);
  fill(255);
  text(frameRate + "\nEstimated amount of time until completion: " + (((1920*1080)/(1920/l * 1080/l)) - num)/frameRate, 150, 150);
  frames++;
  //newPoint();
  //u = (mouseY)/100;
  if (frames >= u) {
    newPoint();
    frames = 0;
  }
  newH = (float)Math.floor(num/l);
  if (newH != lastH) {
    if (newH<=(255/cc)) {
      g+=cc;
    }
    if (newH>=(255/cc) && newH<=2*(255/cc)) {
      r-=cc;
    }
    if (newH>=2*(255/cc) && newH<=3*(255/cc)) {
      b+=cc;
    }
    if (newH>=3*(255/cc) && newH<=4*(255/cc)) {
      g-=cc;
    }
    if (newH>=4*(255/cc) && newH<=5*(255/cc)) {
      r+=cc;
    }
    if (newH>=5*(255/cc) && newH<=6*(255/cc)) {
      b-=cc;
    }
    
  }
  x = (float)(num*w - w*l*(Math.floor(num/l))+xOffset);
  y = (float)(Math.floor(num/l)*w);
  
  lastH = (float)Math.floor(num/l);
}

void mouseClicked() {

}


void newPoint() {
  //rect((float)(num*w - l*(Math.floor(num/12)) + xOffset), (float)(Math.floor(num/12)*w), w, w);
  if (!strokeEnabled) {
    noStroke();
  }
  fill(r, g, b);
  rect(x, y, w, w);
  num++;
  //rect((float)(num - 12*(Math.floor(num/12))), (float)(Math.floor(num/12)), (float)(num - 12*(Math.floor(num/12))), (float)(Math.floor(num/12)));
  //rect(x, y, 50, 50);
  
}
