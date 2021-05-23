int[][] arr1 = {
 {0,0,0,0},
 {0,0,0,0},
 {0,0,0,0},
 {0,0,0,0}
};

public static final int tile_side = 20;
Stephen stephen;
ArrayList<Sausage> sausages;
Map mp1;

void setup(){
  stephen = new Stephen(0,0,0);
  sausages = new ArrayList<Sausage>();
  mp1 = new Map(arr1, stephen, sausages);
}

void draw(){
 mp1.show(); 
}

void keyPressed(){
  stephen.move(key);
}
