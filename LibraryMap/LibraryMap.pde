/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/

import java.util.*; // for ArrayList and list
import java.io.*; // for Calendar

List<Bookshelf> bookshelfList = new ArrayList<Bookshelf>();
Information info = new Information();

Calendar calendar = Calendar.getInstance();
TimeZone tz = TimeZone.getTimeZone("GMT-04");// EST East Coast of America

String currentInfoBox;

float originalWidth = 1920; // The program was originally made on a 1920x1080 resolution computer
float originalHeight = 1080;
float newWidth;             // newWidth and newHeight represent the dimensions of the monitor using the program
float newHeight;
float widthRatio;           // Every calculation using distance or any size is multiplied by these ratios
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
  
  Input inputData = new Input(); // Constructor inputs MapData.txt and makes objects from it
}

void draw(){
  background(255);
  
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).drawBookshelf(); 
    bookshelfList.get(i).checkHitbox(false);
  }
  
  info.drawOrientationInfo();
  
  info.drawInstructions(false); 
  
  for(int i = 0; i < bookshelfList.size(); i++){
    if(bookshelfList.get(i).drawingShelves == true){
       bookshelfList.get(i).drawShelves();
    }
  }
  for(int i = 0; i < bookshelfList.size(); i++){
    if(bookshelfList.get(i).bookshelfName == currentInfoBox){
     info.drawRangeBox(bookshelfList.get(i)); 
      currentInfoBox = ""; //This is so the RangeBox does not remain after the mouse is no longer hovering over it.
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

void exit() { 
  Output output = new Output(); //Constructor outputs the objects data to MapData.txt
  
  System.exit(0); //Makes sure the file closes because otherwise it will run in the background and create lag on the computer
} 