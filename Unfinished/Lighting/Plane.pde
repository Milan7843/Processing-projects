class Plane {
  PVector pos;
  PVector normal;
  PVector[] points = new PVector[4];
  PVector midPoint;
  
  color c = color(255);
  
  Plane(PVector p0, PVector p1, PVector p2, PVector p3, PVector n) {
    points[0] = p0;
    points[1] = p1;
    points[2] = p2;
    points[3] = p3;
    normal = n.normalize();
    
    midPoint = vectorAverage(points);
  }
  
  /*
  void calculateVertices() {
    //float a = PI; //angle
    //PVector normalX = new PVector(normal.x, cos(a)*normal.y + sin(a)*normal.z, -sin(a)*normal.y + cos(a)*normal.z);
    //PVector normalY = new PVector(cos(a)*normal.x - sin(a)*normal.z, normal.y, sin(a)*normal.x + cos(a)*normal.z);
    ////normal = normalX;
    //PVector normalY = new PVector(cos(a)*normal.x + sin(a)*normal.y, -sin(a)*normal.x + cos(a)*normal.y, normal.z);
    ////PVector normalY = new PVector(cos(a)*normalX.x + sin(a)*normalX.y, -sin(a)*normalX.x + cos(a)*normalX.y, normalX.z);
    
    //works: rotation 90 deg around the x-axis
    PVector normalX = new PVector(normal.x, normal.z, -normal.y);
    
    
    //sorta works: rotation 90 deg around the y-axis
    PVector normalY = new PVector(-normal.z, normal.y, normal.x);
    
    points[0] = new PVector(pos.x, pos.y, pos.z);
    points[1] = new PVector(pos.x + normalX.x, pos.y + normalX.y, pos.z + normalX.z);
    points[2] = new PVector(pos.x + normalX.x + normalY.x, pos.y + normalX.y + normalY.y, pos.z + normalX.z + normalY.z);
    points[3] = new PVector(pos.x + normalY.x, pos.y + normalY.y, pos.z + normalY.z);
  }
  */
  
  
  void render() {
    /*
    stroke(255);
    line(pos.x-1, pos.y, pos.z, pos.x + 20, pos.y, pos.z);
    stroke(255);
    line(pos.x, pos.y-1, pos.z, pos.x, pos.y + 2, pos.z);
    stroke(0, 255, 0);
    line(pos.x, pos.y, pos.z-1, pos.x, pos.y, pos.z + 20);
    */
    
    
    fill(c);
    noStroke();
    beginShape();
    /*
    vertex(points[0].x, points[0].y, points[0].z);
    vertex(points[1].x, points[1].y, points[1].z);
    vertex(points[2].x, points[2].y, points[2].z);
    vertex(points[3].x, points[3].y, points[3].z);
    */
    v(points[0]);
    v(points[1]);
    v(points[2]);
    v(points[3]);
    endShape();
  }
  
  void showNormal() {
    stroke(0, 0, 255);
    line(midPoint.x, midPoint.y, midPoint.z, midPoint.x + normal.x, midPoint.y + normal.y, midPoint.z + normal.z);
  }
  
  void v(PVector p) {
    vertex(p.x, p.y, p.z);
  }
}
