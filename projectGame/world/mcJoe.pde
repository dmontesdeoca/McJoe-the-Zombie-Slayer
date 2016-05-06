class Player extends GameObject {

  int d = grid_size;       // diameter of the player (McJoe)
  Map map;

  /** Player constructor **/
  Player( Map map ) {
    super( #000099 );
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
  } // draw()
 /*** returns the current location of McJoe ***/
 PVector getLoc(){ return pos; }
 
  void kick( int direction ) {
    switch( direction ) {
      case NORTH:
        if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y - grid_size ) / grid_size ) ).equals( "0" ) ) {
          super.kick( direction );
        }
        break;
      case SOUTH:
        if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y + grid_size ) / grid_size ) ).equals( "0" ) ) {
          super.kick( direction );
        }
        break;
      case WEST:
        if ( map.getValue( ( int )( ( pos.x - grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "0" ) ) {
          super.kick( direction );
        }
        break;
      case EAST:
        if ( map.getValue( ( int )( ( pos.x + grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "0" ) ) {
          super.kick( direction );
        }
        break;
    } // switch
  }

} // player class