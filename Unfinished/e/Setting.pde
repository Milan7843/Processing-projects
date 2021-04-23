class Setting {
  
  int intValue;
  int minIntValue;
  int maxIntValue;
  
  float floatValue;
  float minFloatValue;
  float maxFloatValue;
  
  PVector dualValue = new PVector(0, 0);
  boolean boolValue;
  String type;
  String name;
  String callName;
  
  PVector textOffset = new PVector(5, 5);
  
  
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
  
  //For type dual float
  Setting (String callName_, String name_, float mnValue, float mxValue, PVector val) {
    dualValue = val;
    callName = callName_;
    name = name_;
    type = "dualfloat";
    minFloatValue = mnValue;
    maxFloatValue = mxValue;
  }
  
  //For type dual boolean
  Setting (String callName_, String name_, boolean val) {
    boolValue = val;
    callName = callName_;
    name = name_;
    type = "bool";
  }
  
  void render(int i) {
    noStroke();
    fill(submenuColor);
    rect(settingSpace, settingHeight*i+settingSpace*(i+1), menuWidth-settingSpace*2, settingHeight);
    stroke(255);
    fill(0, 0, 90);
    switch (type) {
      case "bool":
        renderForBool(i);
      
    }
  }
  
  void renderForBool(int index) {
    text(name + " " + (boolValue ? "Enabled" : "Disabled"), settingSpace + textOffset.x, settingHeight*index+settingSpace*(index+1) + textOffset.y);
  }
  
  void mouseUp() {
    
  }
  
  void mouseDown() {
    if (type == "bool") {
      boolValue = !boolValue;
    }
  }
}
