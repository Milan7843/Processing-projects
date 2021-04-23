class Firework {
  float currentX;
  boolean exploded = false;
  float right;
  float liveTime;
  float fy;
  PVector currentSpeed;
  PVector[] pos = new PVector[6];
  float xspeed = random(1.001, 1.01);
  Firework(float x) {
    for (int i = 0; i < 6; i++) {
      pos[i] = new PVector(x,1080);
    }
    currentX = x;
    right = (int)random(0,1);
    liveTime = random(600, 1000);
    fy = height;
    currentSpeed = new PVector(random(0.5), random(-1, -5));
    if (right != 1) {
      //xspeed *= -1;
    }
  }
  
  void update() {
    if (fy > liveTime) {
      exploded = true;
    }
    if (!exploded) {
      currentSpeed.x *= xspeed;
      pos[0].add(currentSpeed);
      textSize(50);
      for (int i = 0; i < 6; i++) {
        text(pos[i].x + "\n" + pos[i].y, 50, 100+150*i);
      }
    }
    for (int i = pos.length-1; i > 0; i--) {
      pos[i] = pos[i-1];
      //println(i + " " + pos[i]);
    }
    println(pos);
  }
  void show() {
    //trail
    
    for (int i = 0; i < 5; i++) {
      stroke(255);
      strokeWeight(5);
      line(pos[i].x, pos[i].y, pos[i+1].x, pos[i+1].y);
    }
    fill(255);
    //circle(pos[0].x, pos[0].y, 100);
    
  }
  
}
