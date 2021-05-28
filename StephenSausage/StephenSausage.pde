int[][] arr1 = new int[10][10];

public static final int tile_side = 50;
public static final int map_side = 700;
Stephen stephen;
ArrayList<Sausage> sausages;
Map mp1;

void setup(){
  size(1000,1000);
  
  // Initialization of Board
  for(int i=0; i<arr1.length; i++)
    for(int j=0; j<arr1[0].length; j++)
      if(i==0 || j==0 || i==arr1.length-1 || j==arr1[0].length-1) arr1[i][j] = -1;
      
  // Barriers 
  //arr1[4][4] = 2;
  
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
}

void keyPressed(){
  // Stephen moves freely
  if (mp1.noBarriers(stephen, key) && 
      mp1.forkTouchSausage(stephen,key) && 
      mp1.stephenTouchSausage(stephen,key)) {
        stephen.move(key);
        int k = mp1.updateSausages();
        println(k);
  }
   if (key == ' ') {
     setup();
   }
}
