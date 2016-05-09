class Map{
 // int mapArr[][];
  
BufferedReader reader;
String line;
int maxX, maxY;
String[][] mapArr;
/** map constructor where we will create a reader to the file**/
  Map() {
    // Open the file from the createWriter() example
     reader = createReader("../Maps/map1.stdin");
  }
 
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
       System.out.println(mapArr[i][j]);
     }
   }
   
} // read()

int getMaxX(){ return maxX;}
int getMaxY(){ return maxY;}
String getValue(int x, int y){ return mapArr[y][x];}
String[][] getMapArray() { return mapArr; }
} // end of Map class