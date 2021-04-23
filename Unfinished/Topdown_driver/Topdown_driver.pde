//Top-down driver sim
//Car mechanics use from car_bot
//16/11/2020

//'b' to turn on bot | v to dis-/enable map mode | x to dis-/enable map maker mode

float playerLength = 50;
PVector camPos = new PVector(0, 0);
PVector f = new PVector(0, 0);

boolean mapMode = true;
float mapScale = 0.1;
boolean inLevelCreation = true;
boolean canChangeMapInDriveMode = true;

//Movement
boolean[] keys = new boolean[4];
boolean left, right, gas, brake;
PVector targetPos;
float dstToTarget;
boolean alignToRoad = true;
float alignToRoadSpeed = 0.01;
float alignToRoadActivationAngle = 16;
float freecamSpeed = 15;

//Targets
float targetRot;
float targetSpeed;

//Default bot parameters
float defaultAcceleration = 0.03;
float defaultRotSpeed = 2;
float defaultDistanceSpeedMult = 0.06;
float defaultMinSpeed = 1;
float defaultMaxSpeed = 40;
float defaultSpeedFalloffPerFrame = 0.01;

//UI
PVector headingCirclePos = new PVector(1920-80, 1080-80);
float headingRadius = 70;
float headingCircleWeight = 3;

PVector speedIndicatorPos = new PVector(1920-250, 1080-80);
float speedIndicatorRadius = 70;
float speedIndicatorWeight = 3;
//135 to 225

//Tiles (world)
int worldSize = 15;
Tile[][] tiles = new Tile[worldSize][worldSize];
float tilePixelSize = 400;
float roadWidth = 300;
float sideWalkWidth = (tilePixelSize-roadWidth)/2;
int roadArcRadius = 170; //Shouldn't be higher than roadWidth
int stripesPerRoad = 4;
float stripeWidth = 10;
float stripeSize = tilePixelSize/(stripesPerRoad*2);
color sidewalkColor = color(130);
color roadColor = color(41, 41, 61);
boolean drawSideWalkLines = true;


//Car(acceleration, minSpeed, maxSpeed, rotSpeed, PVector startPos)
Car player = new Car(defaultAcceleration, defaultMinSpeed, defaultMaxSpeed, defaultRotSpeed, new PVector(0, 0));

void setup() {
  fullScreen();
  strokeWeight(3);
  generateWorldTiles();
}

void draw() {
  strokeWeight(3);
  background(200);
  targetPos = new PVector(mouseX+camPos.x, mouseY+camPos.y);
  //rot = mouseX;
  if (mapMode) renderMap();
  else renderWorld();
  if (!inLevelCreation) {
    player.update();
    camPos.x = player.pos.x-width/2 + player.currentSpeed*cos(radians(player.rot))*5;
    camPos.y = player.pos.y-height/2 + player.currentSpeed*sin(radians(player.rot))*5;
  }
  else {
    freeCam();
  }
}

void freeCam() {
  camPos.y += freecamSpeed * (keys[2] ? 1 : (keys[0] ? -1 : 0));
  camPos.x += freecamSpeed * (keys[3] ? 1 : (keys[1] ? -1 : 0));
}

void generateWorldTiles() {
  for (int y = 0; y < worldSize; y++) {
    for (int x = 0; x < worldSize; x++) {
      tiles[x][y] = new Tile(x, y, ((x % 3 == 0 || y % 3 == 0)) ? 1 : 0);
    }
  }
  for (int y = 0; y < worldSize; y++) {
    for (int x = 0; x < worldSize; x++) {
      tiles[x][y].setConnectedRoad();
    }
  }
}

void renderMap() {
  pushMatrix();
  translate(-camPos.x*mapScale, -camPos.y*mapScale);
  for (int y = 0; y < worldSize; y++) {
    for (int x = 0; x < worldSize; x++) {
      //if (abs((camPos.x + width/2) - (x+0.5)*tilePixelSize) < (width+tilePixelSize)/2 && abs((camPos.y + height/2) - (y+0.5)*tilePixelSize) < (height+tilePixelSize)/2) tiles[x][y].render();
      if (tiles[x][y].type == 0) fill(255, 60, 60);
      else if (tiles[x][y].type == 1) fill(roadColor);
      stroke(0);
      rect(x*tilePixelSize*mapScale, y*tilePixelSize*mapScale, tilePixelSize*mapScale, tilePixelSize*mapScale);
    }
  }
  
  popMatrix();
}

void renderWorld() {
  pushMatrix();
  translate(-camPos.x, -camPos.y);
  circle(0, 0, 50);
  fill(255, 0, 0);
  circle(targetPos.x, targetPos.y, 25);
  for (int y = 0; y < worldSize; y++) {
    for (int x = 0; x < worldSize; x++) {
      if (abs((camPos.x + width/2) - (x+0.5)*tilePixelSize) < (width+tilePixelSize)/2 && abs((camPos.y + height/2) - (y+0.5)*tilePixelSize) < (height+tilePixelSize)/2) tiles[x][y].render();
    }
  }
  
  popMatrix();
}



float minClamp(float x, float clamp) {
  if (x < clamp) return clamp;
  return x;
}

void mousePressed() {
  setTileType();
}

void mouseDragged() {
  setTileType();
}

void setTileType() {
  if (inLevelCreation || canChangeMapInDriveMode) {
    int mx = constrain(floor((mouseX+camPos.x*(mapMode ? mapScale : 1))/(tilePixelSize*(mapMode ? mapScale : 1))), 0, worldSize-1);
    int my = constrain(floor((mouseY+camPos.y*(mapMode ? mapScale : 1))/(tilePixelSize*(mapMode ? mapScale : 1))), 0, worldSize-1);
    tiles[mx][my].type = (mouseButton == LEFT ? 1 : 0);
    for (int y = my-1; y < my+2; y++) {
      for (int x = mx-1; x < mx+2; x++) {
        if (x < worldSize && y < worldSize && x >= 0 && y >= 0) {
          tiles[x][y].setConnectedRoad();
        }
      }
    }
  }
}

void keyPressed () {
  if (key == 'w') {
    keys[0] = true;
  } else if (key == 'a') {
    keys[1] = true;
  } else if (key == 's') {
    keys[2] = true;
  } else if (key == 'd') {
    keys[3] = true;
  }
  if (key == 'b') {
    player.mouseDrive = !player.mouseDrive;
  }
  if (key == 'x') {
    inLevelCreation = !inLevelCreation;
    mapMode = false;
  }
  if (key == 'v') {
    mapMode = !mapMode;
    if (mapMode) inLevelCreation = true;
  }
}

void keyReleased () {
  if (key == 'w') {
    keys[0] = false;
  } else if (key == 'a') {
    keys[1] = false;
  } else if (key == 's') {
    keys[2] = false;
  } else if (key == 'd') {
    keys[3] = false;
  }
}
