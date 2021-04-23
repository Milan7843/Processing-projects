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

Setting[] setting = {
  //int settings
  new Setting("framesBetweenDispenses", "Frames between each dispense", 0, 60, 0),
  new Setting("particlesPerDispense", "Particles per dispense", 1, 300, 1),
  new Setting("particleLifetime", "Particle lifetime", 1, 900, 180),
  new Setting("fadeFrame", "Frame to start fading", 1, 900, 150), //custom, based on totalFrames WIP
  //float settings
  new Setting("gravity", "Gravity", 0, 10.0, 0),
  new Setting("drag", "Drag", -0.01, 0.01, 0),
  //dual float settings
  new Setting("force", "Dispense force", 0.01, 30, new PVector(0.01, 5)),
  new Setting("angle", "Dispense angle", 0, 360, new PVector(0, 360)),
  new Setting("size", "Dispense size", 0.1, 100, new PVector(0.1, 14)),
  new Setting("minr", "Minimum R for RGB", 0, 255, new PVector(0, 255)),
  new Setting("ming", "Minimum G for RGB", 0, 255, new PVector(0, 255)),
  new Setting("minb", "Minimum B for RGB", 0, 255, new PVector(0, 255)),
  //boolean settings
  new Setting("fade", "Fade on/off", false),
  new Setting("groundcoll", "Collide with ground", false)
};

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
  //print(getInt("fadeFrame") + "\n");
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

//Finding variables by name
Setting findSetting (String name) {
  for (Setting s : setting) {
    if (s.callName.equals(name)) {
      return s;
    }
  }
  print("variable " + name + " not found");
  return null;
}

int getInt(String name) { 
  for (Setting s : setting) {
    if (s.callName.equals(name)) {
      return s.intValue;
    }
  }
  print("variable " + name + " not found");
  return 0;
}
float getFloat(String name) { 
  for (Setting s : setting) {
    if (s.callName.equals(name)) {
      return s.floatValue;
    }
  }
  print("variable " + name + " not found");
  return 0;
}
PVector getDual(String name) { 
  for (Setting s : setting) {
    if (s.callName.equals(name)) {
      return s.dualValue;
    }
  }
  print("variable " + name + " not found");
  return new PVector(0, 0);
}
boolean getBool(String name) { 
  for (Setting s : setting) {
    if (s.callName.equals(name)) {
      return s.boolValue;
    }
  }
  print("variable " + name + " not found");
  return false;
}
