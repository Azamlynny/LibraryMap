import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 
import java.io.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class LibraryMap extends PApplet {

/* Created by Adam Zamlynny
   azamlynny@hotmail.com
*/



List<Bookshelf> bookshelfList = new ArrayList<Bookshelf>();

Calendar calendar = Calendar.getInstance();
TimeZone tz = TimeZone.getTimeZone("GMT-04");
String currentInfoBox;

public void setup(){
  
  
  calendar.setTimeZone(tz);
  
  textAlign(CENTER);
  String line = null;
  BufferedReader input = null;
   
  try{ //map input from file
    //input = new BufferedReader(new FileReader("C:/Users/Adam/Documents/Processing/LibraryMap/LibraryMap/MapData.txt")); // this is for my computer,
    input = new BufferedReader(new FileReader("C:/Users/Public05/Documents/Processing/Library Map/Do Not Delete/MapData.txt"));//directory for library computer
    int place = 0;
    line = input.readLine();
    while(line != null){

      StringTokenizer bookData = new StringTokenizer(line);
      
      bookshelfList.add(new Bookshelf(Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), bookData.nextToken(" ")));
      
      for(int x = 0; x < bookshelfList.get(place).shelfColumns; x++){
        for(int y = 0; y < bookshelfList.get(place).shelfRows; y++){
          //System.out.println(bookshelfList.get(place).shelves[0][0].yearUpdated);
          StringTokenizer shelfData = new StringTokenizer(input.readLine());
          bookshelfList.get(place).shelves[x][y] = new Shelf(Integer.parseInt(shelfData.nextToken()), Integer.parseInt(shelfData.nextToken()), Boolean.parseBoolean(shelfData.nextToken()));
        }
      }
      place++;
      line = input.readLine();
    }
      
  }
  catch (IOException ioe){
    ioe.printStackTrace();
  } 
}

public void draw(){
  background(255);
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).drawBookshelf(); 
    bookshelfList.get(i).checkHitbox(false);
  }
  
  textSize(50); //Everything past here is just to orientate the Map for people
  text("Tables Area", 350, 700);
  textSize(30);
  text("Volunteer Desk", 1750, 700);
  text("Children's Area", 1750, 300);//end of orientation text
  
  drawInstructions(false); 
  
  for(int i = 0; i < bookshelfList.size(); i++){
    if(bookshelfList.get(i).drawingShelves == true){
       bookshelfList.get(i).drawShelves();
    }
  }
  for(int i = 0; i < bookshelfList.size(); i++){
    if(bookshelfList.get(i).bookshelfName == currentInfoBox){
      bookshelfList.get(i).drawInfoBox(); 
      currentInfoBox = "";
    }
    
  }

  
    
  
}


public void keyPressed(){
  if(key == ESC){
    for(int i = 0; i < bookshelfList.size(); i++){
      bookshelfList.get(i).drawingShelves = false; 
    }
  }
}

public void keyReleased(){
  key = 'a'; // resets the key value 
}

public void mousePressed(){
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).checkHitbox(true); // drawingShelves must be false 
  }
  
  for(int i = 0; i < bookshelfList.size(); i++){
    if(mouseX > 500 && mouseX < 1500){
      bookshelfList.get(i).shelves[(int) ((bookshelfList.get(i).shelfColumns * (mouseX - 500)) / 1000) ][(int) ((bookshelfList.get(i).shelfRows * (mouseY)) / 1000)].checkHitbox(i);
    }
  }
}

public void exit() { // writes any changes to MapData.txt
  PrintWriter output = createWriter("MapData.txt");
  
  for(int i = 0; i < bookshelfList.size(); i++){
    
    output.println(bookshelfList.get(i).shelfColumns + " " + bookshelfList.get(i).shelfRows + " " + bookshelfList.get(i).xPosition + " " + bookshelfList.get(i).yPosition + " " + bookshelfList.get(i).xWidth + " " + bookshelfList.get(i).yHeight + " " + bookshelfList.get(i).bookshelfName);
    
    for(int x = 0; x < bookshelfList.get(i).shelfColumns; x++){
      for(int y = 0; y < bookshelfList.get(i).shelfRows; y++){
        output.println(bookshelfList.get(i).shelves[x][y].yearUpdated + " " + bookshelfList.get(i).shelves[x][y].dayUpdated + " " + bookshelfList.get(i).shelves[x][y].hasBooks);
      }
    }  
  }
  
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
} 

public void drawInstructions(boolean shelvesDrawn){
  textAlign(LEFT);
  if(shelvesDrawn == true){
    textSize(40);
    text("Instructions:", 50, 100);
    textSize(23);
    text("Hold 'Space' down and click on a", 50, 150);
    text("shelf to reset the day last sorted.", 50, 180);
    text("Hold 'Enter' down and click on a shelf", 50, 230);
    text("to toggle whether it has books on it.", 50, 260);
    text("Shelves that appear red mean the", 50, 310);
    text("bookshelf viewed has no books on it.", 50, 340);
    text("Press 'Escape' to exit the bookshelf.", 50, 390);
  }
  else if(shelvesDrawn == false){
    textSize(40);
    text("Instructions:", 50, 880);
    textSize(30);
    text("Click on a bookshelf to see each individual shelf and when it was last sorted.", 50, 920);
    textSize(25);
    text("The number displayed on a bookshelf is the average amount of days when the shelves on it were last sorted", 50, 960);
  }
  textAlign(CENTER);
}
/* Created by Adam Zamlynny
   azamlynny@hotmail.com
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

  public void drawBookshelf() {
    findAverageShade();
    fill(averageShade);
    rect(this.xPosition, this.yPosition, this.xWidth, this.yHeight);
    textSize(30);
    fill(0);
    findAverageTimeNotUpdated();
    text((int) averageTimeNotUpdated, xPosition + (xWidth / 2), yPosition + (yHeight / 2) + 10);
  }

  public void checkHitbox(boolean mousePress){
    if(mouseX > xPosition && mouseX < xPosition + xWidth && mouseY > yPosition && mouseY < yPosition + yHeight || mouseX < xPosition && mouseX > xPosition + xWidth && mouseY > yPosition && mouseY < yPosition + yHeight || mouseX > xPosition && mouseX < xPosition + xWidth && mouseY < yPosition && mouseY > yPosition + yHeight || mouseX < xPosition && mouseX > xPosition + xWidth && mouseY < yPosition && mouseY > yPosition + yHeight){
      for(int i = 0; i < bookshelfList.size(); i++){
        if(bookshelfList.get(i).drawingShelves == true){
          break; 
        }
        else if(i == bookshelfList.size() - 1){
          if(mousePress == true){
            this.drawingShelves = true;
          }
          else{
            currentInfoBox = this.bookshelfName;
            
          }
        }
      }
    }
  }

  public void drawShelves() {
    background(255, 255, 255);
    
    drawInstructions(this.drawingShelves);
    
    for (int x = 0; x < shelfColumns; x++) {
      for (int y = 0; y < shelfRows; y++) {
        if(shelves[x][y].hasBooks == true){
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
        else if(shelves[x][y].hasBooks == false){ // if the bookshelf has no books on it then display it as red and do not display when it was sorted last.
        fill(255,0,0);
        rect(500 + ((1000 / this.shelfColumns) * x), (1000 / this.shelfRows) * y, 1000 / this.shelfColumns, 1000 / this.shelfRows);
        }
      }
    }
  
    
    drawInfoBox();
  }
  
  public void findAverageShade(){
    float totalShade = 0;
    for(int x = 0; x < this.shelfColumns; x++){
      for(int y = 0; y < this.shelfRows; y++){
        totalShade += this.shelves[x][y].shade;
      }
    }
    averageShade = totalShade / (this.shelfColumns * this.shelfRows);
  }
  
  public void findAverageTimeNotUpdated(){
    float totalTimeNotUpdated = 0;
    for(int x = 0; x < this.shelfColumns; x++){
      for(int y = 0; y < this.shelfRows; y++){
        if(shelves[x][y].hasBooks == true){
          totalTimeNotUpdated += shelves[x][y].timeNotUpdated; 
        }
      }
    }
    averageTimeNotUpdated = totalTimeNotUpdated / (this.shelfColumns * this.shelfRows);
  }
  
  public void drawInfoBox(){
    if(drawingShelves == false){
      fill(255, 242, 163);
      rect(10, 10, 250, 30);
    }
    textSize(20);
    fill(0);
    text(this.bookshelfName, 130, 30);
  }
}
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
  
  public void updateShelf(){
    yearUpdated = calendar.get(Calendar.YEAR);
    dayUpdated = calendar.get(Calendar.DAY_OF_YEAR);
    timeNotUpdated = 0;
  }
  
  public void checkHitbox(int bookshelfNum){ // previous logic in mousePressed() determines which Shelf was clicked on 
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
  
  public void lastUpdated(){
    timeNotUpdated = ((calendar.get(Calendar.YEAR) - yearUpdated) * 365) + (calendar.get(Calendar.DAY_OF_YEAR) - dayUpdated);
  }
  
  public void findShade(){
    if(50 <= 255 - (timeNotUpdated * 8.5f)){
      shade = (int) (255 - (timeNotUpdated * 8.5f));
    }
    else{
      shade = 50;
    }
  }
  
}
  public void settings() {  size(2000, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "LibraryMap" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
