class Color {
  Color() {
    
  }
  
  color getColor(float i) {
    //float g = i < 1.0/2.0 ? i*6*255 : (i < 2.0/3.0 ? (i-(1.0/2.0))*6*255 : 0);
    float r = constrain(i < 2.0/6.0 ? 510-i*6*255 : (i > 4.0/6.0 ? (i-(2.0/3.0))*6*255 : 0), 0, 255);
    
    float g = constrain(i < 2.0/6.0 ? i*6*255 : (i < 4.0/6.0 ? 510-((i-(1.0/3.0))*6*255) : 0), 0, 255);
    
    float b = constrain(i > 4.0/6.0 ? 510-((i-(4.0/6.0))*6*255) : (i > 2.0/6.0 ? (i-(1.0/3.0))*6*255 : 0), 0, 255);
    
    return color(r, g, b);
  } 
}
