
class Hole extends GameObject {
  int d = grid_size;       // diameter of the player

  /** Player constructor **/
  Hole() {
    super( #000000 );
    ellipseMode( CORNER );
    pos = new PVector( 0, 0 ); // start bottom left corner
  }

  void draw() {
    fill(mycolor);
    stroke( mycolor );
    strokeWeight( 3 );
    ellipse( pos.x, pos.y, d, d );
  } // draw()
  
  

} // player class