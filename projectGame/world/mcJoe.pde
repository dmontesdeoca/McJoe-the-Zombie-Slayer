class Player extends GameCharacter {

  int d = grid_size;       // diameter of the player (McJoe)

  /** Player constructor **/
  Player( Map map ) {
    super( #000099, map );
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
  
} //Player class