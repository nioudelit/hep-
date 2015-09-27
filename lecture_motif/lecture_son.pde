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
    //println(id);
    //println(nb + "        " + mouvement);
    println("Sonn    " + player[int(id)].length());
  }
  
  void jouerSon(){
    if(nombreObjets >= 1){
      //Si il y a du mouvement, on ouvre le "ok"
      if(mouvement == 1){
        println("YES");
        ok = true;
      }
      //si le ok est ouvert: on peut jouer le son.
      if(ok){
        player[int(id)].play();
      }
      //si on arrive à la fin du son, on rembobine et on remet le curseur sur 0.
      if(player[int(id)].position() == player[int(id)].length()){
        ok = false;
        player[int(id)].rewind();
      }
      //si le son est en train de se jouer, on ferme le "ok" pour empecher que le son se superpose
      if(player[int(id)].isPlaying()){
        ok = false;
      } else {
        if(mouvement == 1){
          ok = true;
        }
      }
    }
  }
  
  void jouerVideo(){
  }
}
