// on importe la bibliothèque OscP5
import oscP5.*;
import netP5.*;

//création d'un objet OscP5 appelé 'oscP5'
OscP5 oscP5;

//on créée 2 variables qui vont nous
//permettre d'assigner les valeurs des fader de touchOSC
//aux coordonnées de notre cercle
float positionX, positionY;
boolean diable = false;
int hi;

void setup() {
  size(600, 600);
  //paramétrage de l'objet oscP5 qui recevra les données 
  // sur le port 7000
  oscP5 = new OscP5(this, 7000);
  //au départ, on place notre cercle au centre
  positionX = width/2;
  positionY = height/2;
  //on desactive les dessin des contours
  noStroke();
}

void draw() {
  //arriere plan blanc
  background(255);
  //on lisse notre affichage
  smooth();
  println(diable);
  if(hi == 1){
    fill(255,255,0);
  } else {
    fill(0);
  }
  //on assigne les coordonnées variables à notre cercle
  ellipse(positionX, positionY, 20, 20);
}

/* methode oscevent permettant d'ecouter les evenements OSC */
void oscEvent(OscMessage theOscMessage) {
  // si l'applet reçoit un messag OSC avec l'address pattern "/positionsCurseur"
  if (theOscMessage.checkAddrPattern("/hep")==true) {
    //on assigne les valeurs de l'index 0, de type integer (.intValue)  du message OSC 
    //à la variable positionX que l'on assignera à la coordonnée x de notre cercle
    hi = theOscMessage.get(0).intValue();
  }
}
