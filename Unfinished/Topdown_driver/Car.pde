class Car {
  
  boolean mouseDrive = false;
  float acceleration;
  float minSpeed;
  float maxSpeed;
  float rotSpeed;
  float currentSpeed;
  float rot = 0;
  PVector pos = new PVector(0, 0);
  
  
  Car (float acceleration_, float minSpeed_, float maxSpeed_, float rotSpeed_, PVector startPos) {
    acceleration = acceleration_;
    minSpeed = minSpeed_;
    maxSpeed = maxSpeed_;
    rotSpeed = rotSpeed_;
    pos = startPos;
  }
  
  
  void update() {
    if (mouseDrive) feedbackLoop();
    drive();
    drawPlayer();
    drawUI();
    drawText();
  }
  
  
  void drawPlayer() {
    //line(pos.x-(cos(radians(rot))*playerLength), pos.y-(sin(radians(rot))*playerLength), pos.x+(cos(radians(rot))*playerLength), pos.y+(sin(radians(rot))*playerLength));
    stroke(0);
    pushMatrix();
    fill(255);
    translate(pos.x-camPos.x, pos.y-camPos.y);
    rotate(radians(rot));
    rect(-30, -20, 60, 40);
    rect(-20, -20, 30, 40);
    rotate(radians(-rot));
    translate(-pos.x, -pos.y);
    popMatrix();
  }
  
  
  void feedbackLoop() {
    left = false;
    right = false;
    gas = false;
    brake = false;
    //Turning
    if (rot != (int)(targetRot/rotSpeed)*rotSpeed) {
      float rightDiff = (targetRot-rot); //difference in degrees on right side, seen from the current point
      if (rightDiff < 0) rightDiff+=360;
      float leftDiff = (rot-targetRot); //difference in degrees on right side, seen from the current point
      if (leftDiff < 0) leftDiff+=360;
      
      if (min(leftDiff, rightDiff) < rotSpeed) {
        if (leftDiff < rightDiff) rot -= leftDiff;
        else right = true; rot += rightDiff;
      }
      else {
        if (leftDiff < rightDiff) left = true;
        else right = true;
      }
    }
    //Speed
    if (currentSpeed < targetSpeed) {
      gas = true;
    } else {
      brake = true;
    }
  }
  
  
  
  void drive() {
    //Getting player input
    if (!mouseDrive) {
      gas = keys[0];
      left = keys[1];
      brake = keys[2];
      right = keys[3];
    }
    //Handling input input
    if (right) rot += rotSpeed;
    if (left) rot -= rotSpeed;
    if (gas) currentSpeed += acceleration;
    if (brake) currentSpeed -= acceleration*1.7;
    
    rot = rot%360;
    if (rot < 0) rot += 360;
    
    if (alignToRoad && min((rot % 90), 90-(rot % 90)) < alignToRoadActivationAngle && !mouseDrive) {
      if (rot % 90 < alignToRoadActivationAngle) {
        rot -= rot % 90 * alignToRoadSpeed;
      } else if (90-(rot % 90) < alignToRoadActivationAngle) {
        rot += (90-(rot % 90)) * alignToRoadSpeed;
      }
    }
    
    currentSpeed -= defaultSpeedFalloffPerFrame;
    currentSpeed = minClamp(currentSpeed, 0);
    dstToTarget = sqrt(sq(targetPos.x-pos.x) + sq(targetPos.y-pos.y));
    targetSpeed = dstToTarget*defaultDistanceSpeedMult;
    if (targetSpeed > maxSpeed) targetSpeed = maxSpeed;
    
    
    pos.add(new PVector(f.x, -f.y));
    pos.add(new PVector(cos(radians(rot))*currentSpeed, sin(radians(rot))*currentSpeed));
  }
  
  void drawUI() {
    fill(255);
    targetRot = (450 - degrees(atan2(targetPos.x-pos.x, targetPos.y-pos.y)))%360;
    /*
    targetRot -= 90;
    targetRot = 360-targetRot;
    targetRot = targetRot%360;
    */
    
    //Heading to mouse indicator
    strokeWeight(headingCircleWeight);
    circle(headingCirclePos.x, headingCirclePos.y, headingRadius*2);
    stroke(255, 0, 0);
    line(headingCirclePos.x, headingCirclePos.y, headingCirclePos.x+cos(radians(targetRot))*headingRadius, headingCirclePos.y+sin(radians(targetRot))*headingRadius);
    stroke(0);
    line(headingCirclePos.x, headingCirclePos.y, headingCirclePos.x+cos(radians(rot))*headingRadius, headingCirclePos.y+sin(radians(rot))*headingRadius);
    
    //Speed indicator
    arc(speedIndicatorPos.x, speedIndicatorPos.y, speedIndicatorRadius*2, speedIndicatorRadius*2, 3*QUARTER_PI, PI+5*QUARTER_PI, PIE);
    float speedIndicatorRot = map(currentSpeed, 0, maxSpeed, 140, 400);  
    float targetSpeedIndicatorRot = map(targetSpeed, 0, maxSpeed, 140, 400);  
    line(speedIndicatorPos.x, speedIndicatorPos.y, speedIndicatorPos.x+cos(radians(speedIndicatorRot))*speedIndicatorRadius, speedIndicatorPos.y+sin(radians(speedIndicatorRot))*speedIndicatorRadius);
    stroke(255, 0, 0);
    line(speedIndicatorPos.x, speedIndicatorPos.y, speedIndicatorPos.x+cos(radians(targetSpeedIndicatorRot))*speedIndicatorRadius, speedIndicatorPos.y+sin(radians(targetSpeedIndicatorRot))*speedIndicatorRadius);
    stroke(0);
  }
  
  void drawText() {
    textSize(30);
    fill(0);
    text("Rot: " + rot + "\nTarget rot: " + targetRot + "\nTarget: " + targetPos + "\nDst from target: " + dstToTarget + "\nPos: "+ (int)pos.x + ", "  + (int)pos.y + "\nCam pos: "+ (int)camPos.x + ", "  + (int)camPos.y + "\nSpeed: " + currentSpeed + "\nMouse drive: " + mouseDrive + "\nRot cos" + cos(radians(rot)), 0, 60);
  }
}
