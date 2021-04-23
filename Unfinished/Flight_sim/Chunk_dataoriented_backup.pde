class Chunk2 {
  
  //Plate[][] plates;
  float[][] plateHeight;
  int size;
  int lod = 1;
  color[][][] c = new color[size/lod][size/lod][2];
  PVector chunkOffset;
  PVector pos;
  float[][][] avgHeight = new float[size/lod][size/lod][2];
  
  
  Chunk2 (int s, int x, int y, int lod_) {
    size = s;
    //plates = new Plate[s][s];
    plateHeight = new float[s+1][s+1];
    chunkOffset = new PVector(x * chunkSize*plateSize, y * chunkSize*plateSize);
    pos = new PVector(x, y);
    newLOD(lod);
  }
  
  void createTerrain() {
    float startX = -(size/2)*plateSize;
    float startZ = -(size/2)*plateSize;
    for (int z = 0; z < size+1; z++) {
      for (int x = 0; x < size+1; x++) {
        //plateHeight[x][z] = random(maxPlateHeight);
        plateHeight[x][z] = noise((x+pos.x*chunkSize)*noiseScale + noiseOffset.x, (z+pos.y*chunkSize)*noiseScale + noiseOffset.y)*-maxPlateHeight;
      }
    }
    for (int z = 0; z < size; z += lod) {
      for (int x = 0; x < size; x += lod) {
        //plates[x][z] = new Plate(new PVector(startX + x*plateSize, plateHeight[x][z], startZ + z*plateSize), (int)(x + pos.x*size), (int)(z + pos.y*size), plateHeight[x][z], plateHeight[x+1][z], plateHeight[x][z+1], plateHeight[x+1][z+1]);
        //plates[x][z] = new Plate(new PVector(startX + x*plateSize + pos.x*fullChunkSize, plateHeight[x][z], startZ + z*plateSize + pos.y*fullChunkSize), x, z, plateHeight[x][z], plateHeight[x+1][z], plateHeight[x][z+1], plateHeight[x+1][z+1], lod);
      }
    }
  }
  
  void newLOD(int newLOD) {
    lod = newLOD;
    c = new color[size/lod][size/lod][2];
    setColours();
    createTerrain();
  }
  
  void setColours() {
    for (int z = 0; z < size; z++) {
      for (int x = 0; x < size; x++) {
        //avgHeight[x][z][0] = (plateHeight[x][z]+plateHeight[x+lod][z]+plateHeight[x][z+lod])/3;
        //avgHeight[x][z][1] = (plateHeight[x+lod][z+lod]+plateHeight[x+lod][z]+plateHeight[x][z+lod])/3;
        
        for (int i = 0; i < 2; i++) {
          avgHeight[x][z][i] = (plateHeight[x+i][z+i]+plateHeight[x+1][z]+plateHeight[x][z+1])/3;
          //Snow
          if (avgHeight[x][z][i] < -(maxPlateHeight*snowHeight)) {
            c[x][z][i] = color(255);
          }
          //Rock
          else if (avgHeight[x][z][i] < -(maxPlateHeight*rockHeight)) {
            c[x][z][i] = color(avgHeight[x][z][individualRockTriColour ? i : 0]/maxPlateHeight*-255);
          }
          //Grass
          else {
            //c[i] = color((1-noise(x*noiseScale + noiseOffset.x, z*noiseScale + noiseOffset.y))*30, (1-noise(x*noiseScale + noiseOffset.x,dScale + noiseOffset.y))*255, (1-noise(x*noiseScale + noiseOffset.x, z*noiseScale + noiseOffset.y))*30);
            c[x][z][i] = color((1-(avgHeight[x][z][i]/-(maxPlateHeight)))*30, (1-(avgHeight[x][z][individualGrassTriColour ? i : 0]/-(maxPlateHeight)))*255, (1-(avgHeight[x][z][i]/-(maxPlateHeight)))*30);
            //print((-avg[i]/rockHeight) + "\n");
            //c[i] = color(-avg[i]/maxPlateHeight*30, -avg[i]/maxPlateHeight*255, -avg[i]/maxPlateHeight*30);
          }
        }
      }
    }
  }
  
  void renderTerrain() {
    //rotateX(PI/2);
    for (int z = 0; z < size; z++) {
      for (int x = 0; x < size; x++) {
        //plates[x][z].render();
        pushMatrix();
        translate(x*plateSize*lod, 0, z*plateSize*lod);
        fill(c[x][z][0]);
        noStroke();
        pushMatrix();
        createTriangle(new PVector(0, plateHeight[x][z], 0), new PVector(plateSize*lod, plateHeight[x+1][z], 0),new PVector(0, plateHeight[x][z+1], plateSize*lod));
        popMatrix();
        fill(c[x][z][1]);
        translate(plateSize*lod, 0, plateSize*lod);
        createTriangle(new PVector(0, plateHeight[x+1][z+1], 0), new PVector(0, plateHeight[x+1][z], -plateSize*lod),new PVector(-plateSize*lod, plateHeight[x][z+1], 0));
        popMatrix();
      }
    }
  }
  
  void createTriangle(PVector v1, PVector v2, PVector v3) {
    beginShape();
    vertex(v1.x, v1.y, v1.z);
    vertex(v2.x, v2.y, v2.z);
    vertex(v3.x, v3.y, v3.z);
    endShape();
  }
}
