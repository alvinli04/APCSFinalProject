int[][] arr1 = new int[10][10];

public static final int tile_side = 50;
public static final int map_side = 700;
Stephen stephen;
ArrayList<Sausage> sausages;
Map mp1;

void setup(){
  size(1000,1000);
  
  for(int i=0; i<arr1.length; i++)
    for(int j=0; j<arr1[0].length; j++)
      if(i==0 || j==0 || i==arr1.length-1 || j==arr1[0].length-1) arr1[i][j] = -1;
  arr1[4][4] = 2;
  
  stephen = new Stephen(2, 2, 0);
  sausages = new ArrayList<Sausage>();
  mp1 = new Map(arr1, stephen, sausages);
}

void draw(){
 mp1.show(); 
}

void keyPressed(){
  if(mp1.noBarriers(stephen, key))
    stephen.move(key);
}
