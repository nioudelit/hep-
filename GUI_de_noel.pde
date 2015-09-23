void GUI(){
  
  cp5 = new ControlP5(this);
  cp5.addSlider("seuilBruit")
      .setPosition(640 + 20, 50 +100)
      .setRange(0, 100);
      
  cp5 = new ControlP5(this);
  cp5.addSlider("contrastou")
      .setPosition(640 + 20, 30 +100)
      .setRange(0, 15);
      
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
