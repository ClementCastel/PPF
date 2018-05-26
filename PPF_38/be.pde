class be {
  int x;
  int y;
  int level;
  int corner = int(random(1, 5));
  boolean display = true;
  int cx, cy;

  be(int i, int j) {
    x = 10+i*1300;
    y = 10+j*1300;
    level = int(random(1, 4));
  }

  void display (int mx, int my) {
    if ( display == true) {
      fill(255, 0, 0);
      rectMode(CORNER);
      imageMode(CORNER);
      if (corner == 1) { 
        cx = x+45+150+mx;
        cy = y+45+150+my;
        if (level == 1) {
          image(bn_ennemi_1, x+45+mx, y+45+my);
        }
        if (level == 2) {
          image(bn_ennemi_2, x+45+mx, y+45+my);
        }
        if (level == 3) {
          image(bn_ennemi_3, x+45+mx, y+45+my);
        }
      }
      if (corner == 2) {
        cx = x+45+150+mx;
        cy = y+350+150+my;
        if (level == 1) {
          image(bn_ennemi_1, x+45+mx, y+350+my);
        }
        if (level == 2) {
          image(bn_ennemi_2, x+45+mx, y+350+my);
        }
        if (level == 3) {
          image(bn_ennemi_3, x+45+mx, y+350+my);
        }
      }
      if (corner == 3) {
        cx = x+350+150+mx;
        cy = y+45+150+my;
        if (level == 1) {
          image(bn_ennemi_1, x+350+mx, y+45+my);
        }
        if (level == 2) {
          image(bn_ennemi_2, x+350+mx, y+45+my);
        }
        if (level == 3) {
          image(bn_ennemi_3, x+350+mx, y+45+my);
        }
      }
      if (corner == 4) {
        cx = x+350+150+mx;
        cy = y+350+150+my;
        if (level == 1) {
          image(bn_ennemi_1, x+350+mx, y+350+my);
        }
        if (level == 2) {
          image(bn_ennemi_2, x+350+mx, y+350+my);
        }
        if (level == 3) {
          image(bn_ennemi_3, x+350+mx, y+350+my);
        }
      }
    }
  }
  void suppr () {
    if (display == true) display = false;
  }
}