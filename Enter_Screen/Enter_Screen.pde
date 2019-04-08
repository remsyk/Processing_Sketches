

float s=1;
int q=1;


void setup() {
  size(600, 600, P3D);
  frameRate(20);
}
  
void draw(){
  
  rotateX(radians(40));
  background(64);
  lights();
  for(float w = 0; w <= width; w += 35){
    for(float h = 0; h <= height; h += 35){
      pushMatrix();
      translate(w, h);
      if (mousePressed==true){  
        q=0;
      }     
      if(q==0){ 
         scale(s-=.0001);
         if(s==.001){
           s=0;
         }
      }        
      noStroke();
      box(25, 25, 25);
      popMatrix();
 
 
    }
  }
}