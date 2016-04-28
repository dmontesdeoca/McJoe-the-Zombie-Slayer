
static final int DUNGEON = 0;
static final int BATTLE = 1;

class GameObject {
   PVector pos;      // current (x,y) position of object
   color mycolor;    // the color for drawing the object
   int state;
   
   GameObject( int c0 ) {
     mycolor = color( c0 ); 
     state = DUNGEON;
   }
   
   void setState( int state ) {
     this.state = state;
   }
   
   void reset( int x, int y ) {
    pos.x = x;
    pos.y = y;
  }
}