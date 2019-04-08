
import peasy.*;

PeasyCam cam;


void setup()
{
    size(800, 500, P3D);
    
    int sizeX, sizeY ;
    int gridSizeX, gridSizeY;
    sizeX = width; sizeY = height;
    gridSizeX = int((sizeX + sizeY)/2) ;
    gridSizeY = int((sizeX + sizeY)/2);
    cam = new PeasyCam(this, sizeX/2 , sizeY/2, 0, 600);  // default settings on double click
    cam.setMinimumDistance(.001);
    cam.setMaximumDistance(50000);
    cam.setRotations( -0.7301672, -0.274728, 0.30156484); 
    
}  

int constant = 250;
float angle = 0.05;
int scalar = 200;
float speed = 0.01;
void draw()
{
    background(150);
    lights();
    fill(255, 128, 0);
    
    //base of light house
    pushMatrix();    
    //translate( 120, 330, 0 );
    translate(width/2, height/2);
    rotateX(radians(90));
    //noStroke();
    drawCylinder( 7, 50, 350 );
    popMatrix();
    
    //shaft of light house
    pushMatrix();
    translate(width/2, 420, -10);
    rotateX(radians(90));
    drawCylinder(10, 150, 10);
    popMatrix();
    
    //balcony of light house
    pushMatrix();
    translate(width/2, 140,0);
     rotateX(radians(90));
    drawCylinder(7, 70, 10);
    popMatrix();
  
    //top of the light house
    pushMatrix();    
    translate( width/2, 50, 0 );
    rotateX( radians(90));
    //rotateY( radians( frameCount ) );
    //rotateZ( radians( frameCount ) );
     drawCone( 8, 60, 5, 40 );    
     popMatrix();
    
    //first cube and or test cube
    pushMatrix();
    float x = constant + sin(angle) * scalar;
    float z = constant + cos(angle) * scalar;
    float y=150;
    angle = angle + speed;
    translate(150+x,150,-300+z); 
    //rotateX(radians(frameCount/3));
    //rotateY(radians(frameCount/3));
    
    if (mouseX >= x-150 && mouseX <= 150+x && 
      mouseY >= 140 && mouseY <=160 ) {
        if(mousePressed){
          fill(255,255,255);
        }
      }
    box(25,25,25);
    popMatrix();
    
}

void drawCylinder( int sides, float r, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
        vertex( x, y, -halfHeight);    
    }
    endShape(CLOSE);

}

void drawCone( int sides, float r1, float r2, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r1;
        float y = sin( radians( i * angle ) ) * r1;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r2;
        float y = sin( radians( i * angle ) ) * r2;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x1, y1, -halfHeight);
        vertex( x2, y2, halfHeight);    
    }
    endShape(CLOSE);

}