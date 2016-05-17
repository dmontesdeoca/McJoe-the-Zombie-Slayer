boolean hole_access = false;

//Hole class is a GameObject used for moving down the dungeon
class Hole extends GameObject {
  int d = grid_size;       // diameter of the player

  //Calls super constructor
  Hole() {
    super();
    ellipseMode( CORNER );
  }

  //Draws hole when in DUNGEON state
  void draw() {
    if ( state == DUNGEON ) {
      fill( #000000 );
      stroke(  #000000  );
      strokeWeight( 3 );
      ellipse( pos.x, pos.y, d, d );
    }
  } 
  
  

} // Hole class