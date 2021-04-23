class Face {
  int vertexAmnt = 0;
  int normalIndex;
  int[] vertexIndices;
  int colorIndex = 0;
  boolean reflective = false;
  PVector pos;
  
  Face(int[] p, PVector median, int normal, int color_) {
    vertexAmnt = p.length;
    vertexIndices = p;
    normalIndex = normal;
    colorIndex = color_;
    pos = median;
    printArray(p);
    print(median + "\n");
  }
}
