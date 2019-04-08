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