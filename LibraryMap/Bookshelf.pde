class Bookshelf {
  int shelfColumns; 
  int shelfRows;
  int xPosition;
  int yPosition;
  int xWidth;
  int yHeight;
  boolean drawingShelves = false;

  Shelf[][] shelves;

  String shelfName = "Shelf_Name";

  public Bookshelf(int columns, int rows, int xPos, int yPos, int Width, int Height, String name) {
    shelfColumns = columns;
    shelfRows = rows;
 
    shelves = new Shelf[shelfColumns][shelfRows];

    xPosition = xPos;
    yPosition = yPos;
    xWidth = Width; 
    yHeight = Height;

    shelfName = name;
  }

  void drawBookshelf() {
    //fill function depending on when last sorted TODO
    rect(this.xPosition, this.yPosition, this.xWidth, this.yHeight);
  }

  void checkHitbox(){
    if(mouseX > xPosition && mouseX < xPosition + xWidth && mouseY > yPosition && mouseY < yPosition + yHeight || mouseX < xPosition && mouseX > xPosition + xWidth && mouseY > yPosition && mouseY < yPosition + yHeight || mouseX > xPosition && mouseX < xPosition + xWidth && mouseY < yPosition && mouseY > yPosition + yHeight || mouseX < xPosition && mouseX > xPosition + xWidth && mouseY < yPosition && mouseY > yPosition + yHeight){
      this.drawingShelves = true; 
    }
  }

  void drawShelves() {
    for (int x = 0; x < shelfColumns; x++) {
      for (int y = 0; y < shelfRows; y++) {
        fill(shelves[x][y].shade);
        rect(500 + ((1000 / this.shelfColumns) * x), (1000 / this.shelfRows) * y, 1000 / this.shelfColumns, 1000 / this.shelfRows);
      }
    }
  }
}