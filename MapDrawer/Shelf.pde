class Shelf{
  int yearUpdated;
  int dayUpdated;//1-365 day of the year
  int timeNotUpdated;
  int r;
  int g;
  int b;
    
  public Shelf(int yearUp, int dayUp){
    yearUpdated = yearUp; 
    dayUpdated = dayUp;
    
    this.lastUpdated();
    this.findTint();
  }
  
  void updateShelf(){ // for when the shelf is sorted
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