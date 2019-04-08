/**
 Determines whether a point'c' is close to a line from
 'a' to 'b' <br>
 If the point is close enough then the point haloe will be green else it is red. <br>
 It works by calculating the point nearest point (pj)  on the line to the point 'c'.
 It then determoines whether 'pj' is inside the line segment a-->b and that the dist
 c<>pj is less than a closeness value.
 */
 
PVector a, b, c, pj;
float closeness;
 
public void setup() {
  size(400, 400);
  a = new PVector(121, 87);
  b = new PVector(299, 322);
  c = new PVector(160, 410);
  pj = new PVector();
  closeness = 1;
}
 
public void draw() {
  background(255);
  // Offset the cursor so we can see what is happening
  c.set(mouseX - 20, mouseY - 20);
  // Is c on the line a --> b
  // pj is the nearest point on the line
  boolean ol = isOnLine(a, b, c, pj);
 
  noFill();
  stroke(160);
  strokeWeight(1.1);
  line(a.x, a.y, pj.x, pj.y);
  line(c.x, c.y, pj.x, pj.y);
  stroke(0);
  strokeWeight(1.5);
  line(a.x, a.y, b.x, b.y);
  noStroke();
  ellipse(a.x, a.y, 4, 4);
  ellipse(b.x, b.y, 4, 4);
  // Point halo
  if (ol)
    fill(0, 255, 0, 64);
  else
    fill(255, 0, 0, 64);
  ellipse(c.x, c.y, 20, 20);
  // Point
  fill(0);
  ellipse(c.x, c.y, 4, 4);
}
 
boolean isOnLine(PVector v0, PVector v1, PVector p, PVector vp) {
  // Return minimum distance between line segment vw and point p
  PVector the_line = PVector.sub(v1, v0);
  float l2 = the_line.mag();
  l2 = l2 * l2;
  if (l2 == 0.0) {
    vp.set(v0);
    return false;
  }
  PVector pv0_line = PVector.sub(p, v0);
  float t = pv0_line.dot(the_line)/l2;
  pv0_line.normalize();
  vp.x = the_line.x * t + v0.x;
  vp.y = the_line.y * t + v0.y;
  float d = sqrt((p.x-vp.x)*(p.x-vp.x) +(p.y-vp.y)*(p.y-vp.y)); 
  if (t >= 0 && t <= 1 && d <= closeness)
    return true;
  else
    return false;
}