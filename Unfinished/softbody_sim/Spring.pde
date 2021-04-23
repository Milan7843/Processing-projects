class Spring {
  Point a, b;
  float k = 0.4; //Stiffness
  float restLength;
  Softbody body;
  int ax, ay, bx, by;
  
  Spring(Softbody _body, int _ax, int _ay, int _bx, int _by) {
    body = _body;
    ax = _ax;
    ay = _ay;
    bx = _bx;
    by = _by;
  }
  
  void update() 
  {
    if (a != null) {
      float max = 3;
      PVector ABnorm = (b.pos.copy().sub(a.pos)).normalize();
      float dampForce = constrain(ABnorm.dot(b.vel.copy().sub(a.vel)) * k, -max, max);
      float springForce = constrain((sqrt(sq(b.pos.x - a.pos.x) + sq(b.pos.y - a.pos.y)) - restLength)*0.03, -max, max);
      float force = springForce + dampForce;
      a.AddForce(ABnorm.mult(force));
      b.AddForce(ABnorm.mult(-force));
      if (dampForce > 0.1 || springForce > 0.1) print("dampForce: " + dampForce + ", springForce: " + springForce + "\n");
    }
  }
  
  void getPoints() {
    a = body.points[ax][ay];
    b = body.points[bx][by];   
    restLength = abs(sqrt(sq(b.pos.x - a.pos.x) + sq(b.pos.y - a.pos.y)));
    //restLength = 10;
  }
  
  void show() 
  {
    if (a == null) {
      getPoints();
    }
    stroke(255);
    strokeWeight(3);
    if (a != null && b != null) line(a.pos.x, a.pos.y, b.pos.x, b.pos.y);
    else if (a == null) {
      print("Error: point (" + ax + ", " + ay + ") does not exist, in spring from point (" + ax + ", " + ay + ") to (" + ax + ", " + ay + ")\n");
    }
    else if (b == null) {
      print("Error: point (" + bx + ", " + by + ") does not exist, in spring from point (" + ax + ", " + ay + ") to (" + ax + ", " + ay + ")\n");
    }
  }
}
