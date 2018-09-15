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
   github.com/Azamlynny
*/

 // for ArrayList and list
 // for Calendar

Information info = new Information();
Map map;
KeyTracker keyTracker = new KeyTracker();
MouseTracker mouseTracker = new MouseTracker();

Calendar calendar = Calendar.getInstance();
TimeZone tz = TimeZone.getTimeZone("GMT-04");// EST East Coast of America

public void settings(){ // This runs before void setup()
  size(displayWidth, displayHeight); //Sets the size to the resolution of the computer so that later on everything is scaled to it.
}
  
public void setup(){
  calendar.setTimeZone(tz); // Changes timezone from GMT to EST
  
  map = new Map();
  
  Input inputData = new Input(); // Constructor inputs MapData.txt and makes objects from it
  inputData.inputFile();
}

public void draw(){
  background(255);
  map.drawMap(); 
}

public void keyPressed(){
  keyTracker.checkKeyPress();
}

public void keyReleased(){ // keyReleased() is used so that buttons may be held down and then the mouse can click in combination.
  keyTracker.resetKey(); // Gives the key value a value of Null so that key is not equal to a character when not being pressed.
}

public void mousePressed(){
  mouseTracker.checkMousePress();
}

public void exit() { 
  Output output = new Output(); //Constructor outputs the objects data to MapData.txt, which will be in the same directory as the program.
  output.outputFile("MapData.txt");
  
  System.exit(0); //Makes sure the file closes because otherwise it will run in the background and create lag on the computer
} 
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

  public void drawBookshelf() {
    findAverageInfo(); //Findes averageSahde and averageTimeNotUpdated
    // for finding the color and the drawing of the bookshelf depending on the average shade of all shelves
    fill(averageShade);
    rect(this.xPosition * map.widthRatio, this.yPosition * map.heightRatio, this.xWidth * map.widthRatio, this.yHeight * map.heightRatio);
    
    //For the number that displays on the bookshelf showing the average time not sorted of all shelves
    textSize(30 * map.widthRatio);
    fill(0);
    text((int) averageTimeNotUpdated, (xPosition + (xWidth / 2)) * map.widthRatio, (yPosition + (yHeight / 2) + 10) * map.widthRatio);
  }

  public void checkHitbox(boolean mousePress){
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

  public void drawShelves(){
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
  
  public void findAverageInfo(){
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
/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class Information{//This is to organize text which tells Instructions or Information
  String currentRangeBox; //Stores which bookshelf range is displaying the RangeBox so that it may be drawn over Bookshelf objects in the corner of the screen
  
  public void drawOrientationInfo(){ //Draws "Landmarks" in the Library to orient the user with their surroundings and the map so they can find the bookshelf they sorted easily.
    textSize(50 * map.widthRatio); 
    text("Tables Area", 350 * map.widthRatio, 700 * map.heightRatio);
    textSize(30 * map.widthRatio);
    text("Volunteer Desk", 1750 * map.widthRatio, 700 * map.heightRatio);
    text("Children's Area", 1750 * map.widthRatio, 300 * map.heightRatio);
  }
 
  public void drawInstructions(boolean shelvesDrawn){
    textAlign(LEFT);
    if(shelvesDrawn == true){
      textSize(40 * map.widthRatio);
      text("Instructions:", 50 * map.widthRatio, 100 * map.heightRatio);
      textSize(23 * map.widthRatio);
      text("Hold 'Space' down and click on a", 50 * map.widthRatio, 150 * map.heightRatio);        // continued text is 30 pixels apart
      text("shelf to reset the day last sorted.", 50 * map.widthRatio, 180 * map.heightRatio);
      text("Hold 'Enter' down and click on a shelf", 50 * map.widthRatio, 230 * map.heightRatio);  // new text paragraph is 50 pixels apart
      text("to toggle whether it has books on it.", 50 * map.widthRatio, 260 * map.heightRatio);
      text("Shelves that appear light blue mean", 50 * map.widthRatio, 310 * map.heightRatio);
      text("the shelf has no books on it.", 50 * map.widthRatio, 340 * map.heightRatio);
      text("Press 'q' to exit the bookshelf.", 50 * map.widthRatio, 390 * map.heightRatio);
    }
    else if(shelvesDrawn == false){
      textSize(40 * map.widthRatio);
      text("Instructions:", 50 * map.widthRatio, 880 * map.heightRatio);
      textSize(30 * map.widthRatio);
      text("Click on a bookshelf to see each individual shelf and when it was last sorted.", 50 * map.widthRatio, 920 * map.heightRatio);
      textSize(25 * map.widthRatio);
      text("The number displayed on a bookshelf is the average amount of days when the shelves on it were last sorted", 50 * map.widthRatio, 960 * map.heightRatio);
    }
    textAlign(CENTER); // The numbers on Bookshelves and Shelves are centered
  }
  
  public void drawRangeBox(Bookshelf bookshelf){ // Draws the information about the range of books that are at the bookshelf
    if(bookshelf.drawingShelves == false){ //Draws a box so that the text can sit on top and be easily read
      fill(255, 242, 163);
      rect(10 * map.widthRatio, 10 * map.heightRatio, 250 * map.widthRatio, 30 * map.heightRatio);
    }
    fill(0);
    textSize(20 * map.widthRatio);
    text(bookshelf.bookshelfName, 130 * map.widthRatio, 30 * map.heightRatio);
    
    info.currentRangeBox = ""; //This is so the RangeBox does not remain after the mouse is no longer hovering over it.
  }
}
/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class Input{//This is to organize the code which inputs MapData.txt
  
  public Input(){
   
  }
  
  public void inputFile(){
     String line = null;
    BufferedReader input = null;
     
    try{ 
      input = new BufferedReader(new FileReader("C:/Users/Adam/Documents/Processing/LibraryMap/LibraryMap/MapData.txt")); // This is for my computer to access MapData.txt
      //C:/Users/Public05/Documents/Processing/Library_Map/application.windows64/MapData.txt = directory for the library's computer
      //input = new BufferedReader(new FileReader("MapData.txt")); // This is so the library computer can access MapData.txt

      line = input.readLine();
      
      while(line != null){
  
        StringTokenizer bookData = new StringTokenizer(line);
        
        //Creates Bookshelf objects
        map.bookshelfList.add(new Bookshelf(Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), bookData.nextToken(" ")));
        
        for(int x = 0; x < map.bookshelfList.get(map.bookshelfList.size() - 1).shelfColumns; x++){
          for(int y = 0; y < map.bookshelfList.get(map.bookshelfList.size() - 1).shelfRows; y++){
            StringTokenizer shelfData = new StringTokenizer(input.readLine());
            
            //Creates Shelf objects
            map.bookshelfList.get(map.bookshelfList.size() - 1).shelves[x][y] = new Shelf(Integer.parseInt(shelfData.nextToken()), Integer.parseInt(shelfData.nextToken()), Boolean.parseBoolean(shelfData.nextToken()));
          }
        }
        
        line = input.readLine();
      }
        
    }
    catch (IOException ioe){
      ioe.printStackTrace();
    } 
  }
  
}
/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class KeyTracker{ //Handles key related functions
  
  public void checkKeyPress(){
    if(key == 'q'){
    for(int i = 0; i < map.bookshelfList.size(); i++){
        map.bookshelfList.get(i).drawingShelves = false; 
      }
    }
  }
  
  public void resetKey(){
    key = 0; // Gives the key value a value of Null so that key is not equal to a character when not being pressed. 
  }
  
}
/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class Map{
  final float originalWidth = 1920; // The program was originally made on a 1920x1080 resolution computer
  final float originalHeight = 1080;
  float newWidth;             // newWidth and newHeight represent the dimensions of the monitor using the program
  float newHeight;
  float widthRatio;           // Every calculation using distance or any size is multiplied by these ratios
  float heightRatio;
  
  List<Bookshelf> bookshelfList = new ArrayList<Bookshelf>();
  
  public Map(){
    newWidth = displayWidth;
    newHeight = displayHeight;
    widthRatio = newWidth/originalWidth;
    heightRatio = newHeight/originalHeight;
  }
  
  public void drawMap(){
    this.drawInformation();
  
    this.drawObjects();
    
    this.drawRangeBox();
  }
  
  public void drawObjects(){
    for(int i = 0; i < map.bookshelfList.size(); i++){ //Draws Bookshelves and Shelves
      if(map.bookshelfList.get(i).drawingShelves == true){
         map.bookshelfList.get(i).drawShelves();
         break; //It will draw bookshelves until it finds one that is supposed to be drawing shelves. 
                //The shelves clear the background and draw over the bookshevlves and break the forloop, causing no more bookshelves to be displayed over it and allowing this to work.
      }
      else if(map.bookshelfList.get(i).drawingShelves == false){
         map.bookshelfList.get(i).drawBookshelf(); 
         map.bookshelfList.get(i).checkHitbox(false);
      }
    }
  }
  
  public void drawRangeBox(){ //RangeBox is the box that shows the range of books the shelf contains.
    for(int i = 0; i < map.bookshelfList.size(); i++){                    //Draws RangeBox
      if(map.bookshelfList.get(i).bookshelfName == info.currentRangeBox){ //Not in above forloop so that the RangeBox appears above the Bookshelves
        info.drawRangeBox(map.bookshelfList.get(i)); 
      } 
    }
  }
  
  public void drawInformation(){
    info.drawOrientationInfo();
    info.drawInstructions(false); 
  }
  
}
/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class MouseTracker{ //handles mouse related functions
  
  public void checkMousePress(){
    for(int i = 0; i < map.bookshelfList.size(); i++){
      map.bookshelfList.get(i).checkHitbox(true); // drawingShelves must be false 
    }
    
    for(int i = 0; i < map.bookshelfList.size(); i++){ // drawingShelves must be true
      if(mouseX > (500 * map.widthRatio) && mouseX < (1500 * map.heightRatio)){
        map.bookshelfList.get(i).shelves[(int) ((map.bookshelfList.get(i).shelfColumns * (mouseX - (500 * map.widthRatio))) / (1000 * map.widthRatio)) ][(int) ((map.bookshelfList.get(i).shelfRows * (mouseY)) / (1000 * map.heightRatio))].checkHitbox(i);
      }
    } 
  }
  
}
/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class Output{//This is to organize the code which outputs to MapData.txt any changes that have happened to the data while the program was in use
  
  public Output(){ 
   
 }
  
  public void outputFile(String location){//Location is here so that if wanted, MapData.txt can be printed to a normal location and then a backup folder.
     PrintWriter output = createWriter(location); 
  
    for(int i = 0; i < map.bookshelfList.size(); i++){
      //Writes the data of a Bookshelf object (int shelfColumns, int shelfRows, int xPosition, int yPosition, int xWidth, int yHeight, String bookshelfName)
      output.println(map.bookshelfList.get(i).shelfColumns + " " + map.bookshelfList.get(i).shelfRows + " " + map.bookshelfList.get(i).xPosition + " " + map.bookshelfList.get(i).yPosition + " " + map.bookshelfList.get(i).xWidth + " " + map.bookshelfList.get(i).yHeight + " " + map.bookshelfList.get(i).bookshelfName);
      
      for(int x = 0; x < map.bookshelfList.get(i).shelfColumns; x++){
        for(int y = 0; y < map.bookshelfList.get(i).shelfRows; y++){
          //Writes the data of a Shelf object (int yearUpdated, int dayUpdated, boolean hasBooks)
          output.println(map.bookshelfList.get(i).shelves[x][y].yearUpdated + " " + map.bookshelfList.get(i).shelves[x][y].dayUpdated + " " + map.bookshelfList.get(i).shelves[x][y].hasBooks);
       }
     }  
   }
   
   output.flush(); // Writes the remaining data to the file
   output.close(); // Finishes the file
  }
  
}
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
  
  public void updateShelf(){ //Resets a shelf, used when it was sorted
    yearUpdated = calendar.get(Calendar.YEAR);
    dayUpdated = calendar.get(Calendar.DAY_OF_YEAR);
    timeNotUpdated = 0;
  }
  
  public void checkHitbox(int bookshelfNum){ // previous logic in mousePressed() determines which Shelf was clicked on 
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
  
  public void lastUpdated(){
    timeNotUpdated = ((calendar.get(Calendar.YEAR) - yearUpdated) * 365) + (calendar.get(Calendar.DAY_OF_YEAR) - dayUpdated); //calculates how many ago the bookshelf was updated
  }
  
  public void findShade(){
    if(50 <= 255 - (timeNotUpdated * 2)){ // 50 is the darkest a shelf can be displayed
      shade = (int) (255 - (timeNotUpdated * 2));
    }
    else{
      shade = 50;
    }
  }
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "LibraryMap" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
