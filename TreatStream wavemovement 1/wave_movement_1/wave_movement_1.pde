float a=0;
void setup(){
  size(500,500);
  
}

void draw(){
  
  background(240);
  
  arcWave(.01, 20, 0, 50,50);
  //arcWave(.01, 10, 0, 50,50);
  
  }
  
 private void arcWave( float s, float rot, float angle, float xC, float yC){
beginShape();
    if(a<4){
      scale(a+=s);
      strokeWeight(3);
      stroke(222,115,27);
      noFill();       
      rotate(radians(rot));
      arc(xC, yC, 50, 50, 0, PI/2);     
   
    }
    else{
      a=0;
    }
    endShape(CLOSE);
    
    beginShape();
     if(a<4){
      scale(a+=s);
      strokeWeight(3);
      stroke(222,115,27);
      noFill();
      translate(10,10);
      rotate(radians(angle));
      arc(xC, yC, 50, 50, 0, PI/2);
    
    }
    else{
      a=0;
    }
    endShape(CLOSE);
   }

 