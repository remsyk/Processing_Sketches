/*     <---- 9 tiles ---->
      /_/_/_/_/_/_/_/_/_/  ^
     /_/_/_/_/_/_/_/_/_/   |
    /_/_/_/_/_/_/_/_/_/    |
   /_/_/_/_/_/_/_/_/_/   9 tiles
  /_/_/_/_/_/_/_/_/_/      |
 /_/_/_/_/_/_/_/_/_/       |
/_/_/_/_/_/_/_/_/_/        V
 
each tile is 60x38 pixels
*/
 
//the map will be drawn based on map_x and map_y
float map_x, map_y, w, h;
//array to remember all the tile images
//PImage[] tileBank;
//array to remember the map grid

ArrayList tileBank=new ArrayList();
 
int[][] mapdata={
{0,0,0},
{0,0,0},
{0,0,0},

};
 
void setup(){
  size(800,600,P3D);
   
  w=800;
  h=600;
  map_x=w/2;
  map_y=h/2;
  //load all the images, this could be done in a loop
  //tileBank=new ArrayList();
  //tileBank[0]=box(25,25,25);
  
  for (int x = -5; x<5; x++){
    for (int z = -5; z<5; z++){
        tileBank.add(box(45));
    }
  }

   
}
 
void draw(){
  background(0);
  drawMap();
}
 
void drawMap(){
  for(int i=0;i<mapdata.length;i++){
    for(int j=0;j<mapdata[i].length;j++){
      //to see if mouse if on top, if so tint the tile to yellow
      if(dist(map_x+30*j-30*i+30,map_y+15*i+15*j+17,mouseX, mouseY)<=15){
        tint(255,202,17);
        image(tileBank[mapdata[i][j]],map_x+30*j-30*i,map_y+15*i+15*j);
        //chang tint back to white (normal color);
        tint(255);
      }else{
        image(tileBank[mapdata[i][j]],map_x+30*j-30*i,map_y+15*i+15*j);
      }
    }
  }
}
 
void keyPressed(){
  if (key == CODED) {
    //move map instead of character
    if (keyCode == UP) {
      map_y+=2;
    } else if (keyCode == DOWN) {
      map_y-=2;
    }
  if (keyCode == LEFT) {
      map_x+=2;
    } else if (keyCode == RIGHT) {
      map_x-=2;
    }
  }
   
}

void boxy(){
  box(25,25,25);
}