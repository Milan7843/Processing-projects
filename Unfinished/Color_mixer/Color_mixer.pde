PVector[] colors = new PVector[10];
float lineHeight = 20;
float colorPanelY = 50, colorPanelHeight = 255, colorPanelWidth = 510;
int currentColours = 0;
//PVector[] rgb = new PVector[10];
float r = 255, g = 0, b = 0;

void setup() {
  size(600, 600);
  colors[0] = new PVector(66, 135, 245);
  colors[1] = new PVector(230, 245, 66);
  for (int i = 0; i < 10; i++) {
    //rgb[i] = new PVector(0, 0, 0);
  }
}

void draw() {
  background(230);
  colorLine();
  colorPanel();
}

void colorLine() {
  rect(width/2 - colorPanelWidth/2, colorPanelY + colorPanelHeight + 10, colorPanelWidth, lineHeight);
}

void colorPanel() {
  rect(width/2 - colorPanelWidth/2 -1, colorPanelY - 1, colorPanelWidth + 1, colorPanelHeight +2);
  stroke(255, 0, 0);
  for (int i = 0; i < colorPanelWidth; i++) {
    
    line(width/2 - colorPanelWidth/2 + i, colorPanelY, width/2 - colorPanelWidth/2 + i, colorPanelY + colorPanelHeight);
  }
  stroke(0);
  fill(0);
  text(mouseY, 50, 50);
  fill(255);
}
