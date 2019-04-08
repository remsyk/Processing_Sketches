Brick [][] map;
 int cols = 5;
 int rows = 5;

void setup(){
  size(600, 600,P3D);
  map = new Brick[cols][rows];

  for (int w = 0; i < width; w++) {
    for (int h = 0; j < height; j++) {
      // Initialize each object
      map[j][i] = new Brick(j,i);
    }
  }
}

void draw(){
  background(0);
  lights();
   //<>//
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      map[j][i].k();
    
    }
  }
}

class Brick{ //<>//
  float x,y;
  
  Brick(float tempX, float tempY){
    x = tempX;
    y = tempY;
  }
  
 void k(){
  pushMatrix();
  translate(width/2, height/2);
  rotateX(.5);
  translate(x,y);
  box(30); 
  popMatrix();
 }
}