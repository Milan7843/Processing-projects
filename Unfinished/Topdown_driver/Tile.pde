class Tile {
  
  PVector pos = new PVector(0, 0); //Also index in 2D array of all tiles, might be temporary as could only be used for finite world
  int type = 0;
  boolean[] connectedRoad = new boolean[4];
  int totalRoadsConnected = 0;
  int highestConnectedRoad = 0;
  int roadType = 0;
  /*
  
  Road types:
  
  0: no connected roads
  1: single connection
  2: dual connection: bend
  3: dual connection: straight road
  4: triple connection
  5: quadruple connection (will be upgraded to have roundabout, street lights and simple crossing types)
  
  
  
  ConnectedRoad:
  _______
  |  0  |
  |3   1|
  |  2  |
  -------
  
  Types:
  0: Building
  1: Road
  
  */
  
  Tile(int x, int y, int t) {
    pos = new PVector(x, y);
    type = t;
  }
  
  void setConnectedRoad() {
    for (int i = 0; i < 4; i++) {
      connectedRoad[i] = false;
    }
    totalRoadsConnected = 0;
    int x = (int)pos.x;
    int y = (int)pos.y;
    if (y > 0) { if (tiles[x][y-1].type == 1) { connectedRoad[0] = true; totalRoadsConnected++; highestConnectedRoad = 0; }}
    if (x < worldSize-1) { if (tiles[x+1][y].type == 1) { connectedRoad[1] = true; totalRoadsConnected++; highestConnectedRoad = 1; }}
    if (y < worldSize-1) { if (tiles[x][y+1].type == 1) { connectedRoad[2] = true; totalRoadsConnected++; highestConnectedRoad = 2; }}
    if (x > 0) { if (tiles[x-1][y].type == 1) { connectedRoad[3] = true; totalRoadsConnected++; highestConnectedRoad = 3; }}
    calculateRoadType();
  }
  
  void calculateRoadType() {
    switch (totalRoadsConnected) {
      case 0:
        roadType = 0;
        break;
      case 1: 
        roadType = 1;
        break;
      case 2: 
        //check for bend
        boolean bend = false;
        for (int i = 0; i < 4; i++) {
          if ((connectedRoad[highestConnectedRoad] && connectedRoad[(highestConnectedRoad == 3) ? 0 : highestConnectedRoad+1]) || 
          (connectedRoad[highestConnectedRoad] && connectedRoad[(highestConnectedRoad == 0) ? 3 : highestConnectedRoad-1])) {
            bend = true;
          }
        }
        if (bend) {
          roadType = 2;
          break;
        }
        roadType = 3;
        break;
      case 3:
        roadType = 4;
        break;
      case 4: 
        roadType = 5;
        break;
    }
  }
  
  void render() {
    pushMatrix();
    translate(pos.x*tilePixelSize, pos.y*tilePixelSize);
    if (type == 0) renderBuilding();
    if (type == 1) renderRoad();
    popMatrix();
  }
  
  void renderBuilding() {
    fill(255, 60, 60);
    float offsetFromOtherTiles = 0;
    rect(offsetFromOtherTiles, offsetFromOtherTiles, tilePixelSize-offsetFromOtherTiles*2, tilePixelSize-offsetFromOtherTiles*2);
  }
  
  void renderRoad() {
    pushMatrix();
    
    switch (roadType) {
      case 0:
        //No roads connected
        noStroke();
        fill(sidewalkColor);
        rect(0, 0, tilePixelSize, tilePixelSize);
        
        fill(roadColor);
        
        float far = tilePixelSize-sideWalkWidth-(0.5*roadArcRadius);
        float close = sideWalkWidth+0.5*roadArcRadius;
        
        
        if (drawSideWalkLines) stroke(0);
        else noStroke();
        rect(sideWalkWidth, sideWalkWidth, roadWidth, roadWidth, roadArcRadius/2);
        break;
        
        
      case 1:
        //Single road connected
        pushMatrix();
        translate(tilePixelSize/2, tilePixelSize/2);
        rotate(PI/2*highestConnectedRoad);
        translate(-tilePixelSize/2, -tilePixelSize/2);
        
        fill(sidewalkColor);
        noStroke();
        rect(0, 0, tilePixelSize, tilePixelSize);
        fill(roadColor);
        
        far = tilePixelSize-sideWalkWidth-(0.5*roadArcRadius);
        close = sideWalkWidth+0.5*roadArcRadius;
        /*
        arc(far, far, roadArcRadius, roadArcRadius, 0, PI/2);
        arc(close, far, roadArcRadius, roadArcRadius, PI/2, PI);
        rect(close, far, far-close, roadArcRadius/2);
        rect(sideWalkWidth, 0, roadWidth, tilePixelSize - sideWalkWidth-roadArcRadius/2);
        */
        noStroke();
        rect(sideWalkWidth, 0, roadWidth, tilePixelSize - sideWalkWidth, 0, 0, roadArcRadius/2, roadArcRadius/2);
        
        //Stripes
        fill(255);
        noStroke();
        for (int i = 0; i < ceil(stripesPerRoad/2); i++) {
          rect(tilePixelSize/2 - stripeWidth/2, (i+0.25)*stripeSize*2, stripeWidth, stripeSize);
        }
        
        //Lines:
        if (drawSideWalkLines) {
          stroke(0);
          noFill();
          line(close, tilePixelSize-(0.5*(tilePixelSize-roadWidth)), far, tilePixelSize-(0.5*(tilePixelSize-roadWidth)));
          line(sideWalkWidth, 0, sideWalkWidth, tilePixelSize - sideWalkWidth-roadArcRadius/2);
          line(tilePixelSize-sideWalkWidth, 0, tilePixelSize-sideWalkWidth, tilePixelSize - sideWalkWidth-roadArcRadius/2);
          arc(far, far, roadArcRadius, roadArcRadius, 0, PI/2);
          arc(close, far, roadArcRadius, roadArcRadius, PI/2, PI);
        }
        popMatrix();
        break;
        
        
      case 2:
        //2 connected roads: bend road
        translate(tilePixelSize/2, tilePixelSize/2);
        if (highestConnectedRoad == 3 && connectedRoad[0]) rotate(PI/2);
        rotate(PI + PI/2*highestConnectedRoad);
        translate(-tilePixelSize/2, -tilePixelSize/2);
        noStroke();
        
        fill(sidewalkColor);
        rect(0, 0, tilePixelSize, tilePixelSize);
        
        fill(roadColor);
        rect(sideWalkWidth, sideWalkWidth, tilePixelSize-sideWalkWidth, tilePixelSize-sideWalkWidth, roadArcRadius/2, 0, 0, 0);
        
        
        //Stripes
        fill(255);
        noStroke();
        //rect(tilePixelSize/2, tilePixelSize/2, tilePixelSize/2, tilePixelSize/2, roadArcRadius/2, 0, 0, 0); 
        rect(tilePixelSize/2-stripeWidth/2, tilePixelSize/2-stripeWidth/2, tilePixelSize/2+stripeWidth/2, tilePixelSize/2+stripeWidth/2, roadArcRadius/2, 0, 0, 0); 
        fill(roadColor);
        rect(tilePixelSize/2+stripeWidth/2, tilePixelSize/2+stripeWidth/2, tilePixelSize/2-stripeWidth/2, tilePixelSize/2-stripeWidth/2, roadArcRadius/2-stripeWidth, 0, 0, 0); 
        for (int i = 0; i < stripesPerRoad+1; i++) {
          arc(tilePixelSize, tilePixelSize, (tilePixelSize-sideWalkWidth-3)*2, (tilePixelSize-sideWalkWidth-3)*2, constrain(-PI/(stripesPerRoad*8) + i*PI/(stripesPerRoad*2), 0, PI/2) + PI, constrain(-PI/(stripesPerRoad*8) + (i+0.5)*PI/(stripesPerRoad*2), 0, PI/2) + PI);
          //arc(tilePixelSize, tilePixelSize, (tilePixelSize-sideWalkWidth-3)*2, (tilePixelSize-sideWalkWidth-3)*2, constrain(-PI/(stripesPerRoad*2), 0, PI/2) + PI, constrain(-PI/(stripesPerRoad*2) + 1.5*PI/(stripesPerRoad*2), 0, PI/2) + PI);
        }
        
        
        //Sidewalk
        fill(sidewalkColor);
        arc(tilePixelSize, tilePixelSize, sideWalkWidth*2, sideWalkWidth*2, PI, PI+PI/2);
        
        if (drawSideWalkLines) { 
          stroke(0);
          noFill();
          //Sidewalk
          arc(tilePixelSize, tilePixelSize, sideWalkWidth*2, sideWalkWidth*2, PI, PI+PI/2);
          //Street
          line(sideWalkWidth, sideWalkWidth + roadArcRadius/2, sideWalkWidth, tilePixelSize);
          line(sideWalkWidth + roadArcRadius/2, sideWalkWidth, tilePixelSize, sideWalkWidth);
          arc(sideWalkWidth + roadArcRadius/2, sideWalkWidth + roadArcRadius/2, roadArcRadius, roadArcRadius, PI, PI+PI/2);
        }
        break;
        
      case 3:
        //2 Connected roads: straight road
        pushMatrix();
        if (highestConnectedRoad == 3) {
          translate(tilePixelSize/2, tilePixelSize/2);
          rotate(PI/2);
          translate(-tilePixelSize/2, -tilePixelSize/2);
        }
        noStroke();
        fill(sidewalkColor);
        rect(0, 0, tilePixelSize, tilePixelSize);
        
        
        fill(roadColor);
        noStroke();
        rect(sideWalkWidth, 0, roadWidth, tilePixelSize);
        if (drawSideWalkLines) {
          stroke(0);
          line(sideWalkWidth, 0, sideWalkWidth, tilePixelSize);
          line(tilePixelSize-sideWalkWidth, 0, tilePixelSize-sideWalkWidth, tilePixelSize);
        }
        
        //Stripes
        fill(255);
        noStroke();
        for (int i = 0; i < stripesPerRoad; i++) {
          rect(tilePixelSize/2 - stripeWidth/2, (i+0.25)*stripeSize*2, stripeWidth, stripeSize);
        }
        
        popMatrix();
        break;
        
        
      case 4:
        //Triple connected roads
        translate(tilePixelSize/2, tilePixelSize/2);
        if (highestConnectedRoad == 3 && connectedRoad[0]) {
          rotate(PI/2);
          if (connectedRoad[1]) rotate(PI/2);
        }
        rotate(PI/2 + PI/2*highestConnectedRoad);
        translate(-tilePixelSize/2, -tilePixelSize/2);
        
        noStroke();
        fill(roadColor);
        rect(0, 0, tilePixelSize, tilePixelSize);
        
        //Stripes
        fill(255);
        noStroke();
        //rect(tilePixelSize/2, tilePixelSize/2, tilePixelSize/2, tilePixelSize/2, roadArcRadius/2, 0, 0, 0); 
        rect(tilePixelSize/2-stripeWidth/2, tilePixelSize/2-stripeWidth/2, tilePixelSize/2+stripeWidth/2, tilePixelSize/2+stripeWidth/2, roadArcRadius/2, 0, 0, 0); 
        rect(0, tilePixelSize/2-stripeWidth/2, tilePixelSize/2+stripeWidth/2, tilePixelSize/2+stripeWidth/2, 0, roadArcRadius/2, 0, 0); 
        fill(roadColor);
        rect(tilePixelSize/2+stripeWidth/2, tilePixelSize/2+stripeWidth/2, tilePixelSize/2-stripeWidth/2, tilePixelSize/2-stripeWidth/2, roadArcRadius/2-stripeWidth, 0, 0, 0); 
        rect(0, tilePixelSize/2+stripeWidth/2, tilePixelSize/2-stripeWidth/2, tilePixelSize/2-stripeWidth/2, 0, roadArcRadius/2-stripeWidth, 0, 0); 
        
        for (int i = 0; i < stripesPerRoad+1; i++) {
          arc(tilePixelSize, tilePixelSize, (tilePixelSize-sideWalkWidth-3)*2, (tilePixelSize-sideWalkWidth-3)*2, constrain(-PI/(stripesPerRoad*8) + i*PI/(stripesPerRoad*2), 0, PI/2) + PI, constrain(-PI/(stripesPerRoad*8) + (i+0.5)*PI/(stripesPerRoad*2), 0, PI/2) + PI);
          arc(0, tilePixelSize, (tilePixelSize-sideWalkWidth-3)*2, (tilePixelSize-sideWalkWidth-3)*2, constrain(-PI/(stripesPerRoad*8) + i*PI/(stripesPerRoad*2), 0, PI/2) + 1.5*PI, constrain(-PI/(stripesPerRoad*8) + (i+0.5)*PI/(stripesPerRoad*2), 0, PI/2) + 1.5*PI);
        }
        
        fill(255);
        noStroke();
        for (int i = 0; i < stripesPerRoad; i++) {
          rect((i+0.25)*stripeSize*2, tilePixelSize/2 - stripeWidth/2, stripeSize, stripeWidth);
        }
        
        //Sidewalk
        fill(sidewalkColor);
        rect(0, 0, tilePixelSize, sideWalkWidth);
        if (drawSideWalkLines) stroke(0);
        else noStroke();
        
        for (int i = 0; i < 2; i++) {
          arc((1-i)*tilePixelSize, tilePixelSize, sideWalkWidth*2, sideWalkWidth*2, PI+PI/2*i, PI + PI/2*(i+1));
        }
        line(0, sideWalkWidth, tilePixelSize, sideWalkWidth);
        break;     
        
        
      case 5:
        //Quadruple connected roads; simple crossing
        noStroke();
        fill(roadColor);
        rect(0, 0, tilePixelSize, tilePixelSize);
        
        fill(sidewalkColor);
        if (drawSideWalkLines) stroke(0);
        else noStroke();
        for (int i = 0; i < 4; i++) {
          arc(((i == 1 || i == 2) ? 1 : 0)*tilePixelSize, ((i == 2 || i == 3) ? 1 : 0)*tilePixelSize, sideWalkWidth*2, sideWalkWidth*2, PI/2*i, PI/2*(i+1));
        }
        
        //Stripes
        fill(255);
        noStroke();
        //Vertical
        for (int i = 0; i < stripesPerRoad; i++) {
          rect(tilePixelSize/2 - stripeWidth/2, (i+0.25)*stripeSize*2, stripeWidth, stripeSize);
        }
        //Horizontal
        for (int i = 0; i < stripesPerRoad; i++) {
          rect((i+0.25)*stripeSize*2, tilePixelSize/2 - stripeWidth/2, stripeSize, stripeWidth);
        }
        
        break;
    }
    
    popMatrix();
  }
  
  void renderCorner() {
    
  }
}
