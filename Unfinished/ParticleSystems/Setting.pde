class Setting {
  
  int type;
  boolean intOnly;
  String name;
  int settingIndex;
  int dataIndex;
  boolean dragging;
  boolean mouseClicked;
  int dualDragging;
  
  Setting (int t, int dataIndex_, int settingIndex_) {
    type = t;
    intOnly = false;
    settingIndex = settingIndex_;
    dataIndex = dataIndex_;
    switch (type) {
      //int
      case 0:
        intOnly = true;
        name = intDataName[dataIndex];
        break;
        
      //float
      case 1:
        name = floatDataName[dataIndex];
        break;
      //float min/max
      case 2:
        name = dualFloatDataName[dataIndex];
        //name = booleanDataName[dataIndex];
        break;
      //boolean
      case 3:
        name = booleanDataName[dataIndex];
        //name = booleanDataName[dataIndex];
        break;
    }
  }
  
  void render() {
    
    //fill(type == 3 ? menuColor(settingSpace, 50+(settingHeight + settingSpace)*settingIndex + settingSpace*2, menuWidth-settingSpace*2, settingHeight) : submenuColor);
    fill(menuColor(settingSpace, 50+(settingHeight + settingSpace)*settingIndex + settingSpace*2, menuWidth-settingSpace*2, settingHeight));
    rect(settingSpace, 50+(settingHeight + settingSpace)*settingIndex + settingSpace*2, menuWidth-settingSpace*2, settingHeight);
    textSize(submenuHeight-13);
    fill(0, 0, 90);
    text(name, settingSpace + 5, (settingHeight + settingSpace)*settingIndex + settingSpace*2 + 73);
    
    //Rendering the actual UI to change the data
    switch (type) {
      case 3:
        toggle();
        break;
      case 2:
        dualSlider();
        break;
      case 0: case 1:
        slider();
        break;
    }
  }
  
  void toggle() {
    text(booleanData[dataIndex] ? "Enabled" : "Disabled", settingSpace + 5, (settingHeight + settingSpace)*settingIndex + settingSpace + 100);
  }
  
  void slider() {
    //Float
    fill(255);
    float startY = (settingHeight + settingSpace)*settingIndex + settingSpace*2 + 85;
    float startX = settingSpace + 90;
    float w = menuWidth - (settingSpace*3 + 100);
    float h = 10;
    
    //Bar
    rect(startX, startY, w, h);
    stroke(255);
    fill(0, 0, 90);
    if (type == 1) {
      text(floatData[dataIndex], settingSpace + 5, startY + 10);
      //Handle
      if (maxFloatValue[dataIndex] == -1) {
        floatData[dataIndex] = sliderMath(floatData[dataIndex], minFloatValue[dataIndex], intData[2], startX, startY, w, h);
      }
      else {
        floatData[dataIndex] = sliderMath(floatData[dataIndex], minFloatValue[dataIndex], maxFloatValue[dataIndex], startX, startY, w, h);
      }
      constrain(floatData[dataIndex], minFloatValue[dataIndex], maxFloatValue[dataIndex]);
    }
    //Int
    else if (type == 0){
      text(intData[dataIndex], settingSpace + 5, (settingHeight + settingSpace)*settingIndex + settingSpace*2 + 100);
      intData[dataIndex] = (int)sliderMath(intData[dataIndex], minIntValue[dataIndex], maxIntValue[dataIndex], startX, startY, w, h);
      constrain(intData[dataIndex], minIntValue[dataIndex], maxIntValue[dataIndex]);
    }
    noStroke();
  }
  
  void dualSlider() {
    float y = (settingHeight + settingSpace)*settingIndex + settingSpace*2 + 85;
    float x = settingSpace + 90;
    float w = menuWidth - (settingSpace*3 + 100);
    float h = 10;
    float min = minDualFloatValue[dataIndex];
    float max = maxDualFloatValue[dataIndex];
    
    fill(255);
    //Bar
    rect(x, y, w, h);
    stroke(255);
    fill(0, 0, 90);
    text((int)dualFloatData[dataIndex].x + "-" + (int)dualFloatData[dataIndex].y, settingSpace + 5, y + 10);
    rect(map(dualFloatData[dataIndex].x, min, max, x, x+w)-sliderHandleSize/2, y+h/2-sliderHandleSize/2, sliderHandleSize, sliderHandleSize);
    if (!dragging) {
      if (mouseOn(map(dualFloatData[dataIndex].x, min, max, x, x+w)-sliderHandleSize/2, y+h/2-sliderHandleSize/2, sliderHandleSize, sliderHandleSize) && mouseClicked) {
        dragging = true;
        dualDragging = 0;
      }
    }
    else if (dualDragging == 0) {
      dualFloatData[dataIndex].x = map(mouseX, x, x+w, min, max);
      if (dualFloatData[dataIndex].x + 0.03*max > dualFloatData[dataIndex].y) {
        dualFloatData[dataIndex].y = dualFloatData[dataIndex].x + 0.03*max;
      }
      dualFloatData[dataIndex].x = constrain(dualFloatData[dataIndex].x, min+0.03*max, 0.97*max);
      dualFloatData[dataIndex].y = constrain(dualFloatData[dataIndex].y, min+0.03*max, 0.97*max);
    }
    
    rect(map(dualFloatData[dataIndex].y, min, max, x, x+w)-sliderHandleSize/2, y+h/2-sliderHandleSize/2, sliderHandleSize, sliderHandleSize);
    
    noStroke();
    if (!dragging) {
      if (mouseOn(map(dualFloatData[dataIndex].y, min, max, x, x+w)-sliderHandleSize/2, y+h/2-sliderHandleSize/2, sliderHandleSize, sliderHandleSize) && mouseClicked) {
        dragging = true;
        dualDragging = 1;
      }
    }
    else if (dualDragging == 1) {
      dualFloatData[dataIndex].y = map(constrain(mouseX, x, x+w), x, x+w, min, max);
      if (dualFloatData[dataIndex].y - 0.01*max < dualFloatData[dataIndex].x) {
        dualFloatData[dataIndex].x = dualFloatData[dataIndex].y - 0.03*max;
      }
      dualFloatData[dataIndex].y = constrain(dualFloatData[dataIndex].y, min+0.03*max, 0.97*max);
      dualFloatData[dataIndex].x = constrain(dualFloatData[dataIndex].x, min+0.03*max, 0.97*max);
    }
  }
  
  
  float sliderMath(float currentValue, float min, float max, float x, float y, float w, float h) {
    rect(map(currentValue, min, max, x, x+w)-sliderHandleSize/2, y+h/2-sliderHandleSize/2, sliderHandleSize, sliderHandleSize);
    if (!dragging) {
      if (mouseOn(map(currentValue, min, max, x, x+w)-sliderHandleSize/2, y+h/2-sliderHandleSize/2, sliderHandleSize, sliderHandleSize) && mouseClicked) {
        dragging = true;
      }
      return currentValue;
    }
    else {
      return map(constrain(mouseX, x, x+w), x, x+w, min, max);
    }
  }
  
  void mouseDown() {
    mouseClicked = true;
    print("[[");
  }
  
  void mouseUp() {
    if (type == 3) {
      if (mouseOn(settingSpace, 50+(settingHeight + settingSpace)*settingIndex + settingSpace, menuWidth-settingSpace*2, settingHeight)) {
        booleanData[dataIndex] = !booleanData[dataIndex];
      }
    }
    mouseClicked = false;
    dragging = false;
  }
}
