class Output{//This is to organize the code which outputs to MapData.txt any changes that have happened to the data while the program was in use
  
  public Output(){
    PrintWriter output = createWriter("MapData.txt");
  
    for(int i = 0; i < bookshelfList.size(); i++){
      //Writes the data of a Bookshelf object (int shelfColumns, int shelfRows, int xPosition, int yPosition, int xWidth, int yHeight, String bookshelfName)
      output.println(bookshelfList.get(i).shelfColumns + " " + bookshelfList.get(i).shelfRows + " " + bookshelfList.get(i).xPosition + " " + bookshelfList.get(i).yPosition + " " + bookshelfList.get(i).xWidth + " " + bookshelfList.get(i).yHeight + " " + bookshelfList.get(i).bookshelfName);
      
      for(int x = 0; x < bookshelfList.get(i).shelfColumns; x++){
        for(int y = 0; y < bookshelfList.get(i).shelfRows; y++){
          //Writes the data of a Shelf object (int yearUpdated, int dayUpdated, boolean hasBooks)
          output.println(bookshelfList.get(i).shelves[x][y].yearUpdated + " " + bookshelfList.get(i).shelves[x][y].dayUpdated + " " + bookshelfList.get(i).shelves[x][y].hasBooks);
       }
     }  
   }
   
   output.flush(); // Writes the remaining data to the file
   output.close(); // Finishes the file
 }
  
}