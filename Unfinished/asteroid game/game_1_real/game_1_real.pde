//W, A, D to move, V to shoot, M to spawn asteroid

//player settings
float px = 300, py = 300, pvx, pvy, pa = 0.2, ps = 0.01, playerSpeed = 20;
float pr = 255, pg = 255, pb = 255;
float rot, rotSpeed = 2;

//dev settings
boolean[] keys = new boolean[5];
float textSize = 25;
boolean enableInfo = true;
boolean additionalInfo = false; //turning on this setting will cause the game to be played at a low fps
boolean enableDebug = true;
float dr = 255, dg = 0, db = 0; //debug rgb values
char enableInfoKey = 'i';
char enableAdditionalInfoKey = 'o';

//game settings
float friction = 0.1;
float scale = 0.5;
float gameSpeed = 1;

//ship look
float shipWidth = 0.2;
float shipLength = 100;

//asteroids
int maxAsteroids = 20;
float asteroidSize = 200;
float asteroidAngles = 6;

//bullets
int maxBulletAmount = 500;
float shootingDelay = 10;
float bulletLifetime = 100;
float bulletSpeed = 30;
float bulletSpread = 0;
float bulletKnockback = 10;
float bulletSize = 20;
float bulletAggroRange = 200;

//unchangeable variables
float delay;
boolean new1;
boolean newAsteroid;
float averageSide;
float xr, yr;
float vx, vy;
float a = 1, b = 5;
float sdx, sdy;
float dx, dy;
boolean[] bullets = new boolean[maxBulletAmount];
float[] bx = new float[maxBulletAmount];
float[] by = new float[maxBulletAmount];
float[] brx = new float[maxBulletAmount];
float[] bry = new float[maxBulletAmount];
float[] timer = new float[maxBulletAmount];
float[] asteroidX = new float[maxAsteroids];
float[] asteroidY = new float[maxAsteroids];
boolean[] asteroids = new boolean[maxAsteroids];
float[] asteroidSide = new float[maxAsteroids * (int)asteroidAngles];
float[] asteroidSideX = new float[maxAsteroids * (int)asteroidAngles];
float[] asteroidSideY = new float[maxAsteroids * (int)asteroidAngles];
int closestA;
float dist;

void setup() {
  fullScreen();
  frameRate(60 * gameSpeed);
  //making sure everything is to scale
  ps *= scale;
  pa *= scale;
  playerSpeed *= scale;
  bulletSpeed *= scale;
  bulletSize *= scale;
  bulletLifetime /= scale;
}

void draw() {
  background(0, 0, 70);
  stroke(255, 0, 0);
  delay++;
  Player();
  //translate(px, py);
  xr = cos(a);
  yr = sin(a);
  stroke(255);
  a = rot;
  a /= 50;
  b = asin(a);
  //translate(-px, -py);
  textSize(textSize);
  translate(-px, -py);
  //information about the players rotation and position
  if (enableInfo && additionalInfo) {
    text("xr: " + xr + "\nyr: " + yr + "\npvx: " + pvx + "\npvy: " + pvy + "\npx: " + px + "\npy: " + py, 330, textSize/2+15);
  }
  else if (enableInfo) {
    text("xr: " + xr + "\nyr: " + yr + "\npvx: " + pvx + "\npvy: " + pvy + "\npx: " + px + "\npy: " + py, 10, textSize/2+15);
  }
  for (int i = 0; i < maxBulletAmount; i++) {
    timer[i]--;
    if (timer[i] <= 0) {
      bullets[i] = false;
    }
    
    //putting the timers on screen
    textSize(textSize);
    fill(255);
    if (additionalInfo) {
      text((int)timer[i], 10, textSize + textSize*i);
    }
    if(!bullets[i]) {
      fill(108, 232, 42);
    }
    else {
      fill(217, 0, 0);
    }
    if (additionalInfo) {
      text(bullets[i] + "  " + brx[i] * bulletSpeed, 100, textSize + textSize*i);
    }
    
    //bullets maken
    if (bullets[i]) {
      if (bx[i] > width || bx[i] < 0 || by[i] > height || by[i] < 0) {
        bullets[i] = false;
      }
      else {
        noFill();
        bx[i] += brx[i] * bulletSpeed;
        by[i] += bry[i] * bulletSpeed;
        circle(bx[i], by[i], bulletSize);
        
        for (int r = 0; r < maxAsteroids; r++) {
          if (asteroids[r]) {
            if (asteroidX[r] < bx[i] + bulletAggroRange || asteroidX[r] > bx[i] - bulletAggroRange && asteroidY[r] < bx[i] + bulletAggroRange || asteroidY[r] > bx[i] - bulletAggroRange) {
              if (sqrt(sq(bx[i] - asteroidX[r]) + sq(by[i] - asteroidY[r])) > dist) {
                dist = sqrt(sq(bx[i] - asteroidX[r]) + sq(by[i] - asteroidY[r]));
                closestA = r;
              }
            }
          }
          //deleting bullets and asteroids on impact
          for (int c = 0; c < asteroidAngles; c++) {
            if (sqrt(sq(bx[i] - asteroidSideX[c + (int)asteroidAngles * r]) + sq(by[i] - asteroidSideY[c + (int)asteroidAngles * r])) < asteroidSide[c + (int)asteroidAngles * r]/2 + bulletSize/2) {
              
              fill(100, 255, 100);
              asteroids[r] = false;
              bullets[i] = false;
              //asteroidSide[c] = 0;
              //asteroidX[r] = 0;
            }
          }
        }
        if (enableDebug) {
          square(bx[i] - 0.5*bulletAggroRange, by[i] - 0.5*bulletAggroRange, bulletAggroRange);
        }
        
      }
      
      
    }
  }
  for (int i = 0; i < maxAsteroids; i++) {
    fill(255);
    //asteroids maken
    if (asteroids[i]) {
      for (int x = 0; x < asteroidAngles; x++) {
        
        sdx = cos(x);
        sdy = sin(x);
        //text(i, 250, 250 + i * 50);
        //line(asteroidX[i], asteroidY[i], asteroidX[i] + (sdx)*asteroidSide[x + i*6] * scale, asteroidY[i] + (sdy)*asteroidSide[x + i*6] * scale);         
        stroke(255);
        if (x < asteroidAngles-1) {
          dx = cos(x+1);
          dy = sin(x+1);
          line(asteroidX[i] + (dx)*asteroidSide[x + i*(int)asteroidAngles + 1] * scale, asteroidY[i] + (dy)*asteroidSide[x + i*(int)asteroidAngles + 1] * scale, asteroidX[i] + (sdx)*asteroidSide[x + i*(int)asteroidAngles] * scale, asteroidY[i] + (sdy)*asteroidSide[x + i*(int)asteroidAngles] * scale);
        }
        else {
          dx = cos(0);
          dy = sin(0);
          line(asteroidX[i] + (dx)*asteroidSide[i*(int)asteroidAngles] * scale, asteroidY[i] + (dy)*asteroidSide[i*(int)asteroidAngles] * scale, asteroidX[i] + (sdx)*asteroidSide[x + i*(int)asteroidAngles] * scale, asteroidY[i] + (sdy)*asteroidSide[x + i*(int)asteroidAngles] * scale);          
        }
        
        //if (x == 0) {
        //  line(asteroidX[i], asteroidY[i], asteroidX[i] + (sdx)*asteroidSide[x] * scale, asteroidY[i] + (sdy)*asteroidSide[x] * scale);          
        //} else {
        //  line(asteroidX[i], asteroidY[i], asteroidX[i] + (sdx)*asteroidSide[i % (6 * i)] * scale, asteroidY[i] + (sdy)*asteroidSide[i % (6 * i)] * scale);
        //}
        if (enableDebug) {
          //getting the average of the asteroid sides
          for (int p = 0; p < asteroidAngles; p++) {
            averageSide += asteroidSide[p + i*(int)asteroidAngles];
          }
          
          averageSide /= asteroidAngles;
          stroke(dr, dg, db);
          noFill();
          circle(asteroidX[i], asteroidY[i], 1);
          circle(asteroidX[i] + (0.25 * asteroidSide[i*(int)asteroidAngles + x] * cos(x)), asteroidY[i] + (0.25 * asteroidSide[i*(int)asteroidAngles + x] * sin(x)), 0.5 * asteroidSide[i*(int)asteroidAngles + x]);
        }
      }
      
      //hitboxes for asteroids are circles with a radius of the average asteroidSide2
      
    }
  }
  fill(255);
  textSize(50);
  text((int)frameRate, width -  100, 50);
  translate(px, py);
  //making new bullets
  
  
  if (keys[3] && delay > shootingDelay) {
    for (int i = 0; i < maxBulletAmount; i++) {
      if (!bullets[i] && !new1) {
        bullets[i] = true;
        timer[i] = bulletLifetime;
        new1 = true;
        bx[i] = px;
        by[i] = py;
        brx[i] = xr + random(-bulletSpread, bulletSpread);
        bry[i] = yr + random(-bulletSpread, bulletSpread);
        delay = 0;
        pvx -= xr * bulletKnockback * 0.01;
        pvy -= yr * bulletKnockback * 0.01;
      }
    }
    new1 = false;
  }
  
  
  if (keys[4]) {
    reset();
  }
  
  //acceleration and movement
  if (keys[0]) {
    rot -= rotSpeed;
  }
  if (keys[1]) {
    rot += rotSpeed;
  }
  if (keys[2]) {
    if (pvx < playerSpeed) {
       pvx += pa * xr;
    }
    if (pvy < playerSpeed) {
       pvy += pa * yr;
    }
  }
  else {
    
  }
  if (pvx > 0) {
    //pvx -= ps * pvx;
  }
  if (pvy > 0) {
    //pvy -= ps * pvy;
  }
  pvx -= ps * pvx;
  pvy -= ps * pvy;
  
  
  if (pvx > playerSpeed) {
    pvx = playerSpeed;
  }
  if (pvy > playerSpeed) {
    pvy = playerSpeed;
  }
  if (pvx <= 0) {
    //pvx = 0;
  }
  if (pvy <= 0) {
    //pvy = 0;
  }
  
  px += pvx;
  py += pvy;
}

void keyPressed()
{
  if (key=='a') {
    keys[0]=true;
  } if (key=='d') {
    keys[1]=true;
  } if (key == 'w') {
    keys[2]=true;
  } if (key == 'v') {
    keys[3]=true;
  } if (key == 'r') {
    keys[4]=true;
  }
  //controls for enabling information on screen
  if (key == enableInfoKey) {
    if (enableInfo) {
      enableInfo = false;
    } else {
      enableInfo = true;
    }
  }
  if (key == enableAdditionalInfoKey) {
    if (additionalInfo) {
      additionalInfo = false;
    } else {
      additionalInfo = true;
    }
  }
  //pressing m spawns a new asteroid on a random location
  if (key == 'm') {
    for (int i = 0; i < maxAsteroids; i++) {
      if (!asteroids[i] && !newAsteroid) {
        asteroids[i] = true;
        newAsteroid = true;
        asteroidX[i] = random(width);
        asteroidY[i] = random(height);
        for(int c = 0; c < asteroidAngles; c++) {
          asteroidSide[i*(int)asteroidAngles + c] = random(asteroidSize);
          asteroidSideX[i*(int)asteroidAngles + c] = asteroidX[i] + (0.25 * asteroidSide[i*(int)asteroidAngles + c] * cos(c));
          asteroidSideY[i*(int)asteroidAngles + c] = asteroidY[i] + (0.25 * asteroidSide[i*(int)asteroidAngles + c] * sin(c));
        }
      }
    }
    newAsteroid = false;
  }
     
}

void keyReleased()
 {
   if (key=='a') {
     keys[0]=false;
   } if (key=='d') {
     keys[1]=false;
   } if (key == 'w') {
     keys[2]=false;
   } if (key == 'v') {
     keys[3]=false;
   } if (key == 'r') {
     keys[4]=false;
   }
} 

void Player() {
  stroke(pr,pg,pb);
  translate(px, py);
  sdx = cos(a + shipWidth);
  sdy = sin(a + shipWidth);
  line(0, 0, (sdx)*-shipLength * scale, (sdy)*-shipLength * scale);
  //lijn naar rechtsachter
  sdx = cos(a - shipWidth);
  sdy = sin(a - shipWidth);
  line(0, 0, (sdx)*-shipLength * scale, (sdy)*-shipLength * scale);
  //lijn tussen achterpunten
  //line(0, 0, (xr)*-shipLength, (yr)*-100);
  line((cos(a-shipWidth))*-shipLength * scale, (sin(a-shipWidth))*-shipLength * scale, (cos(a+shipWidth))*-shipLength * scale, (sin(a+shipWidth))*-shipLength * scale);
  //debug lines for bullet spread
  if (enableDebug) {
    stroke(dr, dg, db);
    sdx = cos(a + bulletSpread);
    sdy = sin(a + bulletSpread);
    line(0, 0, (sdx)*10000 * scale, (sdy)*10000 * scale);
    //lijn naar rechtsachter
    sdx = cos(a - bulletSpread);
    sdy = sin(a - bulletSpread);
    line(0, 0, (sdx)*10000 * scale, (sdy)*10000 * scale);
  }
}

void reset() {
  px = 300;
  py = 300;
  pvx = 0;
  pvy = 0;
  xr = 0;
  yr = 0;
  rot = 0;
  for (int i = 0; i < maxBulletAmount; i++) {
    if (bullets[i]) {
      bullets[i] = false;
    }
  }
  for (int i = 0; i < maxAsteroids; i++) {
    if (asteroids[i]) {
      asteroids[i] = false;
    }
  }
}
