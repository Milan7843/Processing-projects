class BezierCurves {
  
  BezierCurves() {
    
  }
  
  void drawCurve(PVector[] point) {
    for (int v = 0; v < steps; v++) {
      if (v != 0) {
        strokeWeight(1);
        line(B[v].x, B[v].y, B[v-1].x, B[v-1].y);
      }
    }
  }
  
  PVector[] calculateCurve(PVector[] point, int pAmnt, boolean loose) {
    PVector[] points = new PVector[pAmnt];
    
    if (loose) {
      for (int v = 0; v < pAmnt; v++) {
        
        int layerAmount = point.length-1;
        int index = 0;
        int qAmountOnLayer = point.length-1;
        
        int qAmount = AddNumbersUnder(point.length);
        
        PVector[] Q = new PVector[qAmount];
        print(qAmount + "\n");
        
        for (int i = 0; i < layerAmount; i++) {
          for (int e = 0; e < qAmountOnLayer; e++) {
            if (qAmountOnLayer == point.length-1) {
              Q[index] = VectorIntermediate(point[index], point[index+1], v/((float)pAmnt-1));
            }
            else {
              Q[index] = VectorIntermediate(Q[index - qAmountOnLayer - 1], Q[index - qAmountOnLayer], v/((float)pAmnt-1));
            }
            points[v] = Q[index];
            
            index++;
          }
          qAmountOnLayer--;
        }
      }
    }
    
    else {
      for (int p = 0; p < point.length; p++) {
        if (p > 0 && p < point.length-1) {
          for (int v = 0; v < pAmnt; v++) {
            float t = v/((float)pAmnt-1);
            int layerAmount = point.length-1;
            int index = 0;
            int qAmountOnLayer = point.length-1;
            
            int qAmount = AddNumbersUnder(point.length);
            
            PVector[] Q = new PVector[qAmount];
            print(qAmount + "\n");
            
            for (int i = 0; i < layerAmount; i++) {
              for (int e = 0; e < qAmountOnLayer; e++) {
                if (qAmountOnLayer == point.length-1) {
                  Q[index] = VectorIntermediate(point[index], point[index+1], v/((float)pAmnt-1));
                }
                else {
                  Q[index] = VectorIntermediate(Q[index - qAmountOnLayer - 1], Q[index - qAmountOnLayer], v/((float)pAmnt-1));
                    }
                points[v] = Q[index];
                
                index++;
              }
              qAmountOnLayer--;
            }
          }
        }
        else points[p] = new PVector(0, 0);
      }
    }
    
    return points;
  }
}
