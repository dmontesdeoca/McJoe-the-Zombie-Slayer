class Player extends GameObject {

  int d = grid_size;       // diameter of the player

  /** Player constructor **/
  Player() {
    super( #000099 );
    ellipseMode( CORNER );
    pos = new PVector( 0, 0 ); // start bottom left corner
  }

  /** returns the player's current (x,y) position **/
  PVector getPos() {
    return( pos );
  } // getPos()

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

  /** Player moves to the direction the key was pressed **/
  void kick( int direction ) {
    switch( direction ) {
    case NORTH:
      pos.y -= 20;
      break;
    case SOUTH:
      pos.y += 20;
      break;
    case WEST:
      pos.x -= 20;
      break;
    case EAST:
      pos.x += 20;
      break;
    } // switch
  } // kick()

} // player class