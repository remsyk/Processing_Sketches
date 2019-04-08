/* @pjs preload="logo_test.svg"; */

PShape s,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9;
float a = 0.0;
float k,l;

void setup() {
  size(300, 550);
  smooth();
  s = loadShape("logo_test.svg");

  s0 = s.getChild(0);
  s1 = s.getChild(1);
  s2 = s.getChild(2);
  s3 = s.getChild(3);
  s4 = s.getChild(4);
  s5 = s.getChild(5);
  s6 = s.getChild(6);
  s7 = s.getChild(7);
  s8 = s.getChild(8);
  s9 = s.getChild(9);

}
 
void draw() {
  background(203);
  if(keyPressed ==true){
    anim_1();
    anim_2();
    anim_3();
    anim_4();
  }
  
  else{
    shape(s,18, 65, 300, 500);
    s0.resetMatrix();
    s1.resetMatrix();
    s2.resetMatrix();
    s3.resetMatrix();
    s4.resetMatrix();
    s5.resetMatrix();
    s0.enableStyle();
    s1.enableStyle();
    s2.enableStyle();
    s3.enableStyle();
    s4.enableStyle();
    s5.enableStyle();
    s0.setVisible(true);
    s1.setVisible(true); 
    s2.setVisible(true); 
    s3.setVisible(true); 
    s4.setVisible(true); 
    s5.setVisible(true); 
  }
}


void anim_1(){
  
  if (key == '1') {   
     shape(s, 18, 65, 300, 500);
     s8.setVisible(false);
     s9.setVisible(false);
     l = sin(radians(a+=1));
     k=abs(l);
     
     if(k<.17){
        s0.setVisible(false); 
     }
     else{
        s0.setVisible(true);
     }
      
     if(k<.34 && k>.16){
       s1.setVisible(false); 
     }
     else{
       s1.setVisible(true); 
     }
       
     if(k<.51 && k>.33 ){
       s2.setVisible(false); 
     }
     else{
       s2.setVisible(true); 
     }
      
     if(k<.68 && k>.5 ){
       s3.setVisible(false); 
     }
     else{
       s3.setVisible(true); 
     }
     
     if(k<.87 && k>.67){
       s4.setVisible(false); 
     }
     else{
       s4.setVisible(true); 
     }
     
     if(k>.86){
       s5.setVisible(false); 
     }
     else{
       s5.setVisible(true); 
     }
     
     if(k==1){
       a=0;
     }
  }
}

void anim_2(){
  
     if (key == '2') {       
       shape(s, 18, 65, 300, 500);
       l = sin(radians(a+=1));
       k=abs(l);
       
     if(k<.17){
       s0.setVisible(false); 
     }
     else{
        s0.setVisible(true);
     }
      
     if(k<.34 && k>.16){
       s1.setVisible(false); 
     }
     else{
       s1.setVisible(true); 
     }
       
     if(k<.51 && k>.33 ){
       s2.setVisible(false); 
     }
     else{
       s2.setVisible(true); 
     }
      
     if(k<.68 && k>.5 ){
       s3.setVisible(false); 
     }
     else{
       s3.setVisible(true); 
     }
     
     if(k<.87 && k>.67){
       s4.setVisible(false); 
     }
     else{
       s4.setVisible(true); 
     }
     
     if(k>.86){
       s5.setVisible(false); 
     }
     else{
       s5.setVisible(true); 
     }
    /////////////////////////////////////////
    
    if(k<.17){
        s6.setVisible(false); 
     }
     else{
        s6.setVisible(true);
     }
     
      if(k<.34 && k>.16){
       s7.setVisible(false); 
     }
     else{
       s7.setVisible(true); 
     }
     
     if(k<.51 && k>.33 ){
       s8.setVisible(false); 
     }
     else{
       s8.setVisible(true); 
     }
     
      if(k<.68 && k>.5 ){
       s9.setVisible(false); 
     }
     else{
       s9.setVisible(true); 
     }
     
     
     if(k==1){
       a=0;
     }
  }
  }

 void anim_3(){
  
     if (key == '3') {       
       shape(s, 18, 65, 300, 500);
       l = sin(radians(a+=.5));
       k=abs(l);
       
       if(k<.1){
          s8.setVisible(false); 
       }
       else{
          s8.setVisible(false);
       }
       
       if(k<.2 && k>.05 ){
          s7.setVisible(false); 
       }
       else{
          s7.setVisible(true);
       }
       
       if(k<.3 && k>.1){
          s6.setVisible(false); 
       }
       else{
          s6.setVisible(true);
       }
       
       if(k<.4 && k>.15){
          s5.setVisible(false); 
       }
       else{
          s5.setVisible(true);
       }
       
       if(k<.5 && k>.2){
          s4.setVisible(false); 
       }
       else{
          s4.setVisible(true);
       }
       
       if(k<.6 && k>.25 ){
         s3.setVisible(false);
       }
       else{
         s3.setVisible(true); 
       }
       
       if(k<.7 && k>.3){
         s2.setVisible(false); 
       }
       else{
         s2.setVisible(true); 
       }
       
       if(k<.8 && k>.35 ){
         s1.setVisible(false); 
       }
       else{
         s1.setVisible(true); 
       }
       
       if(k<.9 && k>.4 ){
         s0.setVisible(false); 
       }
       else{
         s0.setVisible(true); 
       }
        
       if(k<1){
         s9.setVisible(false); 
       }
       else{
         s9.setVisible(false); 
       }
         
       
       if(k==1){
         a=0;
       }
    }
  }
  
  void anim_4(){
  
     if (key == '4') {       
       shape(s, 18, 65, 300, 500);
       s8.setVisible(false);
       s9.setVisible(false);
       l = sin(radians(a+=.5));
       k=abs(l);
       
       if(k<.125 ){
          s0.setVisible(true); 
       }
       else{
          s0.setVisible(false);
       }
       
       if(k<.25 && k>.025){
          s1.setVisible(true); 
       }
       else{
          s1.setVisible(false);
       }
       
       if(k<.375 && k>.05){
          s2.setVisible(true); 
       }
       else{
          s2.setVisible(false);
       }
       
       if(k<.5 && k>.1){
          s3.setVisible(true); 
       }
       else{
          s3.setVisible(false);
       }
       
       if(k<.625 && k>.15 ){
         s4.setVisible(true);
       }
       else{
         s4.setVisible(false); 
       }
       
       if(k<.75 && k>.2){
         s5.setVisible(true); 
       }
       else{
         s5.setVisible(false); 
       }
       
       if(k<.875 && k>.25 ){
         s6.setVisible(true); 
       }
       else{
         s6.setVisible(false); 
       }
       
       if(k<1 && k>.3 ){
         s7.setVisible(true); 
       }
       else{
         s7.setVisible(false); 
       }
        
       if(k==1){
         a=0;
       }
       
    }
  }