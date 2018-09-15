/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class MouseTracker{ //handles mouse related functions
  
  void checkMousePress(){
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