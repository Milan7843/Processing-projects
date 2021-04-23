//Game
//Work started 1-8-2020
Camera cam;
Player player = new Player();

void setup() {
  size(800, 600);
  smooth(7);
}


void draw() {
  background(200);
  DrawPlayer();
}


void DrawPlayer() {
  player.Show();
}
