/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/

import java.util.*; // for ArrayList and list
import java.io.*; // for Calendar

List<Bookshelf> bookshelfList = new ArrayList<Bookshelf>();

Calendar calendar = Calendar.getInstance();
TimeZone tz = TimeZone.getTimeZone("GMT-04");// EST East Coast of America

String currentInfoBox;

float originalWidth = 1920; // The program was originally made on a 1920x1080 resolution computer
float originalHeight = 1080;
float newWidth;            // newWidth and newHeight represent the dimensions of the monitor using the program
float newHeight;
float widthRatio;          // Every calculation using distance or any size is multiplied by these ratios
float heightRatio;

void settings(){ // This runs before void setup()
  size(displayWidth, displayHeight); //Sets the size to the resolution of the computer so that later on everything is scaled to it.
}
  
void setup(){
  calendar.setTimeZone(tz); // Changes timezone from GMT to EST
  
  newWidth = displayWidth;
  newHeight = displayHeight;
  widthRatio = newWidth/originalWidth;
  heightRatio = newHeight/originalHeight;
  
  Input inputData = new Input();
  inputData.inputMapData(); // Turns MapData.txt into Bookshelf and Shelf objects
}

void draw(){
  background(255);
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).drawBookshelf(); 
    bookshelfList.get(i).checkHitbox(false);
  }
  
  textSize(50 * widthRatio); //Everything past here is just to orientate the Map for people
  text("Tables Area", 350 * widthRatio, 700 * heightRatio);
  textSize(30 * widthRatio);
  text("Volunteer Desk", 1750 * widthRatio, 700 * heightRatio);
  text("Children's Area", 1750 * widthRatio, 300 * heightRatio);//end of orientation text
  
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


void keyPressed(){
  if(key == 'q'){
    for(int i = 0; i < bookshelfList.size(); i++){
      bookshelfList.get(i).drawingShelves = false; 
    }
  }
}

void keyReleased(){
  key = 'a'; // resets the key value 
}

void mousePressed(){
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).checkHitbox(true); // drawingShelves must be false 
  }
  
  for(int i = 0; i < bookshelfList.size(); i++){
    if(mouseX > (500 * widthRatio) && mouseX < (1500 * heightRatio)){
      bookshelfList.get(i).shelves[(int) ((bookshelfList.get(i).shelfColumns * (mouseX - (500 * widthRatio))) / (1000 * widthRatio)) ][(int) ((bookshelfList.get(i).shelfRows * (mouseY)) / (1000 * heightRatio))].checkHitbox(i);
    }
  }
}

void exit() { // writes any changes to MapData.txt
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
  
  System.exit(0);
} 

void drawInstructions(boolean shelvesDrawn){
  textAlign(LEFT);
  if(shelvesDrawn == true){
    textSize(40 * widthRatio);
    text("Instructions:", 50 * widthRatio, 100 * heightRatio);
    textSize(23 * widthRatio);
    text("Hold 'Space' down and click on a", 50 * widthRatio, 150 * heightRatio);
    text("shelf to reset the day last sorted.", 50 * widthRatio, 180 * heightRatio);
    text("Hold 'Enter' down and click on a shelf", 50 * widthRatio, 230 * heightRatio);
    text("to toggle whether it has books on it.", 50 * widthRatio, 260 * heightRatio);
    text("Shelves that appear red mean the", 50 * widthRatio, 310 * heightRatio);
    text("bookshelf viewed has no books on it.", 50 * widthRatio, 340 * heightRatio);
    text("Press 'q' to exit the bookshelf.", 50 * widthRatio, 390 * heightRatio);
  }
  else if(shelvesDrawn == false){
    textSize(40 * widthRatio);
    text("Instructions:", 50 * widthRatio, 880 * heightRatio);
    textSize(30 * widthRatio);
    text("Click on a bookshelf to see each individual shelf and when it was last sorted.", 50 * widthRatio, 920 * heightRatio);
    textSize(25 * widthRatio);
    text("The number displayed on a bookshelf is the average amount of days when the shelves on it were last sorted", 50 * widthRatio, 960 * heightRatio);
  }
  textAlign(CENTER);
}