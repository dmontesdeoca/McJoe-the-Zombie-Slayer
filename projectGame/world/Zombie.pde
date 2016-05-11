class Zombie extends GameCharacter {
  
  //int d = grid_size;       // diameter of the Zombie
  String[][] mapArr;
  int frame = 0;
  String move;
  
  Zombie( Map map ) {
    super( map, "6", ZOMBIE_F );
    mapArr = new String[map.getMaxX()][map.getMaxY()];
    arrayCopy( map.getMapArray(), mapArr );
    ellipseMode( CORNER );
    pos = new PVector( 0, 0 ); // start bottom left corner
  }
  
  void draw() {
   super.draw();
   
   if ( frame % 10 == 0 ) { // i changed 30 into 15 to make it a bit faster
      makeRandomMove();
   }
   frame++;
  } // draw()
  
  void makeRandomMove() { // call make move in the world
    int direction = ( int ) random( 0, 4 );
    
    super.kick( direction );
  }

  // FIX CHECK TO SEE IF THE ZOMBIE CAN SEE THE PLAYER KEEPING IN MIND OF THE WALLS
  boolean checkSight(PVector location){
  //FIX cant get pos. this.pos isnt working check later
    return false;
  }
  
  // FIX MAKE A FUNCTION TO CHASE THE PLAYER WITHOUT GOING THROUGH WALLS
  void chase(String move){
  
  }
  
  // FIX MAKE A FUNCTION SO ZOMBIES CAN KEEP AWAY FROM EACH OTHER. MOVE IN OPPOSITE DIRECTIONS 
  void avoid(){
  
  }
}