String text = "Teeeeeeeeeeekst";
int i;
float r = 255, g = 0, b = 0, x;
void setup() {
  size(600, 600);
  frameRate(1);
}

void draw() {
  //background(255);
  textSize(50);
  
  x = 0.7;
  text(x, 150, 150);
  if (x <= 1/6) {
    g = x * 6 * 255;
  }
  if (x > 1/6 && x <= 2/6) {
    r = 255-(x-(1/6)) * 6 * 255;
  }
  if (x > 2/6 && x <= 3/6) {
    b = (x-(2/6)) * 6 * 255;
  }
  if (x > 3/6 && x <= 4/6) {
    g = -(x-(3/6)) * 6 * 255;
  }
  if (x > 4/6 && x <= 5/6) {
    r = (x-(4/6)) * 6 * 255;
  }
  if (x > 5/6 && x <= 1) {
    b = -(x-(5/6)) * 6 * 255;
  }
  fill(r,g,b);
  rect(400, 400, 100, 100);
  
  
  
  
  //for(int i = 0; i < text.length(); i++) {
    fill(r,g,b);
    //fill(255, 255 - i*(255/text.length()), 255 - i*(255/text.length()));
    text(text.substring(0, text.length()-i), 50, 50);
  //}
  
  if (i < text.length()) {
    i++;
  }
}

//aantal letters = n
// telkens i/n
//dan rgb bepalen op dat nummer onder 1
//x verplaatsen met 1/n
//rgb bepalen door x * 255
