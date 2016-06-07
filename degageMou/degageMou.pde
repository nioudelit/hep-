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

boolean ok = false;//POUR EMPECHER DE JOUER PLUSIEURS SON EN MM TEMPS
boolean validation = true; //PENSER A REPASSER EN TRUE
int signature = 0;//POUR LECTURE MOTIF… OSEF

void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 7000);
  minim = new Minim(this);
  for(int i = 0; i < player.length - 2; i++){
    player[i] = minim.loadFile("z" + i + ".wav");
  }
  player[3] = minim.loadFile("z4.mp3");
  player[4] = minim.loadFile("z5.mp3");
  
  for(int i = 0; i < poirot.length; i++){
    poirot[i] = minim.loadFile(i + ".wav");
  }
  
  for(int i = 0; i < sortie.length; i++){
    sortie[i] = new Sortie();
  }
}
 
void draw() {
  background(120);
  //reperes();
  //println("Nombre  obj " + nombreObjets);
  
  for(int i = 0; i < sortie.length; i++){
    sortie[i].identifiant(i);
    sortie[i].dessiner(i);
    if(sortie[i].enLecture() == false){  
      sortie[i].jouerAnimation();
    }
  }
  //alphabet();
}

//RECUPERE INFO (BOUGE OU NB?)
void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("nbrObj") == true) {
    nombreObjets = theOscMessage.get(0).intValue();
  }
  for(int i = 0; i < nombreObjets; i++){
    if (theOscMessage.checkAddrPattern(str(i)) == true) {
      binaire[i] = theOscMessage.get(0).intValue(); // couleur NB
      bouge[i] = theOscMessage.get(1).intValue(); // Mouvement
    }
  }
}

void reperes(){
  stroke(255, 255, 0);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
}