//by Milan, started 19-10-2020, ver 1.0

int tileAmt = 15; //Tile amount only for one axis, say this value is 5, there will be 25 actual tiles
int bombAmt = 40; //Total bomb amount



//No touchy these variables
boolean gameOver;
boolean gameWon;
boolean firstTileUncovered;
boolean alwaysShowBombs = false;

float tileSpace = 2; //Space between tiles
float tileSize = (600-tileSpace)/(tileAmt); //Automatically calculating the exact size of the tiles using the space and amount
Tile[][] tiles = new Tile[tileAmt][tileAmt]; //Tile array which stores the tiles

int safeSpaceUncovered = 0;

//Buttons
float buttonX = 400;

int mousePressedFrames = 0;
int mousePressedTimes = 0;

void setup() {
  size(600, 650);
}

void draw() {
  background(200);
  noFill();
  rect(0, 0, 600, 600);
  gameOver();
  drawSquares();
  drawButtons();
  if (mousePressed) {
    if (mousePressedFrames%(20-constrain(mousePressedTimes, 0, 19)) == 0) {
      if (mouseOn(buttonX, 604, 56, 21)) {tileAmt++; resetField();}
      else if (mouseOn(buttonX, 604+21, 56, 21)) {tileAmt--; resetField();}
      else if (mouseOn(buttonX + 140, 604, 56, 21)) {bombAmt++; resetField();}
      else if (mouseOn(buttonX + 140, 604 + 21, 56, 21)) {bombAmt--; resetField();}
      mousePressedTimes++;
    }
    mousePressedFrames++;
  }
}

void gameOver() {
  fill(15);
  textSize(18);
  text((gameWon ? "YOU WIN! :D\np" : "P") + (gameOver ? "Game over\np" : "") + "ress r to restart", 15, height-33);
}

void resetField() {
  gameOver = false;
  firstTileUncovered = false;
  tileAmt = constrain(tileAmt, 4, 100);
  tiles = new Tile[tileAmt][tileAmt];
  tileSize = (600-tileSpace)/(tileAmt);
  safeSpaceUncovered = 0;
  bombAmt = constrain(bombAmt, 1, tileAmt*tileAmt-9);
  for (int i = 0; i < tileAmt*tileAmt; i++) tiles[i%tileAmt][floor(i/tileAmt)] = new Tile(i%tileAmt, floor(i/tileAmt), false);
}

void drawButtons() {
  fill(60);
  for (int i = 0; i < 2; i++) {
    for (int b = 0; b < 2; b++) {
      rect(buttonX + i*140, 604 + b*21, 56, 21);
    }
  }
  fill(0);
  textSize(20);
  text("Bombs:", 460, height-29);
  text(bombAmt, 470, height-7);
  
  text("Field size:", 300, height-29);
  text(tileAmt + "x" + tileAmt, 310, height-7);
  
  fill(255);
  text("+", 561, height-29);
  text("-", 564, height-7);
  text("+", 420, height-29);
  text("-", 423, height-7);
}

void generateField(int clearX, int clearY) {
  //Generating new tiles
  resetField();
  //for (int i = 0; i < tileAmt*tileAmt; i++) tiles[i%tileAmt][floor(i/tileAmt)] = new Tile(i%tileAmt, floor(i/tileAmt), false);
  //Generating bombs
  generateBombs(clearX, clearY);
  //Setting the values for the amount of bombs taht are nearby each tile
  for (int i = 0; i < tileAmt*tileAmt; i++) tiles[i%tileAmt][floor(i/tileAmt)].checkBombsClose();
  gameOver = false;
}

void drawSquares() {
  fill(230);
  for (int y = 0; y < tileAmt; y++) {
    for (int x = 0; x < tileAmt; x++) {
      //Temporary variables to determine what to draw, if anything other than a simple square
      boolean drawBombCloseAmt = false;
      boolean drawFlag = false;
      
      //Choosing the correct color, and choosing things to draw, like a flag
      
      //A first tile has been uncovered
      if (firstTileUncovered) {
        //Tile uncovered
        if (tiles[x][y].uncovered) {
          //Tile is a bomb
          if (tiles[x][y].isBomb) fill(255, 0, 0);
          //Tile has a number on it
          else if (tiles[x][y].bombsClose > 0) {fill(0); drawBombCloseAmt = true; fill(200);}
          //Tile is empty
          else fill(200);
        }
        //Tile still covered
        else {
          //Tile is a bomb, but bombs have to be shown
          if (alwaysShowBombs && tiles[x][y].isBomb) fill(255, 0, 0);
          //Tile is flagged
          else if (tiles[x][y].flagged) {fill(120); drawFlag = true;}
          //Tile is just covered
          else fill(150);
        }
      }
      //No tiles uncovered yet
      else fill(150);
      
      //Drawing the actual tile
      rect(x * tileSize + tileSpace, y * tileSize + tileSpace, tileSize-tileSpace, tileSize-tileSpace);
      
      //Drawing the text for the amount of bombs closeby
      if (drawBombCloseAmt) {fill(0); textSize(tileSize-tileSpace*2); text(tiles[x][y].bombsClose, x*tileSize+9, y*tileSize + tileSize - 3);}
      
      //Drawing the flag (vertex data made using another program)
      if (drawFlag) {
        fill(color(227, 0, 0));
        noStroke();
        float xOffset = (x+0.5)*tileSize;
        float yOffset = (y+0.8)*tileSize;
        float sc = 15/(float)tileAmt;
        beginShape();
        vertex(-2.0*sc + xOffset, -24.0*sc + yOffset);
        vertex(-2.0*sc + xOffset, -2.5*sc + yOffset);
        vertex(-7.0*sc + xOffset, -2.5*sc + yOffset);
        vertex(-7.0*sc + xOffset, yOffset);
        vertex(6.0*sc + xOffset, yOffset);
        vertex(6.0*sc + xOffset, -2.5*sc + yOffset);
        vertex(1.0*sc + xOffset, -2.5*sc + yOffset);
        vertex(1.0*sc + xOffset, -14.0*sc + yOffset);
        vertex(9.0*sc + xOffset, -19.0*sc + yOffset);
        vertex(-2.0*sc + xOffset, -24.0*sc + yOffset);
        endShape();
        stroke(0);
      }
    }
  }
}

void generateBombs(int clearX, int clearY) {
  for (int i = 0; i < bombAmt; i++) {
    boolean bombGenerated = false;
    while (!bombGenerated) {
      //Generating random coordinates for a bomb
      int x = int(random(tileAmt));
      int y = int(random(tileAmt));
      //Making sure the new bomb is not near the first pressed tile, nor on another bomb
      if (!tiles[x][y].isBomb && !checkWithinRange(x, y, clearX, clearY)) {
        tiles[x][y].isBomb = true;
        bombGenerated = true;
      }
    }
  }
}

boolean mouseInTile (int x, int y) { //Function used to check whether the mouse is on a tile
  return (mouseX >= x * tileSize + tileSpace && mouseX < x * tileSize + tileSize && mouseY >= y * tileSize + tileSpace && mouseY < y * tileSize + tileSize);
}

boolean checkWithinRange(int x, int y, int rx, int ry) { //Function used to check whether a point is next to another (also diagonaly)
  int range = 1;
  return (x >= rx-range && x <= rx+range && y >= ry-range && y <= ry+range);
}

boolean mouseOn(float x, float y, float sx, float sy) {
  return (mouseX >= x && mouseX <= x+sx && mouseY >= y && mouseY <= y+sy);
}

void keyPressed() {
  //Restarting the gameusing R key
  if (key == 'r') {
    gameOver = false;
    gameWon = false;
    firstTileUncovered = false;
  }
}

void mouseReleased() {
  //Calculating the tile position of the mouse
  int tileX = constrain(floor(mouseX/tileSize), 0, tileAmt-1);
  int tileY = constrain(floor(mouseY/tileSize), 0, tileAmt-1);
  //Checking whether mouse is in playing field
  if (!gameOver && mouseY <= 600 && mouseInTile(tileX, tileY)) {
    if (mouseButton == LEFT) {
      //Generaing new field when first tile has not yet been uncovered
      if (!firstTileUncovered) generateField(tileX, tileY);
      //Uncovering the selected tile
      if (!tiles[tileX][tileY].flagged) tiles[tileX][tileY].uncover();
      firstTileUncovered = true;
      print("Tile at " + floor(mouseX/tileSize) + ", " + floor(mouseY/tileSize) + " pressed, game over: " + gameOver + "\n");
    }
    //Setting/removing flag
    else if (mouseButton == RIGHT) {
      if (firstTileUncovered) tiles[tileX][tileY].flagged = !tiles[tileX][tileY].flagged;
    }
  }
  mousePressedFrames = 0;
  mousePressedTimes = 0;
}
