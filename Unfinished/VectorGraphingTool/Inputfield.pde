class Inputfield {
  PVector pos = new PVector(50, 50);
  PVector size = new PVector(50, 50);
  color c = color(255);
  String value = "";
  String selectedString = "|";
  String name = "x:";
  float numValue = 0;
  int index;
  
  Inputfield(int i, PVector pos_, PVector size_, String name_) {
    index = i;
    pos = pos_;
    size = size_;
    textSize(20);
    name = name_;
    size.x -= (textWidth(name)+textInputBoxOffset);
    pos.x += (textWidth(name)+textInputBoxOffset);
  }
  
  void show(boolean sel) {
    rect(pos.x, pos.y, size.x, size.y);
    
    fill(darkMode ? darkTextColor : lightTextColor);
    text(name, pos.x-textWidth(name)-textInputBoxOffset, pos.y+22);
    text(value + (sel && showTypingChar ? selectedString : ""), pos.x+textInputBoxOffset, pos.y+22);
  }
  
  void valueChanged() {
    if (index >= 2) numValue = calculate(value);
    else checkError(value);
  }
  
  boolean mouseDown() {
    return mouseOn(pos.x, pos.y + scrollOffset, size.x, size.y);
  }
}
