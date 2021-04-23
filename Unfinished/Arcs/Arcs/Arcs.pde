float initialX = 50;
float initialY = 250;
float frames = 60;
void setup() {
  size(500, 500);
  frameRate(75);
}

void draw() {
  //frames -= 0.05;
  //frameRate(frames);
  background(255);
  strokeWeight(5);
  fill(0, 255, 38);
  arc(0.5*mouseX + initialX - 25, initialY, (mouseX-50), mouseX-50, radians(180), radians(360));
  if (mouseY >= height/2) {
    fill(255, 0, 255);
    arc(0.5*mouseX + initialX - 25, initialY, (mouseX-50), mouseX-50, radians(0), radians(180));
  }
  //arc((450-(mouseX-50)) + 0.5*(mouseX-50), initialY, 50, 500-(mouseX+50), radians(0), radians(180));
  fill(255, 0, 255);
  arc(initialX*0.5+250+0.5*(mouseX-100), initialY, 400-(mouseX-50), 500-(mouseX+50), radians(0), radians(180));
  if (mouseY >= height/2) {
    fill(0, 255, 38);
    arc(initialX*0.5+250+0.5*(mouseX-100), initialY, 400-(mouseX-50), 500-(mouseX+50), radians(180), radians(360));
    fill(255, 0, 255);
    arc(0.5*mouseX + initialX - 25, initialY, (mouseX-50), mouseX-50, radians(0), radians(180));
  }
  
  if (mousePressed == true) {
    //boven
    fill(0, 255, 38);
    arc(500-(mouseX+50), initialY, 400-(mouseX-50), (initialX*0.5+250+0.5*(mouseX-100)), radians(180), radians(360));
    //beneden
    fill(255, 0, 255);
    arc(0.5*mouseX + initialX - 25, initialY, (mouseX-50), mouseX-50, radians(0), radians(180));
  }
  line(initialX, initialY, width-initialX, initialY);
}
