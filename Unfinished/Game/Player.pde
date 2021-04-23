class Player {
  PVector pos = new PVector(500, 300);
  PVector scale = new PVector(1, 1);
  
  PVector[] point = {
    new PVector(-10.139999, -25.349998),
    new PVector(10.92, -24.439999),
    new PVector(10.4, -10.53),
    new PVector(3.5099998, -10.2699995),
    new PVector(4.0299997, -5.72),
    new PVector(11.7, -5.85),
    new PVector(12.219999, 13.129999),
    new PVector(7.93, 13.129999),
    new PVector(6.5, 0.0),
    new PVector(8.45, 29.9),
    new PVector(4.29, 30.029999),
    new PVector(0.13, 12.219999),
    new PVector(-3.77, 29.509998),
    new PVector(-7.54, 29.509998),
    new PVector(-5.9799995, 12.48),
    new PVector(-7.2799997, 0.0),
    new PVector(-7.7999997, 11.83),
    new PVector(-13.129999, 11.7),
    new PVector(-12.87, -5.85),
    new PVector(-4.29, -5.46),
    new PVector(-4.16, -10.2699995)
  };
  Player() {
    
  }
  
  void Show() {
    //Calculating the actual world positions of the points
    strokeWeight(1);
    PVector[] worldPos = new PVector[point.length];
    for (int i = 0; i < point.length; i++) {
      worldPos[i] = new PVector(pos.x + point[i].x * scale.x, pos.y + point[i].y * scale.y);
    }
    for (int i = 0; i < point.length-1; i++) {
      line(worldPos[i].x, worldPos[i].y, worldPos[i+1].x, worldPos[i+1].y); //Lines between every point
    }
    line(worldPos[worldPos.length-1].x, worldPos[worldPos.length-1].y, worldPos[0].x, worldPos[0].y); //Line connecting the last and first points
  }
  
}
