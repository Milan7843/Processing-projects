//Node editor testing and experimenting by Milan Otten started 24-2-2021

boolean playing = false;

// Dropdown menu settings
float dropdownItemHeight = 25;
float dropdownWidth = 25;

//node editing environment settings
PVector nodeEditorBeginPercent = new PVector(0.1, 0.01);
PVector nodeEditorEndPercent = new PVector(0.9, 0.99);
PVector nodeEditorBegin;
PVector nodeEditorEnd;
PVector nodeEditorSize;

//Node visual settings
color nodeEnvBackgroundColour = #4C4C55;
color nodeColour = #4B4B58;
color nodeStroke = color(0);
color nodeButtonColor = #4B4B58;
color nodeButtonHoveredColor = color(255);

float nodeMinDistFromEdge = 2;

float nodeStrokeWeight = 1;
float nodeTopBarHeight = 25;

float nodeInpuHeight = 25;

// Node arrays
ArrayList<NodeAdd> addNodes = new ArrayList<NodeAdd>(); //Addition nodes - NodeAdd(x, y)

//Read-only important variables
boolean settingsOpened = false;

PVector lastMousePos;

ArrayList<DropdownMenu> activeDropdowns = new ArrayList<DropdownMenu>();

boolean lastFrameOnNode;



void setup() {
  size(1280, 720);
  nodeEditorBegin = new PVector(width * nodeEditorBeginPercent.x, height * nodeEditorBeginPercent.y);
  nodeEditorEnd = new PVector(width * nodeEditorEndPercent.x, height * nodeEditorEndPercent.y);
  nodeEditorSize = new PVector(nodeEditorEnd.x - nodeEditorBegin.x, nodeEditorEnd.y - nodeEditorBegin.y);
  addNodes.add(new NodeAdd(150, 200));
}


void draw() {
  if (!playing) nodeEnvironment();
  lastMousePos = new PVector(mouseX, mouseY);
}


void nodeEnvironment() {
  fill(nodeEnvBackgroundColour);
  rect(nodeEditorBegin.x, nodeEditorBegin.y, nodeEditorSize.x, nodeEditorSize.y);
  
  checkHovered();
  
  for (int i = 0; i < addNodes.size(); i++){
    addNodes.get(i).drawNode();
  }
}

void checkHovered() {
  if (!settingsOpened) {
    for (int i = 0; i < addNodes.size(); i++){
      if (posInNode(mouseX, mouseY, addNodes.get(i)) || addNodes.get(i).lastFrameMouseHover) {
        addNodes.get(i).mouseHover(mouseX, mouseY);
        print("mouse hovered on addition node " + i + "\n");
        addNodes.get(i).lastFrameMouseHover = true;
      }
      if (!posInNode(mouseX, mouseY, addNodes.get(i)) && addNodes.get(i).lastFrameMouseHover) {
        addNodes.get(i).lastFrameMouseHover = false;
      }
    }
  }
}

void mouseReleased() {
  //Checking whether mouse click is valid
  if (!settingsOpened) {
    for (int i = 0; i < addNodes.size(); i++){
      addNodes.get(i).mouseUp(mouseX, mouseY, posInNode(mouseX, mouseY, addNodes.get(i)));
    }
  }
}

void mousePressed() {
  //Checking whether mouse click is valid
  if (!settingsOpened && activeDropdowns.size() == 0) {
    for (int i = 0; i < addNodes.size(); i++){
      if (posInNode(mouseX, mouseY, addNodes.get(i))) {
        addNodes.get(i).mouseDown(mouseX, mouseY);
      }
    }
  }
}

boolean posInNode(float px, float py, NodeAdd n) {
  return (px >= n.pos.x && px <= n.pos.x + n.size.x && py >= n.pos.y && py <= n.pos.y + n.size.y);
}

boolean posIn(float px, float py, float x, float y, float sx, float sy) {
  return (px >= x && px <= x + sx && py >= y && py <= y + sy);
}
