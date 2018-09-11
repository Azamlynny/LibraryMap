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
    else{
      move(); //WASD
    }
  }
  
  void resetKey(){
    key = 0; // Gives the key value a value of Null so that key is not equal to a character when not being pressed. 
  }
  
  void move(){
    if(key == 'w' || key == 'W'){
      map.yShift += 10;
    }
    else if(key == 's' || key == 'S'){
      map.yShift -= 10;
    }
    else if(key == 'a' || key == 'D'){
      map.xShift += 10;
    }
    else if(key == 'd' || key == 'D'){
      map.xShift -= 10;
    }
  }
  
}