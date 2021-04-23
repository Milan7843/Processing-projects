//Vector art creator for game
//1-8-2020

//Right click to add point
//Left click to drag points
//Scroll to adjust scale
//'d' to print vectors
//'e' to print vertices
//'s' to preview real-size

PVector[] point = new PVector[1];
boolean dragging = false;
int drag = 0;
boolean realsize = false;
float scale = 0.1; //Scales the vectors before printing -> scale of 0.5 means it will be half the size in the game
float gridSpace = 10;


void setup() {
  point[0] = new PVector(5, 5);
  size(600, 600);
}

void draw() {
  background(200);
  strokeWeight(1);
  stroke(0);
  line(0, 300, 600, 300);
  line(300, 0, 300, 600);
  //Horizontal grid
  stroke(0, 130);
  strokeWeight(1);
  for (int y = 0; y < height/gridSpace; y++) {
    line(0, y*gridSpace, width, y*gridSpace);
  }
  //Vertical grid
  for (int x = 0; x < width/gridSpace; x++) {
    line(x*gridSpace, 0, x*gridSpace, height);
  }
  DrawPoints();

  if (dragging) {
    point[drag] = new PVector(round(mouseX/gridSpace)*gridSpace, round(mouseY/gridSpace)*gridSpace);
  }
  textSize(30);
  text(scale, 5, 30);
}

void AddPoint() {
  PVector[] oldPoints = new PVector[point.length-1];
  oldPoints = point;
  point = new PVector[oldPoints.length+1];
  for (int i = 0; i < oldPoints.length; i++) {
    point[i] = oldPoints[i];
  }
  point[point.length-1] = new PVector(round(mouseX/gridSpace)*gridSpace, round(mouseY/gridSpace)*gridSpace);
}

void DrawPoints() {
  if (!realsize) {
    for (int i = 0; i < point.length; i++) {
      fill(255, 150);
      noStroke();
      circle(point[i].x, point[i].y, 10);
    }
    stroke(0);
    strokeWeight(3);
    for (int i = 0; i < point.length-1; i++) {
      line(point[i].x, point[i].y, point[i+1].x, point[i+1].y); //Lines between every point
    }
    line(point[point.length-1].x, point[point.length-1].y, point[0].x, point[0].y); //Line connecting the last and first points
  }
  else {
    for (int i = 0; i < point.length-1; i++) {
      line(point[i].x*scale+50, point[i].y*scale+50, point[i+1].x*scale+50, point[i+1].y*scale+50); //Lines between every point
    }
    line(point[point.length-1].x*scale+50  , point[point.length-1].y*scale+50, point[0].x*scale+50, point[0].y*scale+50); //Line connecting the last and first points
  }
  strokeWeight(1);
}

void keyPressed() {
  if (key == 'd') {
    PrintPoints();
  }
  if (key == 'e') {
    PrintVertices();
  }
  if (key == 's') {
    realsize = !realsize;
  }
}

void PrintVertices() {
  for (int i = 0; i < point.length; i++) {
    print("vertex(" + (point[i].x-300)*scale + ", " + (point[i].y-300)*scale + ");\n");
  }
  print("-----------------------------\n");
}

void PrintPoints() {
  for (int i = 0; i < point.length; i++) {
    print("new PVector(" + (point[i].x-300)*scale + ", " + (point[i].y-300)*scale + "),\n");
  }
  print("-----------------------------\n");
}


void mousePressed() {
  if (mouseButton == LEFT) {
    for (int i = 0; i < point.length; i++) {
      if (dist(mouseX, mouseY, point[i].x, point[i].y) <= 10) {
        drag = i;
        dragging = true;
      }
    }
  }
  else if (mouseButton == RIGHT) {
    AddPoint();
  }
}

void mouseWheel(MouseEvent event) {
  scale += event.getCount() * 0.01;
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    dragging = false;
  }
}
