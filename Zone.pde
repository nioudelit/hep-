class Zone{
  //  paramètres, variables globales
  PImage copie;
  boolean dedans = false;
  int x; int y; int l; int h; int carre;
  float retourConsole;
  int[] previousFrame;
  boolean mouvementAvere = false;
  float tauxGris;
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
  
  //  affiche et copie la zone à analyser
  void afficher(int seuil){
    copie.copy(camRetouchee, x, y, l, h, 0, 0, l, h);
    
    if(threshold == true){
      copie.loadPixels();
      for(int i = 0; i < copie.pixels.length; i++){
        if(brightness(copie.pixels[i]) < seuil){
          copie.pixels[i] = color(0);
        } else {
          copie.pixels[i] = color(255);
        }
      }
      copie.loadPixels(); // COMMENTER OU NON? A vérifier à tete reposée
    }
    image(copie, x, y);
    
    pushStyle();
    noFill();
    stroke(255, 0, 0, carre);
    rect(x, y, l, h);
    rect(x, y+h, 20, 5);
    popStyle();
    
  }
  
  //Permet de changer la zone à analyser avec un DragNdrop
  void deplacer(){
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
  
  //  méthode pour calculer une détection de mouvement
  void frameDiff(){
    float mouvement = 0;
    copie.loadPixels();
    
    for(int i = 0; i  < copie.pixels.length; i++){
      color present = copie.pixels[i];
      color passe = previousFrame[i];
      
      float lumPresent = brightness(present);
      float lumPasse = brightness(passe);
      
      float diff = dist(lumPresent, lumPresent, lumPasse, lumPasse);
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
  //  méthode pour activer action si moyenne luminosite d'une zone
  //  dépasse une valeur supérieur à un seuil de blanc donné
  boolean seuilBlanc(){
    copie.loadPixels();
    for(int i = 0; i < copie.pixels.length; i++){
      color brute = copie.pixels[i];
      //tauxGris += brightness(brute);
      //tauxGris += (brute >> 16) & 0xFF;
      //tauxGris += (brute >> 8) & 0xFF;
      tauxGris += brute & 0xFF;
    }
    tauxGris = tauxGris / copie.pixels.length;
    if(tauxGris > 127){
      return true;
      //println("BLANC! HoURRA!!!"); println("BLANC! HoURRA!!!");
    } else {
      return false;
    }
  }
  //  méthode pour activer action si moyenne luminosite d'une zone
  //  dépasse une valeur supérieur à un seuil de noir donné
  void seuilNoir(){
  }
  
  //renvoie si la zone contient du mouyvement
  boolean declencherSource(){
    if(mouvementAvere){
      return true;
    } else {
      return false;
    }
  }
  
  float volumeFondu(){
    mouvementFondu = (1 - PasseBas) * retourConsole + mouvementFondu;
    mouvementFonduSuper = (1 - DeriveePB) * mouvementFondu + mouvementFonduSuper;
    return mouvementFondu;
  }
  
  //Perception du mouvement GUI
  //Affichage en bas des données reçu par les zones
  void retourMouvement(int i) {
    int posY = 465 + i * 15;
    println("MOUVEMENT de L'OBJET " + i +"   " + retourConsole);
    fill(0); noStroke();
    rect(0, posY, 220, 20);
    fill(255);
    textSize(11);
    pushStyle(); fill(255, 0, 0); text(i, x + l + 5, y); popStyle();
    text("Mouvement de l'objet" + i + " est égale à " + int(retourConsole), 0 , posY, 260, 100);
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
