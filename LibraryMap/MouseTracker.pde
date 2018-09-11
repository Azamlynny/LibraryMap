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
      if(mouseX > (500 * widthRatio) && mouseX < (1500 * heightRatio)){
        map.bookshelfList.get(i).shelves[(int) ((map.bookshelfList.get(i).shelfColumns * (mouseX - (500 * widthRatio))) / (1000 * widthRatio)) ][(int) ((map.bookshelfList.get(i).shelfRows * (mouseY)) / (1000 * heightRatio))].checkHitbox(i);
      }
    } 
  }
  
}