static final int NORTH = 0;
static final int WEST  = 1;
static final int SOUTH = 2;
static final int EAST  = 3;
static final int grid_size = 20;
PImage screen;

int frame = 0;

//ArrayList<PVector> obstacles = new ArrayList<PVector>();

boolean running; // flag set to true while the game is running
Player mcJoe; // player (human)
Zombie zombie;
Map map;
Hole hole;
int state;

void setup() {
  frameRate( 30 );
  size( 500,500 );
  map = new Map();
  hole = new Hole();
  running = true;
  map.read();
  
  mcJoe = new Player( map );
  zombie = new Zombie( map );
  setWorld();

  
} // setup()

void draw() {
  if ( running ) {
    if ( state == DUNGEON ) {
      checkCollision();
      drawWorld();
    }
    else {
      background(87);
    }
    mcJoe.draw();
    zombie.draw();
    hole.draw();
    frame++;
  }
} // draw()

/** this function is called when the user releases a key.
    the arrow keys act like giving the player (mcJoe) a kick in the direction of the arrow.
     and when q or Q is pressed it will quit the game **/

void keyReleased() {
  if ( state == DUNGEON ) {
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
  }
} // keyReleased()

void keyPressed() {
  if ( state == BATTLE ) {
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
  }
}

/** set obstacles **/
void setWorld(){ 
  state = DUNGEON;
  screen = loadImage( "../Graphics/map/mapOne.jpg" );
  for ( int x = 0; x < map.getMaxX(); x++ ) {
    for ( int y = 0; y < map.getMaxY(); y++ ) {
      String value = map.getValue( x, y );
      switch ( value ) {
        /*
        case "1":
          obstacles.add( new PVector( x * grid_size, y * grid_size ) );
          break;
          */
        case "2":
          mcJoe.reset( x * grid_size, y * grid_size );
          break;
        case "3":
          hole.reset( x * grid_size, y * grid_size );
          break;
        case "6":
          zombie.reset( x * grid_size, y * grid_size );
          break;
      }
    }
  }
  
} // setWorld()

void setBattle() {
  state = BATTLE;
  mcJoe.setState( BATTLE );
  zombie.setState( BATTLE );
  hole.setState( BATTLE );
  
  mcJoe.reset( 125, 400 );
  zombie.reset( 375, 400 );
}

void drawWorld(){
  /*stroke( #000000 );
  fill( #000000 );
  for(int i = 0; i < obstacles.size(); i++)                
    rect( obstacles.get( i ).x, obstacles.get( i ).y, mcJoe.d, mcJoe.d );
  */  
    imageMode(CORNERS);
    image(screen, 0, 0, 500, 500); 
} // drawWorld()

void checkCollision() {
  
  for ( int direction = 0; direction < 4; direction++ ) {
    switch( direction ) {
      case NORTH:
        if ( map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y - grid_size ) / grid_size ) ).equals( "6" ) ) {
          setBattle();
          return;
        }
        break;
      case SOUTH:
        if ( map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y + grid_size ) / grid_size ) ).equals( "6" ) ) {
          setBattle();
          return;
        }
        break;
      case WEST:
        if ( map.getValue( ( int )( ( mcJoe.getPos().x - grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "6" ) ) {
          setBattle();
          return;
        }
        break;
      case EAST:
        if ( map.getValue( ( int )( ( mcJoe.getPos().x + grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "6" ) ) {
          setBattle();
          return;
        }
        break;
      } // switch 
  }
  
}