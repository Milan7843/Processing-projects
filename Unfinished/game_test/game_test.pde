float x = 50, y = 50, playerSpeed = 4, playerWidth = 50;
boolean up, down , right, left;
float x1 = 150, x2 = 50 + playerWidth, x3 = 50 + playerWidth, x4 = 50;
float y1 = 150, y2 = 50, y3 = 50 + playerWidth, y4 = 50 + playerWidth;
float angle;
void setup() {
  size(600, 600);
  rectMode(CENTER);
} 

void draw() {
  angle = (mouseY-y1)/(mouseX-x1);
  
  
  
  //x2 = x1 + playerWidth * angle;
  
  background(200, 30, 50);
  Player();
  
  if(up) {
    y1-=playerSpeed; 
  }
  if(down) {
    y1+=playerSpeed; 
  }
  if(left) {
    x1-=playerSpeed; 
  }
  if(right) {
    x1+=playerSpeed; 
  } 
}

void Player() {
  fill(120, 40, 50);
  rect(50, 50, 50, 50);
  translate(x1, y1);
  rotate(PI * 1 + atan2((y1 - mouseY), (x1 - mouseX))); 
  rect(0, 0, x, y);
  
}

void keyPressed() {
  if (key == 'w') {
    up = true;
  }
  if (key == 'a') {
    left = true;
  }
  if (key == 's') {
    down = true;
  }
  if (key == 'd') {
    right = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    up = false;
  }
  if (key == 'a') {
    left = false;
  }
  if (key == 's') {
    down = false;
  }
  if (key == 'd') {
    right = false;
  }
}
