class Tile {
  //Tile properties
  int x;
  int y;
  boolean isBomb;
  int bombsClose;
  boolean uncovered;
  boolean flagged;
  
  //Function for creating a new tile
  Tile(int x_, int y_, boolean isBomb_) {
    x = x_;
    y = y_;
    isBomb = isBomb_;
  }
  
  void uncover() {
    uncovered = true;
    gameOver = isBomb;
    alwaysShowBombs = isBomb;
    if (!gameOver) safeSpaceUncovered++;
    if (safeSpaceUncovered >= sq(tileAmt)-bombAmt) {
      gameWon = true;
      gameOver = false;
    }
    //Checkign whether tile is empty, and uncovering neighbouring tiles if so
    if (bombsClose == 0) {
      for (int i = 0; i < 9; i++) {
        int ox = i%3-1;
        int oy = floor(i/3)-1;
        if (x+ox >= 0 && x+ox < tileAmt && y+oy >= 0 && y+oy < tileAmt && !(ox == 0 && oy == 0)) {
          if (!tiles[x+ox][y+oy].uncovered) tiles[x+ox][y+oy].uncover();
        }
      }
    }
  }
  
  void checkBombsClose() {
    bombsClose = 0;
    //Checking the amount of bombs closeby
    for (int oy = -1; oy < 2; oy++) {
      for (int ox = -1; ox < 2; ox++) {
        if (x+ox >= 0 && x+ox < tileAmt && y+oy >= 0 && y+oy < tileAmt) if (tiles[x+ox][y+oy].isBomb) bombsClose++;
      }
    }
  }
}
