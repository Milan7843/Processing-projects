int gameWidth = 20;
PVector[] snek = new PVector[int(sq(gameWidth))];
float gameWindowSize = 600;
float hokSize;
color snekColour = color(0, 0, 0);
color snekTailColour = color(255, 255, 255);
color backgroundColour = color(100, 200, 255);
int snekLength = 5;
PVector dir = new PVector(1, 0);
PVector currentDir = new PVector(1, 0);
float snekUpdateFrames = 20;
float totalFrames = 0;
color fontColour = color(0, 0, 50);
PVector applePos = new PVector((int)random(gameWidth), (int)random(gameWidth));

boolean dead = false;

void setup() {
  frameRate(60);
  size(720, 720);
  hokSize = gameWindowSize/gameWidth;
  for (int i = 0; i < snekLength; i++) {
    snek[i] = new PVector(5 - i, 5);
  }
}

void draw() {
  background(220);
  //gameWidth = (int)(mouseX/10);
  DrawGameWindow();
  DrawSnek();
  if (totalFrames % snekUpdateFrames == 0 && !dead) {
    UpdateSnekPosition();
  }
  totalFrames++;
  CheckingIfDead();
  if (dead){ fill(255, 0, 0);}
  else {fill(0, 0, 0);}
  rect(0, 0, 50, 50);
  if (dead) {
    fill(255, 255, 255);
    strokeWeight(3);
    stroke(fontColour);
    rect(width/2 - width/2.5, height/2 - height/5, width/1.25, 200);
    fill(fontColour);
    textSize(90);
    text("GAME OVER", 100, height/2 - height/5 + 100);
    textSize(50);
    text("SPACE to play again", 120, height/2 - height/5 + 160);
  }
  strokeWeight(1);
  
  //Drawing the apple
  fill(255, 30, 30);
  rect(width/2 - gameWindowSize/2 + applePos.x * hokSize, height - gameWindowSize + applePos.y * hokSize, hokSize, hokSize);
}
void UpdateSnekPosition() {
  //snek[0] = new PVector(snek[0].x + dir.x, snek[0].y + dir.y);
  for (int i = snekLength; i > 0; i--) {
    snek[i] = snek[i-1];
  } 
  snek[0] = new PVector(snek[0].x + dir.x, snek[0].y + dir.y);
  currentDir = dir;
  //Cheking if you touch the apple
  if (snek[0].equals(applePos)) {
    snekLength++;
    applePos = new PVector((int)random(gameWidth), (int)random(gameWidth));
  }
}

void CheckingIfDead() {
  //Je hoeft alleen de eerste te checken!!
  for (int n = 0; n < snekLength; n++) {
    if (snek[0].equals(snek[n])) {
      //dead = true;
      //print(snek[0] + "  " + snek[n]);
      //return;
    }
  }
  if (snek[0].x > gameWidth-1 || snek[0].x < 0 || snek[0].y > gameWidth-1 || snek[0].y < 0) {
    dead = true;
  }
  print(dead);
}

void DrawGameWindow() {
  fill(backgroundColour);
  rect(width/2 - gameWindowSize/2, height - gameWindowSize, gameWindowSize, gameWindowSize);
  stroke(backgroundColour -1);
  for (int x = 0; x < gameWidth + 1; x++) {
    line(width/2 - gameWindowSize/2 + x * hokSize, height - gameWindowSize, width/2 - gameWindowSize/2 + x * hokSize, height);
  }
  for (int y = 0; y < gameWidth; y++) {
    line(width/2 - gameWindowSize/2, height - gameWindowSize + y * hokSize, width/2 + gameWindowSize/2, height  - gameWindowSize + y * hokSize);
  }
}

void DrawSnek() {
  //fill(snekColour);
  for (int i = 0; i < snekLength; i++) {
    if (i != 0) {
      fill(snekTailColour);
    }
    else {
      fill(snekColour);
    }
    rect(width/2 - gameWindowSize/2 + snek[i].x * hokSize, height - gameWindowSize + snek[i].y * hokSize, hokSize, hokSize);
  }
}

void keyPressed() {
  if (key == 'w') {
    if (!currentDir.equals(new PVector(0, 1))) {
      dir = new PVector(0, -1);
    }
  } 
  else if (key == 'a') {
    if (!currentDir.equals(new PVector(1, 0))) {
      dir = new PVector(-1, 0);
    }
  }
  else if (key == 's') {
    if (!currentDir.equals(new PVector(0, -1))) {
      dir = new PVector(0, 1);
    }
  }
  else if (key == 'd') {
    if (!currentDir.equals(new PVector(-1, 0))) {
      dir = new PVector(1, 0);
    }
  }
  if (key == 32 && dead) {
    snekLength = 5;
    dead = false;
    dir = new PVector(1, 0);
    for (int i = 0; i < snekLength; i++) {
      snek[i] = new PVector(5 - i, 5);
    }
  }
}
