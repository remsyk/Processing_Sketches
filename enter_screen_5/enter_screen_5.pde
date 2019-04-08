

 
int rows = 10; //Number of bricks per row
int columns = 10; //Number of columns
int total = rows * columns; //Total number of bricks
 
Brick[][] box = new Brick[rows][columns]; //Initialize the array that will hold all the bricks

void setup()
{
  size(600, 600,P3D);
  background(0);
  smooth();
 
  //Setup array of all bricks on screen
  for (int i = 0; i < rows; i++){
    for (int j = 0; j< columns; j++){
      //box[i*rows + j] = new Brick((i+1) *width/(rows + 2), (j+1) * 50); 
      //box[i*rows + j] = new Brick((i+1) *width/(rows + 2), (j+1) * 50 ); 
      box[i][j]= new Brick(i,j);
    }
  }
}
 
 
void draw(){
  background(0);
  
  for (int i = 0; i < rows; i++){
    for (int j = 0; j< columns; j++){
      box[i][j].update();
      
    }
  }
 /*
  //Draw bricks from the array of bricks
  for (int i = 0; i<total; i++) {
    box[i].update();
    /*
    //if(box[i].x- box[i].w/2>= mouseX && box[i].y- box[i].h/2>= mouseY){
      if (mouseX >= box[i].x && mouseX <= box[i].x+width && 
      mouseY >= box[i].y && mouseY <= box[i].y+height) {
      box[i].isOver();
    }
  }
  */

}
   
 
 
class Brick{
  float x; //brick x
  float y; //brick y
  float w; //paddle width
  float h; //paddle height
  float d; //paddle depth



  boolean over;
 
    Brick(float x0, float y0){

    x = x0;
    y = y0; 
    
    w=25;
    h=25;
    d=25;
    over=false;
    }
   
  //Draws the brick
  void update(){
    pushMatrix();
    translate(x,y);
    box(w,h,d);
    popMatrix();
    
    
  } 
  void isOver(){
   over=true;
   translate(0,0,10);
  }
}
 