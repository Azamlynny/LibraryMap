/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class Output{//This is to organize the code which outputs to MapData.txt any changes that have happened to the data while the program was in use
  
  public Output(){ 
   
 }
  
  void outputFile(String location){//Location is here so that if wanted, MapData.txt can be printed to a normal location and then a backup folder.
     PrintWriter output = createWriter(location); 
  
    for(int i = 0; i < map.bookshelfList.size(); i++){
      //Writes the data of a Bookshelf object (int shelfColumns, int shelfRows, int xPosition, int yPosition, int xWidth, int yHeight, String bookshelfName)
      output.println(map.bookshelfList.get(i).shelfColumns + " " + map.bookshelfList.get(i).shelfRows + " " + map.bookshelfList.get(i).xPosition + " " + map.bookshelfList.get(i).yPosition + " " + map.bookshelfList.get(i).xWidth + " " + map.bookshelfList.get(i).yHeight + " " + map.bookshelfList.get(i).bookshelfName);
      
      for(int x = 0; x < map.bookshelfList.get(i).shelfColumns; x++){
        for(int y = 0; y < map.bookshelfList.get(i).shelfRows; y++){
          //Writes the data of a Shelf object (int yearUpdated, int dayUpdated, boolean hasBooks)
          output.println(map.bookshelfList.get(i).shelves[x][y].yearUpdated + " " + map.bookshelfList.get(i).shelves[x][y].dayUpdated + " " + map.bookshelfList.get(i).shelves[x][y].hasBooks);
       }
     }  
   }
   
   output.flush(); // Writes the remaining data to the file
   output.close(); // Finishes the file
  }
  
}