class Function {
  boolean expanded = true;
  
  String[] inputfieldName = {"x:", "y:", "t min:", "t max:"};
  
  Inputfield[] inputfield = new Inputfield[4];
  //String[] range = {"", ""};
  boolean[] error = {false, false, false, false};
  boolean[] empty = {true, true, true, true};
  int index;
  //PVector range = new PVector(0, 2);
  
  color c;
  
  Function (int i) {
    index = i;
    c = color(random(255), random(255), random(255));
    for (int f = 0; f < inputfield.length; f++) {
      inputfield[f] = new Inputfield(f, new PVector(functionBoxPos.x+inputOffsetFromSide, 
      functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace) + f*(inputBoxHeight+inputTopSpace) + inputTopOffset), new PVector(inputBoxLength, inputBoxHeight), inputfieldName[f]);
    }
  }
  
  PVector getPos(float t) {
    return new PVector(calculate(replaceT(inputfield[0].value, t)), calculate(replaceT(inputfield[1].value, t)));
  }
  
  void show() {
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    translate(0, scrollOffset);
    
    if (expanded) {
      fill(darkMode ? darkBackgroundColor : lightBackgroundColor);
      rect(functionBoxPos.x, functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace), functionBoxSize.x, functionBoxSize.y);
      
      for (int i = 0; i < inputfield.length; i++) {
        if (error[i]) fill(darkMode ? darkErrorColor : lightErrorColor);
        else if (selected && selectedFunctionIndex == index && selectedFieldIndex == i) 
          fill(darkMode ? darkSelectedColor : lightSelectedColor);
        else  fill(darkMode ? darkBackgroundColor : lightBackgroundColor);
        
        inputfield[i].show((selected && selectedFunctionIndex == index && selectedFieldIndex == i));
      }
      
      /*
      fill(darkMode ? darkTextColor : lightTextColor);
      text("X:", functionBoxPos.x+inputOffsetFromSide, functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace) + inputTopOffset-10 + inputBoxHeight);
      text("Y:", functionBoxPos.x+inputOffsetFromSide, functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace) + inputTopOffset-10 + (inputBoxHeight+inputTopSpace) + inputBoxHeight);
      text("Xmin:", functionBoxPos.x+inputOffsetFromSide, functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace) + inputTopOffset-10 + 2*(inputBoxHeight+inputTopSpace) + inputBoxHeight);
      text("Ymin:", functionBoxPos.x+inputOffsetFromSide, functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace) + inputTopOffset-10 + 3*(inputBoxHeight+inputTopSpace) + inputBoxHeight);
      */
      
      fill(c);
      textSize(30);
      text("Function " + (index+1), functionBoxPos.x+inputOffsetFromSide, functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace) + inputTopOffset-5);
      //rect(functionBoxPos.x+offsetFromSide, functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace) + offsetFromSide, functionBoxSize.x-offsetFromSide*2, functionBoxSize.y/2-offsetFromSide*1.5);
      //rect(functionBoxPos.x+offsetFromSide, functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace) + offsetFromSide*0.5 + functionBoxSize.y/2, functionBoxSize.x-offsetFromSide*2, functionBoxSize.y/2-offsetFromSide*1.5);
      textSize(20);
    }
    
    //not expanded
    else {
      fill(darkMode ? darkBackgroundColor : lightBackgroundColor);
      rect(functionBoxPos.x, functionBoxPos.y + index*(functionBoxSize.y+functionBoxSpace), functionBoxSize.x, functionBoxSmallSize);
    }
    popMatrix();
  }
  
  boolean hasError() {
    boolean result = true;
    for (boolean b : error) {
      result = b;
      if (b) break;
    }
    return result;
  }
  
  boolean hasEmpty() {
    boolean result = true;
    for (boolean b : empty) {
      result = b;
      if (b) break;
    }
    return result;
  }
  
}
