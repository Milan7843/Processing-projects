class Plate {
  PVector pos;
  color[] c = new color[2];
  float[] avg = new float[2];
  int x, z;
  float plateHeightUL; //[0][0]
  float plateHeightUR; //[1][0]
  float plateHeightDL; //[0][1]
  float plateHeightDR; //[1][1]
  int lod;
  
  Plate (PVector pos_, int x_, int z_, float ul, float ur, float dl, float dr, int lod_) {
    pos = pos_;
    x = x_;
    z = z_;
    plateHeightUL = ul;
    plateHeightUR = ur;
    plateHeightDL = dl;
    plateHeightDR = dr;
    lod = lod_;
    
    //avg[0] = (plateHeight[x][z]+plateHeight[x+1][z]+plateHeight[x][z+1])/3;
    //avg[1] = (plateHeight[x+1][z+1]+plateHeight[x+1][z]+plateHeight[x][z+1])/3;
    avg[0] = (plateHeightUL+plateHeightUR+plateHeightDL)/3;
    avg[1] = (plateHeightDR+plateHeightUR+plateHeightDL)/3;
    for (int i = 0; i < 2; i++) {
      //Snow
      if (avg[i] < -(maxPlateHeight*snowHeight)) {
        c[i] = color(255);
      }
      //Rock
      else if (avg[i] < -(maxPlateHeight*rockHeight)) {
        c[i] = color(avg[individualRockTriColour ? i : 0]/maxPlateHeight*-255);
      }
      //Sand
      else if (avg[i] > -(maxPlateHeight*sandHeight)) {
        c[i] = color((1-(avg[individualSandTriColour ? i : 0]/-(maxPlateHeight)))*242, (1-(avg[individualSandTriColour ? i : 0]/-(maxPlateHeight)))*209, (1-(avg[individualSandTriColour ? i : 0]/-(maxPlateHeight)))*107);
      }
      //Grass
      else {
        //c[i] = color((1-noise(x*noiseScale + noiseOffset.x, z*noiseScale + noiseOffset.y))*30, (1-noise(x*noiseScale + noiseOffset.x,dScale + noiseOffset.y))*255, (1-noise(x*noiseScale + noiseOffset.x, z*noiseScale + noiseOffset.y))*30);
        c[i] = color((1-(avg[individualGrassTriColour ? i : 0]/-(maxPlateHeight)))*30, (1-(avg[individualGrassTriColour ? i : 0]/-(maxPlateHeight)))*255, (1-(avg[individualGrassTriColour ? i : 0]/-(maxPlateHeight)))*30);
        //print((-avg[i]/rockHeight) + "\n");
        //c[i] = color(-avg[i]/maxPlateHeight*30, -avg[i]/maxPlateHeight*255, -avg[i]/maxPlateHeight*30);
      }
    }
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, 0, pos.z);
    fill(c[0]);
    noStroke();
    pushMatrix();
    createTriangle(new PVector(0, plateHeightUL, 0), new PVector(plateSize*lod, plateHeightUR, 0),new PVector(0, plateHeightDL, plateSize*lod));
    popMatrix();
    fill(c[1]);
    translate(plateSize*lod, 0, plateSize*lod);
    createTriangle(new PVector(0, plateHeightDR, 0), new PVector(0, plateHeightUR, -plateSize*lod),new PVector(-plateSize*lod, plateHeightDL, 0));
    
    popMatrix();
  }
  
  void createTriangle(PVector v1, PVector v2, PVector v3) {
    beginShape();
    vertex(v1.x, v1.y, v1.z);
    vertex(v2.x, v2.y, v2.z);
    vertex(v3.x, v3.y, v3.z);
    endShape();
  }
}
