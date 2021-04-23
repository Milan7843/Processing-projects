float playerX = 50, playerY = 50, playerWidth = 50, playerHeight = 50, playerSpeed = 3;
boolean up, down, left, right;
float angle;

void setup() {
  size(600, 600);
  frameRate(60);
}

void draw() {
  background(66, 226, 244);
  angle = playerY/mouseY;
  
  Player();
  
  if(left) {
    playerX -= playerSpeed;
  }
    
  if(right) {
    playerX += playerSpeed;
  }
  if(up) {
    playerY -= playerSpeed;
  }
    
  if(down) {
    playerY += playerSpeed;
  }
}

void keyPressed() {
  if(key == 'w') {
    up = true;
  }
  if(key == 's') {
    down = true;
  }
  if(key == 'a') {
    left = true;
  }
  if(key == 'd') {
    right = true;
  }
}

void keyReleased() {
  if(key == 'w') {
    up = false;
  }
  if(key == 's') {
    down = false;
  }
  if(key == 'a') {
    left = false;
  }
  if(key == 'd') {
    right = false;
  }
}

void Player() {
  //Rendering the player
  beginShape();
  vertex(playerX, playerY);
  vertex(playerX, playerY * angle);
  vertex(playerX*-angle+playerWidth, playerY*angle+playerHeight);
  vertex(playerX*-angle, playerY);
  endShape();
}
