int maxNumber = 1000000;
int comparisons;
int i = 1;
boolean paused;
PrintWriter output;

void setup() {
  size(600, 600);
  background(182, 224, 192);
  textSize(50);
  output = createWriter("Primes_under_" + maxNumber + ".txt"); 
}

void draw() {
  background(182, 224, 192);
  if (i < maxNumber) {
    for(int b = 0; b < 300; b++) {
      boolean isPrime = true;
      if (isPrime) {
        for (int e = 2; e < ceil(i/2); e++) {
          if (divisible(i, e)) { isPrime = false; break; }
        }
      }
      if (isPrime) output.println(i);
      if (i < maxNumber) i += 2;
      else break;
    }
  }
  text(i, 50, 100);
}

boolean divisible(float number, float divider) {
  comparisons++;
  return number % divider == 0;
}

void mousePressed() {
  paused = !paused;
}
