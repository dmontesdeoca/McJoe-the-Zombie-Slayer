
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
   
   /** Game Object moves to the direction given **/
  void kick( int direction ) {
    switch( direction ) {
      case NORTH:
        pos.y -= grid_size;
        break;
      case SOUTH:
        pos.y += grid_size;
        break;
      case WEST:
        pos.x -= grid_size;
        break;
      case EAST:
        pos.x += grid_size;;
        break;
      } // switch
  } // kick()
   
   /** returns the game object's current (x,y) position **/
   PVector getPos() {
     return( pos );
   } // getPos()
     
   void setState( int state ) {
     this.state = state;
   }
   
   void reset( int x, int y ) {
    pos.x = x;
    pos.y = y;
  }
}