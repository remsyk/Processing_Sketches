

PImage bg;

void setup() {
  size(558, 789,P3D);
  bg = loadImage("proto2.png");
  frameRate(5);
 //cam();
    
}

void draw() {
  background(bg);

 animation_1();
  
}