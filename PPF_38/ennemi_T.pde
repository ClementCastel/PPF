class ennemi_T {
  int x = 100;
  int y;
  int skill;
  int sante;
  int degats;
  boolean alive = true;

  ennemi_T(int pos, int classe) {
    if (pos == 1) {
      x = 1150;
      y = 250;
    }
    if (pos == 2) {
      x = 1250;
      y = 350;
    }
    if (pos == 3) {
      x = 1350;
      y = 450;
    }

    if (classe == 1) { //ennemi simple
      sante = 100;
      degats = 25;
      skill = 1;
    }
    if (classe == 2) { //ennemi tank
      sante = 150;
      degats = 15;
      skill = 2;
    }
    if (classe == 3) { //ennemi assassin
      sante = 80;
      degats = 40;
      skill = 3;
    }
    if (classe == 100) {
      sante = 500;
      degats = 30;
      skill = 100;
    }
  }

  void display (int x, int y) {
    if (sante <= 0) alive = false;

    if (alive) {
      fill(255);
      rect(x-35, y-50, 250, 34);
      if (skill == 1) {
        image(ennemi_simple, x, y);
        fill(210, 0, 0);
        rect(x-32, y-47, sante*2.44, 28);
      } else if (skill == 2) {
        image(ennemi_tank, x, y);
        fill(210, 0, 0);
        rect(x-32, y-47, sante*1.62, 28);
      } else if (skill == 3) {
        image(ennemi_assassin, x, y);
        fill(210, 0, 0);
        rect(x-32, y-47, sante*3.05, 28);
      } else if (skill == 100) {
        image(boss, x, y);
        fill(210, 0, 0);
        rect(x-32, y-47, sante*0.488, 28);
      }
    } else {
    }
  }
}