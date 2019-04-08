sharkBot sharkBot;
sharkParts[] sharkParts = new sharkParts[10];
PVector sharkLocRand;
PVector sharkLoc = new PVector(0,0,10);

//create sharkBot class to call several if needed later //<>//
class sharkBot{
  PVector sharkVol = new PVector(0,0,5);
  float a=0.01;
  float fric=0.95;
  
  void sharkBotDraw(){
    //handle movement of shark elements, this will make its elements dependant on the ship movement when they get close
    sharkVol.x+=a*(abs(shipLoc.x)-sharkLoc.x);
    sharkVol.y+=a*(abs(shipLoc.y)-sharkLoc.y);
    //this is the drawwing effect of the parts when the shark moves, some elements catch up
    sharkVol.x*= fric;
    sharkVol.y*= fric;
    
    float kite = PVector.dist(shipLoc,sharkLoc);
    //if ship is within a certain proximity of the shark it will attack
    if(kite<2500){
      for( int i = 0; i <10; i++ ) {
        sharkParts[i].update( sharkLoc);
      }
      sharkLoc.x+=sharkVol.x;
      sharkLoc.y+= sharkVol.y;
    }
    
    else{
      //shark will move randomly unless the ship is within a certain proximity of ship 
      sharkLocRand=PVector.random2D();
      sharkLocRand.normalize();
      sharkLocRand.mult(9);
      sharkLocRand.lerp(portalLoc,0.01);
      sharkLoc.x= constrain(sharkLoc.x, -(boW*cols/4), (boW*cols/2));
      sharkLoc.y= constrain(sharkLoc.y, -(boH*rows/10), (boH*rows/2));
      for( int i = 0; i <10; i++ ) {
        sharkParts[i].update( sharkLoc.add(sharkLocRand));
      }   
    }   
  }
}

//add shark elements to screen
void sharkBotSetup(){
  sharkBot = new sharkBot();
  int sharkSize= 200;
  for( int i = 0; i < 10; i++ ) {
   sharkParts[i] = new sharkParts((0.098-(i*0.0093)), (sharkSize-=20),(i*100));
  }
}

//ser up individual parts of the shart to give it the fish like movement and keep with theme 
class sharkParts {
 PVector partLoc = new PVector();
 float partProx,sharkSize,sharkColor;
  
  sharkParts (float partProx, int bsize1,float fishColor) {
    this.partProx = partProx; //this will control closeness of parts
    partLoc.x = 100; //starting location of shark
    partLoc.y = 100;
    this.sharkSize = bsize1;
    this.sharkColor=fishColor;
 } 
 //parts move and update a unit
 void update( PVector pos) {
    float update_posX = ((pos.x - partLoc.x)*this.partProx) ;
    update_posX = update_posX*2;
    partLoc.x += update_posX;
    float update_posY = ((pos.y - partLoc.y)*this.partProx) ;
    update_posY = update_posY*2;
    partLoc.y += update_posY;
    this.render();
 }
 
 void render() {
   //colors change based off how class is called
   fill(this.sharkColor%200,this.sharkColor%150,100);;
   pushMatrix();
   translate(partLoc.x,partLoc.y);
   box(this.sharkSize,this.sharkSize,this.sharkSize);
   popMatrix();
 }  
}

//collision detection for sharks
boolean sharkAttack(PVector sharkLoc1, boolean collDetectON){
   //collision dection works by comparing the position of the box to the position of the ship, depending on the side it will then move the ship back the corresponding direction
   if (collDetectON==true){
   
    //Right Side Collison
     if((shipLoc.x-20)<(sharkLoc1.x+100) && (shipLoc.x)>(sharkLoc1.x-20) && (shipLoc.y)>(sharkLoc1.y-50) && (shipLoc.y)<(sharkLoc1.y+50)){ 
       return true;
     }
     
     //Left Side Collision
       if((shipLoc.x+20)>(sharkLoc1.x-100) && (shipLoc.x)<(sharkLoc1.x+20) && (shipLoc.y)>(sharkLoc1.y-50) && (shipLoc.y)<(sharkLoc1.y+50)){    
       return true;
      }
 
      //Bottom Side Collision
       if((shipLoc.y-20)<(sharkLoc1.y+120) && (shipLoc.y)>(sharkLoc1.y-20) && (shipLoc.x)>(sharkLoc1.x-60) && (shipLoc.x)<(sharkLoc1.x+60)){  
       return true;
      }
      
      //Top Side Collision
       if((shipLoc.y+20)>(sharkLoc1.y-120) && (shipLoc.y)<(sharkLoc1.y+20)&& (shipLoc.x)>(sharkLoc1.x-60) && (shipLoc.x)<(sharkLoc1.x+60)){
       return true;
      }
      
   }
   return false;
 }