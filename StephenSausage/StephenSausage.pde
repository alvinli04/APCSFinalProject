int[][] arr1 = new int[10][10];

public static final int tile_side = 50;
public static final int map_side = 700;
Stephen stephen;
ArrayList<Sausage> sausages;
Map mp1;
public boolean lost, won;

void loseText(){
 textAlign(CENTER);
 fill(255);
 textSize(100);
 text("LOST", 500, 450);
 textSize(50);
 text("Press R to restart level", 500, 550);
 //text("Press M to return to menu", 500, 650);
}

void winText(){
 textAlign(CENTER);
 fill(255);
 textSize(100);
 text("WON", 500, 450);
 textSize(50);
 text("Press R to restart level", 500, 550);
 //text("Press M to return to menu", 500, 650);
}

void setup(){
  clear();
  size(1000,1000);
  background(color(50, 150, 200));
  lost = false;
  won = false;
  
  // Initialization of Board
  for(int i=0; i<arr1.length; i++)
    for(int j=0; j<arr1[0].length; j++)
      if(i<2 || j<2 || i>arr1.length-3 || j>arr1[0].length-3) arr1[i][j] = -1;
      
  // Barriers 
  //arr1[4][4] = 1;
  arr1[6][4] = 1;
  arr1[6][5] = 1;
  arr1[5][5] = 1;
  arr1[5][4] = 1;
  // Initialization of Stephen
  stephen = new Stephen(2, 2, 0);
  
  // Initialization of Sausages
  sausages = new ArrayList<Sausage>();
  //sausages.add(new Sausage(8,8,8,7));
  sausages.add(new Sausage(5,4,4,4));
  
  // Initialization of Map
  mp1 = new Map(arr1, stephen, sausages);
}

void draw(){
  // Display Map
  mp1.show();
  if (lost)
    loseText();
  if (won)
    winText();
}

void keyPressed(){
  // Stephen moves freely
  if (mp1.noBarriers(stephen, key) && 
      mp1.forkTouchSausage(stephen,key) && 
      mp1.stephenTouchSausage(stephen,key) && !lost && !won) {
        stephen.move(key);
        int k = mp1.updateSausages();
        lost = (k==-1);
        won = (k==1);
  }
   if (key == 'r') {
     setup();
   }
}
