PrintWriter output;
int columnDim = 4;
int rowDim = 4;
boolean selected = false;
int mx1;
int mx2;
int my1;
int my2;
boolean kp = false;

Calendar calendar = Calendar.getInstance();

List<Bookshelf> bookshelfList = new ArrayList<Bookshelf>();

import java.util.*;
import java.io.*;

void setup(){
  size(2000, 1000);
  frameRate(60);
  String line = null;
  BufferedReader input = null;
   
  try{ //map input from file
    input = new BufferedReader(new FileReader("C:/Users/Adam/Documents/Processing/LibraryMap/MapDrawer/MapData.txt"));
    int place = 0;
    line = input.readLine();
    while(line != null){

      StringTokenizer bookData = new StringTokenizer(line);
      
      bookshelfList.add(new Bookshelf(Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), Integer.parseInt(bookData.nextToken()), bookData.nextToken(" ")));
      
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
  
  output = createWriter("MapData.txt");
}

void draw(){
  background(255);
  fill(0);
  text(columnDim + ", " + rowDim, 40, 40);
  
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).drawBookshelf();
    if(mouseX > bookshelfList.get(i).xPosition && mouseX < bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY > bookshelfList.get(i).yPosition && mouseY < bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX < bookshelfList.get(i).xPosition && mouseX > bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY > bookshelfList.get(i).yPosition && mouseY < bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX > bookshelfList.get(i).xPosition && mouseX < bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY < bookshelfList.get(i).yPosition && mouseY > bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX < bookshelfList.get(i).xPosition && mouseX > bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY < bookshelfList.get(i).yPosition && mouseY > bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight){
        text(bookshelfList.get(i).shelfName, 40, 80);
    }
  //  if(mouseX > bookshelfList.get(i).xPosition && mouseX < bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY > bookshelfList.get(i).yPosition && mouseY < bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX < bookshelfList.get(i).xPosition && mouseX > bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY > bookshelfList.get(i).yPosition && mouseY < bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX > bookshelfList.get(i).xPosition && mouseX < bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY < bookshelfList.get(i).yPosition && mouseY > bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX < bookshelfList.get(i).xPosition && mouseX > bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY < bookshelfList.get(i).yPosition && mouseY > bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight){
  //    text(bookshelfList.get(i).shelfName, 40, 80);
  //    bookshelfList.get(i).shelfName += "" + key;
  //    key = 0;
  //  }
  //  key = 0;
  }
  
  if(selected == true){
    fill(188, 236, 255, 50);
    rect(mx1, my1, -(mx1 - mouseX), -(my1 - mouseY)); 
  }
  
}


void keyPressed(){
    

  if(key == '<'){
    columnDim++; 
  }
  else if(key == '>'){
    columnDim--; 
  }
  else if(key == ','){
    rowDim ++;
  }
  else if(key == '.'){ 
    rowDim--;
  }
  else if(key == 32){
    selected = false; 
  }
  else if(key == ENTER){
    for(int i = 0; i < bookshelfList.size(); i++){
      output.println(bookshelfList.get(i).shelfColumns + " " + bookshelfList.get(i).shelfRows + " " + bookshelfList.get(i).xPosition + " " + bookshelfList.get(i).yPosition + " " + bookshelfList.get(i).xWidth + " " + bookshelfList.get(i).yHeight + " " + bookshelfList.get(i).shelfName);
      for(int x = 0; x < bookshelfList.get(i).shelfColumns; x++){
        for(int y = 0; y < bookshelfList.get(i).shelfRows; y++){
          output.println(bookshelfList.get(i).shelves[x][y].yearUpdated + " " + bookshelfList.get(i).shelves[x][y].dayUpdated);
        }
      }
     
    }
  }
  else if(key == ESC){
    for(int i = 0; i < bookshelfList.size(); i++){
      if(mouseX > bookshelfList.get(i).xPosition && mouseX < bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY > bookshelfList.get(i).yPosition && mouseY < bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX < bookshelfList.get(i).xPosition && mouseX > bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY > bookshelfList.get(i).yPosition && mouseY < bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX > bookshelfList.get(i).xPosition && mouseX < bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY < bookshelfList.get(i).yPosition && mouseY > bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX < bookshelfList.get(i).xPosition && mouseX > bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY < bookshelfList.get(i).yPosition && mouseY > bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight){
        bookshelfList.remove(i);
      }
    }
  }
  
  
}

void keyReleased(){
  //kp = false; 
  if(kp == false){
    kp = true;
    for(int i = 0; i < bookshelfList.size(); i++){
     if(mouseX > bookshelfList.get(i).xPosition && mouseX < bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY > bookshelfList.get(i).yPosition && mouseY < bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX < bookshelfList.get(i).xPosition && mouseX > bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY > bookshelfList.get(i).yPosition && mouseY < bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX > bookshelfList.get(i).xPosition && mouseX < bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY < bookshelfList.get(i).yPosition && mouseY > bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight || mouseX < bookshelfList.get(i).xPosition && mouseX > bookshelfList.get(i).xPosition + bookshelfList.get(i).xWidth && mouseY < bookshelfList.get(i).yPosition && mouseY > bookshelfList.get(i).yPosition + bookshelfList.get(i).yHeight){
        text(bookshelfList.get(i).shelfName, 40, 80);
       if(key == '/'){
          bookshelfList.get(i).shelfName = ""; 
        }
        else{
          
          bookshelfList.get(i).shelfName += key;
          key = 0;
          
        }
      }
      
      
    }
   kp = false; 
  }
}

void mousePressed(){
  if(selected == false){
    selected = true;
  
    mx1 = mouseX;
    my1 = mouseY;
  }
  else{
    selected = false;
    mx2 = mouseX;
    my2 = mouseY;
    bookshelfList.add(new Bookshelf(columnDim, rowDim, mx1, my1, mx2 - mx1, my2 - my1, "Shelf_Name"));
  }
}

void exit() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
} 