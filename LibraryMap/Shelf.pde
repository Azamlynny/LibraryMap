class Shelf{
  int yearUpdated;
  int dayUpdated;//1-365 day of the year
  int timeNotUpdated;
  int shade = 255;
    
  public Shelf(int yearUp, int dayUp){
    yearUpdated = yearUp;
    dayUpdated = dayUp;
    
    lastUpdated();
    findShade();
  }
  
  void updateShelf(){
    yearUpdated = Calendar.YEAR;
    dayUpdated = Calendar.DAY_OF_YEAR;
    timeNotUpdated = 0;
  }
  
  void checkHitbox(int bookshelfNum){ // previous logic in mousePressed() determines which Shelf was clicked on 
    if(bookshelfList.get(bookshelfNum).drawingShelves == true && key == 32){
      updateShelf();
    }

  }
  
  void lastUpdated(){
    timeNotUpdated = ((Calendar.YEAR - yearUpdated) * 365) + (Calendar.DAY_OF_YEAR - dayUpdated);
  }
  
  void findShade(){
    if(50 <= 255 - (timeNotUpdated * 8.5)){
      shade = (int) (255 - (timeNotUpdated * 8.5));
    }
    else{
      shade = 50;
    }
  }
  
}