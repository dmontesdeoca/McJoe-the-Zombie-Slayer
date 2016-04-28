class Player {

  PVector pos;      // current (x,y) position of player
  int max_x, max_y; // maximum x and y values for the player
  color mycolor;    // the color for drawing the player
  int d = 30;       // diameter of the player


  /** Player constructor **/
  Player( int x0, int y0, int c0 ) {
    max_x = x0;
    max_y = y0;
    mycolor = color( c0 );
    ellipseMode( CORNER );
    pos = new PVector( 0.0 + 5, max_y-d-5 ); // start bottom left corner
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
      pos.y -= d/3;
      break;
    case SOUTH:
      pos.y += d/3;
      break;
    case WEST:
      pos.x -= d/3;
      break;
    case EAST:
      pos.x += d/3;
      break;
    } // switch
  } // kick()

} // player class