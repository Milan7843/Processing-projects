//2.5D renderer
//Settings
int totalRays = 90;
float fov = 120; //FOV in deg
boolean visualizeFov = true;
boolean visualizeRays = true;
boolean onlyVisualizeHitRays = false;
float maxViewDst = 1000;
color wallColor = color(98, 166, 15);
color emptyColor = color(66, 135, 245);

boolean inRenderer; //Otherwise it is in the level creator
boolean isRendering = true; //if on, the calculations for rendering will be made, otherwise they won't be made
PVector[] endPoints = new PVector[totalRays];
float playerRot; //Player rotation in degrees
PVector playerPos = new PVector(50, 50);
float playerSpeedMult = 3;

//int actualTotalRays = (int)(360/(fov/totalRays-1));

boolean[] keys = new boolean[4];
int objectPointsAmount = 6; // = Object amount * 2  
PVector[] objects = new PVector[30];
float[] wallHeight = new float[totalRays];
float[] closestDistance = new float[totalRays];
boolean[] intersected = new boolean[totalRays];
PVector[] intsct = new PVector[totalRays];
float dragFrames = 0;
boolean isDragging;
//PVector[] strtEndPoints = new PVector[totalRays];

void setup() {
  fullScreen();
  objects[0] = new PVector(500, 600);
  objects[1] = new PVector(300, 300);
  objects[2] = new PVector(700, 300);
  objects[3] = new PVector(600, 500);
  objects[4] = new PVector(700, 600);
  objects[5] = new PVector(400, 800);
}

void draw() {
  if (!inRenderer) {
    background(242, 238, 203);
  }
  else {
    background(emptyColor);
  }
  
  PlayerInputHandling();
  if (isRendering) {
    Calculations();
    if (inRenderer) {
      RenderSemi3D();
    }
  }
  if (!inRenderer) {
    DrawObjects();
  }
  
  fill(0);
  //text("keys pressed: w: " + keys[0] + "  a: " + keys[1] + "  s: " + keys[2] + "  d: " + keys[3], 50, 50);
}

void RenderSemi3D() {
  float wallWidth = width/(float)totalRays;
  for (int i = 0; i < totalRays; i++) {
    //if (wallHeight[i] != 0 && i == firstPointOnObject[0] || i == lastPointOnObject[0]) {
    if (wallHeight[i] != 0) {
      fill(255 - closestDistance[i]/3);
      rect(wallWidth*i, height/2 - wallHeight[i]/2, wallWidth, wallHeight[i]);
    }
  }
  
}

void DrawObjects() {
  for (int i = 0; i < objectPointsAmount; i += 2) {
    line(objects[i].x, objects[i].y, objects[i + 1].x, objects[i + 1].y);
  }
}

void Calculations() {
  //Some elements of rendering things outside the renderer are also in here, to minimize the amount of for statements
  float degPerRay = fov/(float)(totalRays-1);
  //Resetting distances
  for (int i = 0; i < totalRays; i++) {
    closestDistance[i] = maxViewDst;
    intersected[i] = false;
    endPoints[i] = new PVector(playerPos.x + maxViewDst * cos(radians(degPerRay*i + playerRot - fov/2)), playerPos.y + maxViewDst * sin(radians(degPerRay*i + playerRot - fov/2)));
  }
  
  for (int i = 0; i < totalRays; i++) {
    /*
    if ( i == 0 || i == totalRays-1) {
      float minViewDst = sin(radians(fov/2))*maxViewDst;
      float dstPerRay = sqrt(sq(maxViewDst) + sq(minViewDst)) / (totalRays/2);
      //float dstPerRay = minViewDst / (totalRays/2);
      PVector frontPoint = new PVector(playerPos.x + minViewDst * cos(radians(playerRot)), playerPos.y + minViewDst * sin(radians(playerRot)));
      strtEndPoints[i] = new PVector(frontPoint.x + (i-totalRays/2)*dstPerRay * cos(radians(playerRot+90)), frontPoint.y + (i-totalRays/2)*dstPerRay * sin(radians(playerRot+90)));
      circle(endPoints[i].x, endPoints[i].y, 5);
    }
    */
    
    float _x1 = 0, _y1 = 0, t1, u1;
    float[] x1 = {playerPos.x, endPoints[i].x, endPoints[0].x, endPoints[totalRays-1].x};
    float[] y1 = {playerPos.y, endPoints[i].y, endPoints[0].y, endPoints[totalRays-1].y};
    
    t1 = ((x1[0]-x1[2]) * (y1[2]-y1[3]) - (y1[0] - y1[2]) * (x1[2]-x1[3])) / ((x1[0]-x1[1]) * (y1[2]-y1[3]) - (y1[0] - y1[1]) * (x1[2]-x1[3]));
    u1 = -((x1[0]-x1[1]) * (y1[0]-y1[2]) - (y1[0] - y1[1]) * (x1[0]-x1[2])) / ((x1[0]-x1[1]) * (y1[2]-y1[3]) - (y1[0] - y1[1]) * (x1[2]-x1[3]));
    textSize(25);
    //text("t:  " + t + "   u:  "  + u, 50, 50 + (i+n) * 25);
    //_x = ((x[0]*y[1] - y[0]*x[1]) * (x[2]-x[3]) - (x[0]-x[1]) * (x[2]*y[3] - y[2] * x[3])) / ((x[0]-x[1]) * (y[2]-y[3]) - (y[0] - y[1]) * (x[2]-x[3]));
    //_y = ((x[0]*y[1] - y[0]*x[1]) * (y[2]-y[3]) - (y[0]-y[1]) * (x[2]*y[3] - y[2] * x[3])) / ((x[0]-x[1]) * (y[2]-y[3]) - (y[0] - y[1]) * (x[2]-x[3]));
    
    //Below code is run when the points exists
    if (u1 > 0 && u1 < 1 && t1 > 0 && t1 < 1) {
      _x1 = x1[0] + t1*(x1[1]-x1[0]);
      _y1 = y1[0] + t1*(y1[1]-y1[0]);
      //circle(_x1, _y1, 5);
    }
    
    
    circle(endPoints[i].x, endPoints[i].y, 5);
    //circle(frontPoint.x, frontPoint.y, 50);
    //Intersections
    for (int n = 0; n < objectPointsAmount; n += 2) {
      
      float _x, _y, t, u;
      float[] x = {playerPos.x, endPoints[i].x, objects[n].x, objects[n+1].x};
      float[] y = {playerPos.y, endPoints[i].y, objects[n].y, objects[n+1].y};
      
      t = ((x[0]-x[2]) * (y[2]-y[3]) - (y[0] - y[2]) * (x[2]-x[3])) / ((x[0]-x[1]) * (y[2]-y[3]) - (y[0] - y[1]) * (x[2]-x[3]));
      u = -((x[0]-x[1]) * (y[0]-y[2]) - (y[0] - y[1]) * (x[0]-x[2])) / ((x[0]-x[1]) * (y[2]-y[3]) - (y[0] - y[1]) * (x[2]-x[3]));
      textSize(25);
      //text("t:  " + t + "   u:  "  + u, 50, 50 + (i+n) * 25);
      //_x = ((x[0]*y[1] - y[0]*x[1]) * (x[2]-x[3]) - (x[0]-x[1]) * (x[2]*y[3] - y[2] * x[3])) / ((x[0]-x[1]) * (y[2]-y[3]) - (y[0] - y[1]) * (x[2]-x[3]));
      //_y = ((x[0]*y[1] - y[0]*x[1]) * (y[2]-y[3]) - (y[0]-y[1]) * (x[2]*y[3] - y[2] * x[3])) / ((x[0]-x[1]) * (y[2]-y[3]) - (y[0] - y[1]) * (x[2]-x[3]));
      
      //Below code is run when the points exists
      if (u > 0 && u < 1 && t > 0 && t < 1) {
        _x = x[0] + t*(x[1]-x[0]);
        _y = y[0] + t*(y[1]-y[0]);
        float dst = 1000 - (dist(playerPos.x, playerPos.y, _x1, _y1) / dist(playerPos.x, playerPos.y, _x, _y) * 100);
        if (dst < closestDistance[i]) {
          closestDistance[i] = dst;
          intsct[i] = new PVector(_x, _y);
        }
        intersected[i] = true;
        //PVector intsct = new PVector(_x, _y);
      }
      else {
        //Point not found
      }
    }
  }

  //Checking for every ray outside the main for loop so that this doesn't happen for every object (and drawing lines for them!!)
  for (int e = 0; e < totalRays; e++) {
    if (intersected[e]) {
      if (visualizeRays && !inRenderer) {
        line(playerPos.x, playerPos.y, intsct[e].x, intsct[e].y); 
      }
    }
    else {
      wallHeight[e] = 0;
      if (visualizeRays && !inRenderer && !onlyVisualizeHitRays) {
        line(playerPos.x, playerPos.y, endPoints[e].x, endPoints[e].y); 
      }
    }
    wallHeight[e] = height - map(closestDistance[e], 0, maxViewDst, 0, height);
  }
  
  line(playerPos.x, playerPos.y, playerPos.x + 100 * cos(radians(playerRot)), playerPos.y + 100 * sin(radians(playerRot)));
  stroke(255, 0, 0);
  stroke(0);
  if (visualizeFov && !inRenderer) {
    line(playerPos.x, playerPos.y, endPoints[0].x, endPoints[0].y);
    line(playerPos.x, playerPos.y, endPoints[(int)endPoints.length-1].x, endPoints[(int)endPoints.length-1].y);
  }
}




void PlayerInputHandling() {
  if (keys[0]) {
    playerPos.add(new PVector(playerSpeedMult * cos(radians(playerRot)), playerSpeedMult * sin(radians(playerRot))));
  }
  else if (keys[2]) {
    playerPos.add(new PVector(-playerSpeedMult * cos(radians(playerRot)), -playerSpeedMult * sin(radians(playerRot))));
  }
  if (keys[1]) {
    playerRot-= 1;
  }
  if (keys[3]) {
    playerRot+= 1;
  }
}

void mouseDragged() {
  if (!inRenderer && !isRendering) {
    if (mouseButton == LEFT) {
      isDragging = true;
      if (dragFrames == 0) {
        objects[objectPointsAmount/2] = new PVector(mouseX, mouseY);
        objectPointsAmount += 2;
      }
      dragFrames += 1;
      objects[objectPointsAmount/2+1] = new PVector(mouseX, mouseY);
    }
  }
}

void mouseReleased() {
  if (mouseButton == LEFT && isDragging) {
    dragFrames = 0;
    isDragging = false;
  }
}

void keyPressed() {
  if (keyCode == TAB) {
    inRenderer = !inRenderer;
  }
  if (key == 'v') {
    isRendering = !isRendering;
  }
  
  if (key == 'w') {
    keys[0] = true;
  }
  else if (key == 'a') {
    keys[1] = true;
  }
  else if (key == 's') {
    keys[2] = true;
  }
  else if (key == 'd') {
    keys[3] = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    keys[0] = false;
  }
  else if (key == 'a') {
    keys[1] = false;
  }
  else if (key == 's') {
    keys[2] = false;
  }
  else if (key == 'd') {
    keys[3] = false;
  }
}
