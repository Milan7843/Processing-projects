class AICar {
  
  float acceleration;
  float minSpeed;
  float maxSpeed;
  float rotSpeed;
  float currentSpeed;
  float rot = 0;
  PVector pos = new PVector(0, 0);
  
  
  AICar(float acceleration_, float minSpeed_, float maxSpeed_, float rotSpeed_, PVector startPos) {
    acceleration = acceleration_;
    minSpeed = minSpeed_;
    maxSpeed = maxSpeed_;
    rotSpeed = rotSpeed_;
    pos = startPos;
  }
  
  void feedbackLoop() {
    left = false;
    right = false;
    gas = false;
    brake = false;
    //Turning
    if (rot != (int)(targetRot/rotSpeed)*rotSpeed) {
      float rightDiff = (targetRot-rot); //difference in degrees on right side, seen from the current point
      if (rightDiff < 0)
        rightDiff+=360;
      float leftDiff = (rot-targetRot); //difference in degrees on right side, seen from the current point
      if (leftDiff < 0)
        leftDiff+=360;
      if (leftDiff < rightDiff) {
        left = true;
      } else {
        right = true;
      }
    }
    //Speed
    if (currentSpeed < targetSpeed) {
      gas = true;
    } else {
      brake = true;
    }
  }
}
