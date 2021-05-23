public class Map{
 
  public int[][] board; //-1 is water, 0 is walkable, 1 is barrier, 2 is grill
  private Stephen stephen;
  public ArrayList<Sausage> sausages;
  
  public Map(int[][] board, Stephen stephen, ArrayList<Sausage> sausages){
   this.board = board;
   this.stephen = stephen;
   this.sausages = sausages;
  }
  
  
  public void show(){
    for(int i=0; i<board.length; i++){
     for(int j=0; j<board[0].length; j++){
      float x = tile_side*(i+0.5);
      float y = tile_side*(j+0.5);
      fill(255);
      stroke(0);
      if(i==stephen.x && j==stephen.y)
        fill(color(255,165,0));
      if(i==stephen.forkx && j==stephen.forky)
        fill(100);
      rect(x,y,tile_side, tile_side);
     }
    }
  }
}
