void alphabet(){
  //LECTURE MOTIF
  if(validation){
    
    if(sortie[0].code() == false && sortie[1].code() == true && sortie[2].code() == true && sortie[3].code() == true){
      signature = 1;
    }
    if(sortie[0].code() == true && sortie[1].code() == false && sortie[2].code() == true && sortie[3].code() == true){
      signature = 2;
    }
    if(sortie[0].code() == true && sortie[1].code() == true && sortie[2].code() == false && sortie[3].code() == true){
      signature = 3;
    }
    if(sortie[0].code() == true && sortie[1].code() == true && sortie[2].code() == true && sortie[3].code() == false){
      signature = 4;
    }
    if(sortie[0].code() == false && sortie[1].code() == false && sortie[2].code() == true && sortie[3].code() == true){
      signature = 5;
    }
    if(sortie[0].code() == false && sortie[1].code() == true && sortie[2].code() == false && sortie[3].code() == true){
      signature = 6;
    }
    if(sortie[0].code() == false && sortie[1].code() == true && sortie[2].code() == true && sortie[3].code() == false){
      signature = 7;
    }
    if(sortie[0].code() == true && sortie[1].code() == false && sortie[2].code() == false && sortie[3].code() == true){
      signature = 8;
    }
    if(sortie[0].code() == true && sortie[1].code() == false && sortie[2].code() == true && sortie[3].code() == false){
      signature = 9;
    }
    if(sortie[0].code() == true && sortie[1].code() == true && sortie[2].code() == false && sortie[3].code() == false){
      signature = 10;
    }
    if(sortie[0].code() == false && sortie[1].code() == false && sortie[2].code() == false && sortie[3].code() == true){
      signature = 11;
    }
    if(sortie[0].code() == false && sortie[1].code() == false && sortie[2].code() == true && sortie[3].code() == false){
      signature = 12;
    }
    if(sortie[0].code() == true && sortie[1].code() == false && sortie[2].code() == false && sortie[3].code() == false){
      signature = 13;
    }
    if(sortie[0].code() == false && sortie[1].code() == true && sortie[2].code() == false && sortie[3].code() == false){
      signature = 14;
    }
    
    //SIMPLES.
    if(sortie[0].code() == false && sortie[1].code() == false && sortie[2].code() == false && sortie[3].code() == false){
      signature = 15;
    }
    if(sortie[0].code() == true && sortie[1].code() == true && sortie[2].code() == true && sortie[3].code() == true){
      signature = 0;
    }
  }
  println(signature);
}
