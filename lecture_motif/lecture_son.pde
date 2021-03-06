class Sortie{
  
  String id; // Renvoi le meme id OSC de la zone du programme serveur
  boolean ok = false; // permet de ne pas jouer les sons de façon anarchique
  int nb;
  int mouvement;
  
  Sortie(){
  }
  
  String identifiant(int i){
    id = str(i);
    return id;
  }
  
  void dessiner(int x){
    int taille = 20;
    int posX = x;
    int posY = 0;
    
    nb = binaire[int(id)];
    mouvement = bouge[int(id)];
    
    if(nb == 1){ // BLANC
      fill(255);
    } else {
      fill(0);
    }
    rect(x * taille, 0, taille, taille);
    //println(id);
    //println(nb + "        " + mouvement);
    //println("Sonn    " + player[int(id)].length());
  }
  
  boolean code(){
    //SI c'est BLANC
    if(nb == 1){
      return true; // TRUE
    } else {
      return false; // SI c'est noir retourne Faux
    }
  }
  
  boolean rouge(){
    return false;
    //FAIRE FONCTION + OSC pour LIRE SI CASE est ROUGE ou Non
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
