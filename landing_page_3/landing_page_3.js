
var s = null,roof = null;
var ho = null,hm = null,hh = null;
var w =  1600;
var h =  1300;
var l = false;
var n =  1;

function setup() {
$p.size(800,800);
  s = $p.loadShape("house.svg");
  ho = $p.loadImage("test1.png");
  hm = $p.loadImage("h.png");
  hh = $p.loadImage("logo_test.png");
  $p.smooth();
  roof = s.getChild(4);
}
$p.setup = setup;

function draw() {
$p.background(203);
  $p.shape(s,-350,-150,w,h);

  if ($p.mouseX< (w/2)+(w/10) && $p.mouseX>(w/2)-(w/4)&& $p.mouseY<(h/2)+(h/3) && $p.mouseY>(h/2)-(h/3)){
roof.setVisible(false);
}
  else{
roof.setVisible(true);
}
  house(ho, $p.width/4, $p.height/4, 30,30);
}
$p.draw = draw;

 function house(k, x, y, w, h) {
if ($p.mouseX > x-w && $p.mouseX < x+w && $p.mouseY > y-h && $p.mouseY < y+h){
l = true;
}
   else{
l = false;
}
  $p.pushMatrix();
  $p.noFill();
   $p.image(k,x,y,w,h);

  if (l){
w+=600;
   h+=400;
}

  $p.image(hh,0,0,w+140,h+70);
  $p.popMatrix();
}
$p.house = house;