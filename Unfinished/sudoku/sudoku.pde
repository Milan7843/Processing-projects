int[] num = {
  0,0,0,  0,0,0,  0,0,0,
  3,0,0,  0,0,0,  0,7,0,
  0,0,0,  0,6,0,  0,0,0,
  
  0,0,0,  0,0,0,  0,0,0,
  0,7,0,  0,0,0,  0,0,0,
  0,0,0,  0,0,0,  0,0,0,
  
  0,0,0,  0,0,0,  0,0,0,
  9,0,0,  0,5,0,  0,0,0,
  0,0,0,  0,0,0,  0,0,0,  
};

PVector textDrawOffset = new PVector(15, 47); //Offset of text in each square
PVector gridStart = new PVector(25, 25); //Start position (top left) of sudoku in pixels
float gridSize = 550; //Size of sudoku in pixels

boolean mouseDown = false;

int numberSelected = 2;

void setup() {
  size(600, 680);  
}

void draw() {
  background(200);
  drawGrid();
  drawButtons();
}

void drawButtons() {
  pushMatrix();
  translate(gridStart.x, gridStart.y);
  
  // Drawing the buttons
  for (int i = 0; i < 9; i++) {
    fill(255);
    strokeWeight(1);
    rect(i * gridSize/9, gridSize + 25, gridSize/9, gridSize/9);
    fill(0);
    text(i+1, i*gridSize/9 + textDrawOffset.x, gridSize + 25 + textDrawOffset.y);
  }
  noFill();
  strokeWeight(2);
  rect(0, gridSize + 25, gridSize, gridSize/9);
  popMatrix();
}

void drawGrid() {
  pushMatrix();
  translate(gridStart.x, gridStart.y);
  fill(255);
  strokeWeight(1);
  textSize(45);
  
  // Drawing all small squares, including the numbers in them
  for (int y = 0; y < 9; y++) {
    for (int x = 0; x < 9; x++) {      
      fill(255);
      rect(x*gridSize/9, y*gridSize/9, gridSize/9, gridSize/9);
      fill(0);
      if (num[x+y*9] != 0) text(num[x+y*9], x*gridSize/9 + textDrawOffset.x, y*gridSize/9 + textDrawOffset.y);
    }
  }
  noFill();
  strokeWeight(2);
  
  // Drawing all 9 big squares
  for (int y = 0; y < 3; y++) {
    for (int x = 0; x < 3; x++) {
      rect(x*gridSize/3, y*gridSize/3, gridSize/3, gridSize/3);
    }
  }
  popMatrix();
}

void mousePressed() {
  
  // Checking whether mouse is on grid
  if (mouseX >= gridStart.x && mouseX <= gridStart.x + gridSize && mouseY >= gridStart.y && mouseY <= gridStart.y + gridSize) {
    
    // Number selected = 0 means no number is selected
    if (numberSelected != 0) {
      
      // Calculating mouse position relative to grid
      float mx = mouseX-gridStart.x;
      float my = mouseY-gridStart.y;
      
      // Calculating the index on grid from aforementioned relative mouse position
      int index = floor(my/(gridSize/9)) * 9 + floor(mx/(gridSize/9));
      num[index] = numberSelected;
      print(index + "\n");
    }
  }
  
  // Checking whether mouse is on bar to choose number
  else if (mouseX >= gridStart.x && mouseX <= gridStart.x + gridSize && mouseY >= gridStart.y + gridSize + 25 && mouseY <= gridStart.y + gridSize + 25 + gridSize/9) {
    
    // Calculating the new numebr from relative mouse position
    numberSelected = ceil((mouseX-gridStart.x)/(gridSize/9));
    print("new number selected " + numberSelected + "\n");
  }
  mouseDown = true;
}


void mouseReleased() {
  mouseDown = false;
}
