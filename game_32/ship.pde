Ship ship;
float shipDir;
float shipLocX;
float shipLocY;
float shipLocZ;
float easing = 0.05;

  class Ship {

  void drawCone( int sides, float r1, float r2, float h, float locX, float locY, float locZ, float rot){
    float angle = 360 / sides;
    float halfHeight = h / 2;
    translate(locX,locY, locZ);    
     rotate(rot);

   pushMatrix();
   rotateX(PI/50);
   beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r1;
        float y = sin( radians( i * angle ) ) * r1;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();

    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r2;
        float y = sin( radians( i * angle ) ) * r2;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x1, y1, -halfHeight);
        vertex( x2, y2, halfHeight);    
    }
    endShape(CLOSE);
    popMatrix();

  }
 }

void shipSetup(){
  ship = new Ship();
}

void shipMove(){
  shipLocZ=45;
  shipLocX= constrain(shipLocX, -470, 470);
  shipLocY= constrain(shipLocY, -470, 470);
  if(keyPressed){
    if(key=='a'){
      shipDir=3.14*1.5;
      shipLocX-=30;
    }
    if(key=='w'){
      shipDir=0;
      shipLocY-=30;
    }
    if(key=='d'){
      shipDir=3.14/2;
      shipLocX+=30;
    }
    if(key=='s'){
      shipDir=3.14;
      shipLocY+=30;
    }
    if(key==' '){
    shipLocX+=(mouseX-shipLocX) * easing;
    shipLocY+=(mouseY-shipLocY) * easing;
    }
  }
}




void trdCam () { 
  
  float cameraZ = 500 * sin(radians(480));
  
  camera(shipLocX, shipLocY+300, shipLocZ + cameraZ, shipLocX, shipLocY, shipLocZ, 0, 1, 0);

}