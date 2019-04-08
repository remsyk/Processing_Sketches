int rows = 5;
int columns=5;
int total= rows * columns;
Brick[][] box = new Brick[rows][columns];

void setup() {
  size(600, 600, P3D);
  //frameRate(20);
  
  for (int i = 0; i < rows; i++){
     for (int j = 0; j< columns; j++){
      box[i][j] = new Brick(2,3);     
    }
  }
}
  
void draw(){
  background(100);
  translate(width/2, height/2);
  pushMatrix();
 for (int i = 0; i<total; i++){
    box[i][i].update();
  }
  popMatrix();
}

class Brick{
  Brick(int x0, int y0){
  }
  void update(){
    box(50,50,50);
  }
}