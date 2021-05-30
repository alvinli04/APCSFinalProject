public class Stephen{
  public int x, y, orientation, forkx, forky;
  public boolean burning;
  private int prevx, prevy, prevforkx, prevforky;

  private final int[][] orientations = {
   {0,1}, //right
   {1,0}, //down
   {0,-1}, //left
   {-1,0} //up
  };
  
  public Stephen(int x, int y, int orientation){
    this.x = x;
    this.y = y;
    this.orientation = orientation;
    forky = this.y+orientations[orientation][0];
    forkx = this.x+orientations[orientation][1];
    burning = false;
  }
  
  public void goback(){
   if (burning){
     x = prevx;
     y = prevy;
     forkx = prevforkx;
     forky = prevforky;
     burning = false;
   }
  }
  
  /**
   * WASD is North/West/South/East respectively
   * QE is counterclockwise and clockwise respectively
   */
  public void move(char c){
     prevx = x;
     prevy = y;
     prevforkx = forkx;
     prevforky = forky;
     if(c=='w' && (orientation%2==1)) y--;
     else if(c=='a' && orientation%2==0) x--;
     else if(c=='s' && (orientation%2==1)) y++;
     else if(c=='d' && orientation%2==0) x++;
     else if(c=='e') orientation = (orientation+1)%4;
     else if(c=='q') orientation = orientation == 0 ? 3 : orientation-1;
     forky = y+orientations[orientation][0];
     forkx = x+orientations[orientation][1];
  }
  
}
