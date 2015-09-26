// A RECUPERER: numéro objet (de 1 à 4) et boolean de chacun
import oscP5.*;
import netP5.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;

OscP5 oscP5;
Minim minim;
AudioPlayer[] player = new AudioPlayer[4];

int nbrSortie;
Sortie[] sortie = new Sortie[4];

int nombreObjets;

int[] binaire = new int[12]; // Renvoi information couleur (noir ou blanc)
int[] bouge = new int[12]; // renvoi si ça bouge ou non

boolean ok = false;

void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 7000);
  minim = new Minim(this);
  for(int i = 0; i < player.length; i++){
    player[i] = minim.loadFile("z" + i + ".wav");
  }
  
  for(int i = 0; i < sortie.length; i++){
    sortie[i] = new Sortie();
  }
}
 
void draw() {
  background(120);
  smooth();
  reperes();
  println("Nombre  obj " + nombreObjets);
  
  for(int i = 0; i < sortie.length; i++){
    sortie[i].identifiant(i);
    sortie[i].dessiner(i);
    sortie[i].jouerSon();
  }
}

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("nbrObj") == true) {
    nombreObjets = theOscMessage.get(0).intValue();
  }
  if(theOscMessage.checkAddrPattern("impulsion") == true) {
    impulsion = theOscMessage.get(0).intValue();
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
