void GUI(){
  
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
      .setRange(0.1, 0.9);
      
  cp5 = new ControlP5(this);
  cp5.addSlider("DeriveePB")
      .setPosition(640 + 20, 90 +100)
      .setRange(0.1, 0.9);
      
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

void bouton(){
  if(thre){
    fill(0, 40, 140);
  } else {
    fill(190, 120, 0);
  }
  rect(640 + 50, 100, 20, 20);
  //text("Appuie sur 't' pour activer effet threshold", 640 + 100, 100); 
}

boolean threshold(){
  return thre;
}