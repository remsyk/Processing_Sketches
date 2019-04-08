PShape s, roof;
PImage ho, hm, hh;
int ww = 1600;
int hu = 1300;
boolean l =false;
float n = 1;


void setup() {
  size(1000,1000);
  s = loadShape("house.svg");
  ho = loadImage("test1.png");
  hm = loadImage("h.png");
  hh = loadImage("logo_test.png");
  smooth();
  roof = s.getChild(4);
} 


void draw(){
  background(203);
  shape(s,-250,-150,ww,hu);

  if (mouseX< (ww/2)+(ww/10) && mouseX>(ww/2)-(ww/3)&& mouseY<(hu/2)+(hu/3) && mouseY>(hu/2)-(hu/3)){
    roof.setVisible(false);
    
  //bathtub
  house(ho, 617, 238, 25,25);
  //basement
  house(ho, 671, 577, 25,25);
  //kitchen
  house(ho, 488, 603, 25,25);
  //bedroom window
  house(ho, 688, 304, 25,25);
  //office
  house(ho, 555, 420, 25,25);
  }
  else{
    roof.setVisible(true);
    image(hh,0,0,165,95);
  }

 // println(mouseX,mouseY);
  
}

 void house(PImage k, float x, float y, float w, float h){
   if (mouseX > x-w && mouseX < x+w && mouseY > y-h && mouseY < y+h){
     l = true;
   }
   else{
     l = false;
   }
  pushMatrix();
  noFill();
  image(hm,x,y,w,h);
   
  if (l){
   w+=500;
   h+=500;
   image(k,0,0,w,h);
  }
  else{
    image(hh,0,0,165,95);
  }
    popMatrix();
}