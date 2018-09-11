/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/

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

  String bookshelfName = "Shelf_Name";

  public Bookshelf(int columns, int rows, int xPos, int yPos, int Width, int Height, String shelfName) {
    shelfColumns = columns;
    shelfRows = rows;
 
    shelves = new Shelf[shelfColumns][shelfRows];

    xPosition = xPos;
    yPosition = yPos;
    xWidth = Width; 
    yHeight = Height;

    bookshelfName = shelfName;
  }

  void drawBookshelf() {
    findAverageShade();
    fill(averageShade);
    rect(this.xPosition * widthRatio, this.yPosition * heightRatio, this.xWidth * widthRatio, this.yHeight * heightRatio);
    textSize(30 * widthRatio);
    fill(0);
    findAverageTimeNotUpdated();
    text((int) averageTimeNotUpdated, (xPosition + (xWidth / 2)) * widthRatio, (yPosition + (yHeight / 2) + 10) * widthRatio);
  }

  void checkHitbox(boolean mousePress){
    if(mouseX > xPosition * widthRatio && mouseX < (xPosition + xWidth) * widthRatio && mouseY > yPosition * heightRatio && mouseY < (yPosition + yHeight) * heightRatio || mouseX < xPosition * widthRatio && mouseX > (xPosition + xWidth) * widthRatio && mouseY > yPosition * heightRatio && mouseY < (yPosition + yHeight) * heightRatio || mouseX > xPosition  * widthRatio && mouseX < (xPosition + xWidth) * widthRatio && mouseY < yPosition * heightRatio && mouseY > (yPosition + yHeight) * heightRatio || mouseX < xPosition * widthRatio && mouseX > (xPosition + xWidth) * widthRatio && mouseY < yPosition * heightRatio && mouseY > (yPosition + yHeight) * heightRatio){
      for(int i = 0; i < map.bookshelfList.size(); i++){
        if(map.bookshelfList.get(i).drawingShelves == true){
          break; 
        }
        else if(i == map.bookshelfList.size() - 1){
          if(mousePress == true){
            this.drawingShelves = true;
          }
          else{
            info.currentRangeBox = this.bookshelfName;
            
          }
        }
      }
    }
  }

  void drawShelves() {
    background(255, 255, 255);
    
    info.drawInstructions(this.drawingShelves);
    
    for (int x = 0; x < shelfColumns; x++) {
      for (int y = 0; y < shelfRows; y++) {
        if(shelves[x][y].hasBooks == true){
          shelves[x][y].lastUpdated();
          shelves[x][y].findShade();
          fill(shelves[x][y].shade);
          //System.out.println(shelves[x][y].shade);
          rect((500 + ((1000 / this.shelfColumns) * x)) * widthRatio, ((1000 / this.shelfRows) * y) * heightRatio, (1000 / this.shelfColumns) * widthRatio, (1000 / this.shelfRows) * heightRatio);
          if(shelves[x][y].shade < 100){
            fill(255);
          }
          else{
            fill(0);
          }
          textSize((90/this.shelfColumns) * widthRatio);
          if(shelves[x][y].timeNotUpdated != 1){ // plural days
            text("Unsorted for: " + shelves[x][y].timeNotUpdated + " days", (500 + ((1000 / this.shelfColumns) * x) + ((1000 / this.shelfColumns) / 2)) * widthRatio, (((1000 / this.shelfRows) * y) + ((1000 / this.shelfRows) / 2)) * heightRatio);
          }
          else{
            text("Unsorted for: " + shelves[x][y].timeNotUpdated + " day", (500 + ((1000 / this.shelfColumns) * x) + ((1000 / this.shelfColumns) / 2)) * widthRatio, (((1000 / this.shelfRows) * y) + ((1000 / this.shelfRows) / 2)) * heightRatio);
          }
        }
        else if(shelves[x][y].hasBooks == false){ // if the bookshelf has no books on it then display it as red and do not display when it was sorted last.
        fill(211, 247, 255);
        rect((500 + ((1000 / this.shelfColumns) * x)) * widthRatio, ((1000 / this.shelfRows) * y) * heightRatio, (1000 / this.shelfColumns) * widthRatio, (1000 / this.shelfRows) * heightRatio);
        fill(0);
        text("Empty Shelf", (500 + ((1000 / this.shelfColumns) * x) + ((1000 / this.shelfColumns) / 2)) * widthRatio, (((1000 / this.shelfRows) * y) + ((1000 / this.shelfRows) / 2)) * heightRatio);
        }
      }
    }
  
    
    info.drawRangeBox(this); //Passes in this bookshelf object
  }
  
  void findAverageShade(){
    float totalShade = 0;
    float notEmptyBookshelves = 0;
    for(int x = 0; x < this.shelfColumns; x++){
      for(int y = 0; y < this.shelfRows; y++){
        if(shelves[x][y].hasBooks == true){
          totalShade += this.shelves[x][y].shade;
          notEmptyBookshelves++;
        }
      }
    }
    averageShade = totalShade / notEmptyBookshelves;
  }
  
  void findAverageTimeNotUpdated(){
    float totalTimeNotUpdated = 0;
    int notEmptyBookshelves = 0;
     
    for(int x = 0; x < this.shelfColumns; x++){
      for(int y = 0; y < this.shelfRows; y++){
        if(shelves[x][y].hasBooks == true){
          totalTimeNotUpdated += shelves[x][y].timeNotUpdated; 
          notEmptyBookshelves++;
        }
      }
    }
    averageTimeNotUpdated = totalTimeNotUpdated / notEmptyBookshelves;
  }
  
  
}