class player_T {
  int life = 200;
  int x = 80, y = 450;
  boolean display = true;

  void display(int x, int y) {
    if (display) {
      image(pirate_vertical,x,y);
      
      fill(255);
      rect(x-35, y-50, 250, 34);
      fill(210, 0, 0);
      rect(x-32, y-47, life*1.22, 28);
    }
}
}