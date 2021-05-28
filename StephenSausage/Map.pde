public class Map { //<>// //<>//

  public int[][] board; //-1 is water, 0 is walkable, 1 is grill, 2 is rock
  private Stephen stephen;
  public ArrayList<Sausage> sausages;
  //private int newstephenx=-1, newstepheny=-1, newforkx=-1, newforky=-1;

  public Map(int[][] board, Stephen stephen, ArrayList<Sausage> sausages) {
    this.board = board;
    this.stephen = stephen;
    this.sausages = sausages;
  }

  public boolean noBarriers(Stephen stephen, char c) {
    if (c=='w') {
      if (stephen.y > 1) return board[stephen.y-1][stephen.x] != 2;
      return stephen.y > 0 && 
        board[stephen.y-1][stephen.x] != -1;
    } else if (c=='a') {
      if (stephen.x > 1) return board[stephen.y][stephen.x-1] != 2;
      return stephen.x > 0 && 
        board[stephen.y][stephen.x-1] != -1;
    } else if (c=='s') {
      if (stephen.y < board.length - 2) return board[stephen.y+2][stephen.x] != 2;
      return stephen.y<board.length-1 && 
        board[stephen.y+1][stephen.x] != -1;
    } else if (c=='d') {
      if (stephen.x < board[0].length - 2) return board[stephen.y][stephen.x+2] != 2;
      return stephen.x<board[0].length-1 && 
        board[stephen.y][stephen.x+1] != -1;
    } else if (c=='q') {
      switch(stephen.orientation) {
      case 0:
        return board[stephen.y-1][stephen.x+1] != 2 && board[stephen.y-1][stephen.x] != 2;
      case 1:
        return board[stephen.y][stephen.x+1] != 2 && board[stephen.y+1][stephen.x+1] != 2;
      case 2:
        return board[stephen.y+1][stephen.x] != 2 && board[stephen.y+1][stephen.x-1] != 2;
      case 3:
        return board[stephen.y-1][stephen.x-1] != 2 && board[stephen.y][stephen.x-1] != 2;
      }
    } else if (c=='e') {
      switch(stephen.orientation) {
      case 0:
        return board[stephen.y+1][stephen.x+1] != 2 && board[stephen.y+1][stephen.x] != 2;
      case 1:
        return board[stephen.y+1][stephen.x-1] != 2 && board[stephen.y][stephen.x-1] != 2;
      case 2:
        return board[stephen.y-1][stephen.x-1] != 2 && board[stephen.y-1][stephen.x] != 2;
      case 3:
        return board[stephen.y-1][stephen.x+1] != 2 && board[stephen.y][stephen.x+1] != 2;
      }
    }
    return true;
  }

  public boolean forkTouchSausage(Stephen stephen, char c) {
    int newstephenx=-1, newstepheny=-1, newforkx=-1, newforky=-1;
    if (c=='w' && stephen.orientation%2==1) {
      newstephenx = stephen.x;
      newstepheny = stephen.y-1;
      newforkx = stephen.forkx;
      newforky = stephen.forky-1;
    } else if (c=='a' && stephen.orientation%2==0) {
      newstephenx = stephen.x-1;
      newstepheny = stephen.y;
      newforkx = stephen.forkx-1;
      newforky = stephen.forky;
    } else if (c=='s' && stephen.orientation%2==1) {
      newstephenx = stephen.x;
      newstepheny = stephen.y+1;
      newforkx = stephen.forkx;
      newforky = stephen.forky+1;
    } else if (c=='d' && stephen.orientation%2==0) {
      newstephenx = stephen.x+1;
      newstepheny = stephen.y;
      newforkx = stephen.forkx+1;
      newforky = stephen.forky;
    } else if (c=='e') {
      newstephenx = stephen.x;
      newstepheny = stephen.y;
      if(stephen.orientation==0) {
        newforkx = stephen.x;
        newforky = stephen.y+1;
      } else if (stephen.orientation==1) {
        newforkx = stephen.x-1;
        newforky = stephen.y;
      } else if (stephen.orientation==2) {
        newforkx = stephen.x;
        newforky = stephen.y-1;
      } else if (stephen.orientation==3) {
        newforkx = stephen.x+1;
        newforky = stephen.y;
      }
    } else if (c=='q') {
      newstephenx = stephen.x;
      newstepheny = stephen.y;
      if(stephen.orientation==0) {
        newforkx = stephen.x;
        newforky = stephen.y-1;
      } else if (stephen.orientation==1) {
        newforkx = stephen.x+1;
        newforky = stephen.y;
      } else if (stephen.orientation==2) {
        newforkx = stephen.x;
        newforky = stephen.y+1;
      } else if (stephen.orientation==3) {
        newforkx = stephen.x-1;
        newforky = stephen.y;
      }
    }
    for (Sausage s : sausages) {
      boolean firstchunk = newforkx==s.x1 && newforky==s.y1;
      boolean secondchunk = newforkx==s.x2 && newforky==s.y2;
      if(firstchunk || secondchunk) s.side = !s.side;
      if ((firstchunk&&newstephenx==stephen.x+1) ||
        (secondchunk&&newstephenx==stephen.x+1)) {
        if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
          return false;
        s.moveRight();
      } else if ((firstchunk&&newstephenx==stephen.x-1)||
        (secondchunk&&newstephenx==stephen.x-1)) {
        if (board[s.y1][s.x1-1] == 2 || board[s.y2][s.x2-1] == 2)
          return false;
        s.moveLeft();
      } else if ((firstchunk&&newstepheny==stephen.y+1)||
        (secondchunk&&newstepheny==stephen.y+1)) {
        if (board[s.y1+1][s.x1] == 2 || board[s.y2+1][s.x2] == 2)
          return false;
        s.moveDown();
      } else if ((firstchunk&&newstepheny==stephen.y-1)||
        (secondchunk&&newstepheny==stephen.y-1)) {
        if (board[s.y1-1][s.x1] == 2 || board[s.y2-1][s.x2] == 2)
          return false;
        s.moveUp();
      } 
      //fork intersects sausage
      else if (firstchunk || secondchunk){
        //fork is corner
        if ((stephen.forkx > Math.max(s.x1, s.x2) || stephen.forkx < Math.min(s.x1, s.x2)) &&
            (stephen.forky > Math.max(s.y1, s.y2) || stephen.forky < Math.min(s.y1, s.y2))){
              if (stephen.x < s.x1 && stephen.x < s.x2){
                if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
                  return false;
                s.moveRight();
              }
              //fork is right
              else if (stephen.x > s.x1 && stephen.x > s.x2){
                if (board[s.y1][s.x1-1] == 2 || board[s.y2][s.x2-1] == 2)
                  return false;
                s.moveLeft();
              }
              //fork is down
              else if (stephen.y > s.y1 && stephen.y > s.y2) {
               if (board[s.y1-1][s.x1] == 2 || board[s.y2-1][s.x2] == 2)
                  return false;
                s.moveUp();
              }
              //fork is up
              else if (stephen.y < s.y1 && stephen.y < s.y2) {
               if (board[s.y1+1][s.x1] == 2 || board[s.y2+1][s.x2] == 2)
                  return false;
                s.moveDown();
              }
        }
        //fork is left
        else if (stephen.forkx < s.x1 && stephen.forkx < s.x2){
          if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
            return false;
          s.moveRight();
        }
        //fork is right
        else if (stephen.forkx > s.x1 && stephen.forkx > s.x2){
          if (board[s.y1][s.x1-1] == 2 || board[s.y2][s.x2-1] == 2)
            return false;
          s.moveLeft();
        }
        //fork is down
        else if (stephen.forky > s.y1 && stephen.forky > s.y2) {
         if (board[s.y1-1][s.x1] == 2 || board[s.y2-1][s.x2] == 2)
            return false;
          s.moveUp();
        }
        //fork is up
        else if (stephen.forky < s.y1 && stephen.forky < s.y2) {
         if (board[s.y1+1][s.x1] == 2 || board[s.y2+1][s.x2] == 2)
            return false;
          s.moveDown();
        }
        
      }
      //corner swings
      else if ((s.x1 == stephen.forkx && s.y1 == newforky)||
               (s.x1 == newforkx && s.y1 == stephen.forky)||
               (s.x2 == stephen.forkx && s.y2 == newforky)||
               (s.x2 == newforkx && s.y2 == stephen.forky)){
        if (stephen.forkx < s.x1 && stephen.forkx < s.x2){
          if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
            return false;
          s.moveRight();
        }
        //fork is right
        else if (stephen.forkx > s.x1 && stephen.forkx > s.x2){
          if (board[s.y1][s.x1-1] == 2 || board[s.y2][s.x2-1] == 2)
            return false;
          s.moveLeft();
          println("bob");
        }
        //fork is down
        else if (stephen.forky > s.y1 && stephen.forky > s.y2) {
         if (board[s.y1-1][s.x1] == 2 || board[s.y2-1][s.x2] == 2)
            return false;
          s.moveUp();
        }
        //fork is up
        else if (stephen.forky < s.y1 && stephen.forky < s.y2) {
         if (board[s.y1+1][s.x1] == 2 || board[s.y2+1][s.x2] == 2)
            return false;
          s.moveDown();
        }
      }
    } //<>//
    return true;
  }
  
  public boolean stephenTouchSausage (Stephen stephen, char c) {
    for (Sausage s : sausages) {
      if (c=='w' && ((s.x1==stephen.x&&s.y1==stephen.y-1)||(s.x2==stephen.x&&s.y2==stephen.y-1)) && stephen.orientation%2==1) {
        if (board[s.y1-1][s.x1] == 2 || board[s.y2-1][s.x2] == 2)
            return false;
          s.moveUp();
      } else if (c=='a'&&((s.x1==stephen.x-1&&s.y1==stephen.y)||(s.x2==stephen.x-1&&s.y2==stephen.y)) && stephen.orientation%2==0) {
        if (board[s.y1][s.x1-1] == 2 || board[s.y2][s.x2-1] == 2)
            return false;
          s.moveLeft();
      } else if (c=='s'&&((s.x1==stephen.x&&s.y1==stephen.y+1)||(s.x2==stephen.x&&s.y2==stephen.y+1)) && stephen.orientation%2==1) {
        if (board[s.y1+1][s.x1] == 2 || board[s.y2+1][s.x2] == 2)
            return false;
          s.moveDown();
      } else if (c=='d'&&((s.x1==stephen.x+1&&s.y1==stephen.y)||(s.x2==stephen.x+1&&s.y2==stephen.y)) && stephen.orientation%2==0) {
        if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
            return false;
          s.moveRight();
      }
    }
    return true;
  }
  
  //returns -1 if lose, 1 if won, 0 if continue
  public int updateSausages(){
    boolean allcooked = true;
    for(Sausage s : sausages){
      //check if in the water
      if (board[s.y1][s.x1] == -1 && board[s.y2][s.x2] == -1)
        return -1;
      if (board[s.y1][s.x1] == 1){
       if(s.side){
         if (s.s11cooked)
           return -1;
         s.s11cooked = true;
       } else {
         if (s.s12cooked)
           return -1;
         s.s12cooked = true;
       }
      }
      if(board[s.y2][s.x2] == 1){
        if (s.side) { 
          if (s.s21cooked)
            return -1;
          s.s21cooked = true;
        } else {
          if (s.s22cooked)
            return -1;
          s.s22cooked = true;
        }
      }
      if(!s.cooked()) allcooked = false;
    }
    if (allcooked) return 1;
    return 0;
  }
  
  public void show() {
    for (int i=0; i<board.length; i++) {
      for (int j=0; j<board[0].length; j++) {
        float y = tile_side*(i+0.5);
        float x = tile_side*(j+0.5);
        fill(255);
        stroke(0);
        if (board[i][j]==-1)
          fill(color(50, 150, 200));
        if (board[i][j]== 2)
          fill(color(124, 252, 0));
        if (board[i][j] == 1)
          fill(color(255, 255, 0));
        if (i==stephen.y && j==stephen.x)
          fill(color(255, 165, 0));
        if (i==stephen.forky && j==stephen.forkx)
          fill(100);  
        //show sausages
        for(Sausage s : sausages) {
         if ((i==s.y1 && j==s.x1) ||
             (i==s.y2 && j==s.x2))
          fill(color(150, 75, 0)); 
        }
        rect(x, y, tile_side, tile_side);
      }
    }
  }
}
