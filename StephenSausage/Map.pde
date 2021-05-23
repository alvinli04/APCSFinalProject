public class Map{
 
  public int[][] board;
  private Stephen stephen;
  public ArrayList<Sausage> sausages;
  
  public Map(int[][] board, Stephen stephen, ArrayList<Sausage> sausages){
   this.board = board;
   this.stephen = stephen;
   this.sausages = sausages;
  }
}
