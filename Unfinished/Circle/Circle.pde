float x;
float cX = width/2;
float cY = height/2;
float a;
float b;
float c;
float r = 200;
float angle;
float meetY;
void setup() {
  size(600, 600);
  
  cX = width/2;
  cY = height/2;
}

//Lijn met lengte r
//b = mouseX-cX
//c uitrekenen met deze getallen
//b*b + c*c = r*r



void draw() {
  background(200);
  b = mouseX-cX;
  c = mouseY-cY;
  a = r;
  meetY = sqrt(sq(b) + sq(c) - 2*r*c*cos(angle));
  //a = sqrt(sq(b)+sq(c));
  //Standard circle
  noFill();
  ellipse(cY,cX,r*2,r*2);
  //sqrt(sq(b) + sq(c)) = a;
  angle = tan(c/a);
  angle = degrees(angle);
  line(cX, cY, mouseX, mouseY);
  line(cX, cY, mouseX, cY);
  line(mouseX, cY, mouseX, mouseY);
  line(mouseX, 0, mouseX, height);
  Text();
  
  line(cX, cY, mouseX, meetY);
}

void Text() {
  text(mouseX, 50, 50);
  text(angle, 50, 70);
  text(a, 50, 90);
  text(b, 50, 110);
  text(c, 50, 130);
}
