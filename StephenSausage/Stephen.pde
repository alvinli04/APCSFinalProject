public class Stephen{
  public int x, y, orientation, forkx, forky;
  private int rows, cols;

  private final int[][] orientations = {
   {0,1},
   {1,0},
   {0,-1},
   {-1,0}
  };
  
  
  public Stephen(int x, int y, int orientation, int rows, int cols){
    this.x = x;
    this.y = y;
    this.orientation = orientation;
    this.rows = rows;
    this.cols = cols;
    forky = this.y+orientations[orientation][0];
     forkx = this.x+orientations[orientation][1];
  }
  
  public void move(char c){
     if(c=='w' && y>0) y--;
     else if(c=='a' && x>0) x--;
     else if(c=='s' && y<rows-1) y++;
     else if(c=='d' && x<cols-1) x++;
     else if(c=='e') orientation = (orientation+1)%4;
     else if(c=='q') orientation = orientation == 0 ? 3 : orientation-1;
     forky = y+orientations[orientation][0];
     forkx = x+orientations[orientation][1];
  }
  
}
