/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/

class Shelf{
  int yearUpdated;
  int dayUpdated;//1-365 day of the year
  int timeNotUpdated;
  int shade = 255;
  boolean hasBooks;
    
  public Shelf(int yearUp, int dayUp, boolean containsBooks){
    yearUpdated = yearUp;
    dayUpdated = dayUp;
    hasBooks = containsBooks;
    
    lastUpdated();
    findShade();
  }
  
  void updateShelf(){
    yearUpdated = calendar.get(Calendar.YEAR);
    dayUpdated = calendar.get(Calendar.DAY_OF_YEAR);
    timeNotUpdated = 0;
  }
  
  void checkHitbox(int bookshelfNum){ // previous logic in mousePressed() determines which Shelf was clicked on 
    if(bookshelfList.get(bookshelfNum).drawingShelves == true){
      if(key == 32){
        updateShelf();
      }
      else if(key == ENTER){
        if(hasBooks == true){
          hasBooks = false; 
        }
        else{
          hasBooks = true;
          yearUpdated = calendar.get(Calendar.YEAR);
          dayUpdated = calendar.get(Calendar.DAY_OF_YEAR);
        }
      }
    }

  }
  
  void lastUpdated(){
    timeNotUpdated = ((calendar.get(Calendar.YEAR) - yearUpdated) * 365) + (calendar.get(Calendar.DAY_OF_YEAR) - dayUpdated);
  }
  
  void findShade(){
    if(50 <= 255 - (timeNotUpdated * 2)){
      shade = (int) (255 - (timeNotUpdated * 2));
    }
    else{
      shade = 50;
    }
  }
  
}