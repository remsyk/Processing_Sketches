

PImage bg;

void setup() {
  size(558, 789,P3D);
  bg = loadImage("proto2.png");
  frameRate(5);
 //cam();
    
}

void draw() {
  background(bg);

 animation_1();
  
}
int a;
int b;
int c;

void animation_1(){
  if(key=='a'){
    //frameCount=0;
    if(frameCount<=10){
      a=3;
    }else if(frameCount<=20){
      b=3;
    }else if( frameCount<=30){
      c=3;
    }

  pyr(-23,6,0,180,2,2,100,149,237,0,0,0,a);
  
  pyr(177,6,0,0,2,2,100,149,237,0,0,0,a);

  pyr(115,43,0,0,2,2,100,149,2370,0,0,0,0);
  
  pyr(-86,43,0,180,2,2,100,149,237,0,0,0,0);

  pyr(-23,80,0,180,2,2,100,149,237,0,0,0,b);

  pyr(177,80,0,0,2,2,100,149,237,0,0,0,b);

  pyr(115,117,0,0,2,2,100,149,237,0,0,0,0);
  
  pyr(-86,117,0,180,2,2,100,149,237,0,0,0,0);

  //second array
  pushMatrix();
  translate(0,295);

  pyr(-23,6,0,180,2,2,100,149,237,0,0,0,c);
  
  pyr(177,6,0,0,2,2,100,149,237,0,0,0,c);
  /*

  pyr(115,43,0,0,2,2,100,149,2370,0,0,0,0);
  
  pyr(-86,43,0,180,2,2,100,149,237,0,0,0,0);
  
  

  pyr(-23,80,0,180,2,2,100,149,237,0,0,0,0);

  pyr(177,80,0,0,2,2,100,149,237,0,0,0,0);

  pyr(115,117,0,0,2,2,100,149,237,0,0,0,0);
  
  pyr(-86,117,0,180,2,2,100,149,237,0,0,0,0);

  pyr(177,153,0,0,2,2,100,149,2370,0,0,0,a);
  
  pyr(-23,153,0,180,2,2,100,149,2370,0,0,0,a);
*/
  popMatrix();
    
  }  
}
import peasy.*;

PeasyCam cam;


void cam() {
  size(558, 789,P3D);
  bg = loadImage("proto2.png");
  
  int sizeX, sizeY ;
    int gridSizeX, gridSizeY;
    sizeX = width; sizeY = height;
    gridSizeX = int((sizeX + sizeY)/2) ;
    gridSizeY = int((sizeX + sizeY)/2);
    cam = new PeasyCam(this, sizeX/2 , sizeY/2, 0, 600);  // default settings on double click
    cam.setMinimumDistance(.001);
    cam.setMaximumDistance(50000);
    cam.setRotations( -0.7301672, -0.274728, 0.30156484); 
    
}


void pyr(float x,float y,float z,float Rotate_Y, float Scalar, float Rotate_Z, float Red, float Green, float Blue, float Stroke_R, float Stroke_B, float Stroke_G, float Stroke_W ){
  
  pushMatrix();
  rotateY(radians(Rotate_Y));
  stroke(Stroke_R,Stroke_B,Stroke_G);
  strokeWeight(Stroke_W);
  fill(Red,Green,Blue);
  translate(0,0,z);
  rotateZ(PI/Rotate_Z);
  scale(Scalar);
  triangle(y+27, -x+74, y+58, -x+20, y+90, -x+74);
  popMatrix();
  
}