
//the map will be drawn based on map_x and map_y
//array to remember all the tile images
Brick[] tileBank = new Brick[5];
//array to remember the map grid
 
int[][] mapdata={
{0,0,0},
{0,0,0},
{0,0,0},
};

 
void setup(){
  size(800,600,P3D);
   
   for(int i=0;i<mapdata.length;i++){
    for(int j=0;j<mapdata[i].length;j++){
    
      tileBank[0]=new Brick(0,0);
    }
   }
}
 
void draw(){
  background(0);
for (int i = 0; i<mapdata.length; i++) {
    tileBank[i].update();
  }

}

 
class Brick{
  float x; //brick x
  float y; //brick y
 
    Brick(float x0, float y0){
      
    x = x0;
    y = y0;
   
    }

   
  //Draws the brick
  void update(){
    pushMatrix();
    translate(x,y);
    box(25,25,25);
    popMatrix();
    
  }
}