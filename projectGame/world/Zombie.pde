
class Zombie extends GameObject {
  
  int d = grid_size;       // diameter of the Zombie
  int frame = 0;
  String move;
  Map map; 
  
  Zombie( Map map ) {
    super( #009900 );
    ellipseMode( CORNER );
    this.map = map;
    pos = new PVector( 0, 0 ); // start bottom left corner
  }
  
  /** returns the diameter of the player **/
  int getDiameter() {
    return( d );
  } // getDiameter()

  void draw(PVector player) {
    fill(mycolor);
    stroke( mycolor );
    strokeWeight( 3 );
    ellipse( pos.x, pos.y, d, d );
    
    // FIX..CHECKSIGHT FUNCTION....if mcjoe is in sight chase else make a random move
    if(checkSight(player)){
      // FIX...CHASE FUNCTION
      if( frame % 15 == 0){
        chase(move);
      }
    }
    else if ( frame % 15 == 0 ) { // i changed 30 into 15 to make it a bit faster
      makeRandomMove();
    }
    frame++;
  } // draw()
  
  void makeRandomMove() {
    int direction = ( int ) random( 0, 4 );
    
    switch( direction ) {
      case NORTH:
        if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y - grid_size ) / grid_size ) ).equals( "0" ) ) {
          kick( direction );
        }
        break;
      case SOUTH:
        if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y + grid_size ) / grid_size ) ).equals( "0" ) ) {
          kick( direction );
        }
        break;
      case WEST:
        if ( map.getValue( ( int )( ( pos.x - grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "0" ) ) {
          kick( direction );
        }
        break;
      case EAST:
        if ( map.getValue( ( int )( ( pos.x + grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "0" ) ) {
          kick( direction );
        }
        break;
    } // switch
  }
}
// FIX CHECK TO SEE IF THE ZOMBIE CAN SEE THE PLAYER KEEPING IN MIND OF THE WALLS
boolean checkSight(PVector location){
//FIX cant get pos. this.pos isnt working check later
  return false;
}

// FIX MAKE A FUNCTION TO CHASE THE PLAYER WITHOUT GOING THROUGH WALLS
void chase(String move){

}