class Ray {
  PVector currentEndPoint;
  PVector dirUsing = new PVector();
  RayInfo hit;
  
  String closestObj = "";
  float distance = 0.1;
  float totalDistanceRay = 0;
  float minimumDistanceThisRay = 100;
  boolean normalSet = false;
  PVector normal = new PVector(0, 0, 1);
  
  color clr;
  boolean reflective = false;
  int reflectionIndex;
  
  int closestDstPoint = 0;
  
  boolean hitObj = false;
  
  Ray (PVector pos, PVector dir, boolean needsNormal, boolean doLighting, int reflectionIndex_) {
    //Assigning variables
    currentEndPoint = pos;
    dirUsing = dir;
    reflectionIndex = reflectionIndex_;
    
    
    for(int i = 0; i < maxStepAmountPerPixel; i++) {
      currentEndPoint = new PVector(currentEndPoint.x + distance * dirUsing.x, currentEndPoint.y + distance * dirUsing.y, currentEndPoint.z + distance * dirUsing.z);
      distance = closestDistance(currentEndPoint);
      totalDistanceRay += distance;
      if (distance < minimumDistanceThisRay) {
        minimumDistanceThisRay = distance;
      }
      if (distance > maximumRayDist && useMaxRayDist) {
        clr = getSkyboxColor(dirUsing);
        break;
      }
      if (distance < dstThresHoldToHit) {
        //hit has been found
        //getting normal
        switch (closestObj) {
          case "sphere":
            if (sphere[closestObjIndex].reflective) {
              //reflection code in here
              reflective = true;
              normalSet = true;
              PVector d = new PVector(dirUsing.x, dirUsing.y, dirUsing.z);
              normal = new PVector(currentEndPoint.x - sphere[closestObjIndex].pos.x, currentEndPoint.y - sphere[closestObjIndex].pos.y, currentEndPoint.z - sphere[closestObjIndex].pos.z).normalize();
              
              //reflection = d-2*(d.n)*n
              dirUsing = d.add(normal.mult(-2*d.dot(normal)));
              if (reflectionIndex < maxReflections) clr = reflect(dirUsing, doLighting);
              //if (reflectionIndex < maxReflections) clr = lerpColor(reflect(dirUsing, doLighting), sphere[closestObjIndex].clr, 0.5);
              break;
            }
            else {
              clr = sphere[closestObjIndex].clr;
              if (needsNormal) {
                normalSet = true;
                normal = new PVector(currentEndPoint.x - sphere[closestObjIndex].pos.x, currentEndPoint.y - sphere[closestObjIndex].pos.y, currentEndPoint.z - sphere[closestObjIndex].pos.z).normalize();
              }
            }
            break;
          case "line":
            clr = line[closestObjIndex].clr;
            break;
          case "cube":
            float closestDstToPoint = 100;
            closestDstPoint = 0;
            for (int c = 0; c < 6; c++) {
              float dstThisPoint = dist(currentEndPoint, cube[closestObjIndex].points[c]);
              if (dstThisPoint < closestDstToPoint) {
                closestDstPoint = c;
                closestDstToPoint = dstThisPoint;
              }
            }
            if (cube[closestObjIndex].reflect[closestDstPoint]) {
              //reflection code in here
              reflective = true;
              normalSet = true;
              PVector d = new PVector(dirUsing.x, dirUsing.y, dirUsing.z);
              normal = new PVector(cube[0].normal[closestDstPoint].x, cube[0].normal[closestDstPoint].y, cube[0].normal[closestDstPoint].z);
              //reflection = d-2*(d.n)*n
              dirUsing = d.add(normal.mult(-2*d.dot(normal)));
              if (reflectionIndex < maxReflections) clr = reflect(dirUsing, doLighting);
              break;
            }
            else {
              clr = cube[closestObjIndex].clrs[closestDstPoint];
              if (needsNormal) {
                normalSet = true;
                normal = new PVector(cube[0].normal[closestDstPoint].x, cube[0].normal[closestDstPoint].y, cube[0].normal[closestDstPoint].z);
              }
            }
            break;
          case "box":
            clr = box[closestObjIndex].clr;
            break;
          case "plane":
            if (plane[closestObjIndex].reflective) {
              //reflection code in here
              reflective = true;
              normalSet = true;
              PVector d = new PVector(dirUsing.x, dirUsing.y, dirUsing.z);
              normal = new PVector(plane[closestObjIndex].n.x, plane[closestObjIndex].n.y, plane[closestObjIndex].n.z);
              //reflection = d-2*(d.n)*n
              dirUsing = d.add(normal.mult(-2*d.dot(normal)));
              if (reflectionIndex < maxReflections) clr = reflect(dirUsing, doLighting);
              break;
            }
            else {
              if (plane[closestObjIndex].isGround) {
                float checkerSize = 4;
                int index = 0;
                if (abs(currentEndPoint.x) % checkerSize > checkerSize/2 && abs(currentEndPoint.y) % checkerSize > checkerSize/2) {
                  index = 1;
                }
                else if (abs(currentEndPoint.x) % checkerSize > checkerSize/2 || abs(currentEndPoint.y) % checkerSize > checkerSize/2) {
                  index = 0;
                }
                else {
                  index = 1;
                }
                index = (int)((index+1)/2);
                clr = plane[closestObjIndex].clr[index];
              }
              else {
                clr = plane[closestObjIndex].clr[0];
              }
              if (needsNormal) {
                normalSet = true;
                normal = new PVector(plane[closestObjIndex].n.x, plane[closestObjIndex].n.y, plane[closestObjIndex].n.z);
              }
            }
            break;
          case "torus":
            if (torus[closestObjIndex].reflective) {
              //reflection code in here
              reflective = true;
              normalSet = true;
              PVector d = new PVector(dirUsing.x, dirUsing.y, dirUsing.z);
              normal = torus[closestObjIndex].getNormal(currentEndPoint);
              //reflection = d-2*(d.n)*n
              dirUsing = d.add(normal.mult(-2*d.dot(normal)));
              if (reflectionIndex < maxReflections) clr = reflect(dirUsing, doLighting);
              break;
            }
            else {
              clr = torus[closestObjIndex].clr;
              if (needsNormal) {
                normalSet = true;
                normal = torus[closestObjIndex].getNormal(currentEndPoint);
              }
            }
            break;
          case "cappedLine":
            clr = cappedLine[closestObjIndex].clr;
            break;
          case "model":
            if (model[closestObjIndex].faces[closestFaceIndex].reflective) {
              //reflection code in here
              reflective = true;
              normalSet = true;
              PVector d = new PVector(dirUsing.x, dirUsing.y, dirUsing.z);
              normal = model[closestObjIndex].normals[model[closestObjIndex].faces[closestFaceIndex].normalIndex];
              //reflection = d-2*(d.n)*n
              dirUsing = d.add(normal.mult(-2*d.dot(normal)));
              if (reflectionIndex < maxReflections) clr = reflect(dirUsing, doLighting);
              break;
            }
            else {
              clr = model[closestObjIndex].clrs[model[closestObjIndex].faces[closestFaceIndex].colorIndex];
              if (needsNormal) {
                normalSet = true;
                normal = model[closestObjIndex].normals[model[closestObjIndex].faces[closestFaceIndex].normalIndex];
              }
            }
            break;
        }
        hitObj = true;
        
        
        /* Lighting calculation process:
        The multiplier for the current pixel is automatically set to shade from the shadowMult variable
        Then for each light source, a ray is cast from the object hit point to the light source
        If this ray does not hit anything on it's way to the light source, the point is brightened, depending on the distance from the lightsource
        */
        if (doLighting && !reflective) {
          //clr = newColor;
          float lightMultiplier = shadowMult;
          for (PointLight light : pointLight) {
            PVector dirToLight = new PVector(light.pos.x - currentEndPoint.x, light.pos.y - currentEndPoint.y, light.pos.z - currentEndPoint.z).normalize();
            //if (needsNormal) print(dirToLight + "\n");
            if (!freezeNormal) normal = dirToLight;
            if (!(normalSet && normal.dot(dirToLight) <= 0)) {
              //print(normal.dot(dirToLight) + "\n");
              Ray ray = new Ray(currentEndPoint, dirToLight, false, false, reflectionIndex+1);
              RayInfo rayInfo = ray.getRayInfo();
              if (!rayInfo.hit) {
                //lightMultiplier *= 1+(light.intensity/(vectorLength(new PVector(light.pos.x - currentEndPoint.y, light.pos.x - currentEndPoint.y, light.pos.z - currentEndPoint.z))+1) * constrain(shadowSoftness * rayInfo.closestDst, 0, 1));
                lightMultiplier *= 1+light.intensity/(vectorLength(new PVector(light.pos.x - currentEndPoint.y, light.pos.x - currentEndPoint.y, light.pos.z - currentEndPoint.z))+1)*normal.dot(dirToLight);
                //lightMultiplier *= 1.4;
              }
            }
          }
          color newColor = color(red(clr)*lightMultiplier, green(clr)*lightMultiplier, blue(clr)*lightMultiplier);
          clr = newColor;
        }
        break; //stopping after ray hit
      }
    }
    if (useMaxRayDist && !hitObj) {
      clr = getSkyboxColor(dirUsing);
    }
  }
  
  color reflect(PVector dir, boolean doLighting) {
    Ray ray = new Ray(currentEndPoint, dir, false, doLighting, reflectionIndex+1);
    return ray.getRayInfo().clr;
  }
  
  color getSkyboxColor(PVector d) {
    PVector up = new PVector(0, 0, 1).normalize();
    return lerpColor(skyboxColorHorizon, skyboxColorTop, up.dot(d)+0.1);
  }
  
  RayInfo getRayInfo() {
    hit = new RayInfo(dirUsing, minimumDistanceThisRay, closestObj, currentEndPoint, totalDistanceRay, normalSet, normal, reflective, clr, hitObj);
    return hit;
  }
  
  
  
  float closestDistance(PVector endPoint) {
    float closestDst = maxTravelDstPerStep;
    for(int i = 0; i < sphere.length; i++) {
      float dst = dstSphere(sphere[i], endPoint);
      if (dst < closestDst) {
        closestDst = dst;
        closestObj = "sphere";
        closestObjIndex = i;
      }
    }
    for(int i = 0; i < box.length; i++) {
      float dst = dstBox(box[i], endPoint);
      if (dst < closestDst) {
        closestDst = dst;
        closestObj = "box";
        closestObjIndex = i;
      }
    }
    for(int i = 0; i < plane.length; i++) {
      float dst = dstPlane(plane[i], endPoint);
      //print(dst + "\n");
      if (dst < closestDst) {
        closestDst = dst;
        closestObj = "plane";
        closestObjIndex = i;
      }
    }
    for(int i = (showNormal ? 0 : 1); i < line.length; i++) {
      float dst = dstLine(line[i], endPoint);
      //print(dst + "\n");
      if (dst < closestDst) {
        closestDst = dst;
        closestObj = "line";
        closestObjIndex = i;
      }
    }
    for(int i = 0; i < cube.length; i++) {
      float dst = dstCube(cube[i], endPoint, i);
      //print(dst + "\n");
      if (dst < closestDst) {
        closestDst = dst;
        closestObj = "cube";
        closestObjIndex = i;
      }
    }
    for(int i = 0; i < torus.length; i++) {
      float dst = dstTorus(torus[i], endPoint);
      //print(dst + "\n");
      if (dst < closestDst) {
        closestDst = dst;
        closestObj = "torus";
        closestObjIndex = i;
      }
    }
    for(int i = 0; i < cappedLine.length; i++) {
      float dst = dstCappedLine(cappedLine[i], endPoint);
      //print(dst + "\n");
      if (dst < closestDst) {
        closestDst = dst;
        closestObj = "cappedLine";
        closestObjIndex = i;
      }
    }
    for(int i = 0; i < cappedLine.length; i++) {
      float dst = dstCappedLine(cappedLine[i], endPoint);
      //print(dst + "\n");
      if (dst < closestDst) {
        closestDst = dst;
        closestObj = "cappedLine";
        closestObjIndex = i;
      }
    }
    for(int i = 0; i < model.length; i++) {
      float dst = 0;
      for(int f = 0; f < model[i].faces.length; f++) {
        if (model[i].normals[model[i].faces[f].normalIndex].dot(dirUsing) <= 0) {
          //if (random(1) > 0.99) print(subtractVectors(model[i].faces[f].pos, cameraNormal).normalize().dot(dirUsing.normalize()) + "\n");
          if (subtractVectors(model[i].faces[f].pos, cameraPos).normalize().dot(cameraNormal) > 0.6) {
            //if (random(1) > 0.99) print("drawing model\n");
            if (model[i].faces[f].vertexAmnt == 3) {
              dst = dstTri(model[i].vertices[model[i].faces[f].vertexIndices[0]], model[i].vertices[model[i].faces[f].vertexIndices[1]], model[i].vertices[model[i].faces[f].vertexIndices[2]], endPoint);
            }
            else if (model[i].faces[f].vertexAmnt == 4) {
              dst = dstQuad(model[i].vertices[model[i].faces[f].vertexIndices[0]], model[i].vertices[model[i].faces[f].vertexIndices[1]], model[i].vertices[model[i].faces[f].vertexIndices[2]], model[i].vertices[model[i].faces[f].vertexIndices[3]], endPoint);
            }
            else {
              print("Face " + f + " on model " + i + " has more than 4 vertices (" + model[i].faces[f].vertexAmnt + "), which cannot be interpreted.\n");
            }
            //print(dst + "\n");
            if (dst < closestDst) {
              closestDst = dst;
              closestObj = "model";
              closestObjIndex = i;
              closestFaceIndex = f;
            }
          }
        }
      }
    }
    /*
    for(int i = 0; i < model.length; i++) {
      float dst = 0;
      for(int f = 0; f < model[i].faceVertexAmnt.length; f++) {
        //print(model[i].vertices.length + "\n");
        if (model[i].faceVertexAmnt[f] == 3) {
          dst = dstTri(model[i].vertices[model[i].faceVertices[f][0]], model[i].vertices[model[i].faceVertices[f][1]], model[i].vertices[model[i].faceVertices[f][2]], endPoint);
        }
        else if (model[i].faceVertexAmnt[f] == 4) {
          //print(model[i].faceVertices[f][3] + "\n");
          dst = dstQuad(model[i].vertices[model[i].faceVertices[f][0]], model[i].vertices[model[i].faceVertices[f][1]], model[i].vertices[model[i].faceVertices[f][2]], model[i].vertices[model[i].faceVertices[f][3]], endPoint);
          //print(model[i].faceVertices[f][0]);
        }
        //print(dst + "\n");
        if (dst < closestDst) {
          closestDst = dst;
          closestObj = "model";
          closestObjIndex = i;
        }
      }
    }
    */
    /*
    float dstCube = dstCube(sminTestCube, endPoint, 3);
    float dstSphere = dstSphere(sminTestSphere, endPoint);
    float sminDst = smin(dstCube, dstSphere, 0.1);
    
    if (sminDst < closestDst) {
      closestDst = sminDst;
      closestObj = "sphere";
      closestObjIndex = 0;
    }
    */
    return closestDst;
  }
}
