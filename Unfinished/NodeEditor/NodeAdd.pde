class NodeAdd extends Node {
  
  boolean mouseHovered;
  boolean mouseHoveredTopbar;
  boolean mouseDraggingTopbar;
  PVector mouseDraggingOffset;
  
  String nodeName = "Addition";
  
  Button[] button = new Button[1];
  
  boolean lastFrameMouseHover;
  
  NodeAdd(PVector p) {
    pos = p;
    instantiateButtons();
  }
  
  NodeAdd(float x, float y) {
    pos = new PVector(x, y);
    instantiateButtons();
  }
  
  void instantiateButtons() {
    button[0] = new Button(1, 0, 2.5, 2.5, 20, 20, size); //Button for deleting node
  }
  
  void drawNode() {
    // Pushing the matrix stack so that the top left of the node is (0, 0), making it easier to draw relative coords
    // Dragging
    if (mouseDraggingTopbar) {
      pos = new PVector(constrain(mouseDraggingOffset.x + mouseX, nodeEditorBegin.x + nodeMinDistFromEdge, nodeEditorEnd.x - size.x - nodeMinDistFromEdge), 
      constrain(mouseDraggingOffset.y + mouseY, nodeEditorBegin.y + nodeMinDistFromEdge, nodeEditorEnd.y - size.y - nodeMinDistFromEdge));
    }
    pushMatrix();
    
    translate(pos.x, pos.y);
    //Drawing the basic node parts, which should be mostly the same for every node
    drawRegularNode();
    
    for (Button b : button) {
      b.drawButton();
    }
    
    fill(255);
    textSize(nodeTopBarHeight/2);
    text(nodeName, 5, 18);
    
    popMatrix();
  }
  
  void mouseHover(float x, float y) {
    //Gettting mouse down position relative to the node
    float relX = x-pos.x;
    float relY = y-pos.y;
    //print("Relative mouse position: (" + relX + ", " + relY + ")\n");
    
    mouseHoveredTopbar = relY <= nodeTopBarHeight;
    //print(mouseHoveredTopbar);
    
    //Going over each button, and checkign whether the mouse is hovering over it
    for (Button b : button) {
      b.hovered = (mouseOnButton(b, relX, relY));
    }
  }
  
  void mouseDown(float x, float y) {
    mouseDraggingTopbar = mouseHoveredTopbar;
    mouseDraggingOffset = new PVector(pos.x-x, pos.y-y);
  }
  
  void mouseUp(float x, float y, boolean onNode) {
    mouseDraggingTopbar = false;
    if (onNode) {
      
    }
  }
  
  //Checking whether mouse is on a button based on the relative position of both the button and the mouse
  boolean mouseOnButton(Button b, float x, float y) {
    return (x >= b.pos.x && x <= b.pos.x + b.size.x && y >= b.pos.y && y <= b.pos.y + b.size.y);
  }
}
