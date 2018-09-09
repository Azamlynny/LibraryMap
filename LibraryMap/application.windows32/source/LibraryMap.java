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




List<Bookshelf> bookshelfList = new ArrayList<Bookshelf>();

public void setup(){
  
  
  String line = null;
  BufferedReader input = null;
   
  try{ //map input from file
    input = new BufferedReader(new FileReader("C:/Users/Adam/Documents/Processing/LibraryMap/MapData.txt"));
    int place = 0;
    line = input.readLine();
    while(line != null){
    //for(int i = 0; i < 1; i++){

      StringTokenizer bookData = new StringTokenizer(line);
      
      bookshelfList.add(new Bookshelf(Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), bookData.nextToken()));
      
      
      //System.out.println(shelfData.nextToken() + " " + shelfData.nextToken());
      for(int x = 0; x < bookshelfList.get(place).shelfColumns; x++){
        for(int y = 0; y < bookshelfList.get(place).shelfRows; y++){
          //System.out.println(bookshelfList.get(place).shelves[0][0].yearUpdated);
          StringTokenizer shelfData = new StringTokenizer(input.readLine());
          bookshelfList.get(place).shelves[x][y] = new Shelf(Integer.parseInt(shelfData.nextToken()), Integer.parseInt(shelfData.nextToken()));
        }
      }
      place++;
      line = input.readLine();
    }
      
  }
  catch (IOException ioe){
    ioe.printStackTrace();
  } 
  
  //try {
  //  input.close();
  //} 
  //catch (IOException ioe) 
  //{
  //  System.out.println("Error in closing the BufferedReader");
  //}
}

public void draw(){
  background(255);

  
  fill(0);
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).drawBookshelf(); 
  }
  for(int i = 0; i < bookshelfList.size(); i++){
    if(bookshelfList.get(i).drawingShelves == true){
       bookshelfList.get(i).drawShelves();
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

public void mousePressed(){
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).checkHitbox(); 
  }
}

public void exit() { // writes any changes to MapData.txt
  PrintWriter output = createWriter("MapData.txt");
  for(int i = 0; i < bookshelfList.size(); i++){
    output.println(bookshelfList.get(i).shelfColumns + " " + bookshelfList.get(i).shelfRows + " " + bookshelfList.get(i).xPosition + " " + bookshelfList.get(i).yPosition + " " + bookshelfList.get(i).xWidth + " " + bookshelfList.get(i).yHeight + " " + bookshelfList.get(i).shelfName);
    for(int x = 0; x < bookshelfList.get(i).shelfColumns; x++){
      for(int y = 0; y < bookshelfList.get(i).shelfRows; y++){
        output.println(bookshelfList.get(i).shelves[x][y].yearUpdated + " " + bookshelfList.get(i).shelves[x][y].dayUpdated);
      }
    }  
  }
} 
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

  public void drawBookshelf() {
    //fill function depending on when last sorted TODO
    rect(this.xPosition, this.yPosition, this.xWidth, this.yHeight);
  }

  public void checkHitbox(){
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

  public void drawShelves() {
    background(255, 255, 255);
    for (int x = 0; x < shelfColumns; x++) {
      for (int y = 0; y < shelfRows; y++) {
        shelves[x][y].lastUpdated();
        shelves[x][y].findShade();
        fill(shelves[x][y].shade);
        System.out.println(shelves[x][y].shade);
        rect(500 + ((1000 / this.shelfColumns) * x), (1000 / this.shelfRows) * y, 1000 / this.shelfColumns, 1000 / this.shelfRows);
      }
    }
  }
}

class Shelf{
  int yearUpdated;
  int dayUpdated;//1-365 day of the year
  int timeNotUpdated;
  int shade = 255;
    
  public Shelf(int yearUp, int dayUp){
    yearUpdated = yearUp;
    dayUpdated = dayUp;
  }
  
  public void updateShelf(){
    yearUpdated = Calendar.YEAR;
    dayUpdated = Calendar.DAY_OF_YEAR;
    timeNotUpdated = 0;
  }
  
  public void lastUpdated(){
    timeNotUpdated = ((Calendar.YEAR - yearUpdated) * 365) + (Calendar.DAY_OF_YEAR - dayUpdated);
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
