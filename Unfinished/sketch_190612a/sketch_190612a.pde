float num = 0;
float frames = 0;
float w = 50;
float xOffset = 50;
float l = 50;
float u = 50;


void setup() {
  size(600, 600);
  frameRate(60);
}

void draw() {
  frames++;
  //newPoint();
  u = (mouseY)/100;
  if (frames >= u) {
    newPoint();
    frames = 0;
  }
}

void mouseClicked() {

}


void newPoint() {
  num++;
  //rect((float)(num - (width/w) * Math.floor(num/(width/w))) - w, num*w, (float)(num - (width/w) * Math.floor(num/(width/w))), (num+1)*w);
  //rect((float)(num - 12*(Math.floor(num/12))), (float)(Math.floor(num/12)), (float)(num - 12*(Math.floor(num/12))), (float)(Math.floor(num/12)));
  for (int i = 0; i <= w; i++) {
    point((float)(num - l*(Math.floor(num/l)*w)+xOffset), (float)(Math.floor(num/l)*w + i));
    point((float)(num - l*(Math.floor(num/l)*w)+xOffset+i), (float)(Math.floor(num/l)*w));
  }
  
}
