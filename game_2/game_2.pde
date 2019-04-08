float[][] distances;
float maxDistance;
int spacer;

void setup() {
  size(640, 360, P3D);
  maxDistance = dist(width/2, height/2, width, height);
  distances = new float[width][height];
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      float distance = dist(width/2, height/2, x, y);
      distances[x][y] = distance/maxDistance * 255;
    }
  }
  spacer = 20;
  //strokeWeight(6);
  noLoop();  // Run once and stop
}

void draw() {
  lights();
  background(0);
  // This embedded loop skips over values in the arrays based on
  // the spacer variable, so there are more values in the array
  // than are drawn here. Change the value of the spacer variable
  // to change the density of the points
  for (int y = 0; y < height; y += spacer) {
    for (int x = 0; x < width; x += spacer) {
      stroke(distances[x][y]);
      pushMatrix();
      translate(x + spacer/2, y + spacer/2);
      rotateX(.5);
      box(10);
      popMatrix();
      //point(x + spacer/2, y + spacer/2);
    }
  }
}