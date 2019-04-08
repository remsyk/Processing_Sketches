
float s = 0;
float r;
boolean circleOver = false;


void setup (){
  size (400,400,P2D);
  frameRate(30);
 
}

void draw(){
  update(mouseX,mouseY);
  background(100);
  
  s+=1;
  fill(#330066,50);
  ellipse(width/2, height/2, s+75, s+75);
  if(s==150){
    s=0;
  }
  
  pushStyle();
  fill(#330066);
  ellipse(width/2, height/2, 150, 150);
  popStyle();
  
  if (circleOver && mousePressed) {
    r = (int)random(100);
  }
 
    if (r%10==0){
    pushStyle();
      fill(#FFFFFF);
      textSize(32);
      text("Shark",(width/2)-50,(height/2)+10);
      popStyle();
    }
    if (r%10!=0){
      pushStyle();
      fill(#FFFFFF);
      textSize(32);
      text("Minnow",(width/2)-50,(height/2)+10);
      popStyle();
    }
}


void update(int x, int y) {
  if ( overCircle(width/2, height/2, 100) ) {
    circleOver = true;
  } 
   else {
    circleOver = false;
  }
}


boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}