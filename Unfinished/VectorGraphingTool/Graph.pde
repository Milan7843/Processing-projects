class Graph {
  float minDst = 5;
  float scale = 400;
  PVector pan = new PVector(300, 300);
  float panSens = 1;


  Graph() {
  }

  void drawGraph() {
    stroke(0);
    fill(darkMode ? darkGraphColor : lightGraphColor);
    rect(graphPos.x-2, graphPos.y-2, graphSize.x+4, graphSize.y+4);
    float lineDst = 0.001*scale;
    while (lineDst < minDst) {
      lineDst *= 10;
    }
    strokeWeight(1);
    float stroke = map(lineDst, minDst, minDst*10, 255, 100);
    stroke(stroke);
    if (stroke > 100) drawGrid(lineDst);
    strokeWeight(1);
    drawGrid(lineDst*10);
    stroke(darkMode ? darkGraphLineColor : lightGraphLineColor);
    drawLine(4, 4, 7, -3);
    circle(spaceToScreenX(0), spaceToScreenY(0), 6);
    circle(spaceToScreenX(1), spaceToScreenY(1), 6);
    strokeWeight(2);
    
    if (pan.x+graphPos.x > graphPos.x && pan.x+graphPos.x < (graphPos.x+graphSize.x)) {
      line(pan.x+graphPos.x, graphPos.y, pan.x+graphPos.x, (graphPos.y+graphSize.y));
    }
    if (pan.y+graphPos.y > graphPos.y && pan.y+graphPos.y < (graphPos.y+graphSize.y)) {
      line(graphPos.x, pan.y+graphPos.y, (graphPos.x+graphSize.x), pan.y+graphPos.y);
    }
  }

  void drawFunction(Function func) {
    float t = func.inputfield[2].numValue;
    while (t < func.inputfield[3].numValue) {
      PVector p1 = func.getPos(t);
      
      t += stepSize;
      if (t >= func.inputfield[3].numValue)
        t = func.inputfield[3].numValue;
      PVector p2 = func.getPos(t);
      drawLine(p1.x, p1.y, p2.x, p2.y);
    }
  }


  void drawLine(float x1, float y1, float x2, float y2) {
    PVector p1 = spaceToScreen(new PVector(x1, y1));
    PVector p2 = spaceToScreen(new PVector(x2, y2));
    //Case 1: line is fully in screen
    //if (p1.x >= graphPos.x && p1.x <= (graphPos.x+graphSize.x) && p1.y >= graphPos.y && p1.y <= (graphPos.y+graphSize.y) && p2.x >= graphPos.x && p2.x <= (graphPos.x+graphSize.x) && p2.y >= graphPos.y && p2.y <= (graphPos.y+graphSize.y)) {
    line(p1.x, p1.y, p2.x, p2.y);
    //}
  }

  void drawGrid(float lineDst) {
    PVector panMod = new PVector(pan.x%lineDst, pan.y%lineDst);
    if (panMod.x < 0) panMod.x+=lineDst;
    if (panMod.y < 0) panMod.y+=lineDst;

    stroke(darkMode ? darkGraphLineColor : lightGraphLineColor);
    strokeWeight(constrain(map(lineDst, minDst, minDst*10, 0, 1), 0, 1));
    
    //Vertical lines
    int i = 0;
    while (i*lineDst + graphPos.x + panMod.x < (graphPos.x+graphSize.x)) {
      line(i*lineDst + graphPos.x + panMod.x, graphPos.y, i*lineDst + graphPos.x + panMod.x, (graphPos.y+graphSize.y));
      i++;
    }

    //Horizontal lines
    i = 0;
    while (i*lineDst + graphPos.y + panMod.y < (graphPos.y+graphSize.y)) {
      line(graphPos.x, i*lineDst + graphPos.y + panMod.y, (graphPos.x+graphSize.x), i*lineDst + graphPos.y + panMod.y);
      i++;
    }
    stroke(0);
    strokeWeight(1);
  }



  PVector spaceToScreen(PVector spaceCoord) {
    return new PVector(spaceCoord.x*scale+pan.x+graphPos.x, -spaceCoord.y*scale+pan.y+graphPos.y);
  }

  float spaceToScreenX(float spaceCoord) {
    return spaceCoord*scale+pan.x+graphPos.x;
  }

  float spaceToScreenY(float spaceCoord) {
    return -spaceCoord*scale+pan.y+graphPos.y;
  }

  PVector screenToSpace(PVector screenCoord) {
    return new PVector((screenCoord.x-graphPos.x-pan.x)/scale, -(screenCoord.y-graphPos.y-pan.y)/scale);
  }

  float screenToSpaceX(float screenCoord) {
    return (screenCoord-graphPos.x-pan.x)/scale;
  }

  float screenToSpaceY(float screenCoord) {
    return -(screenCoord-graphPos.x-pan.x)/scale;
  }
}
