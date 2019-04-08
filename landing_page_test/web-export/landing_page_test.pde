
PShape s;

void setup() {
  size(200, 200);
  s = loadShape("test.svg");
  
}

void draw() {
    s = loadShape("test.svg");
    shape(s, 0, 0, 200, 200);
}