static final int NORTH = 0;
static final int WEST  = 1;
static final int SOUTH = 2;
static final int EAST  = 3;

int numObstacle = 10;
PVector[] obstacle = new PVector[numObstacle];

boolean running; // flag set to true while the game is running
Player mcJoe; // player (human)

void setup() {
  size( 500,500 );
  mcJoe = new Player( 500, 500, #000099 ); // mcJoe Blue
  running = true;
  setWorld();

  
} // setup()

void draw() {
  if ( running ) {
    background(87);
    mcJoe.draw();
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
  for(int x = 0; x < numObstacle; x++)
  obstacle[x] = new PVector( ((int)random(0,500 - mcJoe.d)), ((int)random(0,500 - mcJoe.d)) );
} // setWorld()

void drawWorld(){
  stroke( #000000 );
  fill( #000000 );
  for(int i = 0; i < numObstacle; i++)                
    rect( obstacle[i].x, obstacle[i].y, mcJoe.d, mcJoe.d );
} // drawWorld()