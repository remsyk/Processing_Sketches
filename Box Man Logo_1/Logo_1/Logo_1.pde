// Pixel-sized particles version, of 'surfs_up'.
// Particles are now directly noise driven omitting the flow field.
// Array[], particle, pixel, noise()
// Mouse click to reset, mouseX adjusts background clear.
 
Particle[] particles;
float alpha;
PImage img;


 
void setup() {
  size(224, 256);
  background(0);
  setParticles();
  img= loadImage ("logo1.png");
}
 
void draw() {
  frameRate(20);
  alpha = map(0, 0, width, 5, 35);
  fill(0,alpha);
  rect(0, 0, width, height);
  translate(0,0);

  image (img, 0 , 0);
  translate(14,14);

 
 if (frameCount % 300==0){
   setParticles();
   //Stop draw();
   noLoop();
 }
  loadPixels();
  for (Particle p : particles) {
    p.move();
  }
  updatePixels();
  
  //saveFrame("logo1/frames####.tif");
}
 
void setParticles() {
  particles = new Particle[600];
  for (int i = 0; i < 600; i++) {
    float x = random(width);
    float y = random(height);
    float adj = map(y, 0, height, 255, 0);
    int c = color(100, adj, 245);
    particles[i]= new Particle(x, y, c);
  }
  
}
 
 
class Particle {
  float posX, posY, incr, theta;
  color  c;
 
  Particle(float xIn, float yIn, color cIn) {
    posX = xIn;
    posY = yIn;
    c = cIn;
  }
 
  public void move() {
    update();
    wrap();
    display();
  }
 
  void update() {
    incr +=  .008;
    theta = noise(posX * .006, posY * .004, incr) * TWO_PI;
    posX += 2; //* cos(theta);
    posY -= 2; //* sin(theta);
    
  }
 
  void display() {
    if (posX > 0 && posX < width && posY > 0  && posY < height) {
      pixels[(int)posX + (int)posY * width] =  c;
    }
  }
 
  void wrap() {
    if (posX < 0) posX = width;
    if (posX > width ) posX =  0;
    if (posY < 0 ) posY = height;
    if (posY > height) posY =  0;
  }
}