class Ball {
  float x, y, weight, bouncyness, diameter;
  float vx, vy;
  
  Ball(float x_, float y_, float weight_, float bouncyness_, float diameter_) {
    x = x_;
    y = y_;
    weight = weight_;
    bouncyness = bouncyness_;
    diameter = diameter_;
  }
  
  void physics() {
    if (keys[0]) {
      vx -= speed/weight;
    }
    if (keys[1]) {
      vx += speed/weight;
    }
    if (keys[2]) {
      vy -= speed/weight;
    }
    if (keys[3]) {
      vy += speed/weight;
    }
    vx *= 1-airResistance;
    vy += gravity*weight;
    x += vx;
    y += vy;
    text(vx + "\n" + vy, 300, 300);
  }
  
  void show() {
    noFill();
    if (distToB <= diameter/2) {
      stroke(255, 0, 0);
    } else {
      stroke(0);
    }
    circle(x, y, diameter);
    if (info) {
      float len = 100;
      line(x+len, y, x-len, y);
      line(x, y-len, x, y+len);
    }
  }
  void calculate() {
    for (int i = 0; i < currentLines; i++) {
      lineAngle = atan((point[i*2+1].y - (point[i*2].y)) / (point[i*2+1].x - (point[i*2].x)));
      lineAngle = degrees(lineAngle);
      text(lineAngle, 200, 400 + i*20);
      float tempx, tempy;
      newX = x + cos(radians(lineAngle) + PI/2) * 200;
      newY = y + sin(radians(lineAngle) + PI/2) * 200;
      tempx = intersect(x, y, newX, newY, point[i*2].x, point[i*2].y, point[i*2+1].x, point[i*2+1].y).x;
      tempy = intersect(x, y, newX, newY, point[i*2].x, point[i*2].y, point[i*2+1].x, point[i*2+1].y).y;
      
      touching[i] = false;
      if ((dist(x, y, point[i*2].x, point[i*2].y)) < diameter/2 || (dist(x, y, point[i*2+1].x, point[i*2+1].y)) < diameter/2) {
        tempTouching = true;
      }
      else if (tempx < point[i*2].x && tempx > point[i*2+1].x) {
        tempTouching = true;
      }
      else if (tempx > point[i*2].x && tempx < point[i*2+1].x) {
        tempTouching = true;
      }
      if (tempTouching) {
        //distToB = (dist(x, y, tempx, tempy));
        
        if ((dist(x, y, tempx, tempy)) < distToB) {
          distToB = (dist(x, y, tempx, tempy));
        }
        if ((dist(x, y, tempx, tempy)) < diameter/2) {
          //Functie collision hier
          
          
          y = y - (diameter/2-(tempy-y));
          
          
          //als de lineAngle > 45 moet de vx meer uitmaken dan de vy
          //vx += 3/(lineAngle-45) * vy * vx;
          touching[i] = true;
        }
      }
      tempTouching = false;
      
      if (info) {
        line(x, y, newX, newY);
        circle(tempx, tempy, 10);
      }
    }
  }
}
