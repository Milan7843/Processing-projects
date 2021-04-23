float groundY = 500;

//Menu
float menuWidth = 300;
float submenuHeight = 30;
float submenuSpace = 5;
float settingHeight = 55;
float settingSpace = 5;

float sliderHandleSize = 15;

color menuBackgroundColor = color(158, 217, 208);
color submenuColor = color(158, 195, 217);
color hoverColor = color(142, 186, 212);
color pressedColor = color(125, 172, 199);

int frame;
MenuHandler menuHandler = new MenuHandler();





//DATA FOR PARTICLE SYSTEM (has to be global)

//index 0
int[] intData = new int[3];
int[] minIntValue = {
  0,
  1,
  1
};
int[] maxIntValue = {
  60,
  300,
  900
};
String[] intDataName = {
  "Frames between each dispense",
  "Particles per dispense",
  "Particle lifetime"
};
//INT DATA:
//0: framesBetweenDispense, 1
//1: amountPerDispense, 1
//2: particleLifeTime, 2

//index 1
float[] floatData = new float[3];
float[] minFloatValue = {
  0,
  0,
  -0.01
};
float[] maxFloatValue = {
  -1,
  30,
  0.01
};
String[] floatDataName = { 
  "Frame to start fading",
  "Gravity",
  "Drag"
};
//0: fadeFrame, 2, -1 for changing
//1: gravity
//2: Drag, 2

//index 2
PVector[] dualFloatData = {new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0)};
float[] minDualFloatValue = {
  0.01, 
  0,
  0.1,
  0, 
  0, 
  0
};
float[] maxDualFloatValue = {
  30, 
  360,
  100,
  255,
  255,
  255
};
String[] dualFloatDataName = {
  "Dispense force",
  "Dispense angle",
  "Particle size",
  "Minimum R for RGB",
  "Minimum G for RGB",
  "Minimum B for RGB"
};
//0: Force, 2
//1: Angle, 2
//2: Size, 2
//3: Minimum R
//4: Minimum G
//5: Minimum B

//index 3
boolean[] booleanData = new boolean[2];
String[] booleanDataName = {
  "Fade on/off", 
  "Collide with ground"
};
//0: fade, 2
//1: ground collision, 3




ParticleSystem ps1 = new ParticleSystem(
650, 300,  //x and y position
0,         //frames between dispenses
1,         //particles dispensed per dispense
1, 5,      //min force, max force        
180,       //particle lifetime
0, 360,    //min angle, max angle | 0 deg = right, 90 down, 180 left, 270 up
6, 16,     //min size, max size
true,      //fade particles
150,       //fade after frame
0.001      //Drag
);




void setup() {
  size(1000, 600);
  frameRate(60);
}

void draw() {
  background(0);
  ps1.update();
  //ps1.pos = new PVector(mouseX, mouseY);
  menuHandler.render();
  frame++;
}

boolean mouseOn (float x, float y, float sx, float sy) {
  return (mouseX >= x && mouseX <= x+sx && mouseY >= y && mouseY <= y+sy);
}

color menuColor(float x1, float y1, float w, float h) {
  if (mouseOn(x1, y1, w, h)) {
    if (mousePressed) {
      return pressedColor;
    }
    return hoverColor;
  }
  else {
    return submenuColor;
  }
}

void mouseReleased() {
  menuHandler.mouseUp();
}

void mousePressed() {
  menuHandler.mouseDown();
}
