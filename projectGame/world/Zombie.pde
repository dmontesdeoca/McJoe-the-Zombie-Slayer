class Zombie extends GameCharacter {
  String[][] mapArr;
  int frame = 0;
  String move;
  boolean inSight = false;
  PVector mcJoeLocation; // mcJoes current location
  
  Zombie( Map map ) {
    super( map, "6", ZOMBIE_F );
    mapArr = new String[map.getMaxX()][map.getMaxY()];
    arrayCopy( map.getMapArray(), mapArr );
    ellipseMode( CORNER );
    pos = new PVector( 0, 0 ); // start bottom left corner
  }
  
  void draw() {
     super.draw();
     if ( frame % 10 == 0 ) {
         if(inSight){
             chase();
         }
         else{
              makeRandomMove();         
         }
     }
     frame++;
  } // draw()
  
  void makeRandomMove() { // call make move in the world
    int direction = ( int ) random( 0, 4 );
    
    super.kick( direction );
  }


  void checkSight(PVector location){
    mcJoeLocation = new PVector(location.x, location.y);
     if((mcJoeLocation.x > pos.x - (grid_size * 5) && mcJoeLocation.x < pos.x + (grid_size * 5))  && 
        (mcJoeLocation.y > pos.y - (grid_size * 5) && mcJoeLocation.y < pos.y + (grid_size * 5))){
       inSight = true;
     }
     else
        inSight = false;
        
  }
  
  
 // if mcJoe is in the zombies sight, the zombie will chase mcJoe
  void chase(){
    // here move accordingly to mcJoes current location
    if(mcJoeLocation.x < pos.x){
      super.kick( WEST );
    }
    if(mcJoeLocation.x > pos.x){
      super.kick( EAST );
    }
    if(mcJoeLocation.y < pos.y){
      super.kick( NORTH );
    }
    if(mcJoeLocation.y > pos.y){
      super.kick( SOUTH );
    }
    
  }
  
  // FIX MAKE A FUNCTION SO ZOMBIES CAN KEEP AWAY FROM EACH OTHER. MOVE IN OPPOSITE DIRECTIONS  ------- if we decide on having more than two zombies on the screen
  void avoid(){
  
  }
}