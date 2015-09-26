class Sortie{
  
  String id; // Renvoi le meme id OSC de la zone du programme serveur
  boolean ok = false; // permet de ne pas jouer les sons de façon anarchique
  int nb;
  int mouvement;
  
  Sortie(){
//    if(nombreObjets >= 1){
//      player = minim.loadFile("z" + str(nombreObjets - 1) + ".wav");
//      //println("mon fichier = z" + str(nombreObjets-1) + ".wav");
//    }
  }
  
  String identifiant(int i){
    id = str(i);
    return id;
  }
  
  void dessiner(int x){
    nb = binaire[int(id)];
    mouvement = bouge[int(id)];
    
    if(nb == 1){
      fill(255);
    } else {
      fill(0);
    }
    rect(x * 20, 0, 20, 20);
    println(id);
    println(nb + "        " + mouvement);
  }
  
  void jouerSon(){
    if(nombreObjets >= 1){
      if(mouvement == 1){
        println("YES");
        ok = true;
      }
      if(ok){
        player[int(id)].play();
      }
      if(player[int(id)].position() >= player[int(id)].length()){
        ok = false;
        player[int(id)].rewind();
      }
      if(player[int(id)].isPlaying()){
        ok = false;
      }
    }
  }
  
  void jouerVideo(){
  }
}
