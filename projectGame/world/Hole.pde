boolean hole_access = false;

class Hole extends GameObject {
  int d = grid_size;       // diameter of the player

  Hole() {
    super();
    ellipseMode( CORNER );
    pos = new PVector( 0, 0 ); // start bottom left corner
  }

  void draw() {
    if ( state == DUNGEON ) {
      fill( #000000 );
      stroke(  #000000  );
      strokeWeight( 3 );
      ellipse( pos.x, pos.y, d, d );
    }
  } // draw()
  
  

} // Hole class