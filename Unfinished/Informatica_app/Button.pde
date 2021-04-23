class Button {
  float bx, by, bwidth, bheight;
  int functionality;
  String text;
  float textHeightOffset;
  
  Button (float x, float y, float _width, float _height, int _functionality, String _text, float _textHeightOffset) {
    bx = x*size.x;
    by = y*size.y;
    bheight = _height*size.y;
    if (_width > 0) {
      bwidth = _width*size.x;
    }
    else {
      textSize(bheight - 10);
      bwidth = textWidth(_text) + 20;
    }
    text = _text;
    textHeightOffset = _textHeightOffset;
  }
  void show(boolean held) {
    if (!held) {
      fill(buttonColor);
    }
    else {
      fill(buttonPressedColor);
    }
    rect(bx, by, bwidth, bheight);
    textSize(bheight - 10);
    fill(0);
    text(text, bx + 10, by + bheight*1.05-9.5 + textHeightOffset);
    
  }
  
  void pressed() {
    switch(functionality) {
      case 0:
        print("button 0 pressed");
      case 1:
        
    }
  }
  
}
