PrintWriter output;
int columnDim = 4;
int rowDim = 4;
boolean selected = false;
int mx1;
int mx2;
int my1;
int my2;

List<Bookshelf> bookshelfList = new ArrayList<Bookshelf>();

import java.util.*;

void setup(){
  size(2000, 1000);
  output = createWriter("MapData.in");
}

void draw(){
  background(255);
  fill(0);
  text(columnDim + ", " + rowDim, 40, 40);
  
  for(int i = 0; i < bookshelfList.size(); i++){
    bookshelfList.get(i).drawBookshelf(); 
  }
}

void keyPressed(){
  if(key == 'p'){
    columnDim++; 
  }
  else if(key == 'o'){
    columnDim--; 
  }
  else if(key == 'l'){
    rowDim ++;
  }
  else if(key == 'k'){ 
    rowDim--;
  }
  else if(key == 32){
    selected = false; 
  }
  else if(key == 's'){
    for(int i = 0; i < bookshelfList.size(); i++){
      output.println(bookshelfList.get(i).shelfColumns + " " + bookshelfList.get(i).shelfRows + " " + bookshelfList.get(i).xPosition + " " + bookshelfList.get(i).yPosition + " " + bookshelfList.get(i).xWidth + " " + bookshelfList.get(i).yHeight + " " + bookshelfList.get(i).shelfName);
      for(int x = 0; x < bookshelfList.get(i).shelfColumns; x++){
        for(int y = 0; y < bookshelfList.get(i).shelfRows; y++){
          output.println(bookshelfList.get(i).shelves[x][y].yearUpdated + " " + bookshelfList.get(i).shelves[x][y].dayUpdated);
        }
      }
     
    }
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
    bookshelfList.add(new Bookshelf(columnDim, rowDim, mx1, my1, mx2 - mx1, my2 - my1));
  }
}

void exit() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
} 