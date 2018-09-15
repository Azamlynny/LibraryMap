/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class KeyTracker{ //Handles key related functions
  
  void checkKeyPress(){
    if(key == 'q'){
    for(int i = 0; i < map.bookshelfList.size(); i++){
        map.bookshelfList.get(i).drawingShelves = false; 
      }
    }
  }
  
  void resetKey(){
    key = 0; // Gives the key value a value of Null so that key is not equal to a character when not being pressed. 
  }
  
}