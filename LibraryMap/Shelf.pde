/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/

class Shelf{
  int yearUpdated; 
  int dayUpdated; //1-366 day of the year
  int timeNotUpdated;
  int shade = 255;
  boolean hasBooks;
    
  public Shelf(int yearUp, int dayUp, boolean containsBooks){
    yearUpdated = yearUp;
    dayUpdated = dayUp;
    hasBooks = containsBooks;
    
    lastUpdated(); //This is so findAverageInfo() works and bookshelves are colored and numbered
    findShade();
  }
  
  void updateShelf(){ //Resets a shelf, used when it was sorted
    yearUpdated = calendar.get(Calendar.YEAR);
    dayUpdated = calendar.get(Calendar.DAY_OF_YEAR);
    timeNotUpdated = 0;
  }
  
  void checkHitbox(int bookshelfNum){ // previous logic in mousePressed() determines which Shelf was clicked on 
    if(map.bookshelfList.get(bookshelfNum).drawingShelves == true){
      if(key == 32){ // If mouse clicked and space reset the shelf
        updateShelf();
      }
      else if(key == ENTER){ // if mouse clicked and enter toggle hasBooks
        if(hasBooks == true){
          hasBooks = false; 
        }
        else{
          hasBooks = true;
          yearUpdated = calendar.get(Calendar.YEAR);      //if a bookshelf now has books, set the date last sorted to the day it received books
          dayUpdated = calendar.get(Calendar.DAY_OF_YEAR);
        }
      }
    }
  }
  
  void lastUpdated(){
    timeNotUpdated = ((calendar.get(Calendar.YEAR) - yearUpdated) * 365) + (calendar.get(Calendar.DAY_OF_YEAR) - dayUpdated); //calculates how many ago the bookshelf was updated
  }
  
  void findShade(){
    if(50 <= 255 - (timeNotUpdated * 2)){ // 50 is the darkest a shelf can be displayed
      shade = (int) (255 - (timeNotUpdated * 2));
    }
    else{
      shade = 50;
    }
  }
  
}