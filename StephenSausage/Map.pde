public class Map{
 
  public int[][] board; //-1 is water, 0 is walkable, 1 is grill, 2 is rock
  private Stephen stephen;
  public ArrayList<Sausage> sausages;
  
  public Map(int[][] board, Stephen stephen, ArrayList<Sausage> sausages){
   this.board = board;
   this.stephen = stephen;
   this.sausages = sausages;
  }
  
  public boolean noBarriers(Stephen stephen, char c){
   if(c=='w') return stephen.y > 0 && board[stephen.y-1][stephen.x] != -1;
   else if(c=='a') return stephen.x > 0 && board[stephen.y][stephen.x-1]!=-1;
   else if(c=='s') return stephen.y<board.length-1 && board[stephen.y+1][stephen.x] !=-1;
   else if(c=='d') return stephen.x<board[0].length-1 && board[stephen.y][stephen.x+1]!=-1;
   else if(c=='e') return true;
   else if(c=='q') return true;
   return true;
}
  
  public void show(){
    for(int i=0; i<board.length; i++){
     for(int j=0; j<board[0].length; j++){
      float x = tile_side*(i+0.5);
      float y = tile_side*(j+0.5);
      fill(255);
      stroke(0);
      if(board[i][j]==-1)
        fill(color(50,150,200));
      if(i==stephen.x && j==stephen.y)
        fill(color(255,165,0));
      if(i==stephen.forkx && j==stephen.forky)
        fill(100);
      rect(x,y,tile_side, tile_side);
     }
    }
  }
}