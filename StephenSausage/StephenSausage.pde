int[][] arr1 = new int[10][10];

public static final int tile_side = 50;
public static final int map_side = 1000;
public int last_pressed = 0;
Stephen stephen;
ArrayList<Sausage> sausages;
Map mp1;
public boolean lost, won, gameStart=false;
PImage sprites[];

void setup(){
  clear();
  size(1000,800);
  lost = false;
  won = false;
  
  // Images
  sprites = new PImage[15];
  sprites[0] = loadImage("Water.png");
  sprites[1] = loadImage("Sausage1.png");
  sprites[2] = loadImage("BurntSausage1.png");
  sprites[3] = loadImage("Grass.png");
  sprites[4] = loadImage("Grill.png");
  sprites[5] = loadImage("Sausage2.png");
  sprites[6] = loadImage("BurntSausage2.png");
  sprites[7] = loadImage("Stephen1.png");
  sprites[8] = loadImage("Stephen2.png");
  sprites[9] = loadImage("Stephen3.png");
  sprites[10] = loadImage("Stephen4.png");
  sprites[11] = loadImage("StephenFork1.png");
  sprites[12] = loadImage("StephenFork2.png");
  sprites[13] = loadImage("StephenFork3.png");
  sprites[14] = loadImage("StephenFork4.png");
  
  
  
  //image(sprites[0],0,0,1000,1000);
  
  // Initialization of Board
  for(int i=0; i<arr1.length; i++)
    for(int j=0; j<arr1[0].length; j++)
      if(i<3 || j<3 || i>arr1.length-4 || j>arr1[0].length-4) arr1[i][j] = -1;
  arr1[2][4]=0;
  arr1[2][5]=0;
  
  // Barriers 
  //arr1[4][6] = 2;
  // Grills
  arr1[4][4] = 1;
  arr1[4][5] = 1;
  arr1[5][4] = 1;
  arr1[5][5] = 1;
  
  // Initialization of Stephen
  stephen = new Stephen(4, 2, 0);
  
  // Initialization of Sausages
  sausages = new ArrayList<Sausage>();
  //sausages.add(new Sausage(5,3,5,4));
  sausages.add(new Sausage(3,4,3,5));
  sausages.add(new Sausage(6,4,6,5));
  //sausages.add(new Sausage(3,5,3,6));
  
  // Initialization of Map
  mp1 = new Map(arr1, stephen, sausages);
}

void draw(){
  if (!gameStart) {
    startScreen();
  } else {
    // Display Map
    mp1.show();

    if (lost)
      loseText();
    if (won)
      winText();
  }
}

void keyPressed(){
  if (gameStart) {
    // Stephen moves freely
    if (mp1.noBarriers(stephen, key) && 
        mp1.forkTouchSausage(stephen,key) && 
        mp1.stephenTouchSausage(stephen,key) && 
        mp1.sausageTouchSausage(stephen,key) &&
        millis() - last_pressed > 200 &&
        !lost && !won) {
        stephen.move(key);
        int k = mp1.updateSausages();
        lost = (k==-1);
        won = (k==1);
        last_pressed = millis();
    }
    if (key == 'r') {
      setup();
    }
    if (key == ESC) {
      key=0;
      gameStart = false;
    }
  }
}

void keyHeld(){
  
}

void mousePressed() {
  if(mouseButton == LEFT && 
     mouseX>440 && mouseY>390 && 
     mouseX<565 && mouseY<475) {
     if(!gameStart) {
       gameStart = true;
       image(sprites[0],0,0,1000,800);
       //background(color(50, 150, 200));
     }
   }
}

void loseText(){
 textAlign(CENTER);
 fill(color(255,0,0));
 textSize(100);
 text("LOST", 500, 325);
 textSize(50);
 text("Press R to restart level", 500, 425);
 text("Press Escape to return to menu", 500, 525);
}

void winText(){
 textAlign(CENTER);
 fill(color(255,215,0));
 textSize(100);
 text("WON", 500, 325);
 textSize(50);
 text("Press R to restart level", 500, 425);
 text("Press Escape to return to menu", 500, 525);
}

void startScreen() {
  if (!gameStart) {
   PImage startScreen = loadImage("startScreen.jpeg");
   image(startScreen, 0, 0, 1000, 800);
   
   noStroke();
   fill(color(185,0,0));
   rect(420, 350, 160, 238);
   
   stroke(0);
   //fill(color(132,68,32));
   fill(color(200,0,0));
   rect(440, 390, 125, 80, 25);
   
   // Play button, to be replaced with level 1, level 2, level 3 etc.
   textAlign(CENTER);
   fill(color(0));
   PFont font = loadFont("Serif-48.vlw");
   textFont(font,32);
   textSize(50);
   text("Play", 500, 445);
  }
}
