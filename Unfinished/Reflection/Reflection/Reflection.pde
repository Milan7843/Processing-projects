float x1 = 100, x2, x3, x4, x5, x6;
float y1 = 100, y2, y3, y4, y5, y6;
float lineX1 = 200, lineX2 = 400, lineX3, lineX4;
float lineY1 = 200, lineY2 = 300, lineY3, lineY4;
float addLength = 4;
float xc = x1;
float meetX1, meetY1;
float offset = 1;
boolean slowMotion = false;
float speed = 1;
float pressed = 0;
float f1y;
float f2y;
  
void setup() {
  size(600, 600);
  frameRate(30);
  //translate(300, 300);
}
void draw() {
  //slow motion
  pressed += 1;
  if(mousePressed == true && pressed > 60) {
    if (!slowMotion) {
      speed = 0.05;
      slowMotion = true;
      pressed = 0;
    }
    else if (pressed > 60){
      speed = 1;
      slowMotion = false;
      pressed = 0;
    }
    
  }
  background(200);
  //Lijn van x1, y1 naar muis en verder
  float mouseX2 = addLength*mouseX-x1*(addLength-1); 
  float mouseY2 = addLength*mouseY-y1*(addLength-1); 
  line(x1, y1, mouseX2, mouseY2);
  //test f1y en f2y
  line(meetX1, f1y - offset, meetX1, f1y + offset);
  line(meetX1, f2y - offset, meetX1, f2y + offset);
  
  line(lineX1, lineY1, lineX2, lineY2);
  
  //Lijn collision
  //float xc = y1;
  
  xc += speed;
  if (xc >= width) {
    xc = 0;
  }
  line(0, 10, xc, 10);
  line(xc, 10, xc, 1000);
  float rc1 = ((mouseY - y1)/( mouseX - x1));
  float rc2 = ((lineY2 - lineY1)/(lineX2 - lineX1));
  
  //bij de 1e klopt de berekening niet
  //bij de 2e komt er 100 bij ie er niet bij moet
  
  float f1y = rc1*xc;
  float f2y = rc2*xc + lineY1 - y1;
  if (f1y >= f2y - offset && f1y <= f2y + offset) {
    meetX1 = xc;
    meetY1 = rc2*meetX1 + lineY1;
  }
  line(meetX1, meetY1-y1, meetX1 - ((-1/rc1)-1/rc2)*100, meetY1 - y1 - 100);
  
  text(meetX1, 10, 10);
  text(meetY1, 10, 30);
  text("muis x " + mouseX, 10, 50);
  text("muis y " + mouseY, 10, 70);
  text(f1y, 10, 90);
  text(f2y, 10, 110);
  text(rc1, 10, 130);
  text(rc2, 10, 150);
}
