class Information{//This is to organize text which tells Instructions or Information
  String currentRangeBox; //Stores which bookshelf range is displaying the RangeBox so that it may be drawn over Bookshelf objects in the corner of the screen
  
  void drawOrientationInfo(){ //Draws "Landmarks" in the Library to orient the user with their surroundings and the map so they can find the bookshelf they sorted easily.
    textSize(50 * widthRatio); 
    text("Tables Area", 350 * widthRatio, 700 * heightRatio);
    textSize(30 * widthRatio);
    text("Volunteer Desk", 1750 * widthRatio, 700 * heightRatio);
    text("Children's Area", 1750 * widthRatio, 300 * heightRatio);
  }
 
  void drawInstructions(boolean shelvesDrawn){
    textAlign(LEFT);
    if(shelvesDrawn == true){
      textSize(40 * widthRatio);
      text("Instructions:", 50 * widthRatio, 100 * heightRatio);
      textSize(23 * widthRatio);
      text("Hold 'Space' down and click on a", 50 * widthRatio, 150 * heightRatio);        // continued text is 30 pixels apart
      text("shelf to reset the day last sorted.", 50 * widthRatio, 180 * heightRatio);
      text("Hold 'Enter' down and click on a shelf", 50 * widthRatio, 230 * heightRatio);  // new text paragraph is 50 pixels apart
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
    textAlign(CENTER); // The numbers on Bookshelves and Shelves are centered
  }
  
  void drawRangeBox(Bookshelf bookshelf){ // Draws the information about the range of books that are at the bookshelf
    if(bookshelf.drawingShelves == false){ //Draws a box so that the text can sit on top and be easily read
      fill(255, 242, 163);
      rect(10 * widthRatio, 10 * heightRatio, 250 * widthRatio, 30 * heightRatio);
    }
    fill(0);
    textSize(20 * widthRatio);
    text(bookshelf.bookshelfName, 130 * widthRatio, 30 * heightRatio);
    
    info.currentRangeBox = ""; //This is so the RangeBox does not remain after the mouse is no longer hovering over it.
  }
}