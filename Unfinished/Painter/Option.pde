class Option 
{
  String name;
  String functionName;
  PVector size;
  float ypos;
  
  boolean hovered;
  
  Option(String name, String function) 
  {
    this.name = name;
    this.functionName = function;
    size = new PVector(textWidth(name), 22);
  }
  
  void RunFunction() {
    method(functionName);
  }
}
