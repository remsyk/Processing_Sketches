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
 
int cols = 50;
int rows = 50;
Cell[][] grid;
int rand = (int)random(0,43);
int rand1 = (int)random(25,45);
int rand2 = (int)random(10,50);
float closeness;
PVector boxe, cast,setCast;


class Cell {
  float x, y, z, d,x1,y1,z1;


  Cell(float x, float y, float z, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.d = d;
  }
   

 void display(boolean k, int fil) {
    pushMatrix();
    translate(-width,-height);
    translate(x,y,z);
    collide(x,y,z,k);
    fill(fil);
    box(20, 20, d);
     x1 = modelX(x,y,z);
     y1 = modelY(x,y,z);
     z1 = modelZ(x,y,z);
    popMatrix();   
  }  
}


 PVector castleDraw(int r, int i, int j,int w){
   if (i>r+1 && i<r+6 && j>r+1 && j<r+6){ 
       grid[i][j].display(true,#FF9933); 

   }
        
   if (i>r+2 && i<r+5 && j>r+2 && j<r+5){ 
        grid[i][j].display(true,#FF9933);      
   }
  
   
     pushMatrix();
     translate(-width,-height);
     line(grid[r+2][r+2].x,grid[r+2][r+2].y, w+2,w+2);
     popMatrix();

   cast = new PVector(grid[r+2][r+2].x, grid[r+2][r+2].y);  
 
   return cast;
  }
  
 int q = rand;
 int t = rand1;
  void mapDraw(){
    
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
      
      //grid[i][j].display(false,#66B2FF);
        
       castleDraw(rand,i,j,t);
       castleDraw(rand1,i,j,t);
       
       
        
        PVector c, pj;
        pj = new PVector();
        c = new PVector(160, 410);
        c.set(mouseX, mouseY);
        
        boolean on = isOnLine(castleDraw(rand, i, j,t ),castleDraw(rand1, i, j,t ),c,pj);
        
        if(on){
          println("ON");
          grid[int(pj.x)][int(pj.y)].display(true,#FF9933);
        }
       
       
   }
  }
 }
 
 
 PVector castleSetup(int r, int i, int j){
    
    if (i>r+1 && i<r+6 && j>r+1 && j<r+6){ 
       grid[i][j] = new Cell(i*20,j*20,20,(int)random(40,80));  

    }       
    if (i>r+2 && i<r+5 && j>r+2 && j<r+5){ 
       grid[i][j] = new Cell(i*20,j*20,20,(int)random(100,250));  
       setCast =  new PVector(grid[r][r].x,grid[r][r].y);
     }
   return setCast;
  }


 void mapSetup(){
   grid = new Cell[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      
      grid[i][j] = new Cell(i*20,j*20,20,20); 
      castleSetup(rand,i,j);
      castleSetup(rand1,i,j);  
     
   }
  }
 }
 
 void collide(float x, float y, float z, boolean k){
   
  // x = modelX(0, 0, 0);
  // y = modelY(0, 0, 0);
  // z = modelZ(0, 0, 0);
   
   if (k==true){
   //println("Mouse:",mouseX,mouseY);
   //println(xx,yy,zz);
   //println("Ship:",shipLocX,shipLocY,shipLocZ);
   
   
    //(shipLoxX-"30") should be changed based off ship size
    //Right Side Collison
     if((shipLocX-40)==(x+10) && (shipLocY-40)<(y-10) && (shipLocY+40)>(y+10)){
       shipLocX+=30;
     }
     //Left Side Collision
      if((shipLocX+40)==(x-10) && (shipLocY-40)<(y-10) && (shipLocY+40)>(y+10)){
       shipLocX-=30;   
      }
      //Bottom Side Collision
      if((shipLocY-60)==(y+10) && (shipLocX-40)<(x-10) && (shipLocX+40)>(x+10)){
       shipLocY+=30;
      }
      //Top Side Collision
       if((shipLocY+40)==(y-10) && (shipLocY-0) <(y)&& (shipLocX-40)<(x-10) && (shipLocX+40)>(x+10)){
       shipLocY-=30;
      }
   }
 }
 
 boolean isOnLine(PVector v0, PVector v1, PVector p, PVector vp) {
  // Return minimum distance between line segment vp and point p
  PVector the_line = PVector.sub(v1, v0);
  float l2 = the_line.mag();
  l2 = l2 * l2;
  if (l2 == 0.0) {
    vp.set(v0);
    return false;
  }
  PVector pv0_line = PVector.sub(p, v0);
  float t = pv0_line.dot(the_line)/l2;
  pv0_line.normalize();
  vp.x = the_line.x * t + v0.x;
  vp.y = the_line.y * t + v0.y;
  float d = sqrt((p.x-vp.x)*(p.x-vp.x) +(p.y-vp.y)*(p.y-vp.y)); 
  if (t >= 0 && t <= 1 && d <= closeness)
    return true;
  else
    return false;
}
Ship ship;
float shipDir;
float shipLocX;
float shipLocY;
float shipLocZ;
float easing = 0.05;

  class Ship {

  void drawCone( int sides, float r1, float r2, float h, float locX, float locY, float locZ, float rot){
    float angle = 360 / sides;
    float halfHeight = h / 2;
    translate(locX,locY, locZ);    
     rotate(rot);

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

void shipMove(){
  shipLocZ=45;
  shipLocX= constrain(shipLocX, -470, 470);
  shipLocY= constrain(shipLocY, -470, 470);
  if(keyPressed){
    if(key=='a'){
      shipDir=3.14*1.5;
      shipLocX-=50;
    }
    if(key=='w'){
      shipDir=0;
      shipLocY-=50;
    }
    if(key=='d'){
      shipDir=3.14/2;
      shipLocX+=50;
    }
    if(key=='s'){
      shipDir=3.14;
      shipLocY+=50;
    }
    if(key==' '){
    shipLocX+=(mouseX-shipLocX) * easing;
    shipLocY+=(mouseY-shipLocY) * easing;
    }
  }
}




void trdCam () { 
    
  camera(shipLocX, shipLocY+300, shipLocZ + 800, shipLocX, shipLocY, shipLocZ, 0, 1, 0);

}