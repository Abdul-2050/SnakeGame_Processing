// control variables
boolean left;
boolean right;
boolean up;
boolean down;

// allBody
int ALL_BODY;

// snake location
final int[]sX = new int[800];
final int[]sY = new int[600];

// food location
int fX, fY;

// snake length
int sLen;

// body Size
int bodyS;

// play state
boolean play;

// images
PImage downMouth;
PImage upMouth;
PImage rightMouth;
PImage leftMouth;
PImage body;
PImage food;

// score
int score=0;
int bestScore=0;

// fonts
PFont scoreF;

// speed
final int speed= 10;

void setup() {
  size(800, 600);
  surface.setTitle("Snake Game (Elena)");
  frameRate(speed);
  smooth();

  left= false;
  right= false;
  up = false;
  down = false;

  sLen= 3;
  bodyS= 25;

  ALL_BODY = ((width * height) / bodyS);
  println(ALL_BODY);

  //sX = new int[ALL_BODY];
  // sY =  new int[ALL_BODY];

  moveSnakeAtFirst();
  locateFood();

  // itialize images
  downMouth = loadImage("downmouth.png");
  upMouth= loadImage("upmouth.png");
  rightMouth= loadImage("rightmouth.png");
  leftMouth= loadImage("leftmouth.png");
  body= loadImage("snakeimage.png");
  food= loadImage("enemy.png");
  
  scoreF= createFont("Arial Bold", 28);

  play= true;
}


void draw() {
  // background
  background(44, 62, 80);
  makeDesign();

  showSnake();
  if (play) {
    moveSnake();
    showFood();
    checkFoodIntersection();
    checkCollision();
  }

  // score
  textSize(30);
  fill(236, 240, 241);
  textFont(scoreF);
  text("Now: "+ score, width- (width-20), 44);
  text("Best: "+ bestScore, width-120, 44);
  if (score > bestScore) {
    bestScore= score;
  }

  lose();
  restart();

  // testing
  if (sX[0] %25 != 0) {
    println("X " + sX[0]);
  }

  if (sY[0] %25 != 0) {
    println("Y " + sY[0]);
  }
  
}

void makeDesign() {
  for (int a=0; a< width; a+= bodyS+bodyS) {
    for (int b=0; b< height; b+=bodyS+ bodyS) {
      noStroke();
      fill(37, 50, 67);
      rect(a, b, bodyS, bodyS, 5);
    }
  }

  for (int a=bodyS; a< width; a+= bodyS+bodyS) {
    for (int b=bodyS; b< height; b+=bodyS+ bodyS) {
      fill(32, 41, 55);
      rect(a, b, bodyS, bodyS, 5);
    }
  }
}

void lose() {
  if (!play) {
    fill(46, 204, 113);
    textSize(25);
    text("Enter 'r' to Restart ", width/2-100, height/2);
  }
}

void moveSnakeAtFirst() {
  // first 3 bodys
  for (int a=0; a<=sLen; a++) {
    sX[a] = 75 - a*bodyS;
    sY[a] = 75;
  }
}

void moveSnake() {
  for (int a=sLen; a > 0; a--) {
    sX[a] = sX[a -1];
    sY[a] = sY[a -1];
  }


  if (left) {
    sX[0] -= bodyS;
  }

  if (right) {
    sX[0] += bodyS;
  }

  if (up) {
    sY[0] -= bodyS;
  }

  if (down) {
    sY[0] += bodyS;
  }
  // println("Y "+sY[0]);
}


void showSnake() {
  for (int a =0; a < sLen; a++) {
    if (a == 0) {
      if (right) {
        image(rightMouth, sX[a], sY[a], bodyS, bodyS);
      }

      if (left) {
        image(leftMouth, sX[a], sY[a], bodyS, bodyS);
      }
      if (up) {
        image(upMouth, sX[a], sY[a], bodyS, bodyS);
      }
      if (down) {
        image(downMouth, sX[a], sY[a], bodyS, bodyS);
      }
    } else {
      image(body, sX[a], sY[a], bodyS, bodyS);
    }
  }
}

void showFood() {
  image(food, fX, fY, bodyS, bodyS);
}

void locateFood() {
  // for x
  int a= (int) random(31)* bodyS;
  fX = a;

  a= (int) random(23) * bodyS;
  fY = a;
}


void checkFoodIntersection() {
  if ((sX[0] == fX) && (sY[0] == fY)) {
    sLen ++;
    locateFood();
    score+= 5;
  }
}

void checkCollision() {
  for (int a=sLen; a>0; a--) {
    if ((a>4) && (sX[0] == sX[a]) && (sY[0] == sY[a])) {
      play= false;
    }
  }


  if (sX[0] > width-bodyS) {
    sX[0]= 0;
  }

  if (sX[0] <= -bodyS) {
    sX[0] = width-bodyS;
  }

  if (sY[0] > height- bodyS) {
    sY[0] = 0;
  }

  if (sY[0] <= -bodyS) {
    sY[0] = height -bodyS;
  }
  
}

void restart() {
  if (keyPressed && key == 'r'|| key=='R') {
    left= false;
    right = true;
    up = false;
    down= false;
    sLen= 3;
    moveSnakeAtFirst();
    play= true;
    score= 0;
  }
}



// controls

void keySetup(boolean left, boolean right, boolean up, boolean down) {
  this. left= left;
  this.right= right;
  this.up = up;
  this.down= down;
}

public void keyPressed() {
  if (keyCode == LEFT && (!right)) {
    left= true;
    right= false;
    up= false;
    down= false;
  }
  if (keyCode == RIGHT && (!left)) {
    right= true;
    up= false;
    down= false;
  }

  if (keyCode == UP && (!down)) {
    up= true;
    right= false;
    left= false;
  }

  if (keyCode == DOWN && (!up)) {
    down= true;
    right= false;
    left= false;
  }

  if (keyCode == ENTER) {
    right=true;
  }
}
