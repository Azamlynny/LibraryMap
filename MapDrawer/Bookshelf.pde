class Bookshelf{
  int shelfColumns = 4; 
  int shelfRows = 4;
  
  int xPosition;
  int yPosition;
  int xWidth;
  int yHeight;
  
  Shelf[][] shelves;
  
  String shelfName = "Shelf_Name";
  
  public Bookshelf(int columns, int rows, int xPos, int yPos, int Width, int Height){
    shelfColumns = columns;
    shelfRows = rows;
    shelves = new Shelf[shelfColumns][shelfRows];
    
    for(int x = 0; x < shelfColumns; x++){
      for(int y = 0; y < shelfRows; y++){
         shelves[x][y] = new Shelf();
      }
    }
    
    xPosition = xPos;
    yPosition = yPos;
    xWidth = Width;
    yHeight = Height;
    
  }
  
  void drawBookshelf(){
    //fill func depending on when sorted
    rect(this.xPosition, this.yPosition, this.xWidth, this.yHeight);
  }
  
  void drawShelves(){
    for(int x = 0; x < shelfColumns; x++){
      for(int y = 0; y < shelfRows; y++){
         fill(shelves[x][y].r);
         rect(500 + ((1000 / this.shelfColumns) * x), (1000 / this.shelfRows) * y, 1000 / this.shelfColumns, 1000 / this.shelfRows);
      }
    }
  }
  
}