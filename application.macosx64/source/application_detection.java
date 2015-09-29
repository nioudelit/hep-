import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 
import controlP5.*; 
import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class application_detection extends PApplet {






//OBJETS OSC
OscP5 oscP5;
NetAddress myRemoteLocation;

//Gestion des Zones de detection
Zone[] maZone = new Zone[0];

Capture cam;
PImage camRetouchee;

ControlP5 cp5;
Slider abc;

//Details d'ordre relativement esth\u00e9tique
PImage ban;
int dec = 25; 
int posX = 60;
PImage gris;

//GUI
int taille = 50;
int seuilBruit = 10;
float contrastou = 1;
float lux;
float PasseBas = 0.5f; float DeriveePB = 0.3f;
int positionX; int positionY;
float mouvementFondu; float mouvementFonduSuper;
boolean thre = false;

public void setup (){
  size(640 + 200, 480 + 150, P2D);
  background(0);
  
  oscP5 = new OscP5(this, 9000);
  myRemoteLocation = new NetAddress("127.0.0.1", 7000); 
  
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

public void draw() {
  if(cam.available()){
    cam.read();
  }
  
  float contrast = contrastou;
  contrasteLumino(cam, camRetouchee, contrast, lux);
  image(camRetouchee, 0, 0);
  //filter(GRAY);
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
    maZone[i].seuilRouge(1);
    maZone[i].declencherSource();
    maZone[i].envoi(i);
  }
  //affiche un voyant pour v\u00e9rifier si \u00e7a tient le coup
  bouton();
  latence();
  //println(threshold());
  
  OscMessage myMessage = new OscMessage("nbrObj");
  myMessage.add(maZone.length);
  oscP5.send(myMessage, myRemoteLocation);
}

public void keyReleased(){
  if(key == ' '){
    new Zone(positionX, positionY, taille, taille, 255);
  }
  if(key == 't' || key == 'T'){
    thre =! thre;
  }
}
public void contrasteLumino(PImage entree, PImage sortie, float contraste, float lumino){
  int w = entree.width;
  int h = entree.height;
  
  if(w != sortie.width || h != sortie.height)
   {
     println("error dimension");
     return;
   }
  
  entree.loadPixels();
  sortie.loadPixels();
  
  for(int i = 0; i < entree.pixels.length; i++){
    
    int brut = entree.pixels[i];
    
    //BIT OPERATION ! POUR LA VITESSE
    int r = (brut >> 16) & 0xFF;
    int g = (brut >> 8) & 0xFF;
    int b = brut & 0xFF;
    
    r = (int)(r * contraste + lumino);
    g = (int)(g * contraste + lumino);
    b = (int)(b * contraste + lumino);
    
    //OULA CONDITIONS TERNAIRES ;-)
    //ex: r est inf\u00e9rieur \u00e0 0? Oui? Alors 0\u2026
    //Sinon: si r est sup\u00e9rieur \u00e0 255, alors il vaut 255, sinon r vaut r
    
    r = r < 0 ? 0 : r > 255 ? 255 : r;
    g = g < 0 ? 0 : g > 255 ? 255 : g;
    b = b < 0 ? 0 : b > 255 ? 255 : b;
    
    //sortie.pixels[i] = color(r, g, b);
    sortie.pixels[i]= 0xff000000 | (r << 16) | (g << 8) | b;
  }
  
  //entree.updatePixels();
  sortie.updatePixels();
}
public void GUI(){
  
  cp5 = new ControlP5(this);
  cp5.addSlider("seuilBruit")
      .setPosition(640 + 20, 50 +100)
      .setRange(0, 100);
      
  cp5 = new ControlP5(this);
  cp5.addSlider("contrastou")
      .setPosition(640 + 20, 30 +100)
      .setRange(0, 9);
      
   cp5 = new ControlP5(this);
   cp5.addSlider("lux")
      .setPosition(640 + 60, 30 +110)
      .setRange(-100, 100);
      
  cp5 = new ControlP5(this);
  cp5.addSlider("PasseBas")
      .setPosition(640 + 20, 70 +100)
      .setRange(0.1f, 0.9f);
      
  cp5 = new ControlP5(this);
  cp5.addSlider("DeriveePB")
      .setPosition(640 + 20, 90 +100)
      .setRange(0.1f, 0.9f);
      
  cp5 = new ControlP5(this);
  cp5.addSlider("taille")
      .setPosition(640 + 20, 110 +100)
      .setRange(5, 460);
      
  cp5 = new ControlP5(this);
  cp5.addSlider("positionX")
      .setPosition(640 + 20, 130 +100)
      .setRange(0, 640);
      
  cp5 = new ControlP5(this);
  cp5.addSlider("positionY")
      .setPosition(640 + 20, 150 +100)
      .setRange(0, 640);
     
}

public void bouton(){
  if(thre){
    fill(0, 40, 140);
  } else {
    fill(190, 120, 0);
  }
  rect(640 + 50, 100, 20, 20);
  //text("Appuie sur 't' pour activer effet threshold", 640 + 100, 100); 
}

public boolean threshold(){
  return thre;
}
class Zone{
  //  param\u00e8tres, variables globales
  PImage copie;
  boolean dedans = false;
  int x; int y; int l; int h; int carre;
  float retourConsole;
  int[] previousFrame;
  boolean mouvementAvere = false;
  
  float tauxGris; 
  float tauxRouge;
  float tauxBleu;
  float tauxVert;
  float tauxThre;
  
  Zone(int X, int Y, int L, int H, int afficherCarre){
    x = X;
    y = Y;
    l = L;
    h = H;
    x = positionX;
    y = positionY;
    carre = afficherCarre;
    
    copie = createImage(l, h, RGB);
    previousFrame = new int[l*h];
    
    maZone = (Zone[]) append (maZone, this);
  }
  
  //  affiche et copie la zone \u00e0 analyser
  public void afficher(int seuil){
    copie.copy(camRetouchee, x, y, l, h, 0, 0, l, h);
    
    if(threshold() == true){
      copie.loadPixels();
      for(int i = 0; i < copie.pixels.length; i++){
        if(brightness(copie.pixels[i]) < seuil){
          copie.pixels[i] = color(0);
        } else {
          copie.pixels[i] = color(255);
        }
      }
      copie.loadPixels(); // COMMENTER OU NON? A v\u00e9rifier \u00e0 tete repos\u00e9e
    }
    image(copie, x, y);
    
    pushStyle();
    noFill();
    stroke(255, 0, 0, carre);
    rect(x, y, l, h);
    rect(x, y+h, 20, 5);
    popStyle();
    
  }
  
  //Permet de changer la zone \u00e0 analyser avec un DragNdrop
  public void deplacer(){
    if( (x <= mouseX) && (x + l >= mouseX) && (y <= mouseY) && (y + h >= mouseY)){
      dedans = true;
    } else {
      dedans = false;
    }
      if(mousePressed && dedans == true){
        x = mouseX - l/2;
        y = mouseY - h/2;
      }
      if(dedans){
        fill(255,0,0,127);
        rect(x, y, l, h);
        if(keyPressed){
          if(key == 'x'){
            //maZone = (Zone[]) append (maZone, this);
          }
        }
      }
  }
  
  //  m\u00e9thode pour calculer une d\u00e9tection de mouvement
  public void frameDiff(){
    float mouvement = 0;
    copie.loadPixels();
    
    for(int i = 0; i  < copie.pixels.length; i++){
      int present = copie.pixels[i];
      int passe = previousFrame[i];
      
//      float lumPresent = brightness(present);
//      float lumPasse = brightness(passe);

      int rougePresent = (present >> 16)& 0xFF;
      int vertPresent = (present >> 8)& 0xFF;
      int bleuPresent = present & 0xFF;
      
      int rougePasse = (passe >> 16) & 0xFF;
      int vertPasse = (passe >> 8) & 0xFF;
      int bleuPasse = passe & 0xFF;
      
      //float diff = dist(lumPresent, lumPresent, lumPasse, lumPasse);
      float diff = dist(rougePresent, vertPresent, bleuPresent, rougePasse, vertPasse, bleuPasse);
      //diffFiltre = (1 - PasseBas) * diff + (PasseBas * diffFiltre);
      
      if(diff < seuilBruit){
        diff = 0;
        mouvementAvere = false;
      } else {
        mouvementAvere = true;
        //stroke(255, 100, 100); 
        //point(x + l, y + h + 5);
        //pushStyle(); strokeWeight(8); stroke(255, 0, 0); point(x, y - 10);popStyle();
      }
      
      mouvement += diff;
      previousFrame[i] = present;
    }
    float moyenneMouvement = mouvement / ( l * h );
    retourConsole = moyenneMouvement;
    
    //PASSE BAS
    //retourConsoleFiltre = ();
    ///////////
    
    if(mouvementAvere){ 
      pushStyle(); strokeWeight(1); stroke(0, 0, 255); point(x, y - 10);
      noFill();
      rect(x - 10, y - 10, l +20, h +20);
      popStyle();
      //stroke(0,0,255);
    }
    fill(255, moyenneMouvement);
    rect(x, y, l, h);
  } 
  //  m\u00e9thode pour activer action si moyenne luminosite d'une zone
  //  d\u00e9passe une valeur sup\u00e9rieur \u00e0 un seuil de blanc donn\u00e9
  public boolean seuilBlanc(){
    copie.loadPixels();
    for(int i = 0; i < copie.pixels.length; i++){
      int brute = copie.pixels[i];
      //tauxGris += brightness(brute);
      tauxGris += (brute >> 16) & 0xFF;
      tauxGris += (brute >> 8) & 0xFF;
      tauxGris += brute & 0xFF;
    }
    tauxGris = (tauxGris / copie.pixels.length) / 3;
    //println("TAUXGRIS" + tauxGris);
    if(tauxGris > 127){
      return true;
      //println("BLANC! HoURRA!!!"); println("BLANC! HoURRA!!!");
    } else {
      return false;
    }
  }
  
  public boolean seuilRouge(float marge){
    for(int i = 0; i < copie.pixels.length; i++){
      int brute = copie.pixels[i];
      tauxRouge += (brute >> 16) & 0xFF;
      tauxVert += (brute >> 8) & 0xFF;
      tauxBleu += brute & 0xFF;
    }
    tauxRouge = tauxRouge / copie.pixels.length;
    tauxVert = tauxVert / copie.pixels.length;
    tauxBleu = tauxBleu / copie.pixels.length;
    
    if(tauxRouge > 140 * marge && tauxVert < 80 * marge && tauxBleu < 90 * marge){
      //println("Rouge!");
      return true;
      
    } else {
      //println("pasrouge");
      return false;
    }
  }
  
  //envoi donn\u00e9es noir et blanc en OSC
  public void envoi(int i){
    String si = str(i);
    int nb = 0;
    OscMessage myMessage = new OscMessage(si);
    if(seuilBlanc()){
      nb = 1;
    } else {
      nb = 0;
    }
    myMessage.add(nb);
    myMessage.add(declencherSource());
    oscP5.send(myMessage, myRemoteLocation);
  }
  
  //renvoie si la zone contient du mouyvement
  public int declencherSource(){
    if(mouvementAvere){
      //println("MOUVEMENT MEC");
      return 1;
    } else {
      return 0;
    }
  }
  
  public float volumeFondu(){
    mouvementFondu = (1 - PasseBas) * retourConsole + mouvementFondu;
    mouvementFonduSuper = (1 - DeriveePB) * mouvementFondu + mouvementFonduSuper;
    return mouvementFondu;
  }
  
  //Perception du mouvement GUI
  //Affichage en bas des donn\u00e9es re\u00e7u par les zones
  public void retourMouvement(int i) {
    int posY = 465 + i * 15;
    //println("MOUVEMENT de L'OBJET " + i +"   " + retourConsole);
    fill(0); noStroke();
    rect(0, posY, 220, 20);
    fill(255);
    textSize(11);
    pushStyle(); fill(255, 0, 0); text(i, x + l + 5, y); popStyle();
    text("Mouvement de l'objet" + i + " est \u00e9gale \u00e0 " + PApplet.parseInt(retourConsole), 0 , posY, 260, 100);
    if(mouvementAvere){
      //sons[i].loop();
      pushStyle();
      stroke(255);
      strokeWeight(5);
      point(210, posY + 10);
      popStyle();
      //peutJouer = true;
      //sons[i].setGain(map(retourConsole, 0, 5, -50., 24.));
    }
    if(seuilBlanc()){
      fill(255);
      stroke(0, 140, 255);
      rect(x, y+h, 20, 5);
    } else {
      fill(0);
      stroke(0, 140, 255);
      rect(x, y+h, 20, 5);
    }
  }
}
//
////Gestion fichier
//File[] fichiers = new File[25];
//PImage[] imagesChargees = new PImage[25];
//String[] nomsFichiers;
//int compteurFichier = 0;
//boolean ok = false;
//
//void fileSelected(File selection) {
//  if (selection == null) {
//    println("Que dalle");
//  } else {
//    println("Choix du fichier: " + selection.getAbsolutePath() + "\n");
//    nomsFichiers[compteurFichier] = selection.getAbsolutePath();
//    ok = true;
//    compteurFichier+=1;
//  }
//  
//  for(int i = 0; i < compteurFichier; i++){
//    //println( i + "    " + selection.getAbsolutePath());
//  }
//  if(compteurFichier >= 2){
//    for(int i = 0; i < compteurFichier; i++){
//      println( compteurFichier + "    " + selection.getAbsolutePath());
//    }
//    noLoop();
//  }
//}
//
//void lesImages(){
//  if(ok){
//    imagesChargees[compteurFichier] = loadImage(nomsFichiers[compteurFichier]);
//    text(nomsFichiers[compteurFichier], 400, 500);
//  }
//}
public void latence(){
  if(frameRate >= 20){
    fill(10, 255, 40);
  }
  if(frameRate < 20 && frameRate >=15){
    fill(255,255,0);
  }
  if(frameRate < 15 && frameRate >= 10){
    fill(240, 120, 20);
  }
  if(frameRate < 10){
    fill(255, 0, 0);
  }
  noStroke();
  ellipse(640 + dec, 15+100, 10, 10);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "application_detection" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
