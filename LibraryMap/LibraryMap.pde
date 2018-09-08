import java.util.*;
import java.io.*;

List<Bookshelf> bookshelfList = new ArrayList<Bookshelf>();

void setup(){
  size(2000, 1000);
  
  String line = null;
  BufferedReader input = null;
   
  try{ //map input from file
    input = new BufferedReader(new FileReader("C:/Users/Adam/Documents/Processing/LibraryMap/MapData.txt"));
    int place = 0;
    line = input.readLine();
    while(line != null){
    //for(int i = 0; i < 1; i++){

      StringTokenizer bookData = new StringTokenizer(line);
      
      bookshelfList.add(new Bookshelf(Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), bookData.nextToken()));
      
      
      //System.out.println(shelfData.nextToken() + " " + shelfData.nextToken());
      for(int x = 0; x < bookshelfList.get(place).shelfColumns; x++){
        for(int y = 0; y < bookshelfList.get(place).shelfRows; y++){
          //System.out.println(bookshelfList.get(place).shelves[0][0].yearUpdated);
          StringTokenizer shelfData = new StringTokenizer(input.readLine());
          bookshelfList.get(place).shelves[x][y] = new Shelf(Integer.parseInt(shelfData.nextToken()), Integer.parseInt(shelfData.nextToken()));
        }
      }
      place++;
      line = input.readLine();
    }
      
  }
  catch (IOException ioe){
    ioe.printStackTrace();
  } 
  
  //try {
  //  input.close();
  //} 
  //catch (IOException ioe) 
  //{
  //  System.out.println("Error in closing the BufferedReader");
  //}
}

void draw(){
  background(255);
  System.out.println(bookshelfList.size());
  
  fill(0);
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).drawBookshelf(); 
  }
}

void keyPressed(){
  
}

void mousePressed(){
  
}

void exit() {
  
} 