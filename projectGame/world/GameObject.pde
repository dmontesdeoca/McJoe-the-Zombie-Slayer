static final int DUNGEON = 0;
static final int BATTLE = 1;
static final int MAIN = 2;

class GameObject {
   protected PVector pos;      // current (x,y) position of object
   protected int state;
   
   GameObject() { 
     state = DUNGEON;
     pos = new PVector(0,0);
   }
   
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