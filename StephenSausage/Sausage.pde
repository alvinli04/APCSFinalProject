public class Sausage{
 public int x1;
 public int y1; 
 public int x2;
 public int y2;
 boolean s11cooked;
 boolean s12cooked;
 boolean s21cooked;
 boolean s22cooked;
 boolean side;
 
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
 }
 
 public void moveUp() {
   y1--;
   y2--;
 }
 
 public void moveDown() {
   y1++;
   y2++;
 }
 
 public void moveLeft() {
   x1--;
   x2--;
 }
 
 public void moveRight() {
   x1++;
   x2++;
 }
 
 public boolean cooked(){
  return s11cooked && s12cooked && s21cooked && s22cooked;  
 }
}
