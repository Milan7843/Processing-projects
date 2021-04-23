class Ball {
  float x, y;
  float weight;
  float bounce;
  float size;
  float vx, vy;
  boolean holding;
  Ball(float bx, float by, float bsize, float bweight, float bouncyness) {
    x = bx;
    y = by;
    weight = bweight;
    bounce = bouncyness;
    size = bsize;
  }
  
  void update() {
    text(x + "\n" + y + "\n" + weight + "\n" + vx + "\n" + vy, 500, 500);
    //gravity
    if (!holding) {
      vy += gravity * weight;
      if (vx != 0) {
        vx -= size*vx/5000;
      }
    } else {
      vy = (mouseY - pmouseY)*throwStrength/weight*3;
      vx = (mouseX - pmouseX)*throwStrength/weight*3;
    }
    //ground
    
    x += vx;
    y += vy;
    if (y + size/2 > height) {
      //vx -= size*vx/100;
      vy = -vy*bounce/98.33;
    }
    if (y + size/2 > height) {
      y = height-size/2;
    }
    if (vx > -0.000001 && vx < 0.000001) {
      vx = 0;
    }
    
    
    if (holding) {
      x = mouseX;
      y = mouseY;
    }
    
  }
  
  void show() {
    circle(x, y, size);
  }
  void mousedrag() {
    if (dist(mouseX, mouseY, x, y) < size/2) {
      holding = true;
    }
  }
  void stoppedholding() {
    holding = false;
  }
  
  
}
