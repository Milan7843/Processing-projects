class Button {
  PVector pos;
  PVector size;
  color c;  // Regular colour
  
  boolean hovered;
  
  //without specified colour
  Button(int anchX, int anchY, float x, float y, float sx, float sy, PVector nodeSize) {
    pos = new PVector(anchX == 1 ? nodeSize.x-x-sx+1 : x, anchY == 1 ? nodeSize.y-y-sy+1 : y);
    size = new PVector(sx, sy);
    c = nodeButtonColor;
  }
  //with colour
  Button(int anchX, int anchY, float x, float y, float sx, float sy, PVector nodeSize, color col) {
    pos = new PVector(anchX == 1 ? nodeSize.x-x-sx+1 : x, anchY == 1 ? nodeSize.y-y-sy+1 : y);
    size = new PVector(sx, sy);
    c = col;
  }
  
  void drawButton() {
    fill(lerpColor(c, nodeButtonHoveredColor, hovered ? 0.1 : 0));
    rect(pos.x, pos.y, size.x, size.y, 2);
  }
}
