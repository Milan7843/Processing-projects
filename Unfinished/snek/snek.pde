//ander idee: je gaat met je muis over vierkantjes heen en als je een raakt wordt hij rood en dan wordt het langzaam weer wit ofzo

//up = 0, right = 1, down = 2, left = 3
int dir = 1;
boolean lines = false;
int maxTailLength = 50;
int spaceAmount = 9;
PVector[] pos = new PVector[maxTailLength];
PVector lastpos = new PVector(0, 0);
PVector[] animate = new PVector[8];
float framesPast = 0;
void setup() {
  size(600, 600);
  frameRate(60);
  for (int i = 0; i < maxTailLength; i++) {
    pos[i] = new PVector(0, 0);
  }
  animate[0] = new PVector(4, 4);
  animate[1] = new PVector(5, 4);
  animate[2] = new PVector(6, 4);
  animate[3] = new PVector(6, 5);
  animate[4] = new PVector(6, 6);
  animate[5] = new PVector(5, 6);
  animate[6] = new PVector(4, 6);
  animate[7] = new PVector(4, 5);
}

void draw() {
  background(255);
  if (lines)
    lines();
  mouse();
  framesPast++;
}

void lines() {
  for (int i = 0; i < spaceAmount; i++) {
    //vertical lines
    line(i * width/spaceAmount, 0, i * width/spaceAmount, height);
    //horizontal lines
    line(0, i * height/spaceAmount, width, i * height/spaceAmount);
  }
}

void mouse() {
  float tempx = floor(mouseX / (width/spaceAmount));
  float tempy = floor(mouseY / (height/spaceAmount));
  if (tempx > pos[0].x + 1 || tempx < pos[0].x - 1 || tempy > pos[0].y + 1 || tempy < pos[0].y - 1) {
    fill(0);
    //text("suh", 50, 50);
  }
  noStroke();
  //rect(tempx * (width/spaceAmount), tempy * (width/spaceAmount), (width/spaceAmount), (width/spaceAmount));
  for (int i = 0; i < maxTailLength; i++) {
    if (i >= 1) {
      pos[maxTailLength-i] = pos[maxTailLength - i - 1];
      //text(pos[i].x + "" + pos[i].y, 30, 20 + i * 25);
    }
    else {
      pos[i] = new PVector(tempx, tempy);
      //pos[i] = animate[int(framesPast % 8)];
    }
    float r,g,b;
    r = 255;
    g = 255/maxTailLength * i;
    b = 255/maxTailLength * i;
    fill(r,g,b);
    rect(pos[i].x * (width/spaceAmount), pos[i].y * (width/spaceAmount), (width/spaceAmount), (width/spaceAmount));
  }
}
