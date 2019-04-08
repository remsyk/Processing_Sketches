boolean up, down, left, right,space;
PVector carLoc = new PVector(400,400);
PVector mapCenter = new PVector(400,400,0);
float a = PVector.angleBetween(mapCenter, carLoc);

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
  
  
  if(up){
   //s.rotate(PI/2);
   carLoc.y-=20;
   println(carLoc.heading());
  }
  
  if(down){
   //s.rotate(PI/2);
   carLoc.y+=20;
   println(carLoc.heading());
  }
  
  else if(left){
    //s.rotate((3.1));
    println(carLoc.heading());
    carLoc.x-=20;   
  }
  
  else if(right){
    println(carLoc.heading());
    //s.rotateZ(0);
    carLoc.x+=20;
  }
}