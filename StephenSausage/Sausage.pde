public class Sausage{
 public int x1;
 public int y1; 
 public int x2;
 public int y2;
 public int prevx1, prevx2, prevy1, prevy2;
 
 public int anim_cnt;
 //corresponding to the piece at x1, y1
 public boolean s11cooked;
 public boolean s12cooked;
 //corresponding to the piece at x2, y2
 public boolean s21cooked;
 public boolean s22cooked;
 public boolean side; //true for side 1, false for side 2 (down)
 public boolean orientation;
 public boolean drowned = false;
 public boolean movedLeft = false;
  public boolean movedRight = false;
   public boolean movedUp = false;
    public boolean movedDown = false;
 
 public Sausage(int x1, int y1, int x2, int y2){ //must be next to each other
  this.x1 = x1;
  this.x2 = x2;
  this.y1 = y1;
  this.y2 = y2;
  s11cooked = false;
  s12cooked = false;
  s21cooked = false;
  s22cooked = false;
  side = true;
  if (x1==x2) {
    orientation=true;
  } else {
    orientation=false;
  }
  anim_cnt = 0;
 }
 
 public void moveUp() {
   prevx1 = x1;
   prevx2 = x2;
   prevy1 = y1;
   prevy2 = y2;
   y1--;
   y2--;
   movedUp = true;
   if (orientation==false) {
     side = !side;
   }
   anim_cnt = 1;
 }
 
 public void moveDown() {
   prevx1 = x1;
   prevx2 = x2;
   prevy1 = y1;
   prevy2 = y2;
   y1++;
   y2++;
   movedDown = true;
   if (orientation==false) {  
     side = !side;
   }
   anim_cnt = 1;
 }
 
 public void moveLeft() {
   prevx1 = x1;
   prevx2 = x2;
   prevy1 = y1;
   prevy2 = y2;
   x1--;
   x2--;
   movedLeft = true;
   if (orientation==true) {
     side = !side;
   }
   anim_cnt = 1;
 }
 
 public void moveRight() {
   prevx1 = x1;
   prevx2 = x2;
   prevy1 = y1;
   prevy2 = y2;
   x1++;
   x2++;
   movedRight = true;
   if (orientation==true) {  
     side = !side;
   }
   anim_cnt = 1;
 }
 
 public boolean cooked(){
  return s11cooked && s12cooked && s21cooked && s22cooked;  
 }
}
