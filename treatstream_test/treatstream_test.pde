void setup(){
  size (300,300, P3D);
  smooth();
  frameRate(20);
}

void draw(){
  background(240);
  lights();
  noStroke();
  fill(248, 190, 38, 150);
  pushMatrix();
  translate(width/2, height/2);
  rotateX(frameRate);
  ambientLight(40,40,40);
  directionalLight(255, 255, 255, -150, 40, -140);
  sphere(50);
  popMatrix();
}
  