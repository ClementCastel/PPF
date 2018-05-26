class ild {
  int x;
  int y;
  int level;
  int corner = int(random(1, 5));
  boolean display = true;
  int cx, cy;

  ild(int i, int j) {
    x = 10+i*1300;
    y = 10+j*1300;
    level = int(random(1, 4));
  }

  void display (int mx, int my) {
    if (display == true) {
      fill(0, 255, 0);
      rectMode(CORNER);
      imageMode(CORNER);
      if (corner == 1) { 
        cx = x+85+300+mx;
        cy = y+85+300+my;
        if (level == 1) image(ILDLv1, x+85+mx, y+85+my);
        if (level == 2) image(ILDLv2, x+85+mx, y+85+my);
        if (level == 3) image(ILDLv3, x+85+mx, y+85+my);
        if (level == 100) image(ILDLv100, x+85+mx, y+85+my);
      }
      if (corner == 2) {
        cx = x+85+300+mx;
        cy = y+350+300+my;
        if (level == 1) image(ILDLv1, x+85+mx, y+350+my);
        if (level == 2) image(ILDLv2, x+85+mx, y+350+my);
        if (level == 3) image(ILDLv3, x+85+mx, y+350+my);
      }
      if (corner == 3) {
        cx = x+85+300+mx;
        cy = y+350+300+my;
        if (level == 1) image(ILDLv1, x+350+mx, y+85+my);
        if (level == 2) image(ILDLv2, x+350+mx, y+85+my);
        if (level == 3) image(ILDLv3, x+350+mx, y+85+my);
      }
      if (corner == 4) {
        cx = x+350+300+mx;
        cy = y+350+300+my;
        if (level == 1) image(ILDLv1, x+350+mx, y+350+my);
        if (level == 2) image(ILDLv2, x+350+mx, y+350+my);
        if (level == 3) image(ILDLv3, x+350+mx, y+350+my);
      }
    }
  }

  void suppr () {
    if (display == true) display = false;
  }
}