float grav = 0.1;
float timeScale = 0.9;

Softbody body1;

int[][] body1pts = {
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1}  
};

/*
int[][] body1pts = {
  {1, 1}, {1, 1},
};
*/


void setup() 
{
  size(800, 800);
  body1 = new Softbody(body1pts, new PVector(400, 400));
}

void draw() 
{
  background(200);
  if (mousePressed) body1.points[0][0].pos = new PVector(mouseX, mouseY);
  body1.update();
  if (mousePressed) body1.points[0][0].pos = new PVector(mouseX, mouseY);
  body1.show();
}

void mouseDragged() {
  body1.points[0][0].pos = new PVector(mouseX, mouseY);
}
