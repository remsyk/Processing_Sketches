int cols = 50;
int rows = 50;
Cell[][] grid;
int rand = (int)random(20,43);
int rand1 = (int)random(0,43);
int rand2 = (int)random(10,50);
float closeness;
PVector box, cast;


class Cell {
  float x, y, z, d;


  Cell(float x, float y, float z, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.d = d;
  }
   

 PVector display(boolean k, int fill) {
    this.d=d;
    pushMatrix();
    translate(-width,-height);
    translate(x,y,z);
    collide(x,y,z,k);
    fill(fill);
    box(20, 20, d);
    popMatrix();
    box = new PVector(x, y);
    print ("Box: ", box);
    return box;
  }  
}


 PVector castleDraw(int r, int i, int j){
   if (i>r+1 && i<r+6 && j>r+1 && j<r+6){ 
       grid[i][j].display(true,#FF9933);   
   }
        
   if (i>r+2 && i<r+5 && j>r+2 && j<r+5){ 
        grid[i][j].display(true,#FF9933);         
   }
    if (i>r && i<r+1 && j>r && j<r+1){ 
        cast = grid[i][j].display(true,#FF9933);         
    }
    
    println(cast);
    return cast;
  }
 
  
  void mapDraw(){
    
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
      
        grid[i][j].display(false,#66B2FF);
        
      
        //castleDraw(rand, i, j );
        //castleDraw(rand1, i, j );
        //castleDraw(rand2, i, j );
         
        //line(castleDraw(rand, i, j ).x,castleDraw(rand, i, j ).y,50,castleDraw(rand1, i, j ).x,castleDraw(rand1, i, j ).y,50);
        
        /*
        PVector c, pj;
        pj = new PVector();
        c = new PVector(160, 410);
        c.set(mouseX, mouseY);
        
        boolean on = isOnLine(castleDraw(rand, i, j ),castleDraw(rand1, i, j ),c,pj);
        
        if(on){
          println("ON");
          grid[int(pj.x)][int(pj.y)].display(true,#FF9933);
        }
       */
       
   }
  }
 }
 
 
 void castle(int r, int i, int j){
    
    if (i>r+1 && i<r+6 && j>r+1 && j<r+6){ 
       grid[i][j] = new Cell(i*20,j*20,20,(int)random(40,80));  
             
         if (i>r+2 && i<r+5 && j>r+2 && j<r+5){ 
           grid[i][j] = new Cell(i*20,j*20,20,(int)random(100,250));       
         }
    }
  }


 void mapSetup(){
   grid = new Cell[rows][cols];
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      
      grid[i][j] = new Cell(i*20,j*20,20,20);
      
      castle(rand,i,j);
      castle(rand1,i,j);
      castle(rand2,i,j); 
   }
  }
 }
 
 void collide(float x, float y, float z, boolean k){
   
   if(k==false){
   float xx = modelX(0, 0, 0);
   float yy = modelY(0, 0, 0);
   float zz = modelZ(0, 0, 0);
    //println(xx,yy,zz);

      //shipLocX= constrain(shipLocX, xx-(50*20), xx+(50*20));

   }
 
   if (k==true){
   float xx = modelX(0, 0, 0);
   float yy = modelY(0, 0, 0);
   float zz = modelZ(0, 0, 0);
   //println("Mouse:",mouseX,mouseY);
   //println(xx,yy,zz);
   //println("Ship:",shipLocX,shipLocY,shipLocZ);
   

   
    //(shipLoxX-"30") should be changed based off ship size
    //Right Side Collison
     if((shipLocX-40)==(xx+10) && (shipLocY-40)<(yy-10) && (shipLocY+40)>(yy+10)){
       shipLocX+=30;
     }
     //Left Side Collision
      if((shipLocX+40)==(xx-10) && (shipLocY-40)<(yy-10) && (shipLocY+40)>(yy+10)){
       shipLocX-=30;   
      }
      //Bottom Side Collision
      if((shipLocY-60)==(yy+10) && (shipLocX-40)<(xx-10) && (shipLocX+40)>(xx+10)){
       shipLocY+=30;
      }
      //Top Side Collision
       if((shipLocY+40)==(yy-10) && (shipLocY-0) <(yy)&& (shipLocX-40)<(xx-10) && (shipLocX+40)>(xx+10)){
       shipLocY-=30;
      }
   }
 }
 
 boolean isOnLine(PVector v0, PVector v1, PVector p, PVector vp) {
  // Return minimum distance between line segment vw and point p
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

/*
void cord(float x, float y, float z){
 for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      posB[i][j]= new PVector(x,y,z);
  }
 }
  println(posB[2][2]);
  if (posB[2].x==shipLocX & posB[2].y==shipLocY){
    println("Contact");
  }
}
*/