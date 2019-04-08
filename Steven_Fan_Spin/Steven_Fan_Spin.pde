PImage img;  // Declare variable "a" of type PImage

void setup() {
  size(600, 600);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("fan1.png");  // Load the image into the program  
}

void draw() {
  // Displays the image at its actual size at point (0,0)
  //image(img, 0, 0);
  // Displays the image at point (0, height/2) at half of its size
 
  image(img, 40, 60, img.width, img.height);
  fan();
}

class fan {
  float x;
  float y;
  
  fan(float px, float py){
    x = px;
    y = py;
  }
  
  void makeFan(){
    fill(#E88363);
    ellipse(x,y,30,30);
    
    pushMatrix();
    translate(x,y);
    rect(-7.5,20,15,50);
    rect(-2.5,0,5,20);
    popMatrix();
    
    pushMatrix();
    translate(x,y);
    rotate(2*PI/3);
    rect(-7.5,20,15,50);
    rect(-2.5,0,5,20);
    popMatrix();
  
    pushMatrix();
    translate(x,y);
    rotate(-PI/2-PI/6);
    rect(-7.5,20,15,50);
    rect(-2.5,0,5,20);
    popMatrix();
  }
  
  void rotateFan(){
    
  }
}