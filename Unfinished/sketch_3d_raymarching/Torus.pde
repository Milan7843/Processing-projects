class Torus {
  PVector pos;
  PVector t;
  color clr = color(random(255), random(255), random(255));
  boolean reflective;
  
  
  Torus (float x, float y, float z, PVector t_, boolean ref) {
    pos = new PVector(x, y, z);
    t = t_;
    reflective = ref;
  }
  
  PVector getNormal(PVector p) {
    PVector n = new PVector();
    
    PVector inside = new PVector(p.x-pos.x, -pos.y, p.z-pos.z).normalize().mult(t.x);
    inside.add(pos);
    
    //n = new PVector(inside.x-p.x, inside.y-p.y, inside.z-p.z).normalize();
    n = new PVector(p.x-inside.x, p.y-inside.y, p.z-inside.z).normalize();
    
    //print(inside + "\n");
    
    return n;
    
  }
}
