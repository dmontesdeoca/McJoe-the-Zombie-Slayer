static final int NORTH = 0;
static final int WEST  = 1;
static final int SOUTH = 2;
static final int EAST  = 3;
static final int grid_size = 20;

int frame = 0;

ArrayList<PVector> obstacles = new ArrayList<PVector>();

boolean running; // flag set to true while the game is running
Player mcJoe; // player (human)
Zombie zombie;
Map map;
Hole hole;

void setup() {
  frameRate( 30 );
  size( 500,500 );
  map = new Map();
  hole = new Hole();
  running = true;
  map.read();
  setWorld();

  
} // setup()

void draw() {
  if ( running ) {
    background(87);
    mcJoe.draw();
    zombie.draw(mcJoe.getLoc());  // send the location PVECTOR of mcJoe
    hole.draw();
    drawWorld();
  }
} // draw()

/** this function is called when the user releases a key.
    the arrow keys act like giving the player (mcJoe) a kick in the direction of the arrow.
     and when q or Q is pressed it will quit the game **/

void keyReleased() {
  if ( key == CODED ) {
    switch ( keyCode ) {
    case UP:
      mcJoe.kick( NORTH );
      break;
    case DOWN:
      mcJoe.kick( SOUTH );
      break;
    case LEFT:
      mcJoe.kick( WEST );
      break;
    case RIGHT:
      mcJoe.kick( EAST );
      break;
    }
  }
  else if (( key == 'q' ) || ( key == 'Q' )) {
    exit();
  }
} // keyReleased()

/** set obstacles **/
void setWorld(){  
  for ( int x = 0; x < map.getMaxX(); x++ ) {
    for ( int y = 0; y < map.getMaxY(); y++ ) {
      String value = map.getValue( x, y );
      switch ( value ) {
        case "1":
          obstacles.add( new PVector( x * grid_size, y * grid_size ) );
          break;
        case "2":
          mcJoe = new Player( map );
          mcJoe.reset( x * grid_size, y * grid_size );
          break;
        case "3":
          hole.reset( x * grid_size, y * grid_size );
          break;
        case "4":
          zombie = new Zombie( map );
          zombie.reset( x * grid_size, y * grid_size );
          break;
      }
    }
  }
  
} // setWorld()

void drawWorld(){
  stroke( #000000 );
  fill( #000000 );
  for(int i = 0; i < obstacles.size(); i++)                
    rect( obstacles.get( i ).x, obstacles.get( i ).y, mcJoe.d, mcJoe.d );
} // drawWorld()