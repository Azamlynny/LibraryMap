class Shelf{
  int yearUpdated;
  int dayUpdated;//1-365 day of the year
  int timeNotUpdated = 0;
  int r;
  int g;
  int b;
    
  public Shelf(){
    yearUpdated = Calendar.YEAR;
    dayUpdated = Calendar.DAY_OF_YEAR;
    
    this.lastUpdated();
    this.findTint();
  }
  
  void updateShelf(){
    yearUpdated = Calendar.YEAR;
    dayUpdated = Calendar.DAY_OF_YEAR;
    timeNotUpdated = 0;
  }
  
  void lastUpdated(){
    timeNotUpdated = ((Calendar.YEAR - yearUpdated) * 365) + (Calendar.DAY_OF_YEAR - dayUpdated);
  }
  
  void findTint(){
    if(50 <= 255 - (timeNotUpdated * 8.5)){
      r = (int) (255 - (timeNotUpdated * 8.5));
    }
    else{
      r = 50;
    }
  }
  
}