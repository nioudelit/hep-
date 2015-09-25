//Prototype application de mapping d'actions
//frame differencing et taux luminosité
//1. gerer importation fichier
//2. lecture de ces fichiers avec une touche
//3. assignation de ces fichiers sur les zones (lien ou interface)
// epurer le code:
//4. faire design interface en orientee objet (pour text et ergo)
//5. commenter pour modifier plus facilement


//A FAIRE: RENVOYER : Numéro de l'objet + boolean noir/blanc

import processing.video.*;
import controlP5.*;
import oscP5.*;
import netP5.*;

//OBJETS OSC
OscP5 oscP5;
NetAddress myRemoteLocation;

//Gestion des Zones de detection
Zone[] maZone = new Zone[0];

Capture cam;
PImage camRetouchee;

ControlP5 cp5;
Slider abc;

//Details d'ordre relativement esthétique
PImage ban;
int dec = 25; 
int posX = 60;
PImage gris;

//GUI
int taille = 100;
int seuilBruit = 10;
float contrastou = 1;
float PasseBas = 0.5; float DeriveePB = 0.3;
int positionX; int positionY;
float mouvementFondu; float mouvementFonduSuper;
boolean thre = false;

void setup (){
  size(640 + 200, 480 + 150, P2D);
  background(0);
  
  oscP5 = new OscP5(this, 9000);
  myRemoteLocation = new NetAddress("127.0.0.1", 7000); //192.168.1.255    192.168.1.12  127.0.0.1
  
  camRetouchee = new PImage(640, 480);
  
  ban = loadImage("purin.png");
  gris = createImage(1000, 480, RGB);
  for(int i = 0; i < gris.pixels.length; i++){
    gris.pixels[i] = color(127);
  }
  
  image(ban, 620, 0);
  //Barre grise du bas.
  fill(127); noStroke();
  rect(0, 480, width, 200);
  fill(255);
  //text("ICI GESTION FICHIERS", 50, 500);
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[12]);
  cam.start();
  GUI();  //navigation
  
  //######################################################
      
  text("CLIK SUR'ESPACE S'TU VEUX AJOUTER UNE ZONE vindieu",660, 270, 200, 200);
  maZone = new Zone[0];
}

void draw() {
  if(cam.available()){
    cam.read();
  }
  
  float contrast = contrastou;
  contrasteLumino(cam, camRetouchee, contrast, 1);
  image(camRetouchee, 0, 0);
  filter(GRAY);
  //image(cam, 0, 0);
  
  image(cam, 640 + dec, 320, cam.width/4, cam.height/4);
  //image(gris,0, 480);
  fill(0,255,0);
  rect(positionX/4 + 640+dec, positionY/4 +320, taille/4, taille/4);
  
  for(int i = 0; i < maZone.length; i++){
    maZone[i].afficher(127);
    maZone[i].deplacer();
    maZone[i].frameDiff();
    maZone[i].retourMouvement(i+1);
    maZone[i].seuilBlanc();
    maZone[i].envoi(i);
  }
  //affiche un voyant pour vérifier si ça tient le coup
  bouton();
  latence();
  //println(threshold());
}

void keyReleased(){
  if(key == ' '){
    new Zone(positionX, positionY, taille, taille, 255);
    //sons[0].play();
  }
  if(key == 't' || key == 'T'){
    thre =! thre;
  }
}
