class Sortie{
  
  AudioPlayer player;
  
  String id; // Renvoi le meme id OSC de la zone du programme serveur
  boolean ok = false; // permet de ne pas jouer les sons de façon anarchique
  int nb;
  int mouvement;
  
  Sortie(){
    player = minim.loadFile("z0" + ".wav");
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
    if(mouvement == 1){
      println("YES");
      ok = true;
    }
    if(ok){
      player.play();
    }
    if(player.position() >= player.length()){
      ok = false;
      player.rewind();
    }
    if(player.isPlaying()){
      ok = false;
    }
  }
  
  void jouerVideo(){
  }
}
