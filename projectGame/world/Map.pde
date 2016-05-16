int CURRENTSTATE = 2;


class Map{
 // int mapArr[][];
  
BufferedReader reader;
String line;
int maxX, maxY;
String[][] mapArr;
/** map constructor where we will create a reader to the file**/
  Map() {
    // Open the file from the createWriter() example
    if(CURRENTSTATE == 0){
         reader = createReader("../Maps/map1.stdin");
    }
    else if(CURRENTSTATE == 3){
         reader = createReader("../Maps/map2.stdin");
    }
          else if (CURRENTSTATE == 2){
               reader = createReader("../Maps/map3.stdin");
          }
               else if(CURRENTSTATE == 1){
                   reader = createReader("../Maps/map4.stdin");
                }
                    else if(CURRENTSTATE == 4){
                         reader = createReader("../Maps/map5.stdin");
                    }
  }

// reads the map text file into an array
void read() {
  int x = 0, y = 0; 
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
    String[] pieces = split(line, " ");
    System.out.println(pieces[0] + pieces[1]);
    maxX = int(pieces[0]);
    maxY = int(pieces[1]);

    System.out.println(x + " " + y);

   mapArr =  new String[maxX][maxY];
   for(int i = 0; i < maxY; i++){
     try {
       line = reader.readLine();
     } 
     catch (IOException e) {
        e.printStackTrace();
        line = null;
     }
     String[] piece = split(line, " ");

     for(int j = 0; j < maxX; j++){
       mapArr[i][j] = piece[j];
     }
   }
   
} // read()

// returns the max size of columns
int getMaxX() { return maxX; }

// returns the max size of rows
int getMaxY() { return maxY; }

// returns the value of the element array[y][x]
String getValue( int x, int y ) { return mapArr[y][x]; }

// sets value to element array array[y][x]
void setValue( int x, int y, String val ) { mapArr[y][x] = val; }

// returns map
String[][] getMapArray() { return mapArr; }

} // end of Map class