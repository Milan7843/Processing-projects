void setup() {
  for (int i = 0; i < 11; i++) {
    PVector normal = new PVector(1, 0, 0);
    float a = 0; //yaw
    float b = PI/10*i; //pitch
    float c = 0; //roll
    /*
    normal.x = normal.x*(cos(a)*cos(b)) + normal.x*(cos(a)*sin(b)*sin(c)-sin(a)*cos(c)) + normal.x*(cos(a)*sin(b)*cos(c)+sin(a)*sin(c));
    normal.y = normal.y*(sin(a)*cos(b)) + normal.y*(sin(a)*sin(b)*sin(c)+cos(a)*cos(c)) + normal.y*(sin(a)*sin(b)*cos(c)+cos(a)*sin(c));
    normal.z = normal.z*(-sin(b)) + normal.z*(cos(b)*sin(c)) + normal.z*(cos(b)*cos(c));
    
    normal.x = normal.x*(cos(a)*cos(b)) + normal.y*(sin(a)*cos(b)) + normal.z*(-sin(b));
    normal.y = normal.x*(cos(a)*sin(b)*sin(c)-sin(a)*cos(c)) + normal.y*(sin(a)*sin(b)*sin(c)+cos(a)*cos(c)) + normal.z*(cos(b)*sin(c));
    normal.z = normal.x*(cos(a)*sin(b)*cos(c)+sin(a)*sin(c)) + normal.y*(sin(a)*sin(b)*cos(c)-cos(a)*sin(c)) + normal.z*(cos(b)*cos(c));
    */
    
    float x = normal.x;
    float y = normal.y;
    float z = normal.z;
    normal.x = x*(cos(a)*cos(b)) + y*(sin(a)*cos(b)) + z*(-sin(b));
    normal.y = x*(cos(a)*sin(b)*sin(c)-sin(a)*cos(c)) + y*(sin(a)*sin(b)*sin(c)+cos(a)*cos(c)) + z*(cos(b)*sin(c));
    normal.z = x*(cos(a)*sin(b)*cos(c)+sin(a)*sin(c)) + y*(sin(a)*sin(b)*cos(c)-cos(a)*sin(c)) + z*(cos(b)*cos(c));
    
    /*
    normal.z = normal.z*(cos(a)*sin(b)*cos(c)+sin(a)*sin(c)) + normal.y*(sin(a)*sin(b)*cos(c)-cos(a)*sin(c)) + normal.x*(cos(b)*cos(c));
    normal.y = normal.z*(cos(a)*sin(b)*sin(c)-sin(a)*cos(c)) + normal.y*(sin(a)*sin(b)*sin(c)+cos(a)*cos(c)) + normal.x*(cos(b)*sin(c));
    normal.x = normal.z*(cos(a)*cos(b)) + normal.y*(sin(a)*cos(b)) + normal.z*(-sin(b));
    */
    //normal.x = 
    normal = normal.normalize();
    print(normal + " " + i + "\n");
  }
}
