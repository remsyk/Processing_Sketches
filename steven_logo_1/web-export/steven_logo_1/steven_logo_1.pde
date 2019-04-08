/* @pjs preload="logo1.svg"; */
/* @pjs globalKeyEvents=true; */  
  
Branch tree;
float windAngle = 0;
float minX;
float maxX;
float minY;
float maxY;
int blinkUpdate;
String typedText;
String lastSeed;
PImage leaveImage;
float spin=0;
PShape sk;
PShape c1;
PShape c2;
PShape c3;
PShape c4;
float xx;

var curContext; // Javascript drawing context (for faster rendering)
 

void setup() {
    size(400, 200, P2D); // Set screen size & renderer
    textFont(createFont("Verdana", 24, true), 24); // Create font
   PGraphics back = createGraphics(width, height, P2D);
    leaveImage = createLeaveImage();
    createNewTree(getRandomSeed());
    curContext = externals.context; // Get javascript drawing context
    sk = loadShape("logo1.svg");
    smooth();
    c1 = sk.getChild("3"); //3 4 5 6
    c2 = sk.getChild("4"); //3 4 5 6
    c3 = sk.getChild("5"); //3 4 5 6
    c4 = sk.getChild("6"); //3 4 5 6
}
 

String getRandomSeed() {
    randomSeed(millis());
    return ((int)(random(9999999)+random(999999)+random(99999))).toString(36);
}
 

PImage createLeaveImage() {
    PGraphics buffer = createGraphics(12, 18, P2D);
    buffer.beginDraw();
    buffer.background(#000000, 0);
    buffer.stroke(#5d6800);
    buffer.line(6, 0, 6, 6);
    buffer.noStroke();
    buffer.fill(#749600);
    buffer.beginShape();
    buffer.vertex(6, 6);
    buffer.bezierVertex(0, 12, 0, 12, 6, 18);
    buffer.bezierVertex(12, 12, 12, 12, 6, 6);
    buffer.endShape();
    buffer.fill(#8bb800);
    buffer.beginShape();
    buffer.vertex(6, 9);
    buffer.bezierVertex(0, 13, 0, 13, 6, 18);
    buffer.bezierVertex(12, 13, 12, 13, 6, 9);
    buffer.endShape();
    buffer.stroke(#659000);
    buffer.noFill();
    buffer.bezier(6, 9, 5, 11, 5, 12, 6, 15);
    buffer.endDraw();
    return buffer.get();
}


void createNewTree(String seed) {
    lastSeed = seed;
    randomSeed(seed.hashCode()); // Set seed
    minX = width/2;
    maxX = width/2;
    minY = height;
    maxY = height;
    tree = new Branch(null, width/2, height, PI, 110);
    float xSize = maxX-minX;
    float ySize = maxY-minY;
    float scale = 2;
    if(xSize > ySize) {
        if(xSize > 275)
            scale = 275/xSize;
    } else {
        if(ySize > 270)
            scale = 270/ySize;
    }
    tree.setScale(scale);
    tree.x = width-width + 200; //control tree position on x
    tree.y = height+230; //control tree position on y
    blinkUpdate = -1;
    typedText = "";
}

 
void draw() {
  
    background(#FFFFFF);  
    scale(0.5);
    c1.translate((-sin(windAngle) * 0.06),0); //big right one
    c2.translate((-sin(windAngle) * 0.05),0); //big left one
    c3.translate((-sin(windAngle) * 0.04),0); //top one
    c4.translate((-sin(windAngle) * 0.02),0); //little one
    shape(sk, 0, 0, 800,400);
    noStroke();
    noFill();
    windAngle += 0.003;
    tree.windForce = sin(windAngle) * 0.02;
    tree.update();
    tree.render();
    blinkUpdate;  
}

void mouseClicked() {
    createNewTree(getRandomSeed());
}

class Branch {
 
    float x;
    float y;
    float angle;
    float angleOffset;
    float length;
    float growth = 0;
    float windForce = 0;
    float blastForce = 0;
    Branch branchA;
    Branch branchB;
    Branch parent;
  
    Branch(Branch parent, float x, float y, float angleOffset, float length) {
        this.parent = parent;
        this.x = x;
        this.y = y;
        if(parent != null) {
            angle = parent.angle+angleOffset;
            this.angleOffset = angleOffset;
        } else {
            angle = angleOffset;
            this.angleOffset = -0.2+random(0.4);
        }
        this.length = length;
        float xB = x + sin(angle) * length;
        float yB = y + cos(angle) * length;
        if(length > 10) {
            if(length+random(length*10) > 30)
                branchA = new Branch(this, xB, yB, -0.1-random(0.4) + ((angle % TWO_PI) > PI ? -1/length : +1/length), length*(0.6+random(0.3)));
            if(length+random(length*10) > 30)
                branchB = new Branch(this, xB, yB, 0.1+random(0.4) + ((angle % TWO_PI) > PI ? -1/length : +1/length), length*(0.6+random(0.3)));
            if(branchB != null && branchA == null) {
                branchA = branchB;
                branchB = null;
            }
        }
        minX = min(xB, minX);
        maxX = max(xB, maxX);
        minY = min(yB, minY);
        maxY = max(yB, maxY);
    }
     

    void setScale(float scale) {
        length *= scale;
        if(branchA != null) {
            branchA.setScale(scale);
            if(branchB != null)
                branchB.setScale(scale);
        }
    }
     
   
    float update() {
        if(parent != null) {
            x = parent.x + sin(parent.angle) * parent.length * parent.growth;
            y = parent.y + cos(parent.angle) * parent.length * parent.growth;
            windForce = parent.windForce * (1.0+5.0/length) + blastForce;
            blastForce = (blastForce + sin(x/2+windAngle)*0.005/length) * 0.98;
            angle = parent.angle + angleOffset + windForce + blastForce;
            growth = min(growth + 0.1*parent.growth, 1);
        } else
            growth = min(growth + 0.1, 1);
        if(branchA != null) {
            branchA.update();
            if(branchB != null)
                branchB.update();
        }
      return x;
    }
      

    void render() {
        if(branchA != null) {
            float xB = x;
            float yB = y;
            if(parent != null) {
                xB += (x-parent.x) * 0.4;
                yB += (y-parent.y) * 0.4;
            } else {
                xB += sin(angle+angleOffset) * length * 0.3;
                yB += cos(angle+angleOffset) * length * 0.3;
            }
            
            curContext.beginPath();
            curContext.moveTo(x, y);
            curContext.bezierCurveTo(xB, yB, xB, yB, branchA.x, branchA.y);
            int branchColor = floor(1100/length);
            curContext.strokeStyle = "rgb("+branchColor+","+branchColor+","+branchColor+")";
            curContext.lineWidth = length/5;
            curContext.stroke();
            branchA.render();
            if(branchB != null)
                branchB.render();
        } else {
            pushMatrix();
            translate(x, y);
            rotate(-angle);
             image(leaveImage, -leaveImage.width/2, 0);
            popMatrix();
        }
    }
     
    
}