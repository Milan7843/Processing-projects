class Node {
  PVector pos;
  PVector size = new PVector(100, 150);
  
  float[] inputNodes;
  float[] outputNodes;
  
  void drawRegularNode() {
    fill(nodeColour);
    stroke(nodeStroke);
    strokeWeight(nodeStrokeWeight);
    rect(0, 0, size.x, size.y, 3);
    line(0, nodeTopBarHeight, size.x, nodeTopBarHeight);
  }  
}
