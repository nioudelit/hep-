// A RECUPERER: numéro objet (de 1 à 4) et boolean de chacun
import oscP5.*;
import netP5.*;

OscP5 oscP5;

float positionX, positionY;
int hi;
int ha;

void setup() {
  size(600, 600);
  oscP5 = new OscP5(this, 7000);
  
  positionX = width/2;
  positionY = height/2;

  noStroke();
}
 
void draw() {
  background(255);
  smooth();

  if(hi == 1){
    fill(255,255,0);
  } else {
    fill(0);
  }
  ellipse(positionX, positionY, 20, 20);
  
  if(ha == 1){
    fill(255, 0, 0);
  } else {
    fill(0, 0, 255);
  }
  rect(100, 100, 100, 100);
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("0")==true) {
    hi = theOscMessage.get(0).intValue();
  }
  if (theOscMessage.checkAddrPattern("1")==true) {
    ha = theOscMessage.get(0).intValue();
  }
}
