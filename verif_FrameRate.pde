void latence(){
  if(frameRate >= 20){
    fill(10, 255, 40);
  }
  if(frameRate < 20 && frameRate >=15){
    fill(255,255,0);
  }
  if(frameRate < 15 && frameRate >= 10){
    fill(240, 120, 20);
  }
  if(frameRate < 10){
    fill(255, 0, 0);
  }
  noStroke();
  ellipse(640 + dec, 15+100, 10, 10);
}
