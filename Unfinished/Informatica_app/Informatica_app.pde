//Informatica applicatie door Milan & Quinten 5vD, JHk
//Scene 0 = main scherm, includeerd een grafiek die je kan bewegen aan de bovenste helft, en een onderkant van de variabelen
//Scene 1 = scherm waar je de functies kan invoegen
//scene 2 = scherm waar je de grafiek kan uitlezen, includeerd een grafiek die je kan bewegen aan de bovenste helft
int scene = 0;
PVector size;
color buttonColor = color(255, 230, 230);
color buttonPressedColor = color(225, 200, 200);
Button[] button = new Button[1];
boolean[] buttonPressed = new boolean[button.length];

void setup() {
  //fullScreen();
  size(360, 640);
  size = new PVector(width/360, height/640);
  
  //Als je een nieuwe button maakt met width = 0, dan wordt de width automatisch ingesteld!
  button[0] = new Button(40, 40, 0, 60, 0, "Hello there", -5);
}

void draw() {
  background(230);
  DrawButtons();
  switch(scene) {
    case 0:
      SceneOneDraw();
    case 1:
      SceneTwoDraw();
    case 2:
      SceneThreeDraw();
  }
}

void SceneOneDraw() {
  
}

void SceneTwoDraw() {
  
}

void SceneThreeDraw() {
  
}





void DrawButtons() {
  for (int i = 0; i < button.length; i++) {
    if (buttonPressed[i]) {
      button[i].show(true);
    }
    else {
      button[i].show(false);
    }
    //button[i].button();
  }
}




void mouseReleased() {
  for (int i = 0; i < button.length; i++) {
    buttonPressed[i] = false;
  }
  
  for (int i = 0; i < button.length; i++) {
    if (mouseX > button[i].bx && mouseX < button[i].bx + button[i].bwidth && mouseY > button[i].by && mouseY < button[i].by + button[i].bheight) {
      buttonPressed[i] = false;
      button[i].pressed();
    }
  }
}

void mousePressed() {
  for (int i = 0; i < button.length; i++) {
    if (mouseX > button[i].bx && mouseX < button[i].bx + button[i].bwidth && mouseY > button[i].by && mouseY < button[i].by + button[i].bheight) {
      buttonPressed[i] = true;
    }
  }
}
