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

  
  fill(0);
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).drawBookshelf(); 
  }
  for(int i = 0; i < bookshelfList.size(); i++){
    if(bookshelfList.get(i).drawingShelves == true){
       bookshelfList.get(i).drawShelves();
    } 
  }
}

void keyPressed(){
  if(key == ESC){
    for(int i = 0; i < bookshelfList.size(); i++){
      bookshelfList.get(i).drawingShelves = false; 
    }
  }
}

void mousePressed(){
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).checkHitbox(); 
  }
}

void exit() { // writes any changes to MapData.txt
  PrintWriter output = createWriter("MapData.txt");
  for(int i = 0; i < bookshelfList.size(); i++){
    output.println(bookshelfList.get(i).shelfColumns + " " + bookshelfList.get(i).shelfRows + " " + bookshelfList.get(i).xPosition + " " + bookshelfList.get(i).yPosition + " " + bookshelfList.get(i).xWidth + " " + bookshelfList.get(i).yHeight + " " + bookshelfList.get(i).shelfName);
    for(int x = 0; x < bookshelfList.get(i).shelfColumns; x++){
      for(int y = 0; y < bookshelfList.get(i).shelfRows; y++){
        output.println(bookshelfList.get(i).shelves[x][y].yearUpdated + " " + bookshelfList.get(i).shelves[x][y].dayUpdated);
      }
    }  
  }
} 