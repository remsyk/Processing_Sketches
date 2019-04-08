import processing.opengl.*;
float aa;
Map map;

  //add map, ship, levettext, and sharkBot to screen
void setup() {
  size(1000,1000, OPENGL);
  
  map = new Map(true);
  shipSetup();
  levelText();
  sharkBotSetup();
}
//update the screen elements
void draw() {
 // saveFrame("frames/####.tif");
  background(30,140,218);
  levelText();
  lights();
  
  pushStyle();
  water();
  popStyle();
  
  pushStyle();
  ship.drawCone( 3, 40, 5, 20, shipLoc);  
  shipMove();
  popStyle(); 
  
  trdCam();
  
  if(winCount==8){
    exit();
  }
  
  /** Release in Patch 1.1
 //lookAt = degrees(atan2(mouseX, mouseY));
    lookAt = degrees(atan2(mouseY-(shipLoc.y%1000), mouseX-shipLoc.x%1000));

  //println(lookAt);
   
   pushStyle();
   
   for (int i = bullets.size() - 1; i >= 0; i--) { //Go through each bullet from LAST to FIRST
    bull b = bullets.get(i); //Get the bullet
    b.update();
    b.display(); //Render the bullet
    if (b.finished()){
      bullets.remove(i);
    }
  }
  popStyle();
  */
  
  pushStyle();
  sharkBot.sharkBotDraw(); 
  popStyle();
  
  
  //the stroke from the water effects the island draw, and i like the white stroke
  pushStyle();
  map = new Map(false);
  popStyle();
  
  
  if(sharkAttack(sharkLoc,true)==true){
    winCount=8;
    println("Shark Attack: You Lose!");
    
  }
  
}
/**Release in Patch1.1
void mousePressed(){
  bullets.add(new bull(shipLoc.x, shipLoc.y, lookAt));  
}
*/
int cols = 60;
int rows = 60;
int boW = 300;
int boH = 300;
Cell[][] grid;
PVector[] boxLocRand = new PVector[31];
float portalHeight;
float pulseChange;
 PVector portalLoc;
 int portalMoveCount =0;
int winCount=0;
//ArrayList<PVector>gridFilled = new ArrayList<PVector>();
 int n;

//the maze consists of a 2D array of box elements
class Cell {
  PVector boxLoc;
  float d;

  Cell(PVector boxLoc, float d) {
    this.boxLoc = boxLoc;
    this.d = d;
  }
  //this will be called for the update/draw method
  PVector display(boolean collDetectON, int fill,boolean pulseFill) {
    pushMatrix();
    //translate(this.boxe.x-(boW*cols/2),this.boxe.y-(boH*rows/2),this.boxe.z);
    //when drawn each box must be moved its own size over so as to not draw ontop of eachother
    translate(this.boxLoc.x,this.boxLoc.y,this.boxLoc.z);
    //this pulse effect if for the portal
    if(pulseFill){
      float pulse = sin(pulseChange+=.05)*100;
      fill(fill, pulse);
      stroke(#87CEFA);  
      strokeWeight(7);
    }
    else{
    fill(fill);
    noStroke();
    }
    //collision detection will handle all interactions between the individual boxes and ship
    collisionDetect(boxLoc,collDetectON);
    box(boW, boH, d);
    popMatrix();   

  return boxLoc;
  }
}


//the map method is the true core of the code at the moment, this will handle both draw and setup based up boolean setup
  class Map{
    
    //draw type/setup type 1 island is dependant about boolean draw which handles where this method is being used
PVector islandOne(PVector r, int i, int j, boolean draw){
    PVector boxLoc = new PVector(i*300,j*300,20);
    //this is will a certain random variable and i,j from the loop below and draw the boxes from that random variable location to a X,Y range
   if (i>r.x && i<r.x+5 && j>r.y && j<r.y+5){ 
     if(draw){
        grid[i][j].display(true,#F0E68C,false);
       }
       else{
         grid[i][j] = new Cell(boxLoc,(int)random(0,100));  //the heights of ever box are random when setup
       }
    }       
    //these draw elements are staggered so that the islands can have different height sections and colors
    if (i>r.x+1 && i<r.x+4 && j>r.y+1 && j<r.y+4){ 
       if(draw){
          grid[i][j].display(true,#32CD32,false);
       }
       else{
         grid[i][j] = new Cell(boxLoc,(int)random(100,600));
       }
     }
    //////////////////////////////////
     if (i>r.x && i<r.x+5 && j>r.y+5 && j<r.y+10){ 
     if(draw){
         grid[i][j].display(true,#F0E68C,false);
       }
       else{
         grid[i][j] = new Cell(boxLoc,(int)random(0,100));  
       }
    }       
    if (i>r.x+1 && i<r.x+4 && j>r.y+6 && j<r.y+9){ 
       if(draw){
          grid[i][j].display(true,#32CD32,false);
       }
       else{
         grid[i][j] = new Cell(boxLoc,(int)random(100,1000));
       }
     }
     return boxLoc;
  }
 //draw island type 2 in the same way as island type 1
  void islandTwo(PVector r, int i, int j,boolean draw){
     PVector boxLoc = new PVector(i*300,j*300,20);
   
     if (i>r.x && i<r.x+6 && j>r.y && j<r.y+10){ 
      if(draw){
         grid[i][j].display(true,#F0E68C,false);
       }
       else{
       grid[i][j] = new Cell(boxLoc,(int)random(0,100));  
       }
    }       
    if (i>r.x+1 && i<r.x+5 && j>r.y+1 && j<r.y+9){ 
      if(draw){
          grid[i][j].display(true,#32CD32,false);
       }
       else{
       grid[i][j] = new Cell(boxLoc,(int)random(100,600));  
     }
     }
     if (i>r.x+2 && i<r.x+4 && j>r.y+2 && j<r.y+8){ 
        if(draw){
           grid[i][j].display(true,#331900,false);
        }
        else{
       grid[i][j] = new Cell(boxLoc,(int)random(600,2000));
        }
     }
     
     //////////////////////////////////////////////////////////
   if (i>r.x+6 && i<r.x+16 && j>r.y && j<r.y+5){ 
      if(draw){
         grid[i][j].display(true,#F0E68C,false);
       }
       else{
       grid[i][j] = new Cell(boxLoc,(int)random(0,100));  
       }
    }       
    if (i>r.x+7 && i<r.x+15 && j>r.y+1 && j<r.y+4){ 
      if(draw){
          grid[i][j].display(true,#32CD32,false);
       }
       else{
       grid[i][j] = new Cell(boxLoc,(int)random(100,600));  
     }
     }
     if (i>r.x+8 && i<r.x+4 && j>r.y+2 && j<r.y+3){ 
        if(draw){
           grid[i][j].display(true,#331900,false);
        }
        else{
       grid[i][j] = new Cell(boxLoc,(int)random(600,2000));
        }
     }
  }
  //this is the portal what will work the same as the islands are drawn
  PVector portal(int i, int j, boolean draw){
     PVector boxLoc = new PVector(i*300,j*300,0);
     PVector portalCord = new PVector();

     if(draw){
          if(i==portalLoc.x && j==portalLoc.y){
           //translate(0,0,-portalHeight+500); //Release in Patch 1.1
            portalCord = grid[i][j].display(false,#F5F5F5,true);
            return portalCord;
         }
       }
       else{
         if(i==portalLoc.x && j==portalLoc.y){
            grid[i][j] = new Cell(boxLoc,1000);
         }
       }
       return portalCord; //returns the XY coordinate of portal rather than grid coordinates grid coordinate are: XY Cordinate x 300
    } 
    
  
  Map(boolean setup){   
    if(setup){
      //gridFilled is an array list of all grid coordinates that have boxes
       //ArrayList<PVector>gridFilled = new ArrayList<PVector>();
      grid = new Cell[rows][cols];
      //portal location is a random variable at first
      portalLoc = new PVector((int)random(20,60),(int)random(20,50)); 
      n=0;
       for (int l=0; l<boxLocRand.length; l++){
         //all box locations are also random inside the grid
         boxLocRand[l]= new PVector((int)random(0,rows-10),(int)random(0,cols-10));
         //grid filled is adds all grid random setup locations
         //gridFilled.add(boxLocRand[l]);
       }
    }
    
    for (int i = 0; i < rows; i++) {
      n+=1;
      int m=0;
      for (int j = 0; j < cols; j++) {
        m+=1;
       
        if(setup){
          //this if statement handles the placing of the portal
          if (n<30 && m<16){
            PVector temp = new PVector(0,0,0);
            temp.add(n-1,m-1); 
            temp.add(boxLocRand[n]);//it takes all the random setup values and creates a temporary PVector that add the n,m or i,j to the value
            //gridFilled.add(temp); //temp is then added to filled, it will incrementally add value to both X,Y of the rand[] which will be all the box coordinates for the islands
          }
          
          //if the random PortalLoc is found within the gridFilled arraylist then a new random portalLoc is requested
          //the limitation to this method is that it will only do it in 3600 passes.
          /*
          if (gridFilled.contains(portalLoc)){
            portalLoc = new PVector((int)random(10,60),(int)random(10,50)); 
            //println("Portal Moved: " + portalLoc);
          }
          */
          //all islands are called for setup with coresponding random coordinate setup value
          islandOne(boxLocRand[0],i,j,false); 
          islandOne(boxLocRand[1],i,j,false); 
          islandOne(boxLocRand[2],i,j,false);
          islandTwo(boxLocRand[3],i,j,false); 
          islandOne(boxLocRand[4],i,j,false); 
          islandOne(boxLocRand[5],i,j,false);
          islandTwo(boxLocRand[6],i,j,false); 
          islandOne(boxLocRand[7],i,j,false); 
          islandOne(boxLocRand[8],i,j,false);
          islandTwo(boxLocRand[9],i,j,false);
          islandOne(boxLocRand[10],i,j,false); 
          islandOne(boxLocRand[11],i,j,false);
          islandTwo(boxLocRand[12],i,j,false);
          islandOne(boxLocRand[13],i,j,false); 
          islandOne(boxLocRand[14],i,j,false);
          islandTwo(boxLocRand[15],i,j,false); 
          islandOne(boxLocRand[16],i,j,false); 
          islandOne(boxLocRand[17],i,j,false);
          islandTwo(boxLocRand[18],i,j,false);
          islandOne(boxLocRand[19],i,j,false); 
          islandOne(boxLocRand[20],i,j,false);   
          islandTwo(boxLocRand[21],i,j,false);
          islandOne(boxLocRand[22],i,j,false); 
          islandOne(boxLocRand[23],i,j,false);
          islandTwo(boxLocRand[24],i,j,false); 
          islandOne(boxLocRand[25],i,j,false); 
          islandOne(boxLocRand[26],i,j,false);
          islandTwo(boxLocRand[27],i,j,false); 
          islandOne(boxLocRand[28],i,j,false); 
          islandOne(boxLocRand[29],i,j,false);
          islandTwo(boxLocRand[30],i,j,false); 
          portal(i,j,false);  
        }
        else{
          pushStyle();
          islandOne(boxLocRand[0],i,j,true);
          islandOne(boxLocRand[1],i,j,true); 
          islandOne(boxLocRand[2],i,j,true);
          islandTwo(boxLocRand[3],i,j,true);    
          islandOne(boxLocRand[4],i,j,true); 
          islandOne(boxLocRand[5],i,j,true);
          islandTwo(boxLocRand[6],i,j,true); 
          islandOne(boxLocRand[7],i,j,true); 
          islandOne(boxLocRand[8],i,j,true);
          islandTwo(boxLocRand[9],i,j,true);     
          islandOne(boxLocRand[10],i,j,true); 
          islandOne(boxLocRand[11],i,j,true);
          islandTwo(boxLocRand[12],i,j,true);
          islandOne(boxLocRand[13],i,j,true); 
          islandOne(boxLocRand[14],i,j,true);
          islandTwo(boxLocRand[15],i,j,true); 
          islandOne(boxLocRand[16],i,j,true); 
          islandOne(boxLocRand[17],i,j,true);
          islandTwo(boxLocRand[18],i,j,true);
          islandOne(boxLocRand[19],i,j,true);       
          islandOne(boxLocRand[20],i,j,true);
          islandTwo(boxLocRand[21],i,j,true);
          islandOne(boxLocRand[22],i,j,true); 
          islandOne(boxLocRand[23],i,j,true);
          islandTwo(boxLocRand[24],i,j,true); 
          islandOne(boxLocRand[25],i,j,true); 
          islandOne(boxLocRand[26],i,j,true);
          islandTwo(boxLocRand[27],i,j,true); 
          islandOne(boxLocRand[28],i,j,true); 
          islandOne(boxLocRand[29],i,j,true);
          islandTwo(boxLocRand[30],i,j,true);
          popStyle();
        
          pushMatrix();
          pushStyle();
        //as ship gets closer to portal it rises out of the water, but only if the user has enough experience to unlock, if user doesn't have enough experience the portal will move
        //PVector portalLoc1 = portal(i,j,true);
        //portalHeight= PVector.dist(portalLoc1, shipLoc); 
        
          if(collisionDetect(portal(i,j,true),true)){
            winCount+=1;
            shipLoc.x=280;
            shipLoc.y=10000;
            setup();
          }
        
          popStyle();
          popMatrix();
        }
   }
  }
  /*
  if(setup){
  println("Current Loc: "+portalLoc + winCount);
  println(gridFilled);
  }
  */
   }
  }


 
 boolean collisionDetect(PVector boxLoc, boolean collDetectON){
   //collision dection works by comparing the position of the box to the position of the ship, depending on the side it will then move the ship back the corresponding direction
   if (collDetectON==true){
   
    //Right Side Collison
     if((shipLoc.x-20)<(boxLoc.x+200) && (shipLoc.x)>(boxLoc.x-20) && (shipLoc.y)>(boxLoc.y-150) && (shipLoc.y)<(boxLoc.y+150)){
       shipLoc.x+=70;
       return true;
     }
     
     //Left Side Collision
       if((shipLoc.x+20)>(boxLoc.x-200) && (shipLoc.x)<(boxLoc.x+20) && (shipLoc.y)>(boxLoc.y-150) && (shipLoc.y)<(boxLoc.y+150)){
       shipLoc.x-=70;
       return true;
      }
 
      //Bottom Side Collision
       if((shipLoc.y-20)<(boxLoc.y+220) && (shipLoc.y)>(boxLoc.y-20) && (shipLoc.x)>(boxLoc.x-160) && (shipLoc.x)<(boxLoc.x+160)){
       shipLoc.y+=70;   
       return true;
      }
      
      //Top Side Collision
       if((shipLoc.y+20)>(boxLoc.y-220) && (shipLoc.y)<(boxLoc.y+20)&& (shipLoc.x)>(boxLoc.x-160) && (shipLoc.x)<(boxLoc.x+160)){
       shipLoc.y-=70;
       return true;
      }
      
   }
   return false;
 }
 
  
 
 //this shows the level and the win screen
 void levelText (){
   String [] levels = {"Level: 1-------> ","Level: 2------->","Level: 3------->","Level: 4------->","Level: 5------->","Level: 6------->","Level: 7------->","YOU WIN!","YOU LOSE!"};
   textSize(300);
   text(levels[winCount],-1000,10000.0);  
 }
 
SharkBot sharkBot;
SharkParts[] sharkParts = new SharkParts[10];
PVector sharkLocRand;
PVector sharkLoc = new PVector(0,0,10);

//create sharkBot class to call several if needed later
class SharkBot{
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
  sharkBot = new SharkBot();
  int sharkSize= 200;
  for( int i = 0; i < 10; i++ ) {
   sharkParts[i] = new SharkParts((0.098-(i*0.0093)), (sharkSize-=20),(i*100));
  }
}

//ser up individual parts of the shart to give it the fish like movement and keep with theme 
class SharkParts {
 PVector partLoc = new PVector();
 float partProx,sharkSize,sharkColor;
  
  SharkParts (float partProx, int bsize1,float fishColor) {
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
Ship ship;
int num = 40; 
int[] x = new int[num];
int[] y = new int[num];
int waterIndexPos = 0;
float rippleSize = 0;
float rippleVol = 0.0;
boolean up, down, left, right,space;
PVector shipLoc = new PVector(280,10000);
boolean blink=false; //Release in Patch 1.1
int blinkTime = second();
//ArrayList bullets; Release in Patch 1.1
//bullet bullet; Release in Patch 1.1
//float lookAt; Release in Patch 1.1
ArrayList<Bull> bullets = new ArrayList<Bull>(); //An array list of bullets

//the ship really needs to be fixed but it works by taking several traingle planes and sticking them together
  class Ship {

  void drawCone( int sides, float r1, float r2, float h, PVector loc){
    float angle = 360 / sides;
    float halfHeight = h/3;
    fill(#FF0303);
    translate(loc.x,loc.y, loc.z);    


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

//this method reads user input and the moves the ship accordingly
void shipMove(){
  if(up && right){
    //shipLoc.rotate(PI/4);
    shipLoc.x+=70;
    shipLoc.y-=70;
    if(space && blink){
      shipLoc.y-=abs(mouseY-abs(shipLoc.y));
      shipLoc.x+=mouseX;
      blink=false;
    }
  }
  
  else if(up && left){
    //shipLoc.rotate((3*PI)/4);
    shipLoc.x-=70;
    shipLoc.y-=70;
    if(space && blink){
      shipLoc.y-=abs(mouseY-abs(shipLoc.y));
      shipLoc.x-=abs(mouseX-abs(shipLoc.x));
      blink=false;
    }
  }
  
  else if(down && right){
    //shipLoc.rotate((7*PI)/4);
    shipLoc.x+=70;
    shipLoc.y+=70;
    if(space && blink){
      shipLoc.y+=mouseY;
      shipLoc.x+=mouseX;
      blink=false;
    }
  }
  
  else if(down && left){
   // shipLoc.rotate((5*PI)/4);
    shipLoc.x-=70;
    shipLoc.y+=70;
    if(space && blink){
      shipLoc.y+=mouseY;
      shipLoc.x-=abs(mouseX-abs(shipLoc.x));
      blink=false;
    }
  }
  
  else if(up){
   // shipLoc.rotate(PI/2);
    shipLoc.y-=70;
    if(space && blink){
      shipLoc.y-=abs(mouseY-abs(shipLoc.y));
      blink=false;
    }
  }
  
  else if(down){
   // shipLoc.rotate((3*PI)/2);
    shipLoc.y+=70;
    if(space && blink){
      shipLoc.y+=mouseY;
      blink=false;
    }
  }
  
  else if(left){
    //shipLoc.rotate((3.1);
    shipLoc.x-=70;
    if(space && blink){
      shipLoc.x-=abs(mouseX-abs(shipLoc.x));
      blink=false;
    }
  }
  
  else if(right){
   // shipLoc.rotate(0);
    shipLoc.x+=70;
    if(space && blink){
      shipLoc.x+=mouseX;
      blink=false;
      
    }
  /**  Release in Patch 1.1
   if (blink==false){
     if (second()-blinkTime >3){
       blink = true;
       print(blink);
       blinkTime=second();
     }
     
  }
  */
 
}
//contrain is a build in method that creates boundaries
  shipLoc.x= constrain(shipLoc.x, -(boW*cols/4), (boW*cols));
  shipLoc.y= constrain(shipLoc.y, -(boH*rows/8), (boH*rows));
}

//handles bullets Release in patch 1.1
class Bull {
  float xPos = 0;
  float yPos = 0;
  float angle = 0;
  float spd = 5085;
  float life = 50;


  Bull(float _x, float _y, float _a) {
    xPos = _x;
    yPos = _y;
    angle = _a;
  }

  void display() {
    pushMatrix();
    noStroke();
    ellipse(xPos, yPos, 10, 10);
    popMatrix();
  }
    
 void update(){
    xPos += spd * cos(radians(angle));
    yPos += spd * sin(radians(angle));

  }
  
  boolean finished() {
    // Balls fade out
    life--;
    if (life < 0) {
      return true;
    } else {
      return false;
    }
  }
}

//this is the ripple effect you see behind the ship
void water(){
    x[waterIndexPos] = (int)shipLoc.x;
    y[waterIndexPos] = (int)shipLoc.y;
    waterIndexPos = (waterIndexPos + 1) % num;
    
    for (int i = 0; i<num; i++) {
    
      int pos = (waterIndexPos +i) % num;
      float radius = (num-i) /2.5;
      pushMatrix();
      stroke(255,30);
      rippleVol+=0.002;
      rippleSize = cos(rippleVol)+10;
      noFill();
      smooth();
      ellipse(x[pos], y[pos], radius*3+rippleSize, radius*3+rippleSize);
      ellipse(x[pos], y[pos], radius*2-10+rippleSize, radius*2-10+rippleSize);
      popMatrix();
      if (rippleSize>=40.0){
          rippleSize=0;
      }
  }
}


//controls camera angle
void trdCam () { 
    //change back to shiplocY+300, shiplocZ+800
  camera(shipLoc.x, shipLoc.y+800, shipLoc.z+2000, shipLoc.x, shipLoc.y, shipLoc.z, 0, 1, 0);
}