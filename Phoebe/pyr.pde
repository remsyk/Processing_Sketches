

void pyr(float x,float y,float z,float Rotate_Y, float Scalar, float Rotate_Z, float Red, float Green, float Blue, float Stroke_R, float Stroke_B, float Stroke_G, float Stroke_W ){
  
  pushMatrix();
  rotateY(radians(Rotate_Y));
  stroke(Stroke_R,Stroke_B,Stroke_G);
  strokeWeight(Stroke_W);
  fill(Red,Green,Blue);
  translate(0,0,z);
  rotateZ(PI/Rotate_Z);
  scale(Scalar);
  triangle(y+27, -x+74, y+58, -x+20, y+90, -x+74);
  popMatrix();
  
}