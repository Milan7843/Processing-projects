//obj reader
PVector[] vertices;
PVector[] normals;
int[][] faceVertices;
int[][] faceNormals;
int[] faceVertexAmnt;
PShape obj;

void setup() {
  
  getDataFromObj();
}

void getDataFromObj() {
  String[] lines = loadStrings("cube.obj");
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
  faceNormals = new int[facesIndex][4];
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
      faceNormals[facesIndex] = getFaceInfo(split(line.substring(2), ' '), 1);
      faceVertexAmnt[facesIndex] = split(line.substring(2), ' ').length;
      print("f" + faceVertices[facesIndex][0] + " " + faceVertices[facesIndex][1] + " " + faceVertices[facesIndex][2] + " " + faceVertices[facesIndex][3] + " " + faceVertexAmnt[facesIndex] + "  |  " + faceNormals[facesIndex] + "\n");
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
    result[i] = int(splitData[i][info]);
  }
  return result;
}

PVector getVector(String str) {
  String[] val = split(str, ' ');
  return new PVector(float(val[0]), float(val[1]), float(val[2]));
}
