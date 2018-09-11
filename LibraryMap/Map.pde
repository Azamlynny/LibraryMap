/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class Map{
  
  List<Bookshelf> bookshelfList = new ArrayList<Bookshelf>();
  
  void drawMap(){
    this.drawInformation();
  
    this.drawObjects();
    
    this.drawRangeBox();
     
  }
  
  void drawObjects(){
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
  
  void drawRangeBox(){ //RangeBox is the box that shows the range of books the shelf contains.
    for(int i = 0; i < map.bookshelfList.size(); i++){                    //Draws RangeBox
      if(map.bookshelfList.get(i).bookshelfName == info.currentRangeBox){ //Not in above forloop so that the RangeBox appears above the Bookshelves
        info.drawRangeBox(map.bookshelfList.get(i)); 
      } 
    }
  }
  
  void drawInformation(){
    info.drawOrientationInfo();
    info.drawInstructions(false); 
  }
  
}