float[] armAngle = new float[2];
float a1 = 150, a2 = 150;
float num1, num2;
float x = 150, y = 150;
float ix = 100, iy = 100;

void setup() {
  size(600, 600);
  
}

void draw() {
  background(200);
  show();
  num1 = mouseX;
  num2 = mouseY;
  x = mouseX;
  y = mouseY;
  num1 /= 100;
  num2 /= 100;
  //armAngle[0] = num1;
  //armAngle[1] = num2;
  armAngle[1] = acos((sq(x) + sq(y) - sq(a1) - sq(a2)) / 2*(a1*a2));
  armAngle[0] = atan(y/x) - atan((a2 * sin(armAngle[1])) / (a1 + a2 * cos(armAngle[1])));
  text((sq(x) + sq(y) - sq(a1) - sq(a2)) / 2*(a1*a2), 50, 50);
}

void show() {
  //for(int i = 0; i < 2; i++) {
  strokeWeight(3);
  //line(ix, iy, ix + cos(armAngle[0])*a1, iy + sin(armAngle[0])*a1);
  //circle(ix + cos(armAngle[0])*a1, iy + sin(armAngle[0])*a1, 5);
  //line(ix + cos(armAngle[0])*a1, iy + sin(armAngle[0])*a1, ix + (cos(armAngle[0]) + cos(armAngle[1]))*a2, iy + (sin(armAngle[0]) + sin(armAngle[1]))*a2);
  line(0, 0, cos(armAngle[0])*a1, sin(armAngle[0])*a1);
  circle(cos(armAngle[0])*a1, sin(armAngle[0])*a1, 5);
  line(cos(armAngle[0])*a1, sin(armAngle[0])*a1, cos(armAngle[0]) + cos(armAngle[1])*a2, (sin(armAngle[0]) + sin(armAngle[1]))*a2);
  //}
}
