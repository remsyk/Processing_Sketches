import processing.opengl.*;
 
float R_x =0;
float R_y =0;
PImage img;

void setup(){
size(300, 300, OPENGL);
//smooth();
img= loadImage ("2.png");
}
 
void draw() {
  background(0);
  translate(width /2 , height /2);
  beginShape();
  texture(img);
  rotateY(R_y);
  rotateX(R_x);
  R_y+=0.01;
  vertex(-100, -100, 0, 0,   0);
  vertex( 100, -100, 0, 700, 0);
  vertex( 100,  100, 0, 700, 700);
  vertex(-100,  100, 0, 0,   700);
  endShape();
}