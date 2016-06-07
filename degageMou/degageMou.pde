import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
// A RECUPERER: numéro objet (de 1 à 4) et boolean de chacun
import oscP5.*;
import netP5.*;

int nombreSorties = 16;
OscP5 oscP5;
Minim minim;
AudioPlayer[] player = new AudioPlayer[nombreSorties];
AudioPlayer[] poirot = new AudioPlayer[16];

//int nbrSortie;
Sortie[] sortie = new Sortie[nombreSorties]; //EFFET

int nombreObjets;
//RECUPERE OSC 
int[] binaire = new int[nombreSorties]; // Renvoi information couleur (noir ou blanc)
int[] bouge = new int[nombreSorties]; // renvoi si ça bouge ou non
float[] tauxMouv = new float[nombreSorties];

boolean ok = false;//POUR EMPECHER DE JOUER PLUSIEURS SON EN MM TEMPS
boolean validation = true; //PENSER A REPASSER EN TRUE
int signature = 0;//POUR LECTURE MOTIF… OSEF

int cursor;
int[] controle = new int[2];
boolean seJoue = false;
PImage[] anim = new PImage[3];

void setup() {
  size(640, 420);
  oscP5 = new OscP5(this, 7000);
  minim = new Minim(this);
  for (int i = 0; i < player.length - 2; i++) {
    player[i] = minim.loadFile("z" + i + ".wav");
  }
  player[3] = minim.loadFile("z4.mp3");
  player[4] = minim.loadFile("z5.mp3");

  for (int i = 0; i < poirot.length; i++) {
    poirot[i] = minim.loadFile(i + ".wav");
  }

  for (int i = 0; i < sortie.length; i++) {
    sortie[i] = new Sortie();
  }
  for (int i = 0; i < anim.length; i++) {
    anim[i] = loadImage(i + ".jpg");
  }
}

void draw() {
  background(120);
  println(cursor);
  if (int(bouge[0]) >= 1 && poirot[cursor].isPlaying() == false) {
    cursor = int(random(16));
    poirot[cursor].play(1);
  }
  for(int i = 0; i < poirot.length; i++){
    if(poirot[i].position() >= poirot[i].length()-1){
      poirot[i].cue(0);
    }
  }
  animationBouche();
}

void animationBouche() {
  int choix = 0;
  if (poirot[cursor].isPlaying()) {
    for(int i = 0; i < poirot[cursor].bufferSize()-1; i++){
       choix = int(map(poirot[cursor].left.get(i), -0.99, 1, 0, 2));
    }
    image(anim[choix], 0, 0);
  } else {
    image(anim[0], 0, 0);
  }
}

//RECUPERE INFO (BOUGE OU NB?)
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("nbrObj") == true) {
    nombreObjets = theOscMessage.get(0).intValue();
  }
  for (int i = 0; i < nombreObjets; i++) {
    if (theOscMessage.checkAddrPattern(str(i)) == true) {
      binaire[i] = theOscMessage.get(0).intValue(); // couleur NB
      bouge[i] = theOscMessage.get(1).intValue(); // Mouvement
      tauxMouv[i] = theOscMessage.get(2).floatValue(); // Mouvement
    }
  }
}

void reperes() {
  stroke(255, 255, 0);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
}