//3D raymarching by Milan
//6-5-2020
//General info:
//Horizontal fov is locked to 90, vertical to whatever the screen width is set to relative to the height
//On spawn:
//Forward = pos x
//Left = pos y
//Up = pos z
//Underneath are the parameters to try out:
//W, A, S, D to move | T, F, G, H, to move view | Space, Z to move up/down | V to increase detail, C to decrease detail | L to toggle lighting calculation | R to toggle high quality settings | N to show normal, B to freeze normal ray |
//O to switch perspective/orthographic camera mode | P to take screenshot | J to enable/disable loading bar

float mouseSensitivity = 0.01f;


//defualt settings
float defaultMaxTravelDstPerStep = 100;
int defaultMaxStepAmountPerPixel = 60;
float defaultDstThresHoldToHit = 0.006;
int defaultMaxReflections = 7;

//high quality settings
float highMaxTravelDstPerStep = 100;
int highMaxStepAmountPerPixel = 600;
float highDstThresHoldToHit = 0.00006;
int highMaxReflections = 15;

//Allows for drawing of skybox when the ray gets out of object field
boolean useMaxRayDist = true;
float maximumRayDist = 20;

color skyboxColorHorizon = color(204, 102, 0);
color skyboxColorTop = color(135, 206, 235);

boolean onHighSettings = false;


float maxTravelDstPerStep; //The new ray never goes longer than this
int maxStepAmountPerPixel; //Number of rays per pixel, if a hit is already found, the ray won't go on
float dstThresHoldToHit; //If the new rays length is smaller than this, a point wil be drawn. Higher values work better with larger pixel sizes, but may induce artifacts at any pixel size
int sphereAmount = 4;
int boxAmount = 0;
int planeAmount = 1;
int lineAmount = 3;
int cubeAmount = 3;
int torusAmount = 1;
int cappedLineAmount = 1; //cappedLine[0] is always reserved for normal calculation
int modelAmount = 1;





//General settings
boolean loadingBar = false;
boolean glowEffect = true; //not working
float glowEffectmaxDistance = 0.01;
boolean renderSingleFrame = true; //If this is set to true, only a single frame will be rendered, for this the max stap amount should be set to about 1000 for extreme accuracy, not currently implemented
boolean showNormal = false;
boolean calculateLighting = false;
boolean orthographicCameraEnabled = false;
boolean dynamicResolution = false;
int maxReflections;

//Lighting
float shadowMult = 0.4;
float shadowSoftness = 20;
boolean frameChanged;


//Camera
float cameraSpeed = 0.1;
float cameraRotateSpeed = 0.1;
PVector cameraRotation = new PVector();
PVector cameraPos = new PVector(-2, 0, 2);
PVector cameraNormal = new PVector(1, 0, 0);
//Orthographic only:
PVector[] orthographicStartPos;
PVector[] defaultOrthographicStartPos;
float orthographicCameraHeight = 6;
int pixelSize = 10;
PVector orthographicDir = new PVector(1, 0, 0);

boolean cameraChanged = false; //Used for auto resolution


PVector[] dir;
PVector[] defaultDir;
Sphere[] sphere = new Sphere[sphereAmount+5];   //Sphere(x, y, z, radius)
Box[] box = new Box[boxAmount];               //Box(x, y, z, xlength, ylength, zlength)
Plane[] plane = new Plane[planeAmount];       //Plane(x, y, z, x-normal, y-normal, z-normal, height, size)
Line[] line = new Line[lineAmount];           //Line(x1, y1, z1, x2, y2, z2, (c));
Cube[] cube = new Cube[cubeAmount];           //Cube(x, y, z, size)
Torus[] torus = new Torus[torusAmount];       //Torus(x, y, z, PVector t) t.x = dist from middle to center of torus, t.y = thickness of torus (radius)
CappedLine[] cappedLine = new CappedLine[cappedLineAmount]; //Line(x1, y1, z1, x2, y2, z2, r, c);
Model[] model = new Model[modelAmount];

String[] cubeObj;

/*
Cube sminTestCube = new Cube(0, 0, 6, 2, false);
Sphere sminTestSphere = new Sphere(1, 1, 7, 2, false);
*/
PointLight[] pointLight = new PointLight[1];

color normalColor = color(53, 118, 222);
float normalLength = 2;

PVector[] cubeEndPoint = new PVector[cubeAmount]; //used for coloring of cube

//PVector currentEndPoint = new PVector(1, 0, 0);
int framesRendered = 0;

//Input
boolean forward, back , right, left, up, down, rotateLeft, rotateRight, rotateUp, rotateDown;
PVector oldMousePos;

int closestObjIndex;
int closestFaceIndex;
String closestObj;

float lastMillis = 0;


boolean freezeNormal = false;

int raysPerFrame = 300;
int xLeftOff = 0;
int yLeftOff = 0;

void setup() {
  size(800, 600);

  maxTravelDstPerStep = defaultMaxTravelDstPerStep;
  maxStepAmountPerPixel = defaultMaxStepAmountPerPixel;
  dstThresHoldToHit = defaultDstThresHoldToHit;
  maxReflections = defaultMaxReflections;
  
  
  bakeDirectionVectors();
  //dir = defaultDir;
  sphere[0] = new Sphere(4, 0, 4, 1, true);
  sphere[1] = new Sphere(3, 1, 1.8, 0.2, true);
  sphere[3] = new Sphere(4, 1, 1.8, 0.6, true);
  
  for (int i = sphereAmount; i < sphereAmount+5; i++) {
    sphere[i] = new Sphere(0, 0, 0, 0.05, false);
  }
  
  //plane[0] = new Plane(0, 0, 0, 1, 0.5, 1, 2);
  plane[0] = new Plane(0, 0, -1, 0, 0, 1, 1, 5, false, true);
  
  //line[0] = new Line(0, 0, 0, 0, 1, 1, normalColor);
  
  line[0] = new Line(1, 0, 0, 0, 0, 0, color(212, 34, 34));
  line[1] = new Line(0, 1, 0, 0, 0, 0, color(31, 184, 72));
  line[2] = new Line(0, 0, 1, 0, 0, 0, color(43, 71, 186));
  
  //box[0] = new Box(1, 1, 1, 1, 1, 1);
  //sphere[1] = new Sphere(6, 0, 0, 1);
  
  torus[0] = new Torus(5, 0, 6, new PVector(2, 1), false);
  cube[2] = new Cube(5, 10, 6, 1, false);
  
  cube[0] = new Cube(0, 0, 2, 3, true);
  cube[1] = new Cube(5, 0, 2, 1, false);
  
  pointLight[0] = new PointLight(-3, -4, 6, 6,  color(255));
  sphere[2] = new Sphere(-3, -4, 6.2, 0.1, false);
  
  //normal line
  cappedLine[0] = new CappedLine(0, 0, 0, 0, 1, 1, 0.03, normalColor);
  
  cubeObj = loadStrings("triangulated.obj");
  model[0] = new Model(cubeObj, new PVector(0, 5, 3));
  
  for (int i = 0; i < 5; i++) {
    sphere[i+sphereAmount].pos = model[0].faces[i].pos;
  }
  noSmooth();
  background(0);
  
  oldMousePos = new PVector(mouseX, mouseY);
}

void draw() {
  background(0);
  rotateDirectionVectors(cameraRotation.x, cameraRotation.y);
  cameraNormal = rotateVector(new PVector(1, 0, 0), cameraRotation.x, cameraRotation.y);
  //print("Camera normal vector: " + cameraNormal + "\n");
  
  int index = 0;
  int raysDoneForFrame = 0;
  for (int y = 0; y < height/pixelSize; y++) {
    for (int x = 0; x < width/pixelSize; x++) {
      
      index = x + y * (width/pixelSize); //Calculating the index from x and y
      
      Ray ray;
      if (orthographicCameraEnabled) {
        PVector p = new PVector(cameraPos.x, cameraPos.y, cameraPos.z);
        ray = new Ray(p.add(orthographicStartPos[index]), orthographicDir, !freezeNormal, calculateLighting, 0);
      }
      else {
        ray = new Ray(cameraPos, dir[index], !freezeNormal, calculateLighting, 0);
      }
      
      RayInfo hit = ray.getRayInfo();
      
      fill(hit.clr);
      stroke(hit.clr);
      if (pixelSize == 1) {
        point(x*pixelSize, y*pixelSize);
      }
      else {
        noStroke();
        rect(x*pixelSize, y*pixelSize, pixelSize, pixelSize);
      }
      if (x == (int)((width/pixelSize)/2) && y == (int)((height/pixelSize)/2) && showNormal && hit.hasNormal) {
        cappedLine[0].pos1 = new PVector(hit.endPoint.x, hit.endPoint.y, hit.endPoint.z);
        //print(hit.normal + " - ");
        //sphere[2].pos = hit.endPoint;
        
        cappedLine[0].pos2 = hit.normal.mult(normalLength).add(hit.endPoint);
        //cappedLine[0].pos2 = model[0].faces[1].pos;
        //print(subtractVectors(line[0].pos2, line[0].pos1).normalize() + "\n");
      }
      
      //hit = true;
      
      /*
      if (glowEffect) {
        if (minimumDistanceThisRay < glowEffectmaxDistance && !hit) {
          stroke(map(glowEffectmaxDistance-minimumDistanceThisRay, 0, glowEffectmaxDistance, 0, 100));
          fill(map(glowEffectmaxDistance-minimumDistanceThisRay, 0, glowEffectmaxDistance, 0, 100));
          if (pixelSize == 1) {
            point(x*pixelSize, y*pixelSize);
          }
          else {
            noStroke();
            rect(x*pixelSize, y*pixelSize, pixelSize, pixelSize);
          }
        }
      }
      */
      raysDoneForFrame++;
      if (raysDoneForFrame >= raysPerFrame) {
        xLeftOff = x;
        yLeftOff = y;
      }
    }
    //Loading bar and stuff
    
    if (loadingBar) {
      int percentage = round((float)index/((height/pixelSize)*(width/pixelSize))*100);
      print(index + " / " + (height/pixelSize)*(width/pixelSize) + ", " + percentage + "%  [");
      for (int i = 0; i < 100; i++) {
        if (i <= percentage) {
          print("I");
        }
        else {
          print(" ");
        }
      }
      print("]\n");
    }
  }
  
  checkInput();
  
  framesRendered++;
  //print(cameraPos + " f: " + framesRendered + "\n");
  //print("frame rendered");s
  //print(line.length);
  print("Frame time: " + (millis()-lastMillis) + "ms\n");
  
  lastMillis = millis();
}






//Rotating the rays (so basically rotating the camera)
void rotateDirectionVectors(float angleZ, float angleY) {
  
  if (angleY == 0 && angleZ == 0) return;
  
  //print(dir[(height/pixelSize)*(width/pixelSize)-1]);
  
  if (orthographicCameraEnabled) {
    
    orthographicDir = rotateVector(new PVector(1, 0, 0), angleZ, angleY); //Forward
    for (int i = 0; i < (height/pixelSize)*(width/pixelSize); i++) {
      orthographicStartPos[i] = rotateVector(defaultOrthographicStartPos[i], angleZ, angleY);
    }
  }
  else {
    for (int i = 0; i < (height/pixelSize)*(width/pixelSize); i++) {
      //Vertical turning
      int one = 1;
      //PVector defaultDir_ = defaultDir;
      
      dir[i] = rotateVector(defaultDir[i], angleZ, angleY);
      
      //old method: idk what was going on
      /*
      if (angleY != 0) { //  |                                   Y                                 |  |     x          X               |
        dir[i] = new PVector(((defaultDir[i].x*cos(angleY) + defaultDir[i].z*sin(angleY)) * cos(one*cameraRotation.y)) + (defaultDir[i].x * sin(one*cameraRotation.y)),
        //              Y               |   |         Y*cos-z*sin                   X                                  |
        (dir[i].y * cos(one*cameraRotation.y)) + ((defaultDir[i].y * cos(angleY) - (defaultDir[i].z * sin(angleY))) * sin(one*cameraRotation.y)),
        //                                 Y                                 |   |        y*sin + z*cos                 X                                    |
        ((dir[i].z*cos(angleY) - defaultDir[i].x*sin(angleY)) * cos(one*cameraRotation.y)) + ((defaultDir[i].y * sin(angleY) + (defaultDir[i].z * cos(angleY))) * sin(one*cameraRotation.y)));
      }
      //Horizontal turning
      if (angleZ != 0) {
        dir[i] = new PVector(defaultDir[i].x*cos(angleZ) - defaultDir[i].y*sin(angleZ), defaultDir[i].y*cos(angleZ) + defaultDir[i].x*sin(angleZ), defaultDir[i].z);
      }
      */
    }
  }
}

PVector rotateVector(PVector start, float x, float y) {
  PVector s = new PVector(start.x, start.y, start.z);
  //Y rotation matrix: up and down; pitch
  s = new PVector(
    s.x * cos(y) + s.z * -sin(y),
    s.y,
    s.x * sin(y) + s.z * cos(y)
  );
  
  //Z rotation matrix: around; yaw
  s = new PVector(
    s.x * cos(x) + s.y * sin(x),
    s.x * -sin(x) + s.y * cos(x),
    s.z
  );
  return s;
}

void bakeDirectionVectors() { //Bakes the direction vector, so it doesn't have to be computed for every frame, this however does not combine with runtime camera rotation(!)
  //The fixed points are (1, (-)1, 0)
  
  //Perspective baking:
  if (!orthographicCameraEnabled) {
    dir = new PVector[(height/pixelSize)*(width/pixelSize)];
    defaultDir = new PVector[(height/pixelSize)*(width/pixelSize)];
    
    float dstBetweenDirVectorPoints = ((float)-2/((int)width-1)) * pixelSize; //Relies on 2 fixed points, and fixed distance to camera of the dir vector plane
    float startZ = (height-1)/2 * -dstBetweenDirVectorPoints/pixelSize;
    for (int z = 0; z < height/pixelSize; z++) {
      for (int y = 0; y < width/pixelSize; y++) {
        int index = y + z * (width/pixelSize); //Calculating the index from x and y
        PVector pixelVectorPos = new PVector(1, 1 + y*dstBetweenDirVectorPoints, startZ + z * dstBetweenDirVectorPoints);
        defaultDir[index] = (new PVector(pixelVectorPos.x, pixelVectorPos.y, pixelVectorPos.z)).normalize();
        
        //A unit vector is made by dividing all the vector components by the total length
        //print(1 + y*dstBetweenDirVectorPoints + "   y:" + y + "  \n");
        //print(dir[index] +  " at (" + y + ", " + z + "), with index " + index + "\n");
        //print(pixelVectorPos +  " at (" + y + ", " + z + "), with index " + index + "\n");
      }
      //print(pixelVectorPos +  " at (" + b + ", " + z + "), with index " + z * (width) + "\n");
      //print(startZ + z * dstBetweenDirVectorPoints + "   z:" + z + "  \n");
    }
    
    for (int i = 0; i < (height/pixelSize)*(width/pixelSize); i++) {
      dir[i] = defaultDir[i];
    }
  }
  
  //Orthographic
  else {
    defaultOrthographicStartPos = new PVector[(height/pixelSize)*(width/pixelSize)];
    orthographicStartPos = new PVector[(height/pixelSize)*(width/pixelSize)];
    
    float deltaZ = orthographicCameraHeight/((float)(width/pixelSize)-1.0); //distance between each point on vertical axis
    float orthographicCameraWidth = ((float)width)/((float)height)*orthographicCameraHeight;
    float deltaY = orthographicCameraWidth/((float)(height/pixelSize)-1.0); //distance between each point on horizontal axis
    
    for (int z = 0; z < height/pixelSize; z++) {
      for (int y = 0; y < width/pixelSize; y++) {
        int index = y + z * (width/pixelSize); //Calculating the index from x and y
        
        defaultOrthographicStartPos[index] = new PVector(0, -(y-(width/pixelSize)/2)*deltaY, -(z-(height/pixelSize)/2)*deltaZ);
        
        //A unit vector is made by dividing all the vector components by the total length
        //print(1 + y*dstBetweenDirVectorPoints + "   y:" + y + "  \n");
        //print(dir[index] +  " at (" + y + ", " + z + "), with index " + index + "\n");
        //print(pixelVectorPos +  " at (" + y + ", " + z + "), with index " + index + "\n");
      }
      //print(pixelVectorPos +  " at (" + b + ", " + z + "), with index " + z * (width) + "\n");
      //print(startZ + z * dstBetweenDirVectorPoints + "   z:" + z + "  \n");
    }
    
    for (int i = 0; i < (height/pixelSize)*(width/pixelSize); i++) {
      orthographicStartPos[i] = defaultOrthographicStartPos[i];
    }
  }
}

void checkInput() {
  frameChanged = false;
  if (down) {
    cameraPos.add(new PVector(0, 0, -cameraSpeed));
    frameChanged = true;
  }
  if (up) {
    cameraPos.add(new PVector(0, 0, cameraSpeed));
    frameChanged = true;
  }
  if (forward) {
    cameraPos.add(new PVector(cameraSpeed*cos(cameraRotation.x), -cameraSpeed*sin(cameraRotation.x), 0));
    frameChanged = true;
  }
  if (back) {
    cameraPos.add(new PVector(-cameraSpeed*cos(cameraRotation.x), cameraSpeed*sin(cameraRotation.x), 0));
    frameChanged = true;
  } 
  if (left) {
    cameraPos.add(new PVector(-cameraSpeed*sin(-cameraRotation.x), cameraSpeed*cos(-cameraRotation.x), 0));
    frameChanged = true;
  } 
  if (right) {
    cameraPos.add(new PVector(cameraSpeed*sin(-cameraRotation.x), -cameraSpeed*cos(-cameraRotation.x), 0));
    frameChanged = true;
  } 
  PVector toRotate = new PVector(0, 0);
  if (rotateLeft) {
    toRotate.add(cameraRotateSpeed, 0);
    frameChanged = true;
  }
  if (rotateRight) {
    toRotate.add(-cameraRotateSpeed, 0);
    frameChanged = true;
  }
  if (rotateUp) {
    toRotate.add(0, cameraRotateSpeed);
    frameChanged = true;
  }
  if (rotateDown) {
    toRotate.add(0, -cameraRotateSpeed);
    frameChanged = true;
  }
  if (mousePressed) {
    PVector mousePos = new PVector(-mouseX, mouseY);
    toRotate.add(oldMousePos.add(mousePos.mult(-1)).mult(mouseSensitivity));
    frameChanged = true;
  }
  oldMousePos = new PVector(-mouseX, mouseY);
  cameraRotation.add(toRotate);
  if (dynamicResolution) {
    if (frameChanged) {
      if (pixelSize != 10) {
        pixelSize = 10;
        bakeDirectionVectors();
      }
    }
    else if (pixelSize > 4) {
      pixelSize--;
      bakeDirectionVectors();
    }
  }
}


//Vector math

//DISTANCE FUNCTIONS
float dstSphere(Sphere sphere_, PVector endPoint) { //Input sphere named as sphere_ because a sphere array with the name sphere exists
  return vectorLength(subtractVectors(sphere_.pos, endPoint))-sphere_.radius; 
}

float dstBox(Box box_, PVector endPoint) {
  PVector q = subtractVectors(vectorAbs(box_.pos), box_.size);
  //return min(max(q.x, max(q.y, q.z)), 0.0) + vectorLength(q) -  vectorLength(endPoint);
  return max(vectorLength(subtractVectors(vectorAbs(box_.pos), box_.size)), 0) -  vectorLength(endPoint);
}

float dstTorus(Torus tor, PVector endPoint) {
  float dist;
  PVector q = new PVector(vectorLength(new PVector(endPoint.x - tor.pos.x, 0, endPoint.z - tor.pos.z)) - tor.t.x, endPoint.y);
  dist = vectorLength(q)-tor.t.y;
  return dist;
}

float dstCube(Cube cube_, PVector endPoint, int index) {
  float dist;
  /*
  PVector o = vectorAbs(subtractVectors(endPoint, cube_.pos));
  float ud = vectorLength(max(o, 0));
  float n = max(max(min(o.x, 0),min(o.y, 0)), min(o.z, 0));
  return ud+n;
  */
  cubeEndPoint[index] = new PVector(max(0, abs(endPoint.x-cube_.pos.x)-cube_.size), max(0, abs(endPoint.y-cube_.pos.y)-cube_.size), max(0, abs(endPoint.z-cube_.pos.z)-cube_.size));
  //dist = sqrt(sq(max(0, abs(endPoint.x-cube_.pos.x)-1)) + sq(max(0, abs(endPoint.y-cube_.pos.y)-1)) + sq(max(0, abs(endPoint.z-cube_.pos.z)-1)));
  //cubeEndPoint[index] = new PVector 
  dist = sqrt(sq(cubeEndPoint[index].x) + sq(cubeEndPoint[index].y) + sq(cubeEndPoint[index].z));
  return dist;
}

float dstPlane(Plane plane_, PVector endPoint) {
  float dist;
  //dist = plane_.pos.dot(plane_.n) + plane_.h - vectorLength(endPoint);
  dist = endPoint.z-plane_.pos.z;
  return dist;
  
  //return (abs(plane_.a*plane_.pos.x + plane_.b*plane_.pos.y + plane_.c*plane_.pos.z + plane_.d)) / (sqrt(sq(plane_.a) + sq(plane_.b) + sq(plane_.c)));
}

float dstLine(Line line_, PVector endPoint) {
  PVector d = divideVector(subtractVectors(line_.pos2, line_.pos1), line_.pos1.dist(line_.pos2));
  //if (print) print(line_.pos1.dist(line_.pos2) + "\n");
  PVector v = subtractVectors(endPoint, line_.pos2);
  float t = v.dot(d);
  PVector m = multVectorFloat(d, t);
  PVector p = new PVector(line_.pos2.x + m.x, line_.pos2.y + m.y, line_.pos2.z + m.z);
  //print("\np: " + p);
  return p.dist(endPoint) - 0.01;
  
  /*
  PVector s = line_.dir;
  PVector m = line_.pos1;
  PVector mm = subtractVectors(line_.pos1, endPoint);
  PVector ijk = new PVector((m.y*s.z-m.z*s.y), -(m.x*s.z-m.z*s.x), (m.x*s.y-m.y*s.x));
  //print(vectorLength(ijk) / vectorLength(s) + "\n");
  return vectorLength(ijk) / vectorLength(s) - vectorLength(endPoint);
  */
}

/*
float udTriangle( vec3 p, vec3 a, vec3 b, vec3 c )
{
  vec3 ba = b - a; vec3 pa = p - a;
  vec3 cb = c - b; vec3 pb = p - b;
  vec3 ac = a - c; vec3 pc = p - c;
  vec3 nor = cross( ba, ac );

  return sqrt(
    (sign(dot(cross(ba,nor),pa)) +
     sign(dot(cross(cb,nor),pb)) +
     sign(dot(cross(ac,nor),pc))<2.0)
     ?
     min( min(
     dot2(ba*clamp(dot(ba,pa)/dot2(ba),0.0,1.0)-pa),
     dot2(cb*clamp(dot(cb,pb)/dot2(cb),0.0,1.0)-pb) ),
     dot2(ac*clamp(dot(ac,pc)/dot2(ac),0.0,1.0)-pc) )
     :
     dot(nor,pa)*dot(nor,pa)/dot2(nor) );
}
*/

float dstTri(PVector a, PVector b, PVector c, PVector p) {  //p is endpoint
  PVector ba = subtractVectors(b, a);
  PVector cb = subtractVectors(c, b);
  PVector ac = subtractVectors(a, c);
  PVector pa = subtractVectors(p, a);
  PVector pb = subtractVectors(p, b);
  PVector pc = subtractVectors(p, c);
  PVector nor = ba.cross(ac);
  return sqrt(
    (sign(ba.cross(nor).dot(pa)) +
    sign(cb.cross(nor).dot(pb)) +
    sign(ac.cross(nor).dot(pc)) <2.0)
    ?
    min(
      min(
        dot2(subtractVectors(ba.mult(constrain(ba.dot(pa)/dot2(ba), 0.0, 1.0)), pa)),
        dot2(subtractVectors(cb.mult(constrain(cb.dot(pb)/dot2(cb), 0.0, 1.0)), pb))
      ),      
      dot2(subtractVectors(ac.mult(constrain(ac.dot(pc)/dot2(ac), 0.0, 1.0)), pc))
    )
    :
    nor.dot(pa)*nor.dot(pa)/dot2(nor)
  );
}

/*
float udQuad( vec3 p, vec3 a, vec3 b, vec3 c, vec3 d )
{
  vec3 ba = b - a; vec3 pa = p - a;
  vec3 cb = c - b; vec3 pb = p - b;
  vec3 dc = d - c; vec3 pc = p - c;
  vec3 ad = a - d; vec3 pd = p - d;
  vec3 nor = cross( ba, ad );

  return sqrt(
    (sign(dot(cross(ba,nor),pa)) +
     sign(dot(cross(cb,nor),pb)) +
     sign(dot(cross(dc,nor),pc)) +
     sign(dot(cross(ad,nor),pd))<3.0)
     ?
     min( min( min(
     dot2(ba*clamp(dot(ba,pa)/dot2(ba),0.0,1.0)-pa),
     dot2(cb*clamp(dot(cb,pb)/dot2(cb),0.0,1.0)-pb) ),
     dot2(dc*clamp(dot(dc,pc)/dot2(dc),0.0,1.0)-pc) ),
     dot2(ad*clamp(dot(ad,pd)/dot2(ad),0.0,1.0)-pd) )
     :
     dot(nor,pa)*dot(nor,pa)/dot2(nor) );
}
*/
float dstQuad(PVector a, PVector b, PVector c, PVector d, PVector p) {
  //p is endpoint
  PVector ba = subtractVectors(b, a);
  PVector cb = subtractVectors(c, b);
  PVector dc = subtractVectors(d, c);
  PVector ad = subtractVectors(a, d);
  PVector pa = subtractVectors(p, a);
  PVector pb = subtractVectors(p, b);
  PVector pc = subtractVectors(p, c);
  PVector pd = subtractVectors(p, d);
  PVector nor = ba.cross(ad);
  
  return sqrt(
    (sign(ba.cross(nor).dot(pa)) +
    sign(cb.cross(nor).dot(pb)) +
    sign(dc.cross(nor).dot(pc)) +
    sign(ad.cross(nor).dot(pd)) < 3.0)
    ?
    min(
      min(
        min(
          dot2(subtractVectors(ba.mult(constrain(ba.dot(pa)/dot2(ba), 0.0, 1.0)), pa)),
          dot2(subtractVectors(cb.mult(constrain(cb.dot(pb)/dot2(cb), 0.0, 1.0)), pb))
        ),      
        dot2(subtractVectors(dc.mult(constrain(dc.dot(pc)/dot2(dc), 0.0, 1.0)), pc))
      ),      
      dot2(subtractVectors(ad.mult(constrain(ad.dot(pc)/dot2(ad), 0.0, 1.0)), pd))
    )
    :
    nor.dot(pa)*nor.dot(pa)/dot2(nor)
  );
}

int sign(float f) {
  if (f == 0) return(0);
  return(int(f/abs(f)));
}

float dot2(PVector v) { 
  return v.dot(v); 
}


float dstCappedLine(CappedLine line, PVector endPoint) {
  float dst = 0;
  PVector pa = subtractVectors(endPoint, line.pos1);
  PVector ba = subtractVectors(line.pos2, line.pos1);
  float h = constrain(pa.dot(ba)/ba.dot(ba), 0.0, 1.0);
  return vectorLength(subtractVectors(pa, ba.mult(h))) - line.r;
}

float dist(PVector a, PVector b) {
  return dist(a.x, a.y, a.z, b.x, b.y, b.z);
}

PVector max(PVector v, float e) {
  return (new PVector(max(v.x, e),max(v.y, e), max(v.z, e)));
}

PVector subtractVectors (PVector v1, PVector v2) {
  return new PVector(v1.x-v2.x, v1.y-v2.y, v1.z-v2.z);
}
float vectorLength(PVector v) {
  return sqrt((sq(v.x) + sq(v.y) + sq(v.z)));
}
PVector vectorAbs(PVector v) {
  return(new PVector(abs(v.x), abs(v.y), abs(v.z)));
}
/*
float dstVectors (PVector v1, PVector v2) {
  return sqrt(sq(v2.x-v1.x) + sq(v2.y-v1.y) + sq(v2.z-v1.z));
}
*/
PVector divideVector(PVector v, float f) {
  return new PVector(v.x/f, v.y/f, v.z/f);
}

PVector multVectorFloat(PVector v, float f) {
  return new PVector(v.x*f, v.y*f, v.z*f);
}

PVector multVectors(PVector v, PVector v2) {
  return new PVector(v.x*v2.x, v.y*v2.y, v.z*v2.z);
}

float smin( float a, float b, float k )
{
    float h = max( k-abs(a-b), 0.0 )/k;
    return min( a, b ) - h*h*k*(1.0/4.0);
}

void keyPressed() {
  if (key == 'w')
    forward = true;
  if (key == 'a')
    left = true;
  if (key == 's')
    back = true;
  if (key == 'd')
    right = true;
  if (key == ' ')
    up = true;
  if (key == 'z')
    down = true;
  if (key == 'h')
    rotateLeft = true;
  if (key == 'f')
    rotateRight = true;
  if (key == 't')
    rotateUp = true;
  if (key == 'g')
    rotateDown = true;
  if (key == 'v') {
    pixelSize++;
    bakeDirectionVectors();
  }
  if (key == 'c' && pixelSize > 1) {
    pixelSize--;
    bakeDirectionVectors();
  }
}

void keyReleased() {
  if (key == 'w')
    forward = false;
  if (key == 'a')
    left = false;
  if (key == 's')
    back = false;
  if (key == 'd')
    right = false;
  if (key == ' ')
    up = false;
  if (key == 'z')
    down = false;
  if (key == 'h')
    rotateLeft = false;
  if (key == 'f')
    rotateRight = false;
  if (key == 't')
    rotateUp = false;
  if (key == 'g')
    rotateDown = false;
  if (key == 'q')
    glowEffect = !glowEffect;
  if (key == 'l')
    calculateLighting = !calculateLighting;
  if (key == 'n')
    showNormal = !showNormal;
  if (key == 'b')
    freezeNormal = !freezeNormal;
  if (key == 'j')
    loadingBar = !loadingBar;
  if (key == 'o'){
    orthographicCameraEnabled = !orthographicCameraEnabled; bakeDirectionVectors();}
  if (key == 'p') {
    saveFrame("Frame.png");
    print("Screenshot taken\n");
  }
  if (key == 'r') {
    onHighSettings = !onHighSettings;
    if (!onHighSettings) {
      maxTravelDstPerStep = defaultMaxTravelDstPerStep;
      maxStepAmountPerPixel = defaultMaxStepAmountPerPixel;
      dstThresHoldToHit = defaultDstThresHoldToHit;
      maxReflections = defaultMaxReflections;
    }
    else {
      maxTravelDstPerStep = highMaxTravelDstPerStep;
      maxStepAmountPerPixel = highMaxStepAmountPerPixel;
      dstThresHoldToHit = highDstThresHoldToHit;
      maxReflections = highMaxReflections;
    }
  }
}
