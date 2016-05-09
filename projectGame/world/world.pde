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

//for the main screen buttons *******************************************************************************************************************
int swordX, swordY; 
int bowX, bowY; 
int gunX, gunY;     
int batX, batY;  // position of the buttons
int buttonSize = 100;     // diameter of button
color swordColor, bowColor, gunColor, batColor;
color /*swordHighlight, bowHighlight,*/ highLight;
boolean sword = false;
boolean bow = false;
boolean gun = false;
boolean bat = false;
boolean weaponPicked = false;



void setup() {
  frameRate( 30 );
  size( 500,500 );
  state = MAIN;
  running = true;
 /* frameRate( 30 );
  size( 500,500 );
  map = new Map();
  hole = new Hole();
  running = true;
  map.read();
  
  mcJoe = new Player( map );
  zombie = new Zombie( map );*/ // moved to setWorld
  setWorld(); // here set the main page, create the buttons
  
} // setup()

void draw() {
  if ( running ) {
    
    if(state == MAIN){
       updateMouse(mouseX, mouseY);
      if(weaponPicked){ // if a weapon was clicked set state to dungeon and set world accordingly
        state = DUNGEON;
        setWorld(); // set world as dungeon
      }
    }
    else if ( state == DUNGEON ) {
      checkCollision();
      drawWorld();
      mcJoe.draw();
      zombie.draw();
      hole.draw();
      frame++;
    }
    else {
       // background(10); //battle screen will go here!
        screen = loadImage( "../Graphics/battle/battle.png" );
        imageMode(CORNERS);
        image(screen, 0, 0, 500, 500);
        mcJoe.draw();
        zombie.draw();
        hole.draw();
        frame++;
    }
  /*  mcJoe.draw();
    zombie.draw();
    hole.draw();
    frame++;*/ // i removed to create the main page
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

/** set obstacles **/ // call when the image is clicked
void setWorld(){ 
  if(state == MAIN){
         screen = loadImage( "../Graphics/mainScreen.png" );
         imageMode(CORNERS);
         image(screen, 0, 0, 500, 500);
         createButtons();
  }
  if(state == DUNGEON){
  map = new Map();
  hole = new Hole();
  running = true;
  map.read();
  
  mcJoe = new Player( map );
  zombie = new Zombie( map );
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

// create the buttons for the weapons
void createButtons(){
  highLight = color(100);  // change to red maybe?
  swordColor = color(255); // replace to image
  bowColor = color(255); // replace to image
  gunColor = color(255); // replace to image
  batColor = color(255); // replace to image

  // set coor for the buttons
  bowX = 20;
  bowY = width - buttonSize - 60;
  swordX = 140;
  swordY = width - buttonSize - 60;
  gunX = 260;
  gunY = width - buttonSize - 60;
  batX = 400 - 20;
  batY = width - buttonSize - 60;
}

void updateMouse(int x, int y) {
  buttonHighLight(); // highlights if the mouse is over button
  if ( overButton(swordX, swordY, buttonSize, buttonSize) ) { // pass sword coor
        sword = true;
        bow = false;
        gun = false;
        bat = false;
  } else if ( overButton(bowX, bowY, buttonSize, buttonSize) ) { // pass bow coor
        sword = false;
        bow = true;
        gun = false;
        bat = false;
  }
  else if ( overButton(gunX, gunY, buttonSize, buttonSize) ) { // pass gun coor
        sword = false;
        bow = false;
        gun = true;
        bat = false;
  } else if ( overButton(batX, batY, buttonSize, buttonSize) ) { // pass bat coor
        sword = false;
        bow = false;
        gun = false;
        bat = true;
  } else {
      sword = bow = gun = bat = false;
  }
}

//pass coordinates of buttons
boolean overButton(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else { return false; }
}

// depending where the mouse was pressed the weapon would be choosen
// weapon is picked so make it true
void mousePressed() {
  if (sword) {
    // set mcJoe accordingly
    weaponPicked = true;
  }
  if (bow) {
    // set mcJoe accordingly
        weaponPicked = true;

  }
  if (gun) {
    // set mcJoe accordingly
        weaponPicked = true;

  }
  if (bat) {
    // set mcJoe accordingly
        weaponPicked = true;
  }
}

void buttonHighLight(){
  //put in a function called highlight button
      if (sword) {
      fill(highLight);
      } else {
      fill(swordColor); // here put image
      }
      stroke(0);
      rect(swordX, swordY, buttonSize, buttonSize);
  
      if (bow) {
      fill(highLight);
      } else {
      fill(bowColor); // here put image
      }
      stroke(0);
      rect(bowX, bowY, buttonSize, buttonSize);
      
      if (gun) {
      fill(highLight);
      } else {
      fill(gunColor); // here put image
      }
      stroke(0);
      rect(gunX, gunY, buttonSize, buttonSize);
      
      if (bat) {
      fill(highLight);
      } else {
      fill(batColor); // here put image
      }
      stroke(0);
      rect(batX, batY, buttonSize, buttonSize);
}
    