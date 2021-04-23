int graphAmnt;
float graphSpeed;

float value;
float[] values = new float[600];
float[] derivative = new float[600];

float t = 0;

void setup() {
  size(600, 800);
  for(int i = 0; i < 600; i++) {
    values[i] = 0;
  }
}

void draw() {
  background(0);
  stroke(255);
  
  
  //values[0] = sin(t) * 100f;
  values[0] = t*t;
  
  derivative[0] = (values[0]-values[1]) * 1/(0.016);
  
  translate(0, height/2);
  stroke(255);
  for(int i = 0; i < 599; i++) {
    line(i, -values[i], i+1, -values[i+1]);
  }
  stroke(255, 100, 100);
  for(int i = 0; i < 599; i++) {
    line(i, -derivative[i], i+1, -derivative[i+1]);
  }
  
  for(int i = 599; i > 0; i--) {
    values[i] = values[i-1];
  }
  for(int i = 599; i > 0; i--) {
    derivative[i] = derivative[i-1];
  }
  
  t += 0.016f;
}
