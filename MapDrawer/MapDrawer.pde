
Bookshelf obj = new Bookshelf(4, 4, 500, 500, 50, 50);

import java.util.*;

void setup(){
  size(2000, 1000);
}

void draw(){
  background(255);
  obj.drawBookshelf();
  obj.drawShelves();
}