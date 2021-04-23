class Softbody {
  
  float gridSpace = 20; // distance between points in px
  Point[][] points;
  //Spring[] springs;
  ArrayList<Spring> springs = new ArrayList<Spring>();
  
  Softbody(int[][] _points, PVector startPos) 
  {
    
    GeneratePoints(_points, startPos);
    
  }
  
  // Generates points and spring between them
  void GeneratePoints(int[][] pts, PVector pos) 
  {
    // First: generating the points:
    int ptsAmnt = pts[0].length * pts.length; // Total length of array
    
    // Counting points
    for (int y = 0; y < pts.length; y++) {
      for (int x = 0; x < pts[y].length; x++) {
        if (pts[y][x] == 1) {
          ptsAmnt++;
        }
        print(pts[y][x]+ " ");
      }
      print("\n");
    }
    
    
    points = new Point[pts.length][pts[0].length];
    
    // Adding points
    
    for (int y = 0; y < pts.length; y++) {
      for (int x = 0; x < pts[y].length; x++) {
        if (pts[y][x] == 1) {
          points[y][x] = new Point(pos.copy().add(new PVector(x * gridSpace, y * gridSpace)), 1, this);
          
          //Right
          if (x+1 < pts[y].length && pts[y][x+1] == 1) {
            springs.add(new Spring(this, y, x, y, x+1));
          }
          //Down
          if (y+1 < pts.length && pts[y+1][x] == 1) {
            springs.add(new Spring(this, y, x, y+1, x));
          }
          //Down-right
          if (y+1 < pts.length && x+1 < pts[y].length && pts[y+1][x+1] == 1) {
            springs.add(new Spring(this, y, x, y+1, x+1));
          }
          //Down-left
          if (y+1 < pts.length && x > 0 && pts[y+1][x-1] == 1) {
            springs.add(new Spring(this, y, x, y+1, x-1));
          }
        }
      }
    }
    
  }
  
  // Updating positions and forces of points and springs
  void update() 
  {
    for (Spring s : springs) {
      s.update();
    }
    for (Point[] parray : points) {
      for (Point p : parray) {
        if (p != null) p.update();
      }
    }
  }
  
  void show() 
  {
    for (Spring s : springs) {
      s.show();
    }
    for (Point[] parray : points) {
      for (Point p : parray) {
        if (p != null) p.show();
      }
    }    
  }
  
}
