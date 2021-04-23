class Model {
  PVector pos;
  PVector[] vertices;
  PVector[] normals;
  int[][] faceVertices;
  int[] faceNormals;
  int[] faceVertexAmnt;
  String[] objData;
  
  Face[] faces;
  
  //color clr = color(random(255), random(255), random(255));
  color[] clrs = {color(random(255), random(255), random(255))};
  
  Model (String[] obj, PVector pos_) {
    pos = pos_;
    objData = obj;
    getDataFromObj();
    for (PVector p : vertices) {
      p.add(pos);
    }
    createFaces();
  }
  
  void createFaces () {
    faces = new Face[normals.length];
    clrs = new color[normals.length];
    for (int i = 0; i < normals.length; i++) {
      clrs[i] = color(random(255), random(255), random(255));
      PVector median = new PVector();
      for (int v = 0; v < faceVertices[i].length; v++) {
        median.add(vertices[faceVertices[i][v]]);
      }
      median.mult(1/(float)faceVertices[i].length);
      faces[i] = new Face(faceVertices[i], median, faceNormals[i], i);
      print("Making face " + i + " with normal index " + faceNormals[i] + ", making that normal " + normals[faceNormals[i]] + "\n");
    }
  }
  
  void getDataFromObj() {
    String[] lines = objData;
    int normalsIndex = 0;
    int verticesIndex = 0;
    int facesIndex = 0;
    for (String line : lines) {
      print(line + "\n");
      if (line.substring(0, 2).equals("v "))
        verticesIndex++;
      else if (line.substring(0, 2).equals("vn"))
        normalsIndex++;
      else if (line.substring(0, 2).equals("f "))
        facesIndex++;
    }
    vertices = new PVector[verticesIndex];
    normals = new PVector[normalsIndex];
    faceVertices = new int[facesIndex][4];
    faceNormals = new int[facesIndex];
    faceVertexAmnt = new int[facesIndex];
  
    normalsIndex = 0;
    verticesIndex = 0;
    facesIndex = 0;
    for (String line : lines) {
      //print(line.substring(2) + "\n");
      if (line.substring(0, 2).equals("v ")) {
        vertices[verticesIndex] = getVector(line.substring(2));
        print("v" + vertices[verticesIndex] + "\n");
        verticesIndex++;      
      }
      else if (line.substring(0, 2).equals("vn")) {
        normals[normalsIndex] = getVector(line.substring(3));
        print("n" + normals[normalsIndex] + "\n");
        normalsIndex++;      
      }
      else if (line.substring(0, 2).equals("f ")) {
        faceVertices[facesIndex] = getFaceInfo(split(line.substring(2), ' '), 0);
        faceNormals[facesIndex] = getFaceInfo(split(line.substring(2), ' '), 2)[0];
        faceVertexAmnt[facesIndex] = split(line.substring(2), ' ').length;
        //print("f" + faceVertices[facesIndex][0] + " " + faceVertices[facesIndex][1] + " " + faceVertices[facesIndex][2] + " " + faceVertices[facesIndex][3] + " " + faceVertexAmnt[facesIndex] + "  |  " + faceNormals[facesIndex] + "\n");
        facesIndex++;
      }
    }
  }
  int[] getFaceInfo(String[] str, int info) {
    int vertexAmnt = str.length;
    String[][] splitData = new String[vertexAmnt][3];
    int[] result = new int[vertexAmnt];
    
    for (int i = 0; i < vertexAmnt; i++) {
      splitData[i] = split(str[i], '/');
      result[i] = int(splitData[i][info])-1;
    }
    return result;
  }
  
  PVector getVector(String str) {
    String[] val = split(str, ' ');
    return new PVector(float(val[0]), float(val[1]), float(val[2]));
  }
}
