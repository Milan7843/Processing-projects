class Point {
  PVector pos;
  PVector vel = new PVector();
  PVector f = new PVector();
  float m;
  float r = 8;
  Softbody body;
  
  Point(PVector _pos, float _m, Softbody _body) {
    m = _m;
    pos = _pos;
    body = _body;
  }
  
  void AddForce(PVector force) {
    f.add(force);
  }
  
  void update() 
  {
    f.add(new PVector(0, grav * m));  
    for (Point[] parray : body.points) {
      for (Point p : parray) {
        if (p != null && sqrt(sq(pos.x - p.pos.x) + sq(pos.y - p.pos.y)) < r + p.r) {
          f.add((p.pos.copy().sub(pos)).normalize().mult((r + p.r) - sqrt(sq(pos.x - p.pos.x) + sq(pos.y - p.pos.y))).mult(-0.3));
        }
      }
    }
    vel.add(f);
    pos.add(vel.mult(timeScale));
    if (pos.y > height-10) {
      pos.y = height-10;
    }
    if (pos.x > width-10) {
      pos.x = width-10;
    }
    if (pos.x < 10) {
      pos.x = 10;
    }
    
    f = new PVector(0, 0);
  }
  
  void show() 
  {
    fill(255, 100, 100);
    noStroke();
    circle(pos.x, pos.y, r*2);
  }
}
