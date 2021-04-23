class Chunk {
  
  Plate[][] plates;
  float[][] plateHeight;
  int size;
  int lod = 1; //Possible LOD's: 1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48
  PVector chunkOffset;
  PVector pos;
  
  
  Chunk (int s, int x, int y, int lod_) {
    size = s;
    plates = new Plate[s][s];
    plateHeight = new float[s+1][s+1];
    chunkOffset = new PVector(x * chunkSize*plateSize, y * chunkSize*plateSize);
    pos = new PVector(x, y);
    lod = lod_;
    newLOD(lod);
    chunksLoaded.add(pos);
  }
  
  void unload() {
    for (PVector p : chunksLoaded) {
      if (p == pos) {
        //chunksLoaded.remove(p);
      }
    }
    for (int i = 0; i < chunksLoaded.size(); i++) {
      PVector p = chunksLoaded.get(i);
      if (p == pos) {
        chunksLoaded.remove(i);
      }
    }
  }
  
  void printname() {
    print(pos);
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
        plates[x][z] = new Plate(new PVector(startX + x*plateSize + pos.x*fullChunkSize, plateHeight[x][z], startZ + z*plateSize + pos.y*fullChunkSize), x, z, plateHeight[x][z], plateHeight[x+lod][z], plateHeight[x][z+lod], plateHeight[x+lod][z+lod], lod);
      }
    }
  }
  
  void newLOD(int newLOD) {
    lod = newLOD;
    createTerrain();
  }
  
  void renderTerrain() {
    //rotateX(PI/2);
    for (int z = 0; z < size; z += lod) {
      for (int x = 0; x < size; x += lod) {
        plates[x][z].render();
      }
    }
    fill(79, 182, 255);
    pushMatrix();
    translate(0, -waterHeight*maxPlateHeight, 0);
    rotateX(PI/2);
    //rect(pos.x*fullChunkSize-(size/2)*plateSize, pos.y*fullChunkSize-(size/2)*plateSize, chunkSize*plateSize, chunkSize*plateSize);
    rect((pos.x-0.5)*fullChunkSize, (pos.y-0.5)*fullChunkSize, chunkSize*plateSize, chunkSize*plateSize);
    popMatrix();
  }
  
  void checkLodDst(int x, int y) {
    int lod_ = getLOD(x, y);
    if (lod != lod_) {
      newLOD(lod_); //Can be more efficient by only calling get lod oncec
    }
  }
}
