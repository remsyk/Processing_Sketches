import processing.opengl.*;
PShape s;

void setup() {
   size(1000,1000, P3D);
   smooth();
   s = loadShape("tinker.obj");
   s.rotateY(300);
   s.rotateZ(-300);
   s.rotateX(-.2);   
}

void draw() {
   background(255,204,229);
   lights();
   carMove();
   shape(s, carLoc.x, carLoc.y);
}
boolean up, down, left, right,space;
PVector carLoc = new PVector(250,250);

void carSetup(){
   s = loadShape("tinker.obj");
   s.rotateY(300);
   s.rotateZ(-300);
   s.rotateX(-.2);
   s.scale(2);
}

void keyPressed(){
  if(key == 'w'){
    up = true;
  }  
  if(key == 's'){
    down = true;
  }  
  if(key == 'a'){
    left = true;
  }  
  if(key == 'd') {
    right = true;
  }
  if(key==' '){    
    space = true;
  }
}

void keyReleased(){
  if(key == 'w'){
    up = false;
  }  
  if(key == 's'){
    down = false;
  }  
  if(key == 'a'){
    left = false;
  }
  if(key == 'd'){
    right = false;
  }
  if(key==' '){
     space = false;
    }
}

void carMove(){
  if(up && right){
    //carLoc.rotate(PI/4);
    carLoc.x+=20;
    carLoc.y-=20;
  }
  
  else if(up && left){
    //carLoc.rotate((3*PI)/4);
    carLoc.x-=20;
    carLoc.y-=20;
  }
  
  else if(down && right){
    //carLoc.rotate((7*PI)/4);
    carLoc.x+=20;
    carLoc.y+=20;
  }
  
  else if(down && left){
   // carLoc.rotate((5*PI)/4);
    carLoc.x-=20;
    carLoc.y+=20;
  }
  
  else if(up){
   // carLoc.rotate(PI/2);
    carLoc.y-=20;
  }
  
  else if(down){
   // carLoc.rotate((3*PI)/2);
    carLoc.y+=20;
  }
  
  else if(left){
    //carLoc.rotate((3.1);
    carLoc.x-=20;
  }
  
  else if(right){
   // carLoc.rotate(0);
    carLoc.x+=20;
  }
}


void trdCam () { 
  camera(carLoc.x, carLoc.y+800, carLoc.z+6000, carLoc.x, carLoc.y, carLoc.z, 0, 1, 0);
}