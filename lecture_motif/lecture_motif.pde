// A RECUPERER: numéro objet (de 1 à 4) et boolean de chacun
import oscP5.*;
import netP5.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;

OscP5 oscP5;
Minim minim;
AudioPlayer[] player = new AudioPlayer[4];

float positionX, positionY;

int a;
int b;
int c;
int d;

int ma;
int mb;
int mc;
int md;

boolean ok = false;

void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 7000);
  minim = new Minim(this);
  for(int i = 0; i < player.length; i++){
    player[i] = minim.loadFile("z" + i + ".wav");
  }
  
  positionX = width/2;
  positionY = height/2;

}
 
void draw() {
  background(120);
  smooth();
  
  noStroke();
  if(a == 1){
    fill(255);
  } else {
    fill(0);
  }
  rect(0, 0, width/2, height/2);
  ///////
  if(b == 1){
    fill(255);
  } else {
    fill(0);
  }
  rect(width/2, 0, width/2, height/2);
  ////////
  if(c == 1){
    fill(255);
  } else {
    fill(0);
  }
  rect(0, height/2, width/2, height/2);
  ////////
  if(d == 1){
    fill(255);
  } else {
    fill(0);
  }
  rect(width/2, height/2, width/2, height/2);
  ////////
  
  reperes();
  println(player[0].position());
  
  if(ma == 1){
    ok = true;
  } 
  if(ok){
    player[0].play();
  } 
  if(player[0].position() >= player[0].length()){
    ok = false;
    player[0].rewind();
  }
  if(player[0].isPlaying()){
    ok = false;
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("0")==true) {
    a = theOscMessage.get(0).intValue();
    ma = theOscMessage.get(1).intValue();
  }
  if (theOscMessage.checkAddrPattern("1")==true) {
    b = theOscMessage.get(0).intValue();
    mb = theOscMessage.get(1).intValue();
  }
  if (theOscMessage.checkAddrPattern("2")==true) {
    c = theOscMessage.get(0).intValue();
    mc = theOscMessage.get(1).intValue();
  }
  if (theOscMessage.checkAddrPattern("3")==true) {
    d = theOscMessage.get(0).intValue();
    md = theOscMessage.get(1).intValue();
  }
}

void reperes(){
  stroke(255, 255, 0);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
}
