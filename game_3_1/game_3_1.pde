import processing.opengl.*;
var cc = externals.context;

void setup() {
  size(500,500, WEBGL);
//frameRate(60);
  cc = externals.context;
  trdCam();
  mapSetup();  
  shipSetup();


}

void draw() {
  background(209);
  lights();
  trdCam();
  shipMove();
  mapDraw();
  ship.drawCone( 3, 40, 5, 20, shipLocX, shipLocY, shipLocZ, shipDir);  

}
 
