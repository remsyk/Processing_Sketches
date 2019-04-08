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