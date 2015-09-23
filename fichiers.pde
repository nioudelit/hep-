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
