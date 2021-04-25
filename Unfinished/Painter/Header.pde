class Header 
{
  // x: start, y: width
  PVector pos;
  PVector dropdownSize = new PVector(150, 200);
  
  boolean hovered;
  boolean opened;
  
  ArrayList<Option> options = new ArrayList<Option>();
  
  String name;
  
  Header(String name, String[] content) 
  {
    this.name = name;
    int index = 0;
    for(String fullOption : content) 
    {
      //Skipping first element
      if (index != 0) {
        String[] splitOption = split(fullOption, ",");
        options.add( new Option(splitOption[0], splitOption[1]) );
      }
      index++;      
    }
    
    float offset = 0;
    dropdownSize = new PVector(0, 4);
    for(Option option : options) {
      if (option.size.x + 10 > dropdownSize.x) {
        dropdownSize.x = option.size.x + 10;
      }
      dropdownSize.y += option.size.y;
      option.ypos = offset;
      offset += option.size.y;
    }
    
  }
  
  void DrawDropdown() 
  {
    pushMatrix();
    
    noStroke();
    fill(mainColor);
    translate(-headerSpace/2, headerHeight);
    rect(0, 0, dropdownSize.x, dropdownSize.y);
    
    for(Option option : options) {
      if (option.hovered) {
        float offset = 2;
        fill(secondaryColor);
        rect(offset, offset, dropdownSize.x - offset*2, option.size.y);
      }
      fill(textColor);
      text(option.name, 5, 18);
      translate(0, 22);
    }
    
    popMatrix();
  }
  
  void CheckOptionHover() 
  {
    float offset = 2;
    for(Option option : options) {
      if (mouseOn(pos.x + -headerSpace/2 + offset, headerHeight + option.ypos + offset, dropdownSize.x + offset, option.size.y)) {
        option.hovered = true;
      }
      else {
        option.hovered = false;
      }
    }
  }
}
