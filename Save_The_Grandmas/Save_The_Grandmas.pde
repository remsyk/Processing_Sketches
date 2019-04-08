import processing.opengl.*;
PShape s;

void setup() {
   size(800,800, P3D);
   smooth();
   s = loadShape("tinker.obj");
   //s.rotateY(300);
   s.rotateZ(-300);
   //s.rotateX(-.2); 
}

void draw() {
   background(255,204,229);
   lights();
  
 
   carMove();
   shape(s, carLoc.x, carLoc.y);
   
   box(3000,2500,-20);
   
   
   trdCam();
      
}

void trdCam () { 
  camera(400, 2000, 1000, 400,400, 0, 0, 1, 0);
  //camera(carLoc.x, carLoc.y+3000, carLoc.z+3000, 250.0, 250.0, 250.0, 0.0, 1.0, 0.0);
}