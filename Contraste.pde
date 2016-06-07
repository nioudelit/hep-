void contrasteLumino(PImage entree, PImage sortie, float contraste, float lumino){
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
    
    color brut = entree.pixels[i];
    
    //BIT OPERATION ! POUR LA VITESSE
    int r = (brut >> 16) & 0xFF;
    int g = (brut >> 8) & 0xFF;
    int b = brut & 0xFF;
    
    r = (int)(r * contraste + lumino);
    g = (int)(g * contraste + lumino);
    b = (int)(b * contraste + lumino);
    
    //OULA CONDITIONS TERNAIRES ;-)
    //ex: r est inférieur à 0? Oui? Alors 0…
    //Sinon: si r est supérieur à 255, alors il vaut 255, sinon r vaut r
    
    r = r < 0 ? 0 : r > 255 ? 255 : r;
    g = g < 0 ? 0 : g > 255 ? 255 : g;
    b = b < 0 ? 0 : b > 255 ? 255 : b;
    
    //sortie.pixels[i] = color(r, g, b);
    sortie.pixels[i]= 0xff000000 | (r << 16) | (g << 8) | b;
  }
  
  //entree.updatePixels();
  sortie.updatePixels();
}