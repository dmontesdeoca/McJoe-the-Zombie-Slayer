int CURRENTSTATE = 0;
class Map{
  
BufferedReader reader;
String line;
int maxX, maxY;
String[][] mapArr;
/** map constructor where we will create a reader to the file**/
  Map() {
    // Open the file to the createWriter() according to CURRENTSTATE
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
  } // Map()

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
   // sets the string 2d array for map
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
      // plug in values from the file
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