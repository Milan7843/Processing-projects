class Plane {
  PVector pos = new PVector(0, 0, 0);
  PVector rot = new PVector(0, 0, 0);
  PVector rc = new PVector(0, 0, 0); //Change in rotation for matrix
  PVector normal = new PVector(1, 0, 0);
  PVector x = new PVector(1, 0, 0);
  PVector y = new PVector(0, 1, 0);
  PVector z = new PVector(0, 0, 1);
  float maxThrottle = 100;
  float throttleIncreaseSpeed = 0.6;
  float throttle = 50;
  float speed = 0;
  float maxSpeed = 1;
  float pitchChangeSpeed = 0.05;
  float rollChangeSpeed = 0.05;
  float rudderChangeSpeed = 0.05;
  
  color normalColour = color(240, 30, 20);
  color glassColour = color(240, 240, 255);
  
  
  Plane(PVector startPos) {
    pos = startPos;
  }
  
  void render() {
    //normal = new PVector(cos(rot.y), sin(rot.y)*cos(rot.x), sin(rot.y)*cos(rot.x)).normalize();
    //normal = new PVector(cos(-rot.y), sin(rot.z), sin(-rot.y)).normalize();
    //print(rc);
    rotationMatrix();
    //z rot influences y pos
    //x rot influences z pos
    fill(normalColour);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    
    pushMatrix();
    translate(normal.x*6, normal.y*6, normal.z*6);
    
    sphere(0.2);
    popMatrix();
    
    pos.add(multiplyVectorWithFloat(normal, speed));
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    pushMatrix();
    translate(5, 0, 0);
    
    sphere(0.2);
    popMatrix();
    shape(planeModel);
    popMatrix();
  }
  
  void updatePos() {
    speed = throttle/maxThrottle*maxSpeed;
  }
  
  void checkInput() {
    rc = new PVector(0, 0, 0);
    
    if (keys[2]) {
      rc.x -= rollChangeSpeed;
      //rc.y -= rollChangeSpeed*sin(rot.z);
      //rc.z -= rollChangeSpeed*sin(rot.y);
    }
    if (keys[3]) {
      rc.x += rollChangeSpeed;
      //rc.y += rollChangeSpeed*sin(rot.z);
      //rc.z += rollChangeSpeed*sin(rot.y);
    }
    if (keys[0]) {
      rc.z -= pitchChangeSpeed;
    }
    if (keys[1]) {
      rc.z += pitchChangeSpeed;
    } 
    /*
    if (keys[2]) {
      rc.x -= rollChangeSpeed*normal.x;
      rc.y -= rollChangeSpeed*normal.y;
      rc.z -= rollChangeSpeed*normal.z;
      
    }
    if (keys[3]) {
      rc.x += rollChangeSpeed*normal.x;
      rc.y += rollChangeSpeed*normal.y;
      rc.z += rollChangeSpeed*normal.z;
    }
    if (keys[0]) {
      rc.x -= pitchChangeSpeed*normal.x;
      //rc.y -= rollChangeSpeed*cos(rot.x);
      rc.z -= rollChangeSpeed*normal.z;
    }
    if (keys[1]) {
      rc.x += pitchChangeSpeed*normal.x;
      //rc.y += rollChangeSpeed*cos(rot.x);
      rc.z += rollChangeSpeed*normal.z;
    } 
    
    if (keys[2]) {
      rc.x -= pitchChangeSpeed;
    }
    if (keys[3]) {
      rc.x += pitchChangeSpeed;
    }
    if (keys[0]) {
      rc.z -= rollChangeSpeed;
    }
    if (keys[1]) {
      rc.z += rollChangeSpeed;
    } 
    */
    if (keys[4]) {
      throttle -= throttleIncreaseSpeed;
    } 
    if (keys[5]) {
      throttle += throttleIncreaseSpeed;
    }
    if (keys[18]) {
      rc.y += rudderChangeSpeed;
    } 
    if (keys[19]) {
      rc.y -= rudderChangeSpeed;
    }
    throttle = constrain(throttle, 0, maxThrottle);
    rot.add(rc);
  }
  
  void rotationMatrix() {
    normal = new PVector(1, 0, 0);
    float a = -rot.z;
    float b = -rot.y;
    float c = -rot.x;
    if (rot.x < 0) {
      rot.x += 2*PI;
    } if (rot.y < 0) {
      rot.y += 2*PI;
    } if (rot.z < 0) {
      rot.z += 2*PI;
    }
    /*
    normal.x = normal.x*(cos(a)*cos(b)) + normal.x*(cos(a)*sin(b)*sin(c)-sin(a)*cos(c)) + normal.x*(cos(a)*sin(b)*cos(c)+sin(a)*sin(c));
    normal.y = normal.y*(sin(a)*cos(b)) + normal.y*(sin(a)*sin(b)*sin(c)+cos(a)*cos(c)) + normal.y*(sin(a)*sin(b)*cos(c)+cos(a)*sin(c));
    normal.z = normal.z*(-sin(b)) + normal.z*(cos(b)*sin(c)) + normal.z*(cos(b)*cos(c));
    
    normal.x = normal.x*(cos(a)*cos(b)) + normal.y*(sin(a)*cos(b)) + normal.z*(-sin(b));
    normal.y = normal.x*(cos(a)*sin(b)*sin(c)-sin(a)*cos(c)) + normal.y*(sin(a)*sin(b)*sin(c)+cos(a)*cos(c)) + normal.z*(cos(b)*sin(c));
    normal.z = normal.x*(cos(a)*sin(b)*cos(c)+sin(a)*sin(c)) + normal.y*(sin(a)*sin(b)*cos(c)+cos(a)*sin(c)) + normal.z*(cos(b)*cos(c));
    
    normal.x = normal.x*(cos(a)*cos(b)) + normal.y*(sin(a)*cos(b)) + normal.z*(-sin(b));
    normal.y = normal.x*(cos(a)*sin(b)*sin(c)-sin(a)*cos(c)) + normal.y*(sin(a)*sin(b)*sin(c)+cos(a)*cos(c)) + normal.z*(cos(b)*sin(c));
    normal.z = normal.x*(cos(a)*sin(b)*cos(c)+sin(a)*sin(c)) + normal.y*(sin(a)*sin(b)*cos(c)-cos(a)*sin(c)) + normal.z*(cos(b)*cos(c));
    */
    float x = normal.x;
    float y = normal.y;
    float z = normal.z;
    normal.z = x*(cos(a)*sin(b)*cos(c)+sin(a)*sin(c)) + y*(sin(a)*sin(b)*cos(c)-cos(a)*sin(c)) + z*(cos(b)*cos(c));
    normal.y = x*(cos(a)*sin(b)*sin(c)-sin(a)*cos(c)) + y*(sin(a)*sin(b)*sin(c)+cos(a)*cos(c)) + z*(cos(b)*sin(c));
    normal.x = x*(cos(a)*cos(b)) + y*(sin(a)*cos(b)) + z*(-sin(b));
    normal = normal.normalize();
  }

  
  /*
  
shape
frontwindowframe
normal
0.749728|-1.74802|1.00484
0.515733|-1.33776|1.93887
-0.0.515733|-1.33776|1.93887
-0.749728|-1.74802|1.00484
endshape

shape
frontwindowglass
glass
0.448418|-1.38758|1.82544
0.619949|-1.69374|1.12842
-0.619949|-1.69374|1.12842
-0.448418|-1.38758|1.82544
endshape
  */
  /*
  void render() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateZ(PI);
    //stroke(200, 20, 10);
    strokeWeight(1);
    stroke(0);
    fill(240);
    for (int i = 0; i < vertices.length; i++) {
      if (trim(vertices[i]).equals("shape")) {
        beginShape();
        String faceName = vertices[i+1];
        String faceColor = vertices[i+2];
        if (trim(faceColor).equals("normal")) {
          fill(normalColour);
        }
        else if (trim(faceColor).equals("glass")) {
          fill(glassColour);
        }
        i+=2;
        print(faceName + "\n"); 
      }
      else if (trim(vertices[i]).equals("endshape")) {
        endShape();
      }
      else if (trim(vertices[i]).equals("")) {
        //Blank line
      }
      else {
        String[] point = split(vertices[i], '|');
        //print(i);
        vertex(float(point[0]), float(point[2]), float(point[1]));
      }
    }
    popMatrix();
  }
  */
}
