/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class Information{//This is to organize text which tells Instructions or Information
  String currentRangeBox; //Stores which bookshelf range is displaying the RangeBox so that it may be drawn over Bookshelf objects in the corner of the screen
  
  void drawOrientationInfo(){ //Draws "Landmarks" in the Library to orient the user with their surroundings and the map so they can find the bookshelf they sorted easily.
    textSize(50 * map.widthRatio); 
    text("Tables Area", 350 * map.widthRatio, 700 * map.heightRatio);
    textSize(30 * map.widthRatio);
    text("Volunteer Desk", 1750 * map.widthRatio, 700 * map.heightRatio);
    text("Children's Area", 1750 * map.widthRatio, 300 * map.heightRatio);
  }
 
  void drawInstructions(boolean shelvesDrawn){
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
  
  void drawRangeBox(Bookshelf bookshelf){ // Draws the information about the range of books that are at the bookshelf
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