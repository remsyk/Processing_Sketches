//arrays
ArrayList zombies;
ArrayList cannons;

//zombie variables
float timer = 0; 
float zomspeed = 0.5;
float zomspawntime=10;

//tank variables
float tanklocx=250;
float tanklocy=250;
float tankdir = 0;
float tankcandir = 0;
float tanklife = 200;
float canfiretime=0;
float directionX = 0.0;
float directionY = 0.0;
float rotation = 0.0;
float x = 0.0;
float y = 0.0;


void setup(){
  
  size(500,500);
  background(255);
  zombies = new ArrayList();
  cannons = new ArrayList();

}

void draw(){
  background(255);
  timer+= .1;
  if(timer>=zomspawntime){
  zombies.add(new Zombie(zomspeed,tanklocx,tanklocy));
  zomspawntime = zomspawntime +10;
  }
  
  //tankcandir=lookAt();
  
  fill(0);
  /*
  //changes the direction of the tank's cannon
  if(keyPressed){
    if(keyCode==LEFT){
      tankcandir=3.14*1.5;
    }
    if(keyCode==UP){
      tankcandir=0;
    }
    if(keyCode==RIGHT){
      tankcandir=3.14/2;
    }
    if(keyCode==DOWN){
      tankcandir=3.14;
    }
  }
 */
 
  
  //changes the direction and position of the tank's frame 
  if(keyPressed){
    if(key=='a'){
      tankdir=3.14*1.5;
      tanklocx-=5;
    }
    if(key=='w'){
      tankdir=0;
      tanklocy-=5;
    }
    if(key=='d'){
      tankdir=3.14/2;
      tanklocx+=5;
    }
    if(key=='s'){
      tankdir=3.14;
      tanklocy+=5;
    }
  }
  
  //fires a cannon for every 10 frames if you press/hold the space bar
  if(keyPressed && canfiretime<timer){
    if(key==' '){
      //send the tanklocs/y and cannon direction to the cannon class
      cannons.add(new Cannon(tanklocx,tanklocy,tankcandir));
      canfiretime = timer + 1;
    }
  }
  
  //sends the tanklocx/y and tank direction to the tankframe method to make the frame
  tankFrame(tanklocx,tanklocy,tankdir);
  //sends the tanklocx/y and cannon direction to the tankCannon method to make the cannon
  tankCannon(tanklocx,tanklocy, lookAt());
  
  //updates and displays the zombie objects
  //it also sends each zombie the location of the tank
  for(int i = zombies.size()-1; i >=0;i--){
    Zombie zombie = (Zombie)zombies.get(i);
    
    zombie.dest(tanklocx,tanklocy);
    zombie.update();
    zombie.display();
    
  }
  
  //udates and displays the cannons
  for(int i = cannons.size()-1; i >=0;i--){
    Cannon cannon = (Cannon)cannons.get(i);
    
    cannon.update();
    cannon.display();
    //detects and deletes the cannon if it is out of bounds
    if(cannon.locX>=550){
      cannons.remove(i);
    }
    if(cannon.locY>=550){
      cannons.remove(i);
    }
    if(cannon.locX<=-50){
      cannons.remove(i);
    }
    if(cannon.locY<=-50){
      cannons.remove(i);
    }
  }
  
  //takes the hitbox of the cannon to detect if it is hitting the hitbox of any zombies
  //if true then it will delete any of the zombies that are touching the cannon
  //then it will set remove to true so that after contacting the zombies are done
  //the cannon will be removed
  for(int i = cannons.size()-1; i >=0;i--){
    Cannon cannon = (Cannon)cannons.get(i);
    boolean remove = false;
      for(int j = zombies.size()-1; j >=0;j--){
      Zombie zombie = (Zombie)zombies.get(j);
      
      if(zombie.locX+15>=cannon.locX-10&&zombie.locX-15<=cannon.locX+10&&zombie.locY+15>=cannon.locY-10&&zombie.locY-15<=cannon.locY+10){
        zombies.remove(j);
        remove = true;
      }
      
      
    }
    if(remove){
      cannons.remove(i);
    }
  }
}

//creates the tank's cannon
void tankCannon(float tx,float ty, float td){
  pushMatrix();
  if(mouseX != pmouseX || mouseY != mouseY){
  // mouse has moved since last frame so calculate new angle
   tankcandir = atan2(mouseY - pmouseY, mouseX - pmouseX);
  }
  translate(tx,ty);
  rotate(tankcandir);
  beginShape();
  vertex(5,0);
  vertex(5,-40);
  vertex(-5,-40);
  vertex(-5,0);
  endShape();
  popMatrix();
}



//creates the tank's frame
void tankFrame(float tfx,float tfy, float tfd){
    pushMatrix();
    translate(tfx,tfy);
    rotate(tfd);
    fill(#05431D);
    beginShape();
    triangle(-30, 35, 0, -20, 36, 35);
    endShape();
    popMatrix();
}
  

float lookAt(){
   rotation = degrees(atan2(mouseY-y, mouseX-x));
   directionX = cos(radians(rotation));
   directionY = sin(radians(rotation));
   return rotation;
}


//I should have named it CannonBall
class Cannon{
  //cannon ball variables
  float locX;
  float locY;
  
  float dir;
  
  
  //sets the data based on the info it receives
  Cannon(float x,float y, float d){
    locX = x;
    locY = y;
    dir = d; 
  }
 
  //depending on the direction the tanks cannon is aiming will
  //determine the path of the cannon ball
  void update(){
    if(dir == 3.14*1.5){
      locX-=5;
    }
    if(dir == 0){
      locY-=5;
    }
    if(dir == 3.14/2){
      locX+=5;
    }
    if(dir == 3.14){
      locY+=5;
    }
  }
  
  
  //displays the cannon ball based on its location
  void display(){
    pushMatrix();
    fill(50);
    translate(locX,locY);
    ellipse(0,0,20,20);
    popMatrix();
  } 
}


class Zombie{
  
  //zombie variables
  float locX;
  float locY;
  float destx;
  float desty;
  float dir;
  float speed;
  int rand = (int)random(1,5);
  
  //sets the data based on the info it receives
  Zombie(float s, float dx, float dy){
    //when the zombie is created the rand variable will determine where
    //the zombie will spawn
    if(rand == 1){
      locX = random(0,500);
      locY = -25;
    }
    if(rand == 2){
      locX = random(0,500);
      locY = 525;
    }
    if(rand == 3){
      locX = -25;
      locY = random(0,500);
    }
    if(rand >= 4){
      locX = 525;
      locY = random(0,500);
    }
    speed = s;
    destx=dx;
    desty=dy;
  }
  
  //changes the zombie's destination
  void dest(float tx,float ty){
    destx=tx;
    desty=ty;  
  }
  
  
  void update(){
    //this will change the direction and location of the zombie
    //based on the destination/location of the tank
    if(desty>=locY+20){
      locY+=speed;
      dir=0;
    }
    if(desty<=locY-20){
      locY-=speed;
      dir=3.14;
    }
    if(destx>=locX+20){
      locX+=speed;
      dir=3.14*1.5;
    }
    if(destx<=locX-20){
      locX-=speed;
      dir=3.14/2;
    }
  }
  
  //displays the zombie based on it's location and direction
  void display(){
    
    pushMatrix();
    fill(#00762E);
    translate(locX,locY);
    rotate(dir);
    
    ellipse(10,5,10,20);
    ellipse(-10,5,10,20);
    ellipse(0,0,20,20);
    
    popMatrix();
  }
}