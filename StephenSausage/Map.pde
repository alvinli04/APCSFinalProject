public class Map {

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
      if (stephen.y > 1) return board[stephen.y-2][stephen.x] != 2;
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
    } else if (c=='q') {
      newstephenx = stephen.x;
      newstepheny = stephen.y;
      switch(stephen.orientation) {
      case 0: 
        newforkx = stephen.forkx-1;
        newforky = stephen.forky-1;
      case 1:
        newforkx = stephen.forkx-1;
        newforky = stephen.forky+1;
      case 2:
        newforkx = stephen.forkx+1;
        newforky = stephen.forky+1;
      case 3:
        newforkx = stephen.forkx+1;
        newforky = stephen.forky-1;
      }
    } else if (c=='e') {
      newstephenx = stephen.x;
      newstepheny = stephen.y;
      switch(stephen.orientation) {
      case 0: 
        newforkx = stephen.forkx-1;
        newforky = stephen.forky+1;
      case 1:
        newforkx = stephen.forkx-1;
        newforky = stephen.forky-1;
      case 2:
        newforkx = stephen.forkx+1;
        newforky = stephen.forky-1;
      case 3:
        newforkx = stephen.forkx+1;
        newforky = stephen.forky+1;
      }
    }
    for (Sausage s : sausages) {
      boolean firstchunk = (newforkx==s.x1&&newforky==s.y1);
      boolean secondchunk = (newforkx==s.x2&&newforky==s.y2);
      if ((firstchunk&&newstephenx==stephen.x+1)||(secondchunk&&newstephenx==stephen.x+1)) {
        s.moveRight();
      } else if ((firstchunk&&newstephenx==stephen.x-1)||(secondchunk&&newstephenx==stephen.x-1)) {
        s.moveLeft();
      } else if ((firstchunk&&newstepheny==stephen.y+1)||(secondchunk&&newstepheny==stephen.y+1)) {
        s.moveDown();
      } else if ((firstchunk&&newstepheny==stephen.y-1)||(secondchunk&&newstepheny==stephen.y-1)) {
        s.moveUp();
      } else if (stephen.forkx==s.x1 && stephen.forky==s.y1-1 && newforkx==s.x1+1 && newforky==s.y1) {
        s.moveDown();
      }
    }
    return true;
  }
  
  public boolean stephenTouchSausage (Stephen stephen, char c) {
    for (Sausage s : sausages) {
      if (c=='w' && ((s.x1==stephen.x&&s.y1==stephen.y-1)||(s.x2==stephen.x&&s.y2==stephen.y-1)) && stephen.orientation%2==1) {
        s.moveUp();
      } else if (c=='a'&&((s.x1==stephen.x-1&&s.y1==stephen.y)||(s.x2==stephen.x-1&&s.y2==stephen.y)) && stephen.orientation%2==0) {
        s.moveLeft();
      } else if (c=='s'&&((s.x1==stephen.x&&s.y1==stephen.y+1)||(s.x2==stephen.x&&s.y2==stephen.y+1)) && stephen.orientation%2==1) {
        s.moveDown();
      } else if (c=='d'&&((s.x1==stephen.x+1&&s.y1==stephen.y)||(s.x2==stephen.x+1&&s.y2==stephen.y)) && stephen.orientation%2==0) {
        s.moveRight();
      }
    }
    return true;
  }


  public void show() {
    for (int i=0; i<board.length; i++) {
      for (int j=0; j<board[0].length; j++) {
        float x = tile_side*(i+0.5);
        float y = tile_side*(j+0.5);
        fill(255);
        stroke(0);
        if (board[i][j]==-1)
        fill(color(50, 150, 200));
        if (board[i][j]==2)
        fill(color(124, 252, 0));
        if (i==stephen.x && j==stephen.y)
        fill(color(255, 165, 0));
        if (i==stephen.forkx && j==stephen.forky)
        fill(100);
        //show sausages
        if ((i==sausages.get(0).x1 && j==sausages.get(0).y1))
        fill(color(150, 75, 0));
        if ((i==sausages.get(0).x2 && j==sausages.get(0).y2))
        fill(color(150, 75, 0));
        if ((i==sausages.get(1).x1 && j==sausages.get(1).y1))
        fill(color(150, 75, 0));
        if ((i==sausages.get(1).x2 && j==sausages.get(1).y2))
        fill(color(150, 75, 0));
        rect(x, y, tile_side, tile_side);
      }
    }
  }
}
