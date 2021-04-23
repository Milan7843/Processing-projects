boolean[] segments = new boolean[7];
int[] sideways = {1, 0, 0, 1, 0, 0, 1};
PVector[] coords = new PVector[7];
float segmentLength = 200;
float segmentSpace = 20;
float segmentWidth = 30;
float ox = 50, oy = 50;
float x, y;
void setup() {
  size(350, 600);
}

void draw() {
  background(20);
  coordinates();
  segment();
  
  
}

void segment() {
  for (int i = 0; i < 7; i++) {
    pushMatrix();
    if (sideways[i] == 1) {
      rotate(PI);
    }
    
    x = coords[i].x;
    y = coords[i].y;
    beginShape();
    vertex(x, y);
    vertex(x - segmentWidth, y + segmentWidth);
    vertex(x - segmentWidth, y + segmentLength - segmentWidth);
    vertex(x, y + segmentLength);
    vertex(x + segmentWidth, y + segmentLength - segmentWidth);
    vertex(x + segmentWidth, y + segmentWidth); 
    endShape();
    popMatrix();
  }
}


void coordinates() {
  x = ox;
  y = oy;
  coords[0] = new PVector(x, y);
  x += segmentLength;
  y += segmentSpace;
  coords[1] = new PVector(x, y);
  y += segmentLength + segmentSpace;
  coords[2] = new PVector(x, y);
  x -= (segmentLength + segmentSpace);
  y += segmentLength + segmentSpace;
  coords[3] = new PVector(x, y);
  x -= segmentSpace;
  y -= (segmentSpace + segmentLength);
  coords[4] = new PVector(x, y);
  y -= (segmentSpace + segmentLength);
  coords[5] = new PVector(x, y);
  x += segmentSpace;
  y += segmentSpace + segmentLength;
  coords[6] = new PVector(x, y);
}
