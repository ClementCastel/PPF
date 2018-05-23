import controlP5.*;
ControlP5 cp5;
float angle = 30; // variable pour l'angle du canon
// variables pour la position du boulet de canon
float bouletX = 1700;
float bouletY = 400;
float puissance=10;
// variables pour la vitesse du boulet de canon
float dx = 0;
float dy = 0;
float frottement=0.95;
// variable pour l'accélération due à la pesanteur
float pesanteur=1;

float en_angle = 150, en_bouletX = 1200, en_bouletY = 500, en_dx = 0, en_dy = 0, puissance_ennemi, level_en, i_en, j_en; //i_en et j_en sont les coordonnées de l'objet dans le tableau

boat boat = new boat();


PImage render; //IMAGE DE FOND G0 - menu
PImage up; //BATEAU DIRECTION HAUT
PImage down; //BATEAU DIRECTION BAS
PImage left; //BATEAU DIRECTION GAUCHE
PImage right; //BATEAU DIRECTION DROITE
PFont fontAmarrer; //POLICE DE CARACTERE
PFont fontMenu; //POLICE DE CARACTERE
PImage right_combat; //IMAGE BATEAU EN COMBAT NAVAL
PImage sea; //IMAGE MER
PImage bn_ennemi_1;  //BATEAU ENNEMI LV1 (G2 - navigation)
PImage bn_ennemi_2;  //BATEAU ENNEMI LV2 (G2 - navigation)
PImage bn_ennemi_3;  //BATEAU ENNEMI LV3 (G2 - navigation)
PImage bn_ennemi_1_r; //BATEAU ENNEMI LV1 (G3 - combat naval)
PImage bn_ennemi_2_r; //BATEAU ENNEMI LV1 (G3 - combat naval)
PImage bn_ennemi_3_r; //BATEAU ENNEMI LV1 (G3 - combat naval)
PImage ennemi_simple; //ENNEMI .SKILL = 1 (G5 - combat terrestre)
PImage ennemi_tank; //ENNEMI .SKILL = 2 (G5 - combat terrestre)
PImage ennemi_assassin; //ENNEMI .SKILL = 3 (G5 - combat terrestre)
PImage pirate_vertical; //PERSONNAGE COMBAT TERRESTRE
PImage jungle; //IMAGE DE FOND COMBAT TERRESTRE
PImage background; //PAS MOI
PImage ILDLv1;
PImage ILDLv2;
PImage ILDLv3;
PImage ILDLv100;

int mx = 0; //COORDONN2E X, MAP
int my = 0; //COORDONN2E Y, MAP
int speed = 10; //VITESSE D2PLACEMENT BATEAU

int gameStatement = 0; //CORE PROJECT

boolean tour_ennemi = true; //COMBAT NAVAL
int sante_ennemi = 100; //temporaire (?)

int money = 12500; //ARGENT

int index_ILD_x; //COORDONNEE X de l'ile attaquée
int index_ILD_y; //COORDONNEE Y de l'ile attaquée
int current_ILD_level; //NIVEAU de l'ile attaquée
int gain;

int index_BE_x; //COORDONNEE X du bateau ennemi attaqué
int index_BE_y; //COORDONNEE Y du bateau ennemi attaqué
int current_BE_level; //niveau du bateau ennemi attaqué

boolean generate; //GENERATION ENNEMIS (G5 - combat terrestre)

int[][] map = new int[8][8]; //TABLEAU CARTE (pour génération des deux tableaux ci-dessous)
be[][] BE = new be[8][8]; //TABLEAU POSITION BATEAU ENNEMI (BE = bateau ennemi)
ild[][] ILD = new ild[8][8]; //TABLEAU POSITION ILES (ILD = island)
map Map = new map(); //Map = objet, positions: map.x, map.y (+ naturel que mapx, mapy pour ma part)

ennemi_T ennemi[] = new ennemi_T[3]; //ENNEMIS (G5 - combat terrestre)
player_T pirate_T; //JOUEUR (G5 - combat terrestre)
boolean T_tour_ennemi = false; //TOUR PAR TOUR (G5 - combat terrestre)
int tour_en = 0; //ATTAQUE DES ENNEMIS DANS L4ORDRE
int target = -1; //ENNEMI CHOISI POUR CIBLE
int reset = 0; //REMISE A ZERO POSITION & TARGET

boolean generate_ennemi; //GENERATION ENNEMIS (g3 - combat naval)

int g0_subStatement = 0; //D2BUT DE PARTIE (3 menus: New Game -> Pseudo -> Difficulté)
String pseudo = "Pseudo: "; //CHOIX DU PSEUDO EN DEBUT DE PARTIE

PImage difficulty_1; //DIFFICULT2 1 (g0s2 - menu)
PImage difficulty_2; //DIFFICULT2 2 (g0s2 - menu)
PImage difficulty_3; //DIFFICULT2 3 (g0s2 - menu)
PImage difficulty_4; //DIFFICULT2 4 (g0s2 - menu)
String difficulty_info = ""; //TEXTE DECRIVANT LA DIFFICULTE (g0s2 - menu)
float dr = 1; //dr = DIFFICULTY RATIO = COEFFICIENT MULTIPLICATEUR DE DIFFICULTE (0.8, 1, 1.2, 1.5)

PImage g4_map;
PImage g4_player;
PImage shop1;
PImage itemlv1;
PImage itemlv2;
PImage menubg;
int g4_x = -100;
int g4_y = -400;
int menu;
int boost_degats = 0;
int boost_defense = 0;
shop shop[] = new shop[3];

void setup () {
  size(1600, 800);
  smooth(); //ACTIVE L'ANTI-ALIASING (nécessite plus de performances graphiques / rendu dit 'bicubique')
  sea = loadImage("data/sea.png");
  sea.resize(4000, 4000);

  background=loadImage("data/flotte.png"); //PAS MOI
  background.resize(1600, 800); //DE MEME

  render = loadImage("data/render.jpg");
  render.resize(1600, 800);

  ILDLv1 = loadImage("data/ildlv1.png");
  ILDLv2 = loadImage("data/ildlv2.png");
  ILDLv3 = loadImage("data/ildlv3.png");
  ILDLv100 = loadImage("data/ildlv100.png");


  up = loadImage("data/haut.png");
  up.resize(70, 150);
  down = loadImage("data/bas.png");
  down.resize(70, 150);
  left = loadImage("data/gauche.png");
  left.resize(150, 70);
  right = loadImage("data/droite.png");
  right.resize(150, 70);
  right_combat = loadImage("data/be_r.png");
  right_combat.resize(700, 450);

  bn_ennemi_1 = loadImage("data/be_1.png");
  bn_ennemi_1.resize(300, 300);
  bn_ennemi_2 = loadImage("data/be_2.png");
  bn_ennemi_2.resize(300, 300);
  bn_ennemi_3 = loadImage("data/be_3.png");
  bn_ennemi_3.resize(300, 300);

  bn_ennemi_1_r = loadImage("data/be_1_r.png");
  bn_ennemi_1_r.resize(700, 450);
  bn_ennemi_2_r = loadImage("data/be_2_r.png");
  bn_ennemi_2_r.resize(700, 450);
  bn_ennemi_3_r = loadImage("data/be_3_r.png");
  bn_ennemi_3_r.resize(700, 450);

  ennemi_simple = loadImage("data/ennemi_simple.png");
  ennemi_tank = loadImage("data/ennemi_tank.png");
  ennemi_assassin = loadImage("data/ennemi_assassin.png");
  pirate_vertical = loadImage("data/pirate_vertical.png");
  pirate_vertical.resize(180, 310);
  jungle = loadImage("data/jungle.jpg");
  jungle.resize(1600, 800);

  difficulty_1 = loadImage("data/difficulte_1.png");
  difficulty_1.resize(210, 182);
  difficulty_2 = loadImage("data/difficulte_2.png");
  difficulty_2.resize(210, 182);
  difficulty_3 = loadImage("data/difficulte_3.png");
  difficulty_3.resize(210, 182);
  difficulty_4 = loadImage("data/difficulte_4.png");
  difficulty_4.resize(210, 182);

  g4_map = loadImage("data/ile_principale.png");
  g4_map.resize(3000, 3000);
  g4_player = loadImage("data/pirate_vertical.png");
  g4_player.resize(100, 175);
  shop1 = loadImage("data/shop.png");
  shop1.resize(350, 350);
  itemlv1 = loadImage("data/itemlv1.png");
  itemlv1.resize(300, 220);
  itemlv2 = loadImage("data/itemlv2.png");
  itemlv2.resize(300, 220);
  menubg= loadImage("data/menubg.png");

  fontAmarrer = loadFont("data/Dyuthi-40.vlw");
  fontMenu = loadFont("data/Dyuthi-95.vlw");

  rectMode(CENTER);

  cp5 = new ControlP5(this); //CURSEUR CP5 (g3 - combat naval)
  cp5.setAutoDraw(false);
  cp5.addSlider("puissance")
    .setRange(40, 80)
    .setPosition(25, 85)
    .setSize(100, 30)
    .setValue(puissance);

  for (int i = 0; i <= 7; i++) { //CREATION CARTE (C:pointeur x)
    for (int j = 0; j <= 7; j++) { //(C:pointeur y)
      //println(i + " - " + j);
      map[i][j] = int(random(-1, 3)); //3 valeurs possibles : 1 = bateau, 2 = ile, 3 = vide
      if (map[i][j] == 1) { 
        //println("bateau : "+ i*100 +" - " + j*100);
        BE[i][j] = new be(i, j); //APPELLE LE CONSTRUCTEUR
      }
      if (map[i][j] == 2) {
        //println("ile : "+ i*100 +" - " + j*100);
        ILD[i][j] = new ild(i, j); //APPELLE LE CONSTRUCTEUR
      }
    }
  }

  ILD[1][0] = null; //LAISSE VIDE POUR EVITER GENERATION SUR BATEAU
  BE[1][0] = null; //LAISSE VIDE POUR EVITER GENERATION SUR BATEAU
  ILD[1][0] = new ild(1, 0); //CREE L4ILE PRINCIPALE
  ILD[1][0].level = 100; //ILE PRINCIPALE NIVEAU 100: Impossible dans le constructeur donc ile unique
  ILD[1][0].corner = 1; //SOUS-POSITION DANS LA CASE (x:1,y:0)
  ILD[0][0] = null; //LAISSE VIDE POUR EVITER GENERATION SUR BATEAU
  BE[0][0] = null; //LAISSE VIDE POUR EVITER GENERATION SUR BATEAU

  for (int u = 0; u <= 2; u++) {
    shop[u] = new shop();
  }
  shop[0].achete = false;
  shop[1].achete = false;
  shop[2].achete = false;
}



void draw () {
  if (gameStatement == 0) { //MENU PRINCIPAL
    if (g0_subStatement == 0) { //CHOIX DES OPTIONS (1/3 disponible dans cette version)
      image(render, 0, 0); //BG
      fill(random(0, 255), random(0, 255), random(0, 255)); //MULTICOLOR
      strokeWeight(5);
      line(50, 400, 450, 400); //CASE 1
      line(50, 500, 450, 500); //CASE 1
      line(50, 400, 50, 500); //CASE 1
      line(450, 400, 450, 500); //CASE 1
      textFont(fontMenu);
      textSize(95);
      text("NEW GAME", 70, 475);

      fill(0);
      line(50, 525, 450, 525); //CASE 2
      line(50, 625, 450, 625); //CASE 2
      line(50, 525, 50, 625); //CASE 2
      line(450, 525, 450, 625); //CASE 2
      textSize(90);
      text("SAVES", 145, 595);

      fill(0);
      line(50, 650, 450, 650); //CASE 2
      line(50, 750, 450, 750); //CASE 2
      line(50, 650, 50, 750); //CASE 2
      line(450, 650, 450, 750); //CASE 2
      text("CREDITS", 110, 725);

      if ((mouseX >= 50 && mouseX <= 450 && mouseY >= 400 && mouseY <= 500) && mousePressed == true) { //LANCE LE JEU
        println("NEW GAME");
        g0_subStatement = 1;
      }
      if ((mouseX >= 50 && mouseX <= 450 && mouseY >= 525 && mouseY <= 625) && mousePressed == true) { //COMING SOON
        println("SAVES");
      }
      if ((mouseX >= 50 && mouseX <= 450 && mouseY >= 650 && mouseY <= 750) && mousePressed == true) { //UNIQUEMENT DISPONIBLE POUR LA VERSION EN LIGNE
        println("CREDITS");
      }
    }
    if (g0_subStatement == 1) { //ENTREE PSEUDO
      image(render, 0, 0); //IMAGE DE FOND
      fill(0);
      textSize(100);
      pseudo.toUpperCase();
      fill(255);
      text(pseudo, 50, 400); //PREVISUALISATION PSEUDO

      fill(0, 255, 0);
      rectMode(CORNER);
      rect(1050, 600, 450, 150);
      strokeWeight(5);
      line(1050, 600, 1050, 750); //BARRE GAUCHE BOUTON CONTINUER
      line(1050, 600, 1500, 600); //BARRE HAUTE BOUTON CONTINUER
      line(1500, 600, 1500, 750); //BARRE DROITE BOUTON CONTINUER
      line(1050, 750, 1500, 750); //BARRE BASSE BOUTON CONTINUER
      fill(0);
      textSize(70);
      text("CONTINUER", 1075, 695);
      textSize(20);
      strokeWeight(1);
      fill(255, 0, 0);
      rect(1050, 760, 200, 30); //BOUTON RESET
      fill(0);
      text("RESET", 1060, 780);
      text("X:"+mouseX+" Y:"+mouseY, 0, 20);

      if (mouseX >= 1050 && mouseX <= 1500 && mouseY >= 600 && mouseY <= 750 && mousePressed == true) { //BOUTON CONTINUER
        g0_subStatement = 2;
      }
      if (mouseX >= 1050 && mouseX <= 1250 && mouseY >= 760 && mouseY <= 790 && mousePressed == true) { //BOUTON RESET
        pseudo = "Pseudo: ";
      }
    }

    if (g0_subStatement == 2) { //CHOIX DIFFICULT2
      image(render, 0, 0);
      fill(#D89A14);
      textSize(40);
      text("Choississez une difficulté :", width/2-250, 70);
      fill(255);
      rect(400, 200, 800, 200);
      fill(#B41812);
      textSize(50);
      text(difficulty_info, 410, 230);

      image(difficulty_1, 272, 500);
      image(difficulty_2, 554, 500);
      image(difficulty_3, 836, 500);
      image(difficulty_4, 1118, 500);

      if (mouseX >= 272 && mouseX <= 482 && mouseY >= 500 && mouseY <= 682) {
        difficulty_info = "Mode de jeu simple, pour vous permettre de découvrir le jeu en \ndouceur. Utile lors de la première utilisation du jeu.";
        if (mousePressed == true) {
          dr = 0.8;
          gameStatement = 1;
        }
      } else if (mouseX >= 554 && mouseX <= 764 && mouseY >= 500 && mouseY <= 682) {
        difficulty_info = "Difficulté normale. Vous avez déjà testé le jeu et souhaitez \ndécouvrir de nouvelles facettes du jeu, avec plus de réflexion \nlors des combats.";
        if (mousePressed == true) {
          dr = 1;
          gameStatement = 1;
        }
      } else if (mouseX >= 836 && mouseX <= 1046 && mouseY >= 500 && mouseY <= 682) {
        difficulty_info = "Difficulté difficile. Vous souhaitez mettre vos capacité de Gam3r \nà l'épreuve et sentir l'adrénaline couler dans vos veines: \nCe mode est fait pour vous.";
        if (mousePressed == true) {
          dr = 1.2;
          gameStatement = 1;
        }
      } else if (mouseX >= 1118 && mouseX <= 1328 && mouseY >= 500 && mouseY <= 682) {
        difficulty_info = "Difficulté extreme: Techniquement possible, humainement \nnon. Même les devs ni sont pas parvenus !";
        if (mousePressed == true) {
          dr = 1.5;
          gameStatement = 1;
        }
      } else {
        difficulty_info = "";
      }
    }
  }



  if ( gameStatement == 1) {
    for (int j = -10; j <= 10; j++) { //CREATION BG DE TOUTE LA CARTE (x)
      for (int i = -10; i <= 10; i++) { //CREATION BG DE TOUTE LA CARTE (y)
        image(sea, i*4000+Map.x, j*4000+Map.y); //IMAGE REPETEE
      }
    }

    rectMode(CENTER);
    imageMode(CENTER);
    noStroke();
    fill(boat.shape); //DEBUG INFO



    /* - - - - 4* IMAGE BATEAU (UP, DOWN, LEFT, RIGHT) - - - - - */

    if (boat.shape == 0) {
      image(right, boat.x, boat.y); //DIRECTION DROITE
    }

    if (boat.shape == 1) {
      image(up, boat.x, boat.y); //DIRECTION HAUTE
    }

    if (boat.shape == 2) {
      image(down, boat.x, boat.y); //DIRECTION BAS
    }

    if (boat.shape == 3) {
      image(left, boat.x, boat.y); //DIRECTION GAUCHE
    }
    /* - - - - DISTANCE BATEAU / ILE - - - - - */
    /* verifie la distance en le bateau et chaque ile, et si besoin affiche un message d'action */

    for (int i = 0; i <= 7; i++) { 
      for (int j = 0; j <= 7; j++) {
        if (BE[i][j] != null) { //VERIFIE QUE LA CASE DU TABLEAU BE N'EST PAS VIDE
          BE[i][j].display(Map.x, Map.y); //AFFICHE L'IMAGE DU BATEAU
          if (dist(boat.x, boat.y, BE[i][j].cx, BE[i][j].cy) <= 240 && BE[i][j].display == true) { //VERIFIE QUE LE BATEAU EXISTE ENCORE (display = true) et la distance b/ile
            amarrer(0); //APPELLE LA FONCTION AMARRER AVEC LE PARAMETRE: 0 = attaquer
            if (key == 'A') { //LETTRE DEMANDEE
              println("YE - " + millis() + " - " + i + "," + j); //DEBUG INFO
              index_BE_x = i; //GARDE 'en dur' (cependant dynamique) LA COORDONNEE X DANS SON TABLEAU DU BATEAU ATTAQUE
              index_BE_y = j;//GARDE 'en dur'  LA COORDONNEE Y DANS SON TABLEAU DU BATEAU ATTAQUE
              current_BE_level = BE[i][j].level; //GARDE 'en dur' le niveau du bateau attaqué
              generate_ennemi = true; //GENERATION DU MODE
              gameStatement = 2; //ACTIVATION DU MODE
            }
          }
        }

        if (ILD[i][j] != null) { //VERIFIE QUE LA CASE DU TABLEAU CONTIENT UNE ILE
          ILD[i][j].display(Map.x, Map.y); //AFFICHE L'ILE
          if (dist(boat.x, boat.y, ILD[i][j].cx, ILD[i][j].cy) <= 450 && ILD[i][j].display == true) {  //VERIFIE LA DISTANCE ILE/BATEAU POUR SAVOIR S'IL FAUT AFFICHER UNE ACTION
            amarrer(1); //APPELLE LA FONCTION AMARRER AVEC LE PARAMETRE: 1 = acoster
            if (key == 'A' && ILD[i][j].level != 100) { //VERIFIE QUE L'ILE N'EST PAS PRINCIPALE
              combat_terrestre(i, j, ILD[i][j].level); //APPELLE LA FONCTION combat_terrestre(); avec les 3 paramètres demandés
            }

            if (key == 'A' && ILD[i][j].level == 100) { //VERIFIE QUE L'ILE EST L'ILE PRINCIPALE
              gameStatement = 4; //ACCOSTAGE DE L'ILE PRINCIPALE POUR ACHAT, AMELIORATIONS, ...
            }
          }
        }
      }
    }
    stroke(255, 0, 0); //COULEUR DE BORDURE (rect, square, ...)


    /* - - QUETES - - */

    textSize(30);
    fill(255);
    text("OBJECTIF: ALLEZ EN (10;0)", 1300, 25); //LIGNE AFFICHAQUE QUETE
    textSize(25);
    text("VOUS ETES EN: ("+-1*Map.x/100+";"+-1*Map.y/100+")", 1300, 55); //AIDE A LA QUETE
  }




  if (gameStatement == 2) { //COMBAT NAVAL
    if (generate_ennemi) { //GENERATION ON
      sante_ennemi = 100; //REMET L'ENNEMI A 100PV (dans le cas où il y aurait déjà eu un combat auparavant)
      generate_ennemi = false; //GENERATION OFF (tournée 1 seule fois)
    } else {
    }
    image(background, 0, 0); //AFFICHE L'IMAGE DE FOND 
    cp5.draw(); //AFFICHE LE CURSEUR CP5 pour définir la puissance
    rectMode(CORNER);
    imageMode(CORNER);
    boat.x = 200; //AFFICHE LE BATEAU A SA BONNE POSITION
    boat.y = 550; //AFFICHE LA BATEAU A SA BONNE POSITION

    image(right_combat, -50, 270); //IMAGE DU BATEAU DE COT2
    text("X:"+mouseX+" - Y:"+mouseY, 200, 200); //DEBUG INFO

    if (current_BE_level == 1) { //SI ENNEMI LV1 = image ennemi de coté : VERTE
      image(bn_ennemi_1_r, 950, 300);
    }
    if (current_BE_level == 2) { //SI ENNEMI LV2 = image ennemi de coté : BLEU
      image(bn_ennemi_2_r, 950, 300);
    }
    if (current_BE_level == 3) { //SI ENNEMI LV3 = image ennemi de coté : ROUGE
      image(bn_ennemi_3_r, 950, 300);
    }

    fill(124, 27, 27); 
    rect(1373, 23, 204, 44); //ENTOURAGE RECTANGLE VIE ENNEMI
    fill(255, 50, 50);
    rect(1375, 25, sante_ennemi*2, 40); //RECTANGLE VIE ENNEMI
    fill(0);
    textFont(fontMenu);
    textSize(40);
    text("VIE", 1380, 57);

    /* - - - CANNONS - - - */

    pushMatrix(); //ENREGISTRE LES COORDONNEES
    fill(0, 255, 0);
    translate(390, 550); //DEPLACE LE REFERENTIEL
    rotate(-PI/4);  //ROTATION CANNON
    rect(0, 0, 50, 20); //TAILLE CANNON
    popMatrix();  //RESTAURE LES COORDONNEES INITIALES DU REFERENTIEL

    pushMatrix(); //ENREGISTRE LES COORDONNEES
    fill(0, 255, 0);
    translate(1160, 610); //DEPLACE LE REFERENTIEL
    rotate(-3*PI/4);  //ROTATION CANNON
    rect(0, 0, 50, 20); //TAILLE CANNON
    popMatrix();  //RESTAURE LES COORDONNEES INITIALES DU REFERENTIEL
    if (tour_ennemi == false) { //A NOTRE TOUR DE JOUER
      fill(0);
      ellipse(bouletX, bouletY, 20, 20); //DESSINE LE BOULET

      //PESANTEUR
      dy = dy+ pesanteur;

      //FROTTEMENTS DE L'AIR
      dx = dx*frottement;
      dy = dy*frottement;

      //REDEFINITION DES COORDONN2ES DU BOULET A CHAQUE IMAGE (dx calcule le déplacement à effectuer en X, de même dy / y)
      bouletX = bouletX+dx;
      bouletY = bouletY+dy;


      if ((bouletX >= 1150 && bouletX <= width) && (bouletY >= 550 && bouletY <= 600)) { //HIBOX N°1 : VOILE = DEGAT FAIBLE
        bouletY = 4000; //RETIRE LE BOULET DE L'IMAGE (méthode brutale mais pas d'autre choix ...)
        tour_ennemi = true; //FIN DU TOUR
        sante_ennemi -= 40; //INFLIGE DES DEGATS FAIBLES
      }
      if ((bouletX >= 1150 && bouletX <= width) && (bouletY >= 600 && bouletY <= 650)) { //HIBOX N°2 : PONT = DEGAT MOYEN
        bouletY = 4000; //RETIRE LE BOULET DE L'IMAGE (méthode brutale mais pas d'autre choix ...)
        tour_ennemi = true; //FIN DU TOUR
        sante_ennemi -= 60; //INFLIGE DES DEGATS MOYENS
      }
      if ((bouletX >= 1150 && bouletX <= width) && (bouletY >= 650 && bouletY <= 750)) { //HIBOX N°3 : COQUE = DEGAT FORT
        bouletY = 4000; //RETIRE LE BOULET DE L'IMAGE (méthode brutale mais pas d'autre choix ...)
        tour_ennemi = true; //FIN DU TOUR
        sante_ennemi -= 80; //INFLIGE DES DEGATS FORTS
      }
      if (bouletY >= 850 && bouletX < 1600) { //CIBLE RATEE
        bouletX = 1700;
        tour_ennemi = true;
      }
    }

    if (tour_ennemi == true) { //TOUR ENNEMI
      fill(255, 0, 0); //COULEUR BOULET ENNEMI (R pour différence avec N(le notre))
      ellipse(en_bouletX, en_bouletY, 20, 20); //BOULET ENNEMI

      /* CALCUL POSITION BOULET - voir + haut pour explications détaillées */
      /* + HITBOXES */

      en_dy = en_dy + pesanteur; 
      en_dx = en_dx*frottement;
      en_dy = en_dy*frottement;
      en_bouletX = en_bouletX+en_dx;
      en_bouletY = en_bouletY+en_dy;

      if ((en_bouletX >= 50 && en_bouletX <= 450) && (en_bouletY >= 550 && en_bouletY <= 600)) {
        en_bouletY = 4000;
        tour_ennemi = false;
        boat.sante -= 40*dr;
      }
      if ((en_bouletX >= 50 && en_bouletX <= 450) && (en_bouletY >= 600 && en_bouletY <= 650)) {
        en_bouletY = 4000;
        tour_ennemi = false;
        boat.sante -= 60*dr;
      }
      if ((en_bouletX >= 50 && en_bouletX <= 450) && (en_bouletY >= 650 && en_bouletY <= 750)) {
        en_bouletY = 4000;
        tour_ennemi = false;
        boat.sante -= 80*dr;
      }
      if (en_bouletY >= 850 && en_bouletX < 1600) { 
        en_bouletY = 4000; 
        en_bouletX = 1700;
        tour_ennemi = false;
      }
    }

    if (sante_ennemi <= 0) { //SI L4ENNEMI PERD
      timerMessage("Félicitations ! Vous avez gagné: 1000$", 2000);
      money += 1000; //BUTIN GAGN2
      boat.x = 200; 
      boat.y = 400;
      BE[index_BE_x][index_BE_y].display = false; //SUPPRESSION "VIRTUELLE" DU BATEAU DE LA CARTE
      boat.mouvement = true; //DEBUG INFO
    }

    if (boat.sante <= 0) { //SI NOUS PERDONS
      timerMessage("Perdu ! retour à la carte", 2000);
    }
  }

  if (gameStatement == 1 || gameStatement == 2 || gameStatement == 4) { //SI G1 OU G2 OU G4 AFFICHAGE BARRE DE VIE / ARGENT
    fill(124, 27, 27);
    rect(23, 23, 204, 44); //RECTANGLE ENTOURAGE VIE
    fill(255, 50, 50);
    rect(25, 25, boat.sante*2, 40); //RECTANGLE VIE
    fill(0);
    textFont(fontMenu);
    textSize(40);
    text("VIE", 30, 57);

    fill(255);
    textSize(30);
    text("Vous avez : "+money+"$", 30, 117); //INDICATIF ARGENT
  }

  if (gameStatement != 2) { //SI NOUS NE SOMMES PAS EN COMBAT NAVAL
    if (boat.sante <= 100) { // ET QUE LA SANTE DU BATEAU N'EST PAS AU MAX.
      if (millis()%2000 < 10) { //GAIN DE 10PV TOUTES LES 2 SECONDES
        boat.sante += 10;
        if (boat.sante > 100) { //VERIFICATION DANS LE CAS DE BUG (parfois stuttering à cause de la RAM et de la CG)
          boat.sante = 100; //REMISE A 100PV SI > 100PV
        }
      }
    }
  }



  if (gameStatement == 4) { //ILE PRINCIPALE
    imageMode(CORNER);
    image(g4_map, g4_x, g4_y); //AFFICHAGE CARTE (coordonnées dynamiques)
    image(g4_player, 100, 350); //AFFICHAGE JOUEUR (coordonnées fixes)
    text("X:"+mouseX+" Y:"+mouseY, 10, 20); //DEBUG INFO
    text("GX:"+g4_x+" GY:"+g4_y, 10, 40); //DEBUG INFO
    text("money"+money, 10, 60); //DEBUG INFO
    if (g4_x >= 0) g4_x = 0; //EVITER UNE SORTIE DE L4IMAGE (/carte)
    if (g4_y >= 0) g4_y = 0; //EVITER UNE SORTIE DE L4IMAGE (/carte)
    if (g4_x <= -2400) g4_x = 2400; //EVITER UNE SORTIE DE L4IMAGE (/carte)
    if (g4_y <= -1700) g4_y = 1700; //EVITER UNE SORTIE DE L4IMAGE (/carte)

    if (dist(g4_x, g4_y, -350, -320) <= 200) { //VERIFICATION CIRCULAIRE DISTANCE PERSONNAGE / 1ER SHOP
      if (shop[0].achete == false) { //SI LE SHOP N'EST PAS ENCORE ACHETE
        text("APPUYEZ SUR B pour acheter ce batiment: \n\n\nAmelioration du bateau \n\n\nCout: 2000$", 500, 100); //PROPOSITION D4ACHAT
        if (key == 'B' && money >= 2000) { //EVENT LISTENER D4ACTION
          money -= 2000; //PRIX DU BATIMENT
          shop[0].achete = true; //BATIMENT ACHETE
        }
      } else if (shop[0].achete == true) { //SI BATIMENT ACHETE
        text("APPUYEZ SUR A pour entrer dans ce batiment: \nAmelioration du personnage", 500, 100); //PROPOSITION D4NENTRER DANS LE MENU
        if (key == 'A') { //ACTION A EFFECTUER POUR ENTRER DANS LE MENU
          menu = 1;
        }
      }
    }
    if (shop[0].achete == true) { //SI BATIMENT 1 EST ACHETE
      image (shop1, g4_x+440, g4_y+330); //AFFICHAGE D'UNE IMAGE AU LIEU DU CARRE NOIR
    }

    if (menu == 1) { //MENU BATIMENT 1 OUVERT
      image(menubg, 0, 0); //INTERFACE (GUI) DE BASE
      fill(255);
      text("X:"+mouseX+" Y:"+mouseY, 10, 40); //DEBUG INFO
      fill(0);
      textSize(60);
      text(pseudo, 20, 395); //AFFICHAGE PSEUDO DANS LA CASE BLANC
      fill(255);
      textSize(30);
      text("MONEY : "+money, 25, 480); //AFFICHAGE ARGENT SOUS LA PARTIE GRISE

      if (shop[0].item1 == true) { //SI ITEM 1 ACHETE
        rectMode(CORNER); 
        fill(0, 255, 0); //VERT
        rect(750, 60, 320, 240); //AFFICHER UN RECTANGLE VERT DERRIERE L'IMAGE
      } else if (shop[0].item1 == false && mouseX >= 750 && mouseY >= 60 && mouseX <= 1070 && mouseY <= 300 && mousePressed == true && money >= 2000) { //POSSIBILITE D4ACHAT
        money -= 2000; //PAIEMENT
        boost_degats += 20; //AJOUT DU BOOST ACHETE
        shop[0].item1 = true; //ITEM 1 = ACHETE
      }
      if (shop[0].item1 == true) { //ITEM 1 DOIT ETRE ACHETE POUR POUVOIR ACHETER LE SECOND ITEM DE LA LIGNE
        if (shop[0].item1l1 == true) { //SI SECOND ITEM, LIGNE 1 EST ACHETE
          rectMode(CORNER); 
          fill(0, 255, 0); //VERT
          rect(1150, 60, 320, 240); //AFFICHER UN RECTANGLE VERT DERRIERE L'IMAGE
        } else if (shop[0].item1l1 == false && mouseX >= 1150 && mouseY >= 70 && mouseX <= 1470 && mouseY <= 300 && mousePressed == true && money >= 2000) { //POSSIBILITE D4ACHAT
          money -= 2000;//PAIEMENT
          boost_degats += 20; //AJOUT DU BOOST ACHETE
          shop[0].item1l1 = true;//SECOND ITEM, LIGNE 1 = ACHETE
        }
      }

      if (shop[0].item2 == true) { //MEME MODELE QUE PRECEDEMMENT
        rectMode(CORNER);
        fill(0, 255, 0);
        rect(750, 450, 320, 240);
      } else if (shop[0].item2 == false && mouseX >= 750 && mouseY >= 450 && mouseX <= 1070 && mouseY <= 700 && mousePressed == true && money >= 2000) {
        money -= 2000;
        boost_defense += 20;
        shop[0].item2 = true;
      }
      if (shop[0].item2 == true) { 
        if (shop[0].item2l1 == true) { 
          rectMode(CORNER);
          fill(0, 255, 0);
          rect(1150, 450, 320, 240);
        } else if (shop[0].item2l1 == false && mouseX >= 1150 && mouseY >= 450 && mouseX <= 1470 && mouseY <= 700 && mousePressed == true && money >= 2000) {
          money -= 2000;
          boost_defense += 20;
          shop[0].item2l1 = true;
        }
      }

      image(itemlv1, 750, 60); //ITEM 1 LIGNE 1
      image(itemlv2, 1150, 70); //ITEM 2 LIGNE 1

      image(itemlv1, 750, 450); //ITEM 1 LIGNE 2
      image(itemlv2, 1150, 450); //ITEM 2 LIGNE 2

      textSize(30);
      text("BOOST DEGATS:    +"+boost_degats+"pts", 25, 530); //BONUS ACHETE
      text("BOOST DEFENSE:    +"+boost_defense+"pts", 25, 560); //BONUS ACHETE

      fill(255, 0, 0);
      rect(1550, 750, 50, 50); //BOUTON ROUGE POUR SORTIR DU MENU
      if (mouseX >= 1550 && mouseY >= 750) menu = -1; //QUITTER LE MENU
    } else {
    }

    if (g4_x >= -10) { 
      gameStatement = 1; //SI LE JOUEUR VA A L'EXTREME DROITE DE LA CARTE, RETOUR A LA NAVIGUATION
      g4_x = 100; //RESET DE LA POSITION POUR EVITER UNE BOUCLE INFINI D4ENTREE / SORTIE
    }
  }


  if (gameStatement == 6) { //COMBAT TERRESTRE
    imageMode(CORNER);
    rectMode(CORNER);
    if (generate == true) { //GENERATION ACTIVE
      if (current_ILD_level == 1) { //SI ILE DE NIVEAU 1 = 3 ENNEMIS SIMPLES
        ennemi[0] = new ennemi_T(1, 1); //__constuct : (position, possible skill). Si 2ème paramètre = 1 : simple, = 2 : tank,  .= 3 : assassin
        ennemi[1] = new ennemi_T(2, 1);
        ennemi[2] = new ennemi_T(3, 1);
      } else if (current_ILD_level == 2) { //SI ILE DE NIVEAU 2 = 2 ENNEMIS SIMPLES & 1 ENNEMIS ALEATOIRE (simple, tank ou assassin)
        ennemi[0] = new ennemi_T(1, 1);
        ennemi[1] = new ennemi_T(2, int(random(1, 4)));
        ennemi[2] = new ennemi_T(3, 1);
      } else if (current_ILD_level == 3) { //SI ILE DE NIVEAU 3 = 3 ENNEMIS ALEATOIRES (simple, tank ou assassin)
        ennemi[0] = new ennemi_T(1, int(random(1, 4)));
        ennemi[1] = new ennemi_T(2, int(random(1, 4)));
        ennemi[2] = new ennemi_T(3, int(random(1, 4)));
      }
      pirate_T = null; //VIDE LA VARIABLE
      pirate_T = new player_T(); //RECREE LE JOUEUR AVEC LE CONSTRUCTEUR
      generate = false; //FIN DE LA GENERATION & SORTIE DE LA BOUCLE
    }

    if (ennemi[0].alive == false && ennemi[1].alive == false && ennemi[2].alive == false) { //SI 3 ENNEMIS = MORTS, SUPPRESSION ILE & RETOUR A LA NAVIGUATION
      ILD[index_ILD_x][index_ILD_y].display = false;
      if (current_ILD_level == 1) { //SI ILE LV1, +1000$
        money += 1000;
        gain = 1000;
      }
      if (current_ILD_level == 2) { //SI ILE LV2,  +1500$
        money += 1500;
        gain = 1500;
      }
      if (current_ILD_level == 3) { //SI ILE LV3,  +2500$
        money += 2500;
        gain = 2500;
      }
      timerMessage("Félicitations, vous avez gagné : "+gain, 2000);
    }

    translate(0, 0); //REMET A 0 LE REPERE (obligatoire, pourquoi ? car parfois bugs incompréhensibles ...)
    image(jungle, 0, 0); //AFFICHAGE FOND DE COMBAT
    textSize(40);
    text("target:"+target+"pirate_Tx: "+pirate_T.x, 850, 400); //DEBUG INFO

    if (T_tour_ennemi == false) { //A NOTRE TOUR DE JOUER
      if (mousePressed == true) {
        if (mouseX >= 1150 && mouseX <= 1250 && mouseY >= 250 && mouseY <= 550) target = 1; //CHOIX DE LA CIBLE 1
        if (mouseX >= 1250 && mouseX <= 1350 && mouseY >= 350 && mouseY <= 650) target = 2; //CHOIX DE LA CIBLE 2
        if (mouseX >= 1350 && mouseX <= 1450 && mouseY >= 450 && mouseY <= 750) target = 3; //CHOIX DE LA CIBLE 3
      }

      if (frameCount%6 == 0) { // 1 à 30 /6 qui retourne un entier = 5 possibilités (6,12,18,24,30), donc 5 fois par seconde cette boucle s'éxecute
        if (pirate_T.x <= 1100 && target ==1) { //COEFFICIENT DIRECTEUR
          pirate_T.x += 30;
          pirate_T.y += -5.6;
        }

        if (pirate_T.x <= 1200 && target == 2) { //COEFFICIENT DIRECTEUR
          pirate_T.x += 30;
          pirate_T.y += -2.56;
        }
        if (pirate_T.x <= 1300 && target == 3) { //COEFFICIENT DIRECTEUR
          pirate_T.x += 30;
          pirate_T.y += 0;
        }
      }

      if (target == 1 && pirate_T.x >= 1090) { //SI CIBLE = 1 & position finale trajectoire
        ennemi[0].sante -= 60+boost_degats; //INFLIGUE DEGATS
        delay(1000); //DELAI
        reset = 1; //LANCE LA BOUCLE RESET (ci-dessous)
      }
      if (target == 2 && pirate_T.x >= 1190) { //SI CIBLE = 2 & position finale trajectoire
        ennemi[1].sante -= 60+boost_degats; //INFLIGUE DEGATS
        delay(1000); //DELAI
        reset = 1; //LANCE LA BOUCLE RESET (ci-dessous)
      }
      if (target == 3 && pirate_T.x >= 1290) { //SI CIBLE = 3 & position finale trajectoire
        ennemi[2].sante -= 60+boost_degats; //INFLIGUE DEGATS
        delay(1000); //DELAI
        reset = 1; //LANCE LA BOUCLE RESET (ci-dessous)
      }

      if (reset == 1) { //BOUCLE RESET (ne tourne qu'une fois lorsque activée)
        pirate_T.x = 80; //remet le joueur en position de départ (X)
        pirate_T.y = 450; //remet le joueur en position de départ (Y)
        target = -1; //réinitialise la target
        reset = 2; //empeche la boucle de re-tourner
        T_tour_ennemi = true; //TOUR ENNEMI ENCLENCH2
      }
    }

    if (T_tour_ennemi) { //TOUR ENNEMI

      if (tour_en == 0 && ennemi[0].sante <= 0) { //SI L4ENNEMI DU HAUT EST MORT, PASSAGE DIRECT A L4ENNEMI DU MILIEU
        tour_en = 1;
      }
      if (tour_en == 1 && ennemi[1].sante <= 0) { //SI L4ENNEMI DU MILEU EST MORT, PASSAGE DIRECT A L4ENNEMI DU BAS
        tour_en = 2;
      }
      if (tour_en == 2 && ennemi[2].sante <= 0) { //SI L4ENNEMI DU BAS EST MORT, FIN DU TOUR ENNEMI (CAR BOUCLE = haut en bas), PASSAGE DIRECT A L4ENNEMI DU HAUT
        T_tour_ennemi = false;
        tour_en = 0;
      }

      if (frameCount%6 == 0) { //COEFFICIENTS DIRECTEURS (voir + haut pour explications détaillées) sauf que cette fois, c'est la trajectoire inverse
        if (tour_en == 0) {
          ennemi[0].x -= 20;
          ennemi[0].y += 5.6;
        }
        if (tour_en == 1) {
          ennemi[1].x -= 20;
          ennemi[1].y += 2.56;
        }
        if (tour_en == 2) {
          ennemi[2].x -= 20;
          ennemi[2].y -= 0;
        }
      }


      if (ennemi[0].x <= 250) { //SI L'ENNEMI DU HAUT ARRIVE A LA FIN DE SA TRAJECTOIRE
        delay(200); //LEGER DELAI
        tour_en = 1; //TOUR ENNEMI = MILIEU
        ennemi[0].x = 1150; //RESET X
        ennemi[0].y = 250; //RESET Y
        if (ennemi[0].skill == 1) { //SI ENNEMI DU HAUT = SIMPLE
          pirate_T.life -= 25*dr; //DEGAT DE REFERENCE 25 (dépends de la difficulté choisie sinon)
        }
        if (ennemi[0].skill == 2) { //SI ENNEMI DU HAUT = TANK
          pirate_T.life -= 15*dr; //DEGAT DE REFERENCE 15 (dépends de la difficulté choisie sinon)
        }
        if (ennemi[0].skill == 3) { //SI ENNEMI DU HAUT = ASSASSIN
          pirate_T.life -= 40*dr; //DEGAT DE REFERENCE 40 (dépends de la difficulté choisie sinon)
        }
      }

      if (ennemi[1].x <= 250) { //SI L'ENNEMI DU MILEU ARRIVE A LA FIN DE SA TRAJECTOIRE
        delay(200); //LEGER DELAI
        tour_en = 2; //TOUR ENNEMI = BAS
        ennemi[1].x = 1250; //RESET X
        ennemi[1].y = 350; //RESET Y
        if (ennemi[1].skill == 1) {
          pirate_T.life -= 25;
        }
        if (ennemi[1].skill == 2) {
          pirate_T.life -= 15;
        }
        if (ennemi[1].skill == 3) {
          pirate_T.life -= 40;
        }
      }

      if (ennemi[2].x <= 250) {
        delay(200);
        tour_en = 0;
        ennemi[2].x = 1350;
        ennemi[2].y = 450;
        if (ennemi[2].skill == 1) {
          pirate_T.life -= 25;
        }
        if (ennemi[2].skill == 2) {
          pirate_T.life -= 15;
        }
        if (ennemi[2].skill == 3) {
          pirate_T.life -= 40;
        }
        T_tour_ennemi = false;
      }
    }

    ennemi[0].display(ennemi[0].x, ennemi[0].y);
    ennemi[1].display(ennemi[1].x, ennemi[1].y);
    ennemi[2].display(ennemi[2].x, ennemi[2].y);
    pirate_T.display(pirate_T.x, pirate_T.y);

    if (pirate_T.life <= 190) {
      if (frameCount%1200  == 0) {
        pirate_T.life += 25;
      }
    }

    if (pirate_T.life <= 0) {
      timerMessage("Vous avez perdu, retour à la carte", 2000);
    }
  }
}


void keyPressed() {
  if (gameStatement == 0 && g0_subStatement == 1) {
    if (key == 'a' || key == 'b' || key == 'c' || key == 'd' || key == 'e' || key == 'f' || key == 'g' || key == 'h' || key == 'i' || 
      key == 'j' || key == 'k' || key == 'l' || key == 'm' || key == 'n' || key == 'o' || key == 'p' || key == 'q' || key == 'r' || key == 's' 
      || key == 't' || key == 'u' || key == 'v' || key == 'w' || key == 'x' || key == 'y' || key == 'z' || key == '_' || key == '-' || key == 'A' || key == 'B' 
      || key == 'C' || key == 'D' || key == 'E' || key == 'F' || key == 'G' || key == 'H' || key == 'I' || key == 'J' || key == 'K' || key == 'L' 
      || key == 'M' || key == 'N' || key == 'O' || key == 'P' || key == 'Q' || key == 'R' || key == 'S' || key == 'T' || key == 'U' || key == 'V' 
      || key == 'W' || key == 'X' || key == 'Y' || key == 'Z') { 
      pseudo += key;
    }
  }

  if (boat.mouvement) {
    if (keyCode == UP) {
      boat.shape = 1;
      Map.y += speed;
    }

    if (keyCode == DOWN) { 
      boat.shape = 2;
      Map.y -= speed;
    }

    if (keyCode == LEFT) { 
      boat.shape = 3;
      Map.x += speed;
    }

    if (keyCode == RIGHT) { 
      boat.shape = 0;
      Map.x -= speed;
    }
  }

  if (gameStatement == 2 && tour_ennemi == false && key == ' ') {

    //POSITION DE DEPART DU BOULET
    bouletX = 365 + 50 * cos(-angle*PI/180);
    bouletY = 520 + 50 * sin(-angle*PI/180);

    //VITESSE INITIALE
    dx = puissance * cos(-angle*PI/180);
    dy = puissance * sin(-angle*PI/180);
  }

  if (gameStatement == 2 && tour_ennemi == true && key == ' ') { //CALCULS RAPIDES POUR BOULET ENNEMI
    float en_puissance = random(30, 80);
    en_bouletX = 1240 + 50 * cos(-en_angle*PI/180);
    en_bouletY = 560 + 50 * sin(-en_angle*PI/180);
    en_dx = en_puissance * cos(-en_angle*PI/180);
    en_dy = en_puissance * sin(-en_angle*PI/180);
  }

  if (gameStatement == 4) { //DEPLACEMENT SUR LA CARTE DE L'ILE PRINCIPALE
    if (keyCode == UP) g4_y += 10;
    if (keyCode == DOWN) g4_y -= 10;
    if (keyCode == LEFT) g4_x += 10;
    if (keyCode == RIGHT) g4_x -= 10;
  }
}



void amarrer (int type) { //MESSAGE A AFFICHER POUR DES ACTIONS

  /* VARIABLES LOCALES:
   type = 0 si bateau, 1 si ile
   */
  int timer = millis()/1000; //TIMER (par seconde)
  if (type == 0) { //DISTANCE BATEAU / BE faible
    if (timer%2 == 0) { //AFFICHAGE 0.5s TOUTES LES SECONDES
      fill(255, 0, 0); //ROUGE
      textSize(60);
      textFont(fontAmarrer);
      text("APPUYEZ SUR 'A' POUR ATTAQUER", 500, 50); //MESSAGE
    }
  }

  if (type == 1) { //DISTANCE BATEAU / ILD faible
    if (timer%2 == 0) { //AFFICHAGE 0.5s TOUTES LES SECONDES
      fill(255, 0, 0); //ROUGE
      textSize(60);
      textFont(fontAmarrer);
      text("APPUYEZ SUR 'A' POUR AMARRER", 500, 50); //MESSAGE
    }
  }

  if (timer%2 != 0) { //REDUCTION TAILLE MESSAGE (invisible, pour eviter suppression et ameliorer les performances)
    textSize(1);
  }
}


void combat_naval(int i, int j, int level) { //DEFINIS LES VARIABLES
  level_en = level;
  i_en = i;
  j_en = j;
}

void combat_terrestre (int i, int j, int level) { //PERMET DE DEFINIR LES 'constantes de combat'
  generate = true; //LANCE LA GENERATION ENNEMI
  index_ILD_x = i; //VOIR DECLARATION
  index_ILD_y = j; //VOIR DECLARATION
  current_ILD_level = level; //VOIR DECLARATION
  gameStatement = 6; //LANCEMENT MODE COMBAT DANS LA JUNGLE
}

void timerMessage(String message, int timer) { //AFFICHAGE MESSAGE & DELAY
  gameStatement = 1; //RETOUR A LA NAVIGATION
  textSize(40);
  text(message, 600, 100); //AFFICHE LE MESSAGE
  delay(timer); //DUREE D'AFFICHAGE ET DE PAUSE DU JEU
}