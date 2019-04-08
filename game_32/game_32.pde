import peasy.*;
import picking.*;
import processing.opengl.*;

PeasyCam cam;
int sizeX, sizeY ;
int gridSizeX, gridSizeY;

void setup() {
  size(500,500, OPENGL);
  //frameRate(60);
  peasy();
  mapSetup();  
  shipSetup();

}

void draw() {
  background(209);
  lights();
  shipMove();
  mapDraw();
  ship.drawCone( 3, 40, 5, 20, shipLocX, shipLocY, shipLocZ, shipDir);  
  trdCam();

}
 
void peasy(){
    gridSizeX = int((width + height)/2) ;
    gridSizeY = int((width + height)/2);
    cam = new PeasyCam(this, width/2 , height/2, 0, 600);  // default settings on double click
    cam.setMinimumDistance(100);
    cam.setMaximumDistance(1500);
    //cam.setRotations( -0.7301672, -0.274728, 0.30156484); 
    cam.setRotations( 0.0, 0.0, 0.0); 

     

}