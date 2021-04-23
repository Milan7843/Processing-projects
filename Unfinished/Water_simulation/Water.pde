class Water {
  PVector pos;
  Water(float x, float y) {
    pos = new PVector(x, y);
  }
  
  void update() {
    if (!pixelOccupied((int)pos.x, (int)pos.y+1)) {
      pos.y++;
    }
    else if (!pixelOccupied((int)pos.x-1, (int)pos.y+1)) {
      pos.x--;
      pos.y++;
    }
    else if (!pixelOccupied((int)pos.x+1, (int)pos.y+1)) {
      pos.x++;
      pos.y++;
    }
    else if (!pixelOccupied((int)pos.x-2, (int)pos.y+1)) {
      pos.x -= 2;
      pos.y++;
    }
    else if (!pixelOccupied((int)pos.x+2, (int)pos.y+1)) {
      pos.x += 2;
      pos.y++;
    }
    else if (!pixelOccupied((int)pos.x-3, (int)pos.y+1)) {
      pos.x -= 3;
      pos.y++;
    }
    else if (!pixelOccupied((int)pos.x+3, (int)pos.y+1)) {
      pos.x += 3;
      pos.y++;
    }
    /*
    else if (!pixelOccupied((int)pos.x+1, (int)pos.y)) {
      pos.x++;
    }
    else if (!pixelOccupied((int)pos.x-1, (int)pos.y)) {
      pos.x--;
    }
    */
  }
  
  void show() {
    stroke(0, 0, 255);
    point(pos.x, pos.y);
  }
}
