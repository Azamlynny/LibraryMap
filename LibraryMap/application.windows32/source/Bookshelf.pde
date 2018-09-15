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
    xPosition = xPos;
    yPosition = yPos;
    xWidth = Width; 
    yHeight = Height;
    bookshelfName = shelfName; // This is also the bookshelf range, the range of books a bookshelf holds
  
    shelves = new Shelf[shelfColumns][shelfRows];
  }

  void drawBookshelf() {
    findAverageInfo(); //Findes averageSahde and averageTimeNotUpdated
    // for finding the color and the drawing of the bookshelf depending on the average shade of all shelves
    fill(averageShade);
    rect(this.xPosition * map.widthRatio, this.yPosition * map.heightRatio, this.xWidth * map.widthRatio, this.yHeight * map.heightRatio);
    
    //For the number that displays on the bookshelf showing the average time not sorted of all shelves
    textSize(30 * map.widthRatio);
    fill(0);
    text((int) averageTimeNotUpdated, (xPosition + (xWidth / 2)) * map.widthRatio, (yPosition + (yHeight / 2) + 10) * map.widthRatio);
  }

  void checkHitbox(boolean mousePress){
    //if the mouse is inside the Bookshelf
    if(mouseX > xPosition * map.widthRatio && mouseX < (xPosition + xWidth) * map.widthRatio && mouseY > yPosition * map.heightRatio && mouseY < (yPosition + yHeight) * map.heightRatio || mouseX < xPosition * map.widthRatio && mouseX > (xPosition + xWidth) * map.widthRatio && mouseY > yPosition * map.heightRatio && mouseY < (yPosition + yHeight) * map.heightRatio || mouseX > xPosition  * map.widthRatio && mouseX < (xPosition + xWidth) * map.widthRatio && mouseY < yPosition * map.heightRatio && mouseY > (yPosition + yHeight) * map.heightRatio || mouseX < xPosition * map.widthRatio && mouseX > (xPosition + xWidth) * map.widthRatio && mouseY < yPosition * map.heightRatio && mouseY > (yPosition + yHeight) * map.heightRatio){
      for(int i = 0; i < map.bookshelfList.size(); i++){
        if(map.bookshelfList.get(i).drawingShelves == true){
          break; 
        }
        else if(i == map.bookshelfList.size() - 1){ // if no shelves are being displayed, it continues. If a shelf is displayed, the forloop breaks.
          if(mousePress == true){ // if the mouse was pressed, draw the shelves
            this.drawingShelves = true;
          }
          else if(mousePress == false){ // if the mouse is not pressed, but hovered over the Bookshelf, then draw the RangeBox
            info.currentRangeBox = this.bookshelfName; // Have to do this or else RangeBox is drawn under the Bookshelves. It needs to be drawn after all bookshelves are drawn. //info.drawRangeBox(this); does not work for this reason
          }
        }
      }
    }
  }

  void drawShelves(){
    background(255); //Draws a white background to overlap everything currently drawn
    
    info.drawInstructions(drawingShelves);
    
    for (int x = 0; x < shelfColumns; x++) {
      for (int y = 0; y < shelfRows; y++) {
        if(shelves[x][y].hasBooks == true){
          shelves[x][y].lastUpdated();
          shelves[x][y].findShade();
          fill(shelves[x][y].shade);
          //draws the shelves depending on their x and y values in shelves[][]
          rect((500 + ((1000 / this.shelfColumns) * x)) * map.widthRatio, ((1000 / this.shelfRows) * y) * map.heightRatio, (1000 / this.shelfColumns) * map.widthRatio, (1000 / this.shelfRows) * map.heightRatio);
          
          if(shelves[x][y].shade < 100){ // if the shade of the bookshelf is lower than 100, so darker than 100, make the text white to make it more visible
            fill(255);
          }
          else{
            fill(0);
          }
          
          textSize((90/this.shelfColumns) * map.widthRatio);
          
          if(shelves[x][y].timeNotUpdated != 1){ // writes day as plural if the time not updated is not 1
            text("Unsorted for: " + shelves[x][y].timeNotUpdated + " days", (500 + ((1000 / this.shelfColumns) * x) + ((1000 / this.shelfColumns) / 2)) * map.widthRatio, (((1000 / this.shelfRows) * y) + ((1000 / this.shelfRows) / 2)) * map.heightRatio);
          }
          else{ // writes day as singular 
            text("Unsorted for: " + shelves[x][y].timeNotUpdated + " day", (500 + ((1000 / this.shelfColumns) * x) + ((1000 / this.shelfColumns) / 2)) * map.widthRatio, (((1000 / this.shelfRows) * y) + ((1000 / this.shelfRows) / 2)) * map.heightRatio);
          }
        }
        else if(shelves[x][y].hasBooks == false){ // if the bookshelf has no books on it then display it as light blue and do not display when it was sorted last.
        fill(211, 247, 255);
        rect((500 + ((1000 / this.shelfColumns) * x)) * map.widthRatio, ((1000 / this.shelfRows) * y) * map.heightRatio, (1000 / this.shelfColumns) * map.widthRatio, (1000 / this.shelfRows) * map.heightRatio);
        fill(0);
        text("Empty Shelf", (500 + ((1000 / this.shelfColumns) * x) + ((1000 / this.shelfColumns) / 2)) * map.widthRatio, (((1000 / this.shelfRows) * y) + ((1000 / this.shelfRows) / 2)) * map.heightRatio);
        }
      }
    }
    
    info.drawRangeBox(this); //Passes in this bookshelf object to draw the bookshelf Name/range
  }
  
  void findAverageInfo(){
    float totalShade = 0;
    float notEmptyBookshelves = 0;
    float totalTimeNotUpdated = 0;
    for(int x = 0; x < this.shelfColumns; x++){
      for(int y = 0; y < this.shelfRows; y++){
        if(shelves[x][y].hasBooks == true){
          totalShade += this.shelves[x][y].shade;
          totalTimeNotUpdated += shelves[x][y].timeNotUpdated;
          notEmptyBookshelves++;
        }
      }
    }
    averageShade = totalShade / notEmptyBookshelves;
    averageTimeNotUpdated = totalTimeNotUpdated / notEmptyBookshelves;
  }
  
}