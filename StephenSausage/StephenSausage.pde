import processing.sound.*;

int[][] arr1 = new int[10][10];
int[][] arr2 = new int[10][10];
int[][] arr3 = new int[10][10];

public static final int tile_side = 50;
public static final int map_side = 1000;
public int last_pressed = 0;
Stephen stephen, stephen2, stephen3, stephentest;
ArrayList<Sausage> sausages, sausages2, sausages3;
Map mp1, mp2, mp3, test;
public boolean lost, won, gameStart=false, levelOne=false, levelTwo=false, levelThree=false, testLevel = false;
PImage sprites[];

public static final int move_time = 150;
public int anim_time = 1;

ArrayList<SoundFile> soundfiles=new ArrayList<SoundFile>();
SoundFile file,file2,file3; 
String audioName1 = "data/win.mp3", audioName2 = "data/splash.mp3", audioName3 = "data/cookingnoise.mp3";
String path;

void setup(){
  clear();
  size(1000,800);
  frameRate(120);
  lost = false;
  won = false;
  
  path = sketchPath(audioName1);
  file = new SoundFile(this, path);
  path = sketchPath(audioName2);
  file2 = new SoundFile(this, path);
  path = sketchPath(audioName3);
  file3 = new SoundFile(this, path);
  soundfiles.add(file);
  soundfiles.add(file2);
  soundfiles.add(file3);
  
  // Images
  sprites = new PImage[24];
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
  sprites[15] = loadImage("CookedSausage1.png");
  sprites[16] = loadImage("CookedSausage2.png");
  sprites[17] = loadImage("HorizontalSausage1.png");
  sprites[18] = loadImage("HorizontalSausage2.png");
  sprites[19] = loadImage("HorizontalCookedSausage1.png");
  sprites[20] = loadImage("HorizontalCookedSausage2.png");
  sprites[21] = loadImage("HorizontalBurntSausage1.png");
  sprites[22] = loadImage("HorizontalBurntSausage2.png");
  sprites[23] = loadImage("watertile.jpg");
  
  
  // Initialization of Level 1
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
  mp1 = new Map(arr1, stephen, sausages,soundfiles);
  
  
  // Initialization of Level 2
  for(int i=0; i<arr2.length; i++)
    for(int j=0; j<arr2[0].length; j++)
      if(i<3 || j<2 || i>arr2.length-4 || j>arr2[0].length-4) arr2[i][j] = -1;
  // Barriers 
  //arr1[4][6] = 2;
  // Grills
  arr2[3][3] = 1;
  arr2[3][4] = 1;
  arr2[3][5] = 1;
  arr2[6][5] = 1;
  arr2[6][3] = 1;
  arr2[6][4] = 1;
  // Initialization of Stephen
  stephen2 = new Stephen(2, 6, 3);
  // Initialization of Sausages
  sausages2 = new ArrayList<Sausage>();
  sausages2.add(new Sausage(5,5,6,5));
  sausages2.add(new Sausage(2,4,3,4));
  sausages2.add(new Sausage(4,4,4,5));
  //sausages.add(new Sausage(3,5,3,6));
  // Initialization of Map
  mp2 = new Map(arr2, stephen2, sausages2,soundfiles);
  
  
  // Initialization of Level 3
  for(int i=0; i<arr3.length; i++)
    for(int j=0; j<arr3[0].length; j++)
      if(i<3 || j<3 || i>arr3.length-5 || j>arr3[0].length-5) arr3[i][j] = -1;
  // Barriers 
  //arr1[4][6] = 2;
  // Grills
  arr3[5][1] = 1;
  arr3[5][2] = 1;
  arr3[6][1] = 1;
  arr3[6][2] = 1;
  arr3[5][6] = 1;
  arr3[6][6] = 1;
  arr3[6][7] = 1;
  // Initialization of Stephen
  stephen3 = new Stephen(4, 5, 2);
  // Initialization of Sausages
  sausages3 = new ArrayList<Sausage>();
  //sausages.add(new Sausage(5,3,5,4));
  sausages3.add(new Sausage(3,4,4,4));
  sausages3.add(new Sausage(5,4,5,5));
  //sausages.add(new Sausage(3,5,3,6));
  // Initialization of Map
  mp3 = new Map(arr3, stephen3, sausages3,soundfiles);
  
  
  stephentest = new Stephen(5,5,0);
  test = new Map(new int[20][20], stephentest, new ArrayList<Sausage>(),soundfiles);
  
  for (int i=0; i<test.board.length; i++)
    for(int j=0; j<test.board[0].length; j++)
      if(i < 3 || i > test.board.length - 3 || j < 3 || j > test.board[0].length - 3)
        test.board[i][j] = -1;
  
  test.sausages.add(new Sausage(8,9,9,9));
  
  image(sprites[0],0,0,1000,800);
}

void draw(){
  
  if (!gameStart && (frameCount%60==0||frameCount==1)) {
    startScreen();
  } else if (gameStart && levelOne) {
    mp1.show();
  } else if (gameStart && levelTwo) {
    mp2.show();
  } else if (gameStart && levelThree) {
    mp3.show();
  } else if (gameStart && testLevel){
   test.show(); 
   //text(frameRate, 50, 50);
  }
  println(frameRate);
    if (lost)
      loseText();
    if (won)
      winText();
  if (!gameStart) {
    textAlign(CENTER);
    fill(color(0));
    PFont font = loadFont("Serif-48.vlw");
    textFont(font,32);
    textSize(40);
    if(mouseX>430 && mouseY>350 && 
       mouseX<570 && mouseY<410) {
       if(!gameStart) {
         fill(color(117, 46, 35));
         rect(430, 350, 140, 60, 25);
         fill(color(0));
         text("Level 1", 500, 395);
       }
     } else {
       fill(color(165, 42, 42));
       rect(430, 350, 140, 60, 25);
       fill(color(0));
       text("Level 1", 500, 395);
     }
     if(mouseX>430 && mouseY>415 && 
       mouseX<570 && mouseY<475) {
       if(!gameStart) {
         fill(color(117, 46, 35));
         rect(430, 415, 140, 60, 25);
         fill(color(0));
         text("Level 2", 500, 460);
       }
     } else {
       fill(color(165, 42, 42));
       rect(430, 415, 140, 60, 25);
       fill(color(0));
       text("Level 2", 500, 460);
     }
     if(mouseX>430 && mouseY>480 && 
       mouseX<570 && mouseY<540) {
       if(!gameStart) {
         fill(color(117, 46, 35));
         rect(430, 480, 140, 60, 25);
         fill(color(0));
         text("Level 3", 500, 525);
       }
     } else {
       fill(color(165, 42, 42));
       rect(430, 480, 140, 60, 25);
       fill(color(0));
       text("Level 3", 500, 525);
     }
   }
}

void keyPressed(){
  if (gameStart) {
    // Stephen moves freely
    if (levelOne) {
      if (mp1.noBarriers(stephen, key) && 
          mp1.forkTouchSausage(stephen,key) && 
          mp1.stephenTouchSausage(stephen,key) && 
          mp1.sausageTouchSausage(stephen,key) &&
          millis() - last_pressed > move_time &&
          !lost && !won) {
            stephen.move(key);
            int k = mp1.updateSausages();
            lost = (k==-1);
            won = (k==1);
            last_pressed = millis();
      }
    } else if (levelTwo) {
      if (mp2.noBarriers(stephen2, key) && 
          mp2.forkTouchSausage(stephen2,key) && 
          mp2.stephenTouchSausage(stephen2,key) && 
          mp2.sausageTouchSausage(stephen2,key) &&
          millis() - last_pressed > move_time &&
          !lost && !won) {
            stephen2.move(key);
            int k = mp2.updateSausages();
            lost = (k==-1);
            won = (k==1);
            last_pressed = millis();
      }
    } else if (levelThree) {
      if (mp3.noBarriers(stephen3, key) && 
          mp3.forkTouchSausage(stephen3,key) && 
          mp3.stephenTouchSausage(stephen3,key) && 
          mp3.sausageTouchSausage(stephen3,key) &&
          millis() - last_pressed > move_time &&
          !lost && !won) {
            stephen3.move(key);
            int k = mp3.updateSausages();
            lost = (k==-1);
            won = (k==1);
            last_pressed = millis();
      }
    } else if (testLevel) {
      if (test.noBarriers(stephentest, key) && 
          test.forkTouchSausage(stephentest,key) && 
          test.stephenTouchSausage(stephentest,key) && 
          test.sausageTouchSausage(stephentest,key) &&
          millis() - last_pressed > move_time &&
          !lost && !won) {
            stephentest.move(key);
            last_pressed = millis();
      }
    }
    if (key == 'r') {
      setup();
    }
    if (key == ESC) {
      key=0;
      gameStart = false;
      levelOne = false;
      levelTwo = false;
      levelThree = false;
      lost = false;
      won = false;
    }
  }
  
  if(key == ']') {
     if(!gameStart) {
       println("testing started");
       gameStart = true;
       testLevel = true;
       image(sprites[0],0,0,1000,800);
       //background(color(50, 150, 200));
     }
   }
}

void mousePressed() {
  if(mouseButton == LEFT && 
     mouseX>430 && mouseY>350 && 
     mouseX<570 && mouseY<410) {
     if(!gameStart) {
       gameStart = true;
       levelOne = true;
       image(sprites[0],0,0,1000,800);
       //background(color(50, 150, 200));
     }
   }
   if(mouseButton == LEFT && 
     mouseX>430 && mouseY>415 && 
     mouseX<570 && mouseY<475) {
     if(!gameStart) {
       gameStart = true;
       levelTwo = true;
       image(sprites[0],0,0,1000,800);
       //background(color(50, 150, 200));
     }
   }
   if(mouseButton == LEFT && 
     mouseX>430 && mouseY>480 && 
     mouseX<570 && mouseY<540) {
     if(!gameStart) {
       gameStart = true;
       levelThree = true;
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
   
   // Level 1
   stroke(0);
   fill(color(165, 42, 42));
   rect(430, 350, 140, 60, 25);
  
   // Level 2
   rect(430, 415, 140, 60, 25);
   
   // Level 3
   rect(430, 480, 140, 60, 25);
   
   // Play button, to be replaced with level 1, level 2, level 3 etc.
   textAlign(CENTER);
   fill(color(0));
   PFont font = loadFont("Serif-48.vlw");
   textFont(font,32);
   textSize(40);
   text("Level 1", 500, 395);
   
   textSize(40);
   text("Level 2", 500, 460);
   
   textSize(40);
   text("Level 3", 500, 525);
   
  }
}
