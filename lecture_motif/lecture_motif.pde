// A RECUPERER: numéro objet (de 1 à 4) et boolean de chacun
import oscP5.*;
import netP5.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;

OscP5 oscP5;
Minim minim;
Sortie sortie;

float positionX, positionY;
int nombreObjets;

int[] binaire = new int[12]; // Renvoi information couleur (noir ou blanc)
int[] bouge = new int[12]; // renvoi si ça bouge ou non

boolean ok = false;

void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 7000);
  minim = new Minim(this);
  
  sortie = new Sortie();
  
  positionX = width/2;
  positionY = height/2;

}
 
void draw() {
  background(120);
  smooth();
  reperes();
  sortie.identifiant(0);
  sortie.dessiner(20);
  sortie.jouerSon();
}

void oscEvent(OscMessage theOscMessage) {
  if((theOscMessage.checkAddrPattern("nbrObj") == true) {
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
