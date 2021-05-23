public class Stephen{
  public int x;
  public int y;
  private int orientation; //0 is up, 1 is right, etc.
  public Stephen(int x, int y, int orientation){
    this.x = x;
    this.y = y;
    this.orientation = orientation;
  }
  
  public void move(char c){
     if(c=='w') y--;
     if(c=='a') x--;
     if(c=='s') y++;
     if(c=='d') x++;
  }
  
  public void rotateL(){
    return;
  }
  
  public void rotateR(){
    return; 
  }
  
}
