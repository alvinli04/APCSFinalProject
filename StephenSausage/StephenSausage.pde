int[][] arr1 = {
 {0,0,0,0},
 {0,0,0,0},
 {0,0,0,0},
 {0,0,0,0}
};

public static final int tile_side = 50;
Stephen stephen;
ArrayList<Sausage> sausages;
Map mp1;

void setup(){
  size(1000,1000);
  stephen = new Stephen(0, 0, 0, 4, 4);
  sausages = new ArrayList<Sausage>();
  mp1 = new Map(arr1, stephen, sausages);
}

void draw(){
 mp1.show(); 
}

void keyPressed(){
  stephen.move(key);
}
