/* Created by Adam Zamlynny
   azamlynny@hotmail.com
   github.com/Azamlynny
*/
class Input{//This is to organize the code which inputs MapData.txt
  
  public Input(){
    String line = null;
    BufferedReader input = null;
     
    try{ 
      input = new BufferedReader(new FileReader("C:/Users/Adam/Documents/Processing/LibraryMap/LibraryMap/MapData.txt")); // This is for my computer to access MapData.txt
      //C:/Users/Public05/Documents/Processing/Library_Map/application.windows64/MapData.txt = directory for the library's computer
      //input = new BufferedReader(new FileReader("MapData.txt")); // This is so the library computer can access MapData.txt

      line = input.readLine();
      
      while(line != null){
  
        StringTokenizer bookData = new StringTokenizer(line);
        
        //Creates Bookshelf objects
        map.bookshelfList.add(new Bookshelf(Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), bookData.nextToken(" ")));
        
        for(int x = 0; x < map.bookshelfList.get(map.bookshelfList.size() - 1).shelfColumns; x++){
          for(int y = 0; y < map.bookshelfList.get(map.bookshelfList.size() - 1).shelfRows; y++){
            StringTokenizer shelfData = new StringTokenizer(input.readLine());
            
            //Creates Shelf objects
            map.bookshelfList.get(map.bookshelfList.size() - 1).shelves[x][y] = new Shelf(Integer.parseInt(shelfData.nextToken()), Integer.parseInt(shelfData.nextToken()), Boolean.parseBoolean(shelfData.nextToken()));
          }
        }
        
        line = input.readLine();
      }
        
    }
    catch (IOException ioe){
      ioe.printStackTrace();
    } 
  }
  
}