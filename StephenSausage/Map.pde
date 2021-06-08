public class Map { //<>// //<>// //<>//

  public int[][] board; //-1 is water, 0 is walkable, 1 is grill, 2 is rock
  private Stephen stephen;
  public ArrayList<Sausage> sausages;
  private PImage img;
  
  /**
   * Constructor for the Map class 
   * Has access to Stephen and the sausages 
   */
  public Map(int[][] board, Stephen stephen, ArrayList<Sausage> sausages) {
    this.board = board;
    this.stephen = stephen;
    this.sausages = sausages;
  }
  
  /**
   * Checks if Stephen is able to move in the direction c
   */
  public boolean noBarriers (Stephen stephen, char c) {
    if (c=='w') {
      return stephen.y > 0 && 
             board[stephen.y-1][stephen.x] != -1 && 
             board[stephen.y-1][stephen.x] != 2;
    } else if (c=='a') {
      return stephen.x > 0 && 
             board[stephen.y][stephen.x-1] != -1 &&
             board[stephen.y][stephen.x-1] != 2;
    } else if (c=='s') {
      return stephen.y<board.length-1 && 
             board[stephen.y+1][stephen.x] != -1 &&
             board[stephen.y+2][stephen.x] != 2;
    } else if (c=='d') {
      return stephen.x<board[0].length-1 && 
             board[stephen.y][stephen.x+1] != -1 &&
             board[stephen.y][stephen.x+2] != 2;
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
  
  /**
   * Checks if fork pushes sausage up/down/left/right
   * Checks if fork swing pushes sausage up/down/left/right
   */
  public boolean forkTouchSausage (Stephen stephen, char c) {
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
      // Check if the new fork position intersects a sausage
      boolean firstchunk = (newforkx==s.x1 && newforky==s.y1);
      boolean secondchunk = (newforkx==s.x2 && newforky==s.y2);
      // Fork intersects sausage through WASD
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
      // Fork intersects sausage through rotation QE 
      else if (firstchunk || secondchunk){
        // Fork is corner
        if ((stephen.forkx > Math.max(s.x1, s.x2) || stephen.forkx < Math.min(s.x1, s.x2)) &&
            (stephen.forky > Math.max(s.y1, s.y2) || stephen.forky < Math.min(s.y1, s.y2))){
              if (stephen.orientation == 2) {
                if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
                  return false;
                s.moveRight();
              }
              else if (stephen.orientation == 0) {
                if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
                  return false;
                s.moveLeft();
              }
              else if (stephen.orientation == 3) {
                if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
                  return false;
                s.moveDown();
              }
              else if (stephen.orientation == 1) {
                if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
                  return false;
                s.moveUp();
              }
        }
        // Fork is left
        else if (stephen.forkx < s.x1 && stephen.forkx < s.x2) {
          if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
            return false;
          s.moveRight();
        }
        // Fork is right
        else if (stephen.forkx > s.x1 && stephen.forkx > s.x2) {
          if (board[s.y1][s.x1-1] == 2 || board[s.y2][s.x2-1] == 2)
            return false;
          s.moveLeft();
        }
        // Fork is down
        else if (stephen.forky > s.y1 && stephen.forky > s.y2) {
         if (board[s.y1-1][s.x1] == 2 || board[s.y2-1][s.x2] == 2)
            return false;
         s.moveUp();
        }
        // Fork is up
        else if (stephen.forky < s.y1 && stephen.forky < s.y2) {
         if (board[s.y1+1][s.x1] == 2 || board[s.y2+1][s.x2] == 2)
            return false;
         s.moveDown();
        }
        
      }
      // Corner swings move sausage 
      else if ((s.x1 == stephen.forkx && s.y1 == newforky)||
               (s.x1 == newforkx && s.y1 == stephen.forky)||
               (s.x2 == stephen.forkx && s.y2 == newforky)||
               (s.x2 == newforkx && s.y2 == stephen.forky)){
        if (stephen.forkx < s.x1 && stephen.forkx < s.x2){
          if (board[s.y1][s.x1+1] == 2 || board[s.y2][s.x2+1] == 2)
            return false;
          s.moveRight();
        }
        // Fork is right
        else if (stephen.forkx > s.x1 && stephen.forkx > s.x2){
          if (board[s.y1][s.x1-1] == 2 || board[s.y2][s.x2-1] == 2)
            return false;
          s.moveLeft();
        }
        // Fork is down
        else if (stephen.forky > s.y1 && stephen.forky > s.y2) {
         if (board[s.y1-1][s.x1] == 2 || board[s.y2-1][s.x2] == 2)
            return false;
          s.moveUp();
        }
        // Fork is up
        else if (stephen.forky < s.y1 && stephen.forky < s.y2) {
         if (board[s.y1+1][s.x1] == 2 || board[s.y2+1][s.x2] == 2)
            return false;
          s.moveDown(); //<>// //<>//
        }
      }
    } //<>// //<>//
    return true;
  }
  
  /**
   * Checks if Stephen moves sausage up/down/left/right
   */
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
  
  /**
   * Checks if a sausage moves another sausage up/down/left/right
   */
  public boolean sausageTouchSausage (Stephen stephen, char c) {
    for (int i=0; i<sausages.size(); i++) {
      for (int j=i+1; j<sausages.size(); j++) {
        Sausage s1 = sausages.get(i);
        Sausage s2 = sausages.get(j);
        boolean touchsausage =((s1.x1==s2.x1 && s1.y1==s2.y1) || 
                               (s1.x1==s2.x2 && s1.y1==s2.y2) ||
                               (s1.x2==s2.x1 && s1.y2==s2.y1) || 
                               (s1.x2==s2.x2 && s1.y2==s2.y2));
        // Sausage moves down
        if (c=='s' && touchsausage || 
            (c=='e'||c=='q')  && touchsausage && 
            (s2.movedDown || s1.movedDown)) {
          if (s2.movedDown) {
            if (board[s1.y1+1][s1.x1] == 2 || board[s1.y2+1][s1.x2] == 2){
              s2.moveUp();
              return false;
            }
            s1.moveDown();
          } else {  
            if (board[s2.y1+1][s2.x1] == 2 || board[s2.y2+1][s2.x2] == 2) {
              s1.moveUp();
              return false;  
            }
            s2.moveDown();
          }
        }
        // Sausage moves up
        else if (c=='w' && touchsausage ||
                 (c=='e'||c=='q') && touchsausage && 
                 (s1.movedUp || s2.movedUp)) {
          if (s2.movedUp) {
            if (board[s1.y1-1][s1.x1] == 2 || board[s1.y2-1][s1.x2] == 2) {
              s2.moveDown();
              return false;
            }
            s1.moveUp();
          } else {  
            if (board[s2.y1-1][s2.x1] == 2 || board[s2.y2-1][s2.x2] == 2) {
              s1.moveDown();
              return false;
            }
            s2.moveUp();
          }
        }
        // Sausage moves left
        else if (c=='a' && touchsausage ||
                 (c=='e'||c=='q') && touchsausage && 
                 (s1.movedLeft || s2.movedLeft)) {
          if (s2.movedLeft) {
            if (board[s1.y1][s1.x1-1] == 2 || board[s1.y2][s1.x2-1] == 2) {
              s2.moveRight();
              return false;
            }
            s1.moveLeft();
          } else {
            if (board[s2.y1][s2.x1-1] == 2 || board[s2.y2][s2.x2-1] == 2) {
              s1.moveRight();
              return false;
            }
            s2.moveLeft();
          }
        }
        // Sausage moves right
        else if (c=='d' && touchsausage ||
                 (c=='e'||c=='q') && touchsausage && 
                 (s1.movedRight || s2.movedRight)) {
          if (s2.movedRight) {
            if (board[s1.y1][s1.x1+1] == 2 || board[s1.y2][s1.x2+1] == 2) {
              s2.moveLeft();
              return false;
            }
            s1.moveRight();
          } else { 
            if (board[s2.y1][s2.x1+1] == 2 || board[s2.y2][s2.x2+1] == 2) {
              s1.moveLeft();
              return false;
            }
            s2.moveRight();
          }
        } 
      }
    }
    return true;
  }
  
  /**
   * Update sausages
   * Returns -1 if lose, 1 if won, 0 if continue
   */
  public int updateSausages(){
    boolean allcooked = true;
    for(Sausage s : sausages){
      //check if in the water
      if (board[s.y1][s.x1] == -1 && board[s.y2][s.x2] == -1){
         s.drowned = true; 
        return -1;
      }
      if (board[s.y1][s.x1] == 1 && (s.movedLeft||s.movedRight||s.movedUp||s.movedDown)){
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
      if(board[s.y2][s.x2] == 1 && (s.movedLeft||s.movedRight||s.movedUp||s.movedDown)){
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
      s.movedLeft = false;
      s.movedRight = false;
      s.movedUp = false;
      s.movedDown = false;
    }
    if (allcooked) return 1;
    return 0;
  }
  
  /**
   * Display the map and its elements
   */
  public void show() {
    image(sprites[0],0,0,1000,800);
    
    if (stephen.burning) stephen.goback();
    if (board[stephen.y][stephen.x] == 1) stephen.burning = true;
    
    for (int i=0; i<board.length; i++) {
      for (int j=0; j<board[0].length; j++) {
        float y = tile_side*(i+0.5) + 120;
        float x = tile_side*(j+0.5) + 250;
        noFill();
        noStroke();
        if (board[i][j]==0) {
          image(sprites[3],x,y,tile_side,tile_side);
          rect(x, y, tile_side, tile_side);
        } 
        if (board[i][j]==2){
          fill(color(168, 46, 63));
          rect(x, y, tile_side, tile_side);
        } else if (board[i][j] == 1) {
          image(sprites[4],x,y,tile_side,tile_side);
          rect(x, y, tile_side, tile_side);
        }
        if (i==stephen.y && j==stephen.x) {
          switch(stephen.orientation) {
            case 0:
              image(sprites[10],x,y,tile_side,tile_side);
              break;
            case 1:
              image(sprites[9],x,y,tile_side,tile_side);
               break;
            case 2:
              image(sprites[8],x,y,tile_side,tile_side);
              break;
            case 3:
              image(sprites[7],x,y,tile_side,tile_side);
              break;
          }
        } else if (i==stephen.forky && j==stephen.forkx) {
          switch(stephen.orientation) {
            case 0:
              image(sprites[14],x,y,tile_side,tile_side);
              break;
            case 1:
              image(sprites[13],x,y,tile_side,tile_side);
               break;
            case 2:
              image(sprites[12],x,y,tile_side,tile_side);
              break;
            case 3:
              image(sprites[11],x,y,tile_side,tile_side);
              break;
          }
        } 
        //show sausages
        for(Sausage s : sausages) {
         if (i==s.y1 && j==s.x1 && !s.drowned && s.x1==s.x2){
           if(s.s12cooked && !s.s11cooked)
               image(sprites[15],x,y,tile_side,tile_side);
             else if (!s.s12cooked && !s.s11cooked)
               image(sprites[1],x,y,tile_side,tile_side);
             else if (!s.s12cooked && s.s11cooked) 
               image(sprites[15],x,y,tile_side,tile_side);
             else 
               image(sprites[2],x,y,tile_side,tile_side);
         }
         if (i==s.y2 && j==s.x2 && !s.drowned && s.x1==s.x2) {
           if(s.s22cooked && !s.s21cooked)
               image(sprites[16],x,y,tile_side,tile_side);
             else if (!s.s22cooked && !s.s21cooked)
               image(sprites[5],x,y,tile_side,tile_side);
             else if (!s.s22cooked && s.s21cooked)
               image(sprites[16],x,y,tile_side,tile_side);
             else 
               image(sprites[6],x,y,tile_side,tile_side);
         }
         if (i==s.y1 && j==s.x1 && !s.drowned && s.y1==s.y2){
           if(s.s12cooked && !s.s11cooked)
               image(sprites[19],x,y,tile_side,tile_side);
             else if (!s.s12cooked && !s.s11cooked)
               image(sprites[17],x,y,tile_side,tile_side);
             else if (!s.s12cooked && s.s11cooked) 
               image(sprites[19],x,y,tile_side,tile_side);
             else 
               image(sprites[21],x,y,tile_side,tile_side);
         }
         if (i==s.y2 && j==s.x2 && !s.drowned && s.y1==s.y2) {
           if(s.s22cooked && !s.s21cooked)
               image(sprites[20],x,y,tile_side,tile_side);
             else if (!s.s22cooked && !s.s21cooked)
               image(sprites[18],x,y,tile_side,tile_side);
             else if (!s.s22cooked && s.s21cooked)
               image(sprites[20],x,y,tile_side,tile_side);
             else 
               image(sprites[22],x,y,tile_side,tile_side);
         }
        }
      }
    }
  }
  
}
