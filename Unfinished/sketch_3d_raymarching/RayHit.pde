class RayInfo {
  boolean hit;
  
  PVector dirUsing;
  PVector endPoint;
  
  float closestDst;
  String closestObj;
  
  float rayLength;
  
  //normal
  boolean hasNormal;
  PVector normal = new PVector(0, 0, 0);
  
  //object properties
  boolean reflective = false;
  color clr = color(255);
  
  
  
  RayInfo(PVector dir_, float closestDst_, String closestObj_, PVector endPoint_, float totalDistance, boolean hasNormal_, PVector normal_, boolean reflective_, color clr_, boolean hit_) {
    dirUsing = dir_;
    endPoint = endPoint_;
    
    closestDst = closestDst_;
    closestObj = closestObj_;
  
    rayLength = totalDistance;
  
    //normal
    hasNormal = hasNormal_;
    normal = normal_;
  
    //object properties
    reflective = false;
    clr = clr_;
    
    hit = hit_;
  }
}
