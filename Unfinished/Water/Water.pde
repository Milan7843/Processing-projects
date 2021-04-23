int maxCircleAmount = 150;
float[] x = new float[maxCircleAmount];
float[] y = new float[maxCircleAmount];
boolean[] circles = new boolean[maxCircleAmount];
float[] timer = new float[maxCircleAmount];
int num = 0;
boolean new1 = false;
float time = 60;
int totalAmount = 0;
//measured in frames
//total needed circles = maxCircleSize/circleGrowAmount
float maxCircleSize = 450;
float circleGrowAmount = 3;
float lastMouseX;
float lastMouseY;

boolean mouseDragging = true;
float textSize = 5;
void setup() {
  //fullScreen();
  size(600, 600);
  frameRate(60);
  maxCircleSize /= circleGrowAmount;
}

void draw() {
  background(100, 100, 255);
  for (int i = 0; i < maxCircleAmount; i++) {
    timer[i]--;
    if (timer[i] <= 0) {
      circles[i] = false;
      if (num >= 1) {
        num--;
      }
    }
    
    //putting the timers on screen
    textSize(textSize);
    fill(255);
    text((int)timer[i], 10, textSize + textSize*i);
    
    if(!circles[i]) {
      fill(108, 232, 42);
    }
    else {
      fill(217, 0, 0);
    }
    text(circles[i] + "", 100, textSize + textSize*i);
    
    //cirkels maken
    if (circles[i]) {
      noFill();
      circle(x[i], y[i], -circleGrowAmount * (timer[i]-maxCircleSize));
      
    }
  }
  
  //voor elke cirkel past dit de x en y aan aan de offset van de laatste
  for(int i = 0; i < num; i++) {
    
  }
  
    
  fill(255);
  textSize(50);
  text((int)frameRate, width -  100, 50);
  text((int)num, width -  100, 100);
  if (mousePressed) {
    if (mouseDragging) {
      for (int i = 0; i < maxCircleAmount; i++) {
        if (!circles[i] && !new1) {
          circles[i] = true;
          timer[i] = maxCircleSize;
          new1 = true;
          x[i] = mouseX;
          y[i] = mouseY;
          num++;
        }
      }
    new1 = false;
    }
  }
  
  lastMouseX = mouseX;
  lastMouseY = mouseY;
}

void mousePressed() {
  if (!mouseDragging) {
    
    for (int i = 0; i < maxCircleAmount; i++) {
      if (!circles[i] && !new1) {
        circles[i] = true;
        timer[i] = maxCircleSize;
        new1 = true;
        x[i] = mouseX;
        y[i] = mouseY;
        num++;
      }
    }
    new1 = false;
  }
  
}

void mouseDragged() {

}
