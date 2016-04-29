
class Zombie extends GameObject {
  
  int d = grid_size;       // diameter of the Zombie
  int frame = 0;
  
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

  void draw() {
    fill(mycolor);
    stroke( mycolor );
    strokeWeight( 3 );
    ellipse( pos.x, pos.y, d, d );
    if ( frame % 30 == 0 ) {
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