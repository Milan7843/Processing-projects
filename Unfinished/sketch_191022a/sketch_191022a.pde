//actual line amount is pointAmount/2
int fov = 90;
int maxIntersects = 1;
int objectAmount = 2;
float currentObjectAmount;
PVector[] vector = new PVector[objectAmount*2];
PVector[] ray = new PVector[fov];
float tx1, tx2, ty1, ty2;
float[] intersectX = new float[fov];
float[] intersectY = new float[fov];
float[] ceilingColour = {59, 84, 130};
float[] wallColour = {212, 111, 23};
boolean editMode = true;

float rays = 150;
boolean infoEnabled = true;
float px = 300, py = 300, rot, playerSpeed = 5, rotSpeed = 0.07;

//A D W S R
//0 1 2 3 4 
boolean[] keys = new boolean[5];

void setup() {
  fullScreen();
  object(100, 100, 200, 200);
  for (int p=0; p<fov; p++) {
    ray[p] = new PVector(0,0);
  }
}

//sdx = cos(a + shipWidth);
//sdy = sin(a + shipWidth);
//line(0, 0, (sdx)*-shipLength * scale, (sdy)*-shipLength * scale);

void draw() {
  background(200);
  playerMovement();
  
  
  for (int i = 0; i < currentObjectAmount; i++) {
    if (i % 2 == 0) {
      line(vector[i].x, vector[i].y, vector[i+1].x, vector[i+1].y);
      
    }
  }
  
  
  
  if (infoEnabled) {
    info();
  }
  circle(vector[0].x, vector[0].y, 10);
  circle(vector[1].x, vector[1].y, 10);
  
  if (!editMode) {
    rendering();
    rays();
  }
  line(vector[0].x, vector[0].y, vector[1].x, vector[1].y);
  if (keys[4]) {
    editMode = false;
  }
}

void info() {
  
}

void playerMovement() {
  if (keys[0]) {
    rot -= rotSpeed;
  }
  if (keys[1]) {
    rot += rotSpeed;
  }
  if (keys[2]) {
    px += cos(rot) * playerSpeed;
    py += sin(rot) * playerSpeed;
  }
  if (keys[3]) {
    px -= cos(rot) * playerSpeed;
    py -= sin(rot) * playerSpeed;
  }
  //line(px, py, px + cos(rot) * 100, py + sin(rot) * 100);
  circle(px, py, 20);
}

void keyPressed()
{
  if (key=='a') {
    keys[0]=true;
  } if (key=='d') {
    keys[1]=true;
  } if (key == 'w') {
    keys[2]=true;
  } if (key == 's') {
    keys[3]=true;
  } if (key == 'r') {
    keys[4]=true;
  }
}

void keyReleased()
 {
   if (key=='a') {
     keys[0]=false;
   } if (key=='d') {
     keys[1]=false;
   } if (key == 'w') {
     keys[2]=false;
   } if (key == 's') {
     keys[3] = false;
   } if (key == 'r') {
     keys[4]=false;
   }
} 


void object(int x1, int y1, int x2, int y2) {
  //text(x1 + "\n" + x2 + "\n" + y1 + "\n" + y2, 200, 200);
  vector[(int)currentObjectAmount*2] = new PVector(x1, y1);
  vector[(int)currentObjectAmount*2 + 1] = new PVector(x2, y2);
  
  
  currentObjectAmount++;
}

void rays() {
  if (!editMode) {
    for (int i = 0; i < (int)fov; i++) {
      //sdx = cos(a + shipWidth);
      //sdy = sin(a + shipWidth);
      
      ////x[0] is een fixed point, namelijk het eindpunt van de ray
      //wat eerst x[0] was is nu de px
      //wat eerst x[1] was is nu x[0]
      ray[i].x = px + cos(rot + (i*1.6)/fov - 1.6/(180/fov)) * 700;
      ray[i].y = py + sin(rot + (i*1.6)/fov - 1.6/(180/fov)) * 700;
      line(ray[i].x, ray[i].y, px, py);
      for (int k = 0; k < currentObjectAmount; k++) {
        if (k % 2 == 0) {
          //line(vector[k].x, vector[k].y, vector[k+1].x, vector[k+1].y);
          //              ((x1y2  -  y1x2)    * (x3 - x4)   -  ((x1 - x2)    *  (x3y4 - y3x4))         /   ((x1 - x2)  *  (y3 - y4)  -  (y1 - y2)  *  (x3 - x4));
          intersectX[i] = ((px*ray[i].y-py*ray[i].x) * (vector[k].x-vector[k+1].x) - (px-ray[i].x) * (vector[k].x*vector[k+1].y-vector[k].y*vector[k+1].x))  /  ((px-ray[i].x) * (vector[k].y-vector[k+1].y) - (py-ray[i].y) * (vector[k].x-vector[k+1].x));
          //intersectX[0] = ((x[0]*y[1]-y[0]*x[1]) * (x[2]-x[3]) - (x[0]-x[1]) * (x[2]*y[3]-y[2]*x[3]))  /  ((x[0]-x[1]) * (y[2]-y[3]) - (y[0]-y[1]) * (x[2]-x[3]));
          //              ((x1y2  -  y1x2)    * (y3 - y4)   -  ((y1 - y2)    * (x3y4 - y3x4))          /   ((x1 - x2)  *  (y3 - y4)  -  (y1 - y2)  *  (x3 - x4));
          intersectY[i] = ((px*ray[i].y-py*ray[i].x) * (vector[k].y-vector[k+1].y) - (py-ray[i].y) * (vector[k].x*vector[k+1].y-vector[k].y*vector[k+1].x))  /  ((px-ray[i].x) * (vector[k].y-vector[k+1].y) - (py-ray[i].y) * (vector[k].x-vector[k+1].x));
          //intersectY[0] = ((x[0]*y[1]-y[0]*x[1]) * (y[2]-y[3]) - (y[0]-y[1]) * (x[2]*y[3]-y[2]*x[3]))  /  ((x[0]-x[1]) * (y[2]-y[3]) - (y[0]-y[1]) * (x[2]-x[3]));
        }
        if (intersectX[i] > vector[k].x && intersectX[i] > vector[k+1].x && intersectY[i] > vector[k].y && intersectY[i] > vector[k+1].y) {
          intersectX[i] = 0;
          intersectY[i] = 0;
        }
        if (intersectX[i] < vector[k].x && intersectX[i] < vector[k+1].x && intersectY[i] < vector[k].y && intersectY[i] < vector[k+1].y) {
          intersectX[i] = 0;
          intersectY[i] = 0;
        }
      }
      circle(ray[i].x, ray[i].y, 5);
      circle(intersectX[i], intersectY[i], 5);
    }
  }
  
}

void rendering() {
  //wall rendering
  noStroke();
  fill(wallColour[0], wallColour[1], wallColour[2]);
  for (int i = 0; i < (int)fov; i++) {
    if (intersectX[i] != 0 && intersectY[i] != 0) {
      rect(width/90*i, dist(px, py, intersectX[i], intersectY[i]), width/90, height - 2*(dist(px, py, intersectX[i], intersectY[i])));
    }
  }
  fill(ceilingColour[0], ceilingColour[1], ceilingColour[2]);
  for (int i = 0; i < (int)fov; i++) {
    if (intersectX[i] == 0 && intersectY[i] == 0) {
      rect(width/90*i, 0, width/90, height);
    }
    if (intersectX[i] != 0 && intersectY[i] != 0) {
      rect(width/90*i, 0, width/90, dist(px, py, intersectX[i], intersectY[i]));
      rect(width/90*i, 1080, width/90, -dist(px, py, intersectX[i], intersectY[i]));
    }
  }
  stroke(0);
  
}
