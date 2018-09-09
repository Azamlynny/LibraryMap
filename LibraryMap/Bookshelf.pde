class Bookshelf {
  int shelfColumns; 
  int shelfRows;
  int xPosition;
  int yPosition;
  int xWidth;
  int yHeight;
  boolean drawingShelves = false;
  float averageShade;
  float averageTimeNotUpdated;

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
    findAverageShade();
    fill(averageShade);
    rect(this.xPosition, this.yPosition, this.xWidth, this.yHeight);
    textSize(30);
    fill(0);
    findAverageTimeNotUpdated();
    text((int) averageTimeNotUpdated, xPosition + (xWidth / 2), yPosition + (yHeight / 2));
  }

  void checkHitbox(){
    if(mouseX > xPosition && mouseX < xPosition + xWidth && mouseY > yPosition && mouseY < yPosition + yHeight || mouseX < xPosition && mouseX > xPosition + xWidth && mouseY > yPosition && mouseY < yPosition + yHeight || mouseX > xPosition && mouseX < xPosition + xWidth && mouseY < yPosition && mouseY > yPosition + yHeight || mouseX < xPosition && mouseX > xPosition + xWidth && mouseY < yPosition && mouseY > yPosition + yHeight){
      for(int i = 0; i < bookshelfList.size(); i++){
        if(bookshelfList.get(i).drawingShelves == true){
          break; 
        }
        else if(i == bookshelfList.size() - 1){
          this.drawingShelves = true;          
        }
      }
    }
  }

  void drawShelves() {
    background(255, 255, 255);
    for (int x = 0; x < shelfColumns; x++) {
      for (int y = 0; y < shelfRows; y++) {
        shelves[x][y].lastUpdated();
        shelves[x][y].findShade();
        fill(shelves[x][y].shade);
        //System.out.println(shelves[x][y].shade);
        rect(500 + ((1000 / this.shelfColumns) * x), (1000 / this.shelfRows) * y, 1000 / this.shelfColumns, 1000 / this.shelfRows);
        if(shelves[x][y].shade < 100){
          fill(255);
        }
        else{
          fill(0);
        }
        textSize(90/this.shelfColumns);
        if(shelves[x][y].timeNotUpdated != 1){ // plural days
          text("Unsorted for: " + shelves[x][y].timeNotUpdated + " days", 500 + ((1000 / this.shelfColumns) * x) + ((1000 / this.shelfColumns) / 2), ((1000 / this.shelfRows) * y) + ((1000 / this.shelfRows) / 2));
        }
        else{
          text("Unsorted for: " + shelves[x][y].timeNotUpdated + " day", 500 + ((1000 / this.shelfColumns) * x) + ((1000 / this.shelfColumns) / 2), ((1000 / this.shelfRows) * y) + ((1000 / this.shelfRows) / 2));
        }
      }
    }
  }
  
  void findAverageShade(){
    float totalShade = 0;
    for(int x = 0; x < this.shelfColumns; x++){
      for(int y = 0; y < this.shelfRows; y++){
        totalShade += this.shelves[x][y].shade;
      }
    }
    averageShade = totalShade / (this.shelfColumns * this.shelfRows);
  }
  
  void findAverageTimeNotUpdated(){
    float totalTimeNotUpdated = 0;
    for(int x = 0; x < this.shelfColumns; x++){
      for(int y = 0; y < this.shelfRows; y++){
        totalTimeNotUpdated += shelves[x][y].timeNotUpdated; 
      }
    }
    averageTimeNotUpdated = totalTimeNotUpdated / (this.shelfColumns * this.shelfRows);
  }
}