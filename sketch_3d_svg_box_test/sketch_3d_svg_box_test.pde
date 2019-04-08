PShape s;

void setup() {
  size(500, 500,P3D);
   smooth();
  s = loadShape("3box.svg");
}

void draw(){
  shape(s, 250, 250, 100, 100);
  s.translate(4,4,-.4);
  s.rotate(.04);
}