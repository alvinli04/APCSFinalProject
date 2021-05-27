public class Stephen{
  public int x, y, orientation, forkx, forky;

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
  }
  
  /**
   * WASD is North/West/South/East respectively
   * QE is counterclockwise and clockwise respectively
   */
  public void move(char c){
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
