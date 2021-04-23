int inputBoxes = 3;
String[] n = new String[inputBoxes];
String[] inputLabel = new String[inputBoxes];
float a, b, c;
boolean[] typing = new boolean[inputBoxes];
float r_ = 255, g_ = 50, b_ = 50;
float textBoxX = 30, textBoxY = 30, textBoxHeight = 40, textBoxWidth = 150, textBoxSpace, maxTextBoxSpace = 30;
float middleY = 300, middleX = 300;
float solutionBoxHeight = 40, solutionBoxWidth = 200, solutionBoxSpaceSide = 30, solutionBoxSpaceUp = 50;
//float inputBoxes = 3;
int num = 0;
float abc;
float solution;
boolean typing_ = false;
void setup() {
  
  for (int i = 0; i < inputBoxes; i++) {
    n[i] = "0";
  }
  size(600, 600);
  strokeWeight(1.5);
}

void draw() { 
  background(r_,g_,b_);
  ui();
  textBox();
  textSize(textBoxHeight - 5);
  fill(0);
  for (int i = 0; i < inputBoxes; i++) {
    text(n[i], textBoxX + textBoxWidth - textWidth(n[i]), textBoxY + textBoxHeight - 5 + i * (textBoxHeight + textBoxSpace));
  }
  abc();
  //adding the numbers up to test whether it works to go from string to float
  //text(float(n[0]) + float(n[1]), 50, 250);
  solution();
}

void ui() {
  textBoxSpace = ((height/2-(2*textBoxY)) - inputBoxes * textBoxHeight)/(inputBoxes-1);
  if (textBoxSpace > maxTextBoxSpace) {
    textBoxSpace = maxTextBoxSpace;
  }
  
}


void solution() {
  noFill();
  rect(width/2 + solutionBoxSpaceSide, solutionBoxSpaceUp, width/2 - 2*solutionBoxSpaceSide, solutionBoxHeight);
  textSize(solutionBoxHeight-5);
  text(solution, width - solutionBoxSpaceSide - textWidth(str(solution)), solutionBoxSpaceUp + solutionBoxHeight - 5); 
  println(solution);
}

void keyPressed() {
  //text(key + "" + keyCode, 50, 150);
  typing_ = false;
  for (int i = 0; i < inputBoxes; i++) {
    if (typing[i] || typing_) {
      typing_ = true;
      
    }
    if (typing[i]) {
      num = i;
    }
  }
  if (typing_) {
    if (n[num] == "0") {
      n[num] = "";
    }
    if (key == '1') {
      n[num] += key;
    } else if (key == '2') {
      n[num] += key;
    } else if (key == '3') {
      n[num] += key;
    } else if (key == '4') {
      n[num] += key;
    } else if (key == '5') {
      n[num] += key;
    } else if (key == '6') {
      n[num] += key;
    } else if (key == '7') {
      n[num] += key;
    } else if (key == '8') {
      n[num] += key;
    } else if (key == '9') {
      n[num] += key;
    } else if (key == '0') {
      n[num] += key;
    } 
  }
}

void textBox() {
  for (int i = 0; i < inputBoxes; i++) {
    if (typing[i]) {
      fill(255);
    }
    else {
      fill(r_,g_,b_);
    }
    rect(textBoxX, textBoxY + i * (textBoxSpace + textBoxHeight), textBoxWidth, textBoxHeight);
    
  }
  line(0, middleY, width, middleY);
  line(middleX, 0, middleX, height);
}

void abc() {
  a = float(n[0]);
  b = float(n[1]);
  c = float(n[2]);
  solution = (-b + sqrt(sq(b) - 4*a*c)) / 2*a;
  //abc = ;
}

void mousePressed() {
  for (int i = 0; i < inputBoxes; i++) {
    if (mouseX > textBoxX && mouseX <  textBoxX + textBoxWidth && mouseY > textBoxY + i * (textBoxSpace + textBoxHeight) && mouseY < textBoxY + i * (textBoxSpace + textBoxHeight) + textBoxHeight) {
      for (int k = 0; k < inputBoxes; k++) {
        typing[k] = false;
      }
      typing[i] = true;
    }
    else {
      typing[i] = false;
    }
  }
}
