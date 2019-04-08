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
 