static final int DUNGEON = 0;
static final int BATTLE = 1;
static final int MAIN = 2;
static final int END = 3;
static final int GAMEOVER = 4;

//Base class for all game objects and characters
class GameObject {
   protected PVector pos;      // current (x,y) position of object
   protected int state;        // current state 
   
   //Initializes pos and state to default values
   GameObject() { 
     state = DUNGEON;

     pos = new PVector( 0, 0 );
   }
   
   //returns the game object's current (x,y) position 
   PVector getPos() {
     return( pos );
   }
     
   //Set state
   void setState( int state ) {
     this.state = state;
   }
   
   //Reset position of GameObject object
   void reset( int x, int y ) {
    pos.x = x;
    pos.y = y;
  }
} //GameObject class