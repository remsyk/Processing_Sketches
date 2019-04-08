import shapes3d.*;
 
Ellipsoid AddEllipsoid (int slices, int segments, String textureFile, float radius)
{
  Ellipsoid aShape = new Ellipsoid(this, slices, segments);
  aShape.setTexture(textureFile);
  aShape.drawMode(Shape3D.TEXTURE);
  aShape.setRadius(radius);
  return aShape;
}
 
Ellipsoid earth, moon, stars;   
float rotx = -0.3;
float distance = 0;

PImage img;
float s = 0.0;
float a = 0.0;
int p = 1;
 
void setup()
{
  
  
  
  
   //animation2 = new Animation("PT_Teddy_", 60);
  size(800,600, P3D);
  frameRate(30);
 
  // create the earth
  earth = AddEllipsoid (60,30, "body_color.png", 90);
 
  // create the moon
  moon = AddEllipsoid (10,15, "main_logo.png", 20);
  moon.moveTo(-220,0,0);
 
  // add moon to the earth relative to it
  earth.addShape(moon);
  moon.rotateBy(0, radians(90), 0);
  
  
   img= loadImage("wave1.png");
 
}
 
void draw()
{  
  
  //saveFrame("anim/frame###.tif"); 
  
  
  camera(0, 0, 400+distance, 0, 0, 0, 0, 1, 0);
  if (mousePressed)
    if (mouseButton == LEFT)
      rotx = constrain(rotx + (pmouseY-mouseY)*0.003, -HALF_PI, HALF_PI);
    else distance = constrain(distance + (mouseY-pmouseY), -200, 200); 
  else
  { // do rotation before drawing
    earth.rotateBy(0, radians(0.6), 0);
  }
  
  rotateX (rotx);
  rotateZ(radians(-10));
  
  background(240);
  
  // lightning earth
  ambientLight(40,40,40);
  directionalLight(255, 255, 255, -350, 100, 200);
  directionalLight(255, 255, 255, 350, 0, 200 );
  earth.draw();
  noLights();
  ambientLight(255,255,255);
  
  //left eye box 1
  translate(-30, -20, 95);
  rotateZ(radians(-30));
  fill(222,115,27);
  stroke(222,115,27);
  box(16,42,5);
  
  //left eye box 2
  translate(0, 0, 0);
  rotateZ(radians(90));
  fill(222,115,27);
  stroke(222,115,27);
  box(16,42,5);
  
  //right eye box 1
  translate(30, -55, 0);
  rotateZ(radians(50));
  stroke(222,115,27);
  fill(222,115,27);
  box(16,42,5);
  
  //right eye box 2
  translate(0, 0, 0);
  rotateZ(radians(92));
  stroke(222,115,27);
  fill(222,115,27);
  box(16,42,5);
 
  //white half circle for headphones 
  translate(15,-50,0);
  rotateZ(radians(160));
  fill(#FFFFFF);
  stroke(#FFFFFF);
  drawCylinder(20, 32, 5 );
  
  //arc of headphones
  translate(15,0,1);
  fill(248,189,38);
  stroke(248,189,38);
  drawCylinder(20,10,5);
  
  //mouth
  translate(-15,-23,-90);
  fill(#FFFFFF);
  stroke(#FFFFFF);
  rotateZ(radians(180));

  drawCylinder(20,90,5);
  
  //tooth
  translate(0,9,-1);
  stroke(222,115,27);
  fill(222,115,27);
  rotateZ(radians(0));
  drawCylinder(20,90,5);
  
  
  //right ear bud
  pushMatrix();
  translate(-80,9,-1);
  stroke(222,115,27);
  fill(222,115,27);
  rotateZ(radians(80));
  drawCylinder(20,30,5);
  arcWave(.08, 50,0,0,0);
  popMatrix();

 
  
  //left ear bud
  pushMatrix();
  translate(83,-5,-1);
  stroke(222,115,27);
  fill(222,115,27);
  rotateZ(radians(270));
  drawCylinder(20,30,5);
  arcWave(.08, 50,0,0,0);  
  popMatrix();
  
}

private void arcWave(float s, float rot, float angle, float xC, float yC){
    if(a<7){
      scale(a+=s);
     
      
      strokeWeight(3);
      stroke(222,115,27);
      noFill();
      rotate(radians(rot));
      arc(xC, yC, 50, 50, 0, PI/2);
       
      translate(10,10);
      rotate(radians(angle));
        arc(xC, yC, 50, 50, 0, PI/2);
    }
    else{
      a=0;
  }
 }

void drawCylinder( int sides, float r, float h)
{
    float angle = 180 / sides;
    float halfHeight = h / 2;

    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight);
        
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();
    for (int i = 1; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
        
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides ; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
        vertex( x, y, -halfHeight);    
    }
    endShape(CLOSE);

}