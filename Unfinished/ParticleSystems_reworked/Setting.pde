class Setting {
  
  int intValue;
  int minIntValue;
  int maxIntValue;
  
  float floatValue;
  float minFloatValue;
  float maxFloatValue;
  
  PVector valueX = new PVector(0, 0);
  
  PVector dualValue = new PVector(0, 0);
  boolean boolValue;
  String type;
  String name;
  String callName;
  boolean singleValue;
  boolean dragging;
  int draggingIndex;
  boolean dependant = false;
  Setting dependantSetting;
  boolean open;
  
  PVector textOffset = new PVector(5, 22);
  float textOffset2 = 25;
  float startY;
  PVector sliderStart = new PVector(130, 35);
  float sliderDstFromSide = 10;
  
  float sliderLength = (menuWidth-settingSpace*2-sliderDstFromSide) - sliderStart.x;
  float midY = sliderStart.y + sliderHeight/2;
  float endX = menuWidth-settingSpace-sliderDstFromSide;
  
  //For type int
  Setting (String callName_, String name_, int mnValue, int mxValue, int val) {
    intValue = val;
    callName = callName_;
    name = name_;
    type = "int";
    minIntValue = mnValue;
    maxIntValue = mxValue;
    if (intValue < mnValue) {
      intValue = mnValue;
    } else if (intValue > mxValue) {
      intValue = mxValue;
    }
  }
  
  //For type float
  Setting (String callName_, String name_, float mnValue, float mxValue, float val) {
    floatValue = val;
    callName = callName_;
    name = name_;
    type = "float";
    minFloatValue = mnValue;
    maxFloatValue = mxValue;
    if (floatValue < mnValue) {
      floatValue = mnValue;
    } else if (intValue > mxValue) {
      floatValue = mxValue;
    }
  }
  
  //For type dual float:
  //Normal:
  Setting (String callName_, String name_, float mnValue, float mxValue, PVector val) {
    dualValue = val;
    callName = callName_;
    name = name_;
    type = "dual";
    minFloatValue = mnValue;
    maxFloatValue = mxValue;
    singleValue = (val.x == val.y);
  }
  //Dependant:
  /*
  Setting (String callName_, String name_, float mnValue, String mxValueName, PVector val) {
    dualValue = val;
    callName = callName_;
    name = name_;
    type = "dual";
    minFloatValue = mnValue;
    dependant = true;
    singleValue = (val.x == val.y);
  }
  */
  
  //For type dual boolean
  Setting (String callName_, String name_, boolean val) {
    boolValue = val;
    callName = callName_;
    name = name_;
    type = "bool";
  }
  
  void render(int i) {
    textSize(20);
    noStroke();
    startY = (settingHeight+settingSpace)*(i+1)+settingSpace - scroll;
    fill(menuColor(settingSpace, startY, menuWidth-settingSpace*2, settingHeight));
    rect(settingSpace, startY, menuWidth-settingSpace*2, settingHeight, roundness);
    fill(0, 0, 90);
    stroke(0, 0, 90);
    switch (type) {
      case "int":
        renderForInt();
        break;
      case "float":
        renderForFloat();
        break;
      case "dual":
        renderForDual();
        break;
      case "bool":
        renderForBool();
        break;
    }
  }
  
  void renderForInt() {
    text(name, settingSpace + textOffset.x, startY + textOffset.y);
    text(intValue, settingSpace + textOffset.x, startY + textOffset.y + textOffset2);
    valueX.x = map(intValue, minFloatValue, maxFloatValue, sliderStart.x+settingSpace, sliderStart.x+settingSpace+sliderLength);
    renderSlider();
    fill(0, 0, 90);
    intValue = (int)handle(float(intValue), dragging);
  }
  
  void renderForFloat() {
    text(name, settingSpace + textOffset.x, startY + textOffset.y);
    text(((floatValue%1.0==0) ? round(floatValue) : nf(floatValue, 0, 1)) + "", settingSpace + textOffset.x, startY + textOffset.y + textOffset2);
    valueX.x = map(floatValue, minFloatValue, maxFloatValue, sliderStart.x+settingSpace, sliderStart.x+settingSpace+sliderLength);
    renderSlider();
    fill(0, 0, 90);
    floatValue = handle(floatValue, dragging);
  }
  
  void renderForDual() {
    text(name, settingSpace + textOffset.x, startY + textOffset.y);
    text(((dualValue.x%1.0==0) ? round(dualValue.x) : nf(dualValue.x, 0, 1)) + "" +(singleValue ? "" : "-" + ((dualValue.y%1.0==0) ? round(dualValue.y) : nf(dualValue.y, 0, 1))), settingSpace + textOffset.x, startY + textOffset.y + textOffset2);
    renderSlider();
    fill(102, 150, 209);
    valueX.x = map(dualValue.x, minFloatValue, maxFloatValue, sliderStart.x+settingSpace, sliderStart.x+settingSpace+sliderLength);
    if (!singleValue) {
      valueX.y = map(dualValue.y, minFloatValue, maxFloatValue, sliderStart.x+settingSpace, sliderStart.x+settingSpace+sliderLength);
      rect(valueX.x, midY-sliderHandleSize/2+startY, valueX.y-valueX.x, sliderHeight);
    }
    fill(0, 0, 90);
    
    if (singleValue) {
      dualValue.x = dualValue.y = handle(dualValue.x, dragging);
    }
    else {
      dualValue.x = handle(dualValue.x, (dragging && draggingIndex == 0));
      dualValue.y = handle(dualValue.y, (dragging && draggingIndex == 1));
      spaceHandles();
    }
  }
  
  void spaceHandles() {
    float dstBetweenHandles = 0.03*(maxFloatValue - minFloatValue);
    if (dualValue.y - dualValue.x < dstBetweenHandles) {
      float xspaceLeft = dualValue.x - minFloatValue;
      if (xspaceLeft > dstBetweenHandles) {
        dualValue.x -= dstBetweenHandles;
      }
      else {
        dualValue.x -= xspaceLeft;
        dualValue.y += dstBetweenHandles - xspaceLeft;
      }
    }
    if (dualValue.x > dualValue.y - dstBetweenHandles + 0.001) {
      spaceHandles();
    }
  }
  
  void renderForBool() {
    text(name, settingSpace + textOffset.x, startY + textOffset.y);
    text((boolValue ? "Enabled" : "Disabled"), settingSpace + textOffset.x, startY + textOffset.y + textOffset2);
  }
  
  void renderSlider() {
    fill(255);
    rect(sliderStart.x+settingSpace-sliderHandleSize/2, sliderStart.y+startY, sliderLength+sliderHandleSize-1, sliderHeight, sliderHandleSize);
  }
  
  float handle(float val, boolean drag) {
    circle(map(val, minFloatValue, maxFloatValue, sliderStart.x+settingSpace, sliderStart.x+settingSpace+sliderLength), midY+startY, sliderHandleSize);
    if (drag) {
      val = constrain(map(mouseX, sliderStart.x+settingSpace, sliderStart.x+settingSpace+sliderLength, minFloatValue, maxFloatValue), minFloatValue, maxFloatValue);
    }
    return val;
  }
  
  void mouseUp() {
    if (open) {
      if (mouseOn(settingSpace, startY, menuWidth-settingSpace*2, settingHeight)) {
        if (type == "bool") {
          boolValue = !boolValue;
        }
        else if (type == "dual" && mouseButton == RIGHT) {
          singleValue = !singleValue;
          if (singleValue) {
            dualValue.y = dualValue.x;
          }
          else {
            spaceHandles();
          }
        }
      }
      dragging = false;
    }
  }
  
  void mouseDown() {
    if (open) {
      if (dist(mouseX, mouseY, valueX.x, midY+startY) < sliderHandleSize/2) {
        dragging = true;
        draggingIndex = 0;
      }
      else if (dist(mouseX, mouseY, valueX.y, midY+startY) < sliderHandleSize/2) {
        dragging = true;
        draggingIndex = 1;
      }
    }
  }
}
