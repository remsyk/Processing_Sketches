 float a = 0.0;
float b = 0.0;
float c = 0.0;
float s = 0.0;


void setup(){
  size(450,100);
  //background(0);
  frameRate(20);
  noStroke();
}

void draw(){
  //scale(-1, 1);
  //translate(-width,0 /*-height*/);
  
  background(240);
  
 a = a + 0.12;
 s = sin(a);
 
  scale(s+.01);
  fill(10, 150, 200);
  triangle( 90, 50,
            30, 20, 
            30, 80);
            
  translate(100, 0);
  scale(s+.02);
  fill(10, 150, 200);
  triangle( 90, 50,
            30, 20, 
            30, 80);
 
 translate(110, 0);
  scale(s+.03);
  fill(10, 150, 200);
  triangle( 90, 50,
            30, 20, 
            30, 80);
            
 translate(120, 0);
  scale(s+.03);
  fill(10, 150, 200);
  triangle( 90, 50,
            30, 20, 
            30, 80);
            
            
            
            
       
}
 