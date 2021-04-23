
PFont segoeui;

color textColor       = color(255);
color mainColor       = color(103, 107, 128);
color secondaryColor  = color(126, 131, 156);
color accentColor     = color(123, 109, 191);



String filepath;
// h : header
// d : dropdown
// do : dropdown option
// o : option
// l : line
// Do not use header tag on first header
String topbar = "" +
"File" +
"[o]Save,Save" +
"[o]Save as,SaveAs" +
"[h]Canvas" +
"[o]Background colour,setBackgroundColor" +
"[l]" +
"[o]Save,Save" +
"[o]Save as,SaveAs" +
"[h]Pen" +
"[o]Clear,Clear" +
"[o]Save,Save" +
"[o]Save as,SaveAs";

ArrayList<Header> headers = new ArrayList<Header>();


float headerSpace = 10;
float headerHeight = 25;
float topbarHeight = 25;

void setup() 
{
  segoeui = loadFont("SegoeUI-Light-16.vlw");
  textFont(segoeui, 16);
  size(1280, 720);
  SetupTopBar();  
}

void draw() 
{
  background(255);
  CheckMouse();
  DrawBar();
}

void DrawBar() 
{
  noStroke();
  fill(mainColor);
  rect(0, 0, width, topbarHeight);
  pushMatrix();
  
  translate(headerSpace/2, 0);
  
  for(Header header : headers) 
  {
    if (header.hovered) {
      noStroke();
      fill(secondaryColor);
      rect(-headerSpace/2, 0, header.pos.y+1, headerHeight);
    }
    fill(textColor);
    text(header.name, 0, 17);
    
    // Drawing dropdown
    if (header.opened) {
      header.DrawDropdown();
    }
    
    //Drawing line
    translate(header.pos.y, 0);
    stroke(secondaryColor);
    line(-headerSpace/2, 5, -headerSpace/2, headerHeight-5);
  }
  
  popMatrix();
}

void SetupTopBar() 
{
  // First: split the wholetopbar into headers, including options
  String[] headersArray = split(topbar, "[h]");
  String[][] optionsArrays = new String[3][];  
  int i = 0;
  // For each header
  for(String header : headersArray) 
  {
    // Split into options (meaning index 0 will be name of header
    optionsArrays[i] = split(header, "[o]");
    headers.add( new Header(optionsArrays[i][0], optionsArrays[i]) );
    i++;
  }
  
  // Setting up sizes
  float cumulativeWidth = 0;
  
  for(Header header : headers) 
  {
    header.pos = new PVector(cumulativeWidth, textWidth(header.name) + headerSpace);
    cumulativeWidth += textWidth(header.name) + headerSpace;
  }
  
  //headers.add(new Header(topbar));
}

void CheckMouse() 
{
  // Topbar
  if (mouseOn(0, 0, width, topbarHeight)) 
  {
    for(Header header : headers) 
    {
      if (mouseOn(header.pos.x, 0, header.pos.y, topbarHeight)) {
        header.hovered = true;
        header.opened = true;
      }
      else {
        header.hovered = false;
      }
    }
  }
  // Checking for dropdowns
  for(Header header : headers) 
  {
    if (header.opened) {
      // Check whether mouse is not on button itself, and not on dropdown
      if (!(mouseOn(header.pos.x, 0, header.pos.y, topbarHeight) || mouseOn(header.pos.x, topbarHeight-1, header.dropdownSize.x, header.dropdownSize.y+1))) {
        header.opened = false;
        header.hovered = false;
      }
      header.CheckOptionHover();
    }
  }
}

boolean mouseOn(float x, float y, float sx, float sy) {
  return (mouseX > x && mouseX < x + sx && mouseY > y && mouseY < y + sy);
}

void mousePressed() {
  /*
  for(Header header : headers) 
  {
    if (header.hovered) {
      header.opened = true;
    }
  }
  */
}

void Clear() 
{
  
}

void Save() 
{
  
}

void SaveAs() {
  
}
