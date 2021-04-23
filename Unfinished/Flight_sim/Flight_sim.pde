import queasycam.*;

float freecamSpeed = 1;
float walkSpeed = 0.6;
float freecamSensitivity = 0.3;
float freecamDistanceFromPlane = 15;
boolean invertPitch = false;
float playerHeight = 1;

int renderDistance = 4; //Render distance in chunks

//Chunk generation
float viewDistance = 1000;
float fullChunkSize = 48;
int chunkSize = 48;
ArrayList<Chunk> chunks = new ArrayList<Chunk>();
ArrayList<PVector> chunksLoaded = new ArrayList<PVector>();
float plateSize = fullChunkSize/chunkSize;
float maxPlateHeight = 100;
float rockHeight = 0.45; //Percentage
float snowHeight = 0.66; //Percentage
float sandHeight = 0.20; //Percentage
float waterHeight = 0.20; //Percentage
boolean individualRockTriColour = true;
boolean individualGrassTriColour = true;
boolean individualSandTriColour = true;
//float[] lodDst = {200, 150, 100, 75, 50, 0};
//int[] dstForLod = {16, 8, 6, 4, 3, 2};
float[] lodDst = {600, 200, 0};
int[] dstForLod = {16, 12, 6};


PVector noiseOffset = new PVector(random(-100, 100), random(-100, 100));
//PVector noiseOffset = new PVector(0, 0);

//Plane properties
Plane plane = new Plane(new PVector(0, -100, 0));
PShape planeModel;
//String[] vertices = {""};

//Changing noise
float noiseScale = 0.014; //Lower = larger areas
float noiseMoveSpeed = 0.01;
float noiseScaleChangeSpeed = 0.0005;
float noiseHeightChangeSpeed = 1;
float layerChangeSpeed = 0.01;

//Camera
QueasyCam cam;
PVector cp = new PVector(-24, -100, -24); // Camera position
PVector chunkPos = new PVector(0, 0);
PVector cpold = new PVector(0, 0, 0);
PVector cr = new PVector(0, 0, 0); // Camera rotation
PVector crold = new PVector(0, 0, 0);
PVector lookPos = new PVector(1, 0, 0);
PVector cn = new PVector(0, 1, 0); //Camera normal
PVector planeLookOffset = new PVector(0, -3, 0);

//Input
char[] inputKeys = {'w', 's', 'd', 'a', 'z', ' ', 't', 'g', 'f', 'h', '=', '-', 'q', 'e'};
//'y', 'n', 'u', 'j', 'i', 'k', 'o', 'l', 
String camState = "free";
boolean infoEnabled;
boolean paused;
char toggleFreecam = ',';
char togglePlanecam = '.';
char toggleWalkcam = '/';
char toggleInfo = 'c';
char nextSetting = ']';
char prevSetting = '[';
//char pause = 'p';
boolean[] keys = new boolean[14];
int settingSelected = 0;
String[] udSetting = {"Noise scale", "Max plate height", "Snow layer", "Rock layer", "Sand layer", "Water height"};


//freecam:
//0: cam forward: w
//1: cam backwards: s
//2: cam right: d
//3: cam left: a
//4: cam up: z
//5: cam down: space
//6: noise forward: t 
//7: noise backwards: g
//8: noise right: f
//9: noise left: h
//10: selected up/down setting up: =
//11: selected up/down setting down: -

//Flight cam:
//0: stick forward: w
//1: stick backwards: s
//2: stick right: d
//3: stick left: a
//4: throttle up: z
//5: throttle down: space
//12: rudder left: q
//13: rudder right: e

PVector oldMousePos = new PVector(0, 0);

PMatrix3D baseMat;


void setup() {
  //size(1400, 1000, P3D);
  fullScreen(P3D);
  cam = new QueasyCam(this);
  cam.sensitivity = 0;
  cam.speed = 0;
  baseMat = getMatrix(baseMat);
  //vertices = loadStrings("plane1simple.txt");
  planeModel = loadShape("simpleplane.obj");
  chunks.add(new Chunk(chunkSize, 0, 0, 16));
  chunks.add(new Chunk(chunkSize, 1, 0, 16));
  chunks.add(new Chunk(chunkSize, 0, 1, 16));
  for (Chunk c : chunks) c.createTerrain();
}

void draw() {
  background(49, 210, 235);
  cpold = cp;
  crold = cr;
  PVector mousePos = new PVector(-1*mouseY-height/2, -1*(mouseX-width/2));
  //plane.checkInput();
  //plane.updatePos();
  //Settings camera type
  switch(camState) {
    case "free":
      freecam(mousePos, false);
      break;
    case "walk":
      freecam(mousePos, true);
      break;
    case "plane":
      planeCam(mousePos);
      break;
  }
  cn = new PVector(cos(cr.y)*cos(cr.x), sin(cr.x), sin(cr.y)*cos(cr.x)).normalize();
  if (keys[6] || keys[7] || keys[8] || keys[9] || keys[10] || keys[11]) {moveNoise();}
  cameraCalculations();
  for (Chunk c : chunks) c.checkLodDst((int)c.pos.x, (int)c.pos.y);
  
  for (Chunk c : chunks) c.renderTerrain();
  noStroke();
  checkForNewChunks();
  //plane.render();
  //rect(-50, -50, 100, 100);
  if (infoEnabled) {informationUI();}
  oldMousePos = mousePos;
}

void cameraCalculations() {
  cam.tilt = cr.x;
  cam.pan = cr.y;
  cam.position = cp;
}

void checkForNewChunks() {
  for (int z = (int)chunkPos.y-renderDistance; z < chunkPos.y+renderDistance+1; z++) {
    for (int x = (int)chunkPos.x-renderDistance; x < chunkPos.x+renderDistance+1; x++) {
      if (!chunkLoaded(x, z)) {
        chunks.add(new Chunk(chunkSize, x, z, getLOD(x, z)));
      }
    }
  }
  //for (Chunk c : chunks) {
  for (int i = 0; i < chunks.size(); i++) {
    Chunk c = chunks.get(i);
    //if (floor(dist(chunkPos.x, chunkPos.y, c.pos.x, c.pos.y)) > renderDistance) {
    if (abs(chunkPos.x - c.pos.x) > renderDistance || abs(chunkPos.y - c.pos.y) > renderDistance) {
      c.unload();
      chunks.remove(c);
    }
  }
}

boolean chunkLoaded(int x, int y) {
  for (PVector p : chunksLoaded) {
    if (p.x == x && p.y == y) {
      return true;
    }
  }
  return false;
}

void moveNoise() {
  PVector move = new PVector(0, 0);
  boolean changeTerrain = false;
  if (keys[6]) {
    move.x += noiseMoveSpeed;
    changeTerrain = true;
  }
  if (keys[7]) {
    move.x -= noiseMoveSpeed;
    changeTerrain = true;
  }
  if (keys[8]) {
    move.y -= noiseMoveSpeed;
    changeTerrain = true;
  }
  if (keys[9]) {
    move.y += noiseMoveSpeed;
    changeTerrain = true;
  }
  if (keys[10]) {
    changeUDSetting(1);
    changeTerrain = true;
  }
  if (keys[11]) {
    changeUDSetting(-1);
    changeTerrain = true;
  }
  
  noiseOffset.add(move);
  if (changeTerrain) {
    for (Chunk c : chunks) c.createTerrain();
  }
}

void changeUDSetting (float mult) {
  switch(udSetting[settingSelected]) {
    case "Noise scale":
      noiseScale += noiseScaleChangeSpeed*mult;
      break;
    case "Max plate height":
      maxPlateHeight += noiseHeightChangeSpeed*mult;
      break;
    case "Snow layer":
      snowHeight += layerChangeSpeed*mult;
      break;
    case "Rock layer":
      rockHeight += layerChangeSpeed*mult;
      break;
    case "Sand layer":
      sandHeight += layerChangeSpeed*mult;
      break;
    case "Water height":
      waterHeight += layerChangeSpeed*mult;
      break;
  }
}

String getUDSettingValue(int index) {
  switch(udSetting[settingSelected]) {
    case "Noise scale":
      return noiseScale + "";
    case "Max plate height":
      return maxPlateHeight + "";
    case "Snow layer":
      return snowHeight + "%";
    case "Rock layer":
      return rockHeight + "%";
    case "Sand layer":
      return sandHeight + "%";
    case "Water height":
      return waterHeight + "%";
  }
  return "";
}

void informationUI() {
  
  hint(DISABLE_DEPTH_TEST); 
  pushMatrix();
  resetMatrix();
  //translate(cp.x, cp.y, cp.z);
  //rotateX(-PI/2);
  //rotateY(cr.z);
  //rotateY(PI);
  //rotateZ(PI/2);
  translate(-960, -540, -935);
  
  fill(0);
  fill(100, 100);
  rect(0, 0, 1400, 900);
  fill(255);
  textSize(25);
  text(
  "Cam state: " + camState + 
  "\nFreecam mode\nChunk size: " + chunkSize + 
  "\nPlate size: " + plateSize + 
  "\nSelected setting: " + udSetting[settingSelected] + 
  "\nValue: " + getUDSettingValue(settingSelected) +
  "\nRock colour smoothing: " + individualRockTriColour + 
  "\nGrass colour smoothing: " + individualGrassTriColour + 
  "\nSand colour smoothing: " + individualSandTriColour + 
  "\nNoise offset: " + noiseOffset + 
  "\nCamera pos: " + cp + 
  "\nCamera chunk pos: " + chunkPos + 
  "\nCamera rot: " + cr + 
  "\nAngle to plane: " + atan2(0, 0) + 
  ", " + -atan2(cp.y-plane.pos.y, dist(cp.x, cp.z, plane.pos.x, plane.pos.z)) + 
  "\n" + 7 + 
  "\nNormal: " + cn +
  "\nFlight cam mode\nPlane pos: " + plane.pos + 
  "\nPlane rot: " + plane.rot + 
  "\nSpeed: " + plane.speed + 
  "\nThrottle: " + plane.throttle + 
  "\nNormal: " + plane.normal + 
  "\nCos: " + new PVector(cos(plane.rot.x), cos(plane.rot.y), cos(plane.rot.z)) + 
  "\nSin: " + new PVector(sin(plane.rot.x), sin(plane.rot.y), sin(plane.rot.z)), 10, 30);
  
  //print(chunks.get(2).pos);
  text("Chunks:", 710, 30);
  for (int i = 0; i < chunks.size(); i++) {
    text(
    "Chunk at: (" + chunks.get(i).pos.x + ", " + chunks.get(i).pos.y +
    "), LOD: " + chunks.get(i).lod +
    "), LOD: " + dist((chunks.get(i).pos.x)*fullChunkSize, (chunks.get(i).pos.y)*fullChunkSize, cp.x, cp.z)
    , 710, 55+28*i);
  }
  popMatrix();
  
  //Little thing in the middle
  pushMatrix();
  translate(cp.x, cp.y, cp.z);
  stroke(250, 0, 0);
  strokeWeight(3);
  line(cn.x, cn.y, cn.z, cn.x+0.1, cn.y, cn.z);
  stroke(0, 250, 0);
  line(cn.x, cn.y, cn.z, cn.x, cn.y+0.1, cn.z);
  stroke(0, 0, 250);
  line(cn.x, cn.y, cn.z, cn.x, cn.y, cn.z+0.1);
  popMatrix();
  
  hint(ENABLE_DEPTH_TEST);
}

void planeCam(PVector mPos) {
  //PVector normal = new PVector(cos(cr.xcr.y), sin(), 0);
  if (mousePressed) {
    cr.add(subtractVectors(oldMousePos, mPos).mult(freecamSensitivity*0.01));
  }
  //cr.x = -atan2(cp.y-plane.pos.y, dist(cp.x, cp.z, plane.pos.x, plane.pos.z));
  cn = new PVector(cos(cr.y)*cos(cr.x), sin(cr.x), sin(cr.y)*cos(cr.x)).normalize();
  cp.add(subtractVectors(addVectors(plane.pos, planeLookOffset), addVectors(multiplyVectorWithFloat(cn, freecamDistanceFromPlane), cp)));
}

void freecam(PVector mPos, boolean walking) {
  float speed = freecamSpeed;
  if (walking) {
    speed = walkSpeed;
  }
  if (keys[0]) {
    PVector mvnt = new PVector(cos(cr.y), sin(cr.x), sin(cr.y));
    cp.add(multiplyVectorWithFloat(mvnt.normalize(), speed));
  }
  if (keys[1]) {
    PVector mvnt = new PVector(cos(cr.y), sin(cr.x), sin(cr.y));
    cp.add(multiplyVectorWithFloat(mvnt.normalize(), -speed));
  }
  if (keys[3]) {
    cp.add(new PVector(sin(cr.y)*speed, 0, -cos(cr.y)*speed));
  }
  if (keys[2]) {
    cp.add(new PVector(-sin(cr.y)*speed, 0, cos(cr.y)*speed));
  } 
  if (keys[5]) {
    cp.add(new PVector(0, -speed, 0));
  } 
  if (keys[4]) {
    cp.add(new PVector(0, speed, 0));
  }
  if (mousePressed) {
    cr.add(subtractVectors(oldMousePos, mPos).mult(freecamSensitivity*0.01));
    cr.x = constrain(cr.x, -PI/2, PI/2);
  }
  chunkPos = new PVector(round(cp.x/chunkSize), round(cp.z/chunkSize));
  if (walking) {
    cp.y = noise((cp.x + fullChunkSize/2)*noiseScale + noiseOffset.x, (cp.z + fullChunkSize/2)*noiseScale + noiseOffset.y)*-maxPlateHeight - playerHeight;
  }
}

//v1 - v2
PVector subtractVectors(PVector v1, PVector v2) {
  PVector toReturn = new PVector(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
  return toReturn;
}
//v1 + v2
PVector addVectors(PVector v1, PVector v2) {
  PVector toReturn = new PVector(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
  return toReturn;
}

PVector multiplyVectorWithFloat(PVector v1, float f) {
  return(new PVector(v1.x*f, v1.y*f, v1.z*f));
}

void renderBox(float x, float y, float z, float sx, float sy, float sz) {
  pushMatrix();
  translate(x, y - sy/2, z);
  box(sx, sy, sz);
  popMatrix();
}

void keyPressed() {
  for (int i = 0; i < keys.length; i++) {
    if (key == inputKeys[i]) {
      keys[i] = true;
    }
  }
  if (key == toggleFreecam) {
    camState = "free";
  }
  if (key == toggleWalkcam) {
    camState = "walk";
  }
  if (key == togglePlanecam) {
    camState = "plane";
  }
  if (key == toggleInfo) {
    infoEnabled = !infoEnabled;
  }
  if (key == nextSetting) {
    settingSelected++;
    if (settingSelected > udSetting.length-1) {
      settingSelected = 0;
    }
  }
  if (key == prevSetting) {
    settingSelected--;
    if (settingSelected < 0) {
      settingSelected = udSetting.length-1;
    }
  }
  
  //if (key == pause) {
   // paused = !paused;
  //}
  if (key == '=') {
    int newLOD = int(random(1, 4));
    //print(newLOD);
    chunks.get(0).newLOD(16);
  }
    
}

int getLOD(int x, int y) {
  float dst = dist((x)*fullChunkSize, (y)*fullChunkSize, cp.x, cp.z);
  
  for (int i = 0; i < lodDst.length; i++) {
    if (dst > lodDst[i]) {
      return dstForLod[i];
    }
  }
  return 1;
}

void keyReleased() {
  for (int i = 0; i < keys.length; i++) {
    if (key == inputKeys[i]) {
      keys[i] = false;
    }
  }
}
